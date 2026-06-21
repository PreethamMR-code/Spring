package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.PaymentDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class PaymentServiceImpl
        implements PaymentService {

    /*
     * Razorpay Test Mode API credentials.
     * key_id   = rzp_test_XXXXXXXXXXXXXXXX  (safe to expose to frontend)
     * key_secret = secret kept server-side ONLY, never sent to browser.
     *
     * In production: move these to a properties file or
     * environment variables, never hardcode in source.
     */
    private static final String RAZORPAY_KEY_ID =
            "rzp_test_REPLACE_WITH_YOUR_KEY_ID";
    private static final String RAZORPAY_KEY_SECRET =
            "REPLACE_WITH_YOUR_KEY_SECRET";

    @Autowired
    private PaymentDao paymentDao;

    @Autowired
    private CommissionService commissionService;

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private UserService userService;

    @Autowired
    private ConferenceService conferenceService;

    @Override
    public Payment createRegistrationPayment(
            Registration reg,
            User payer,
            Conference conf) {

        /*
         * Skip payment creation for free conferences.
         * No money changes hands — nothing to record.
         */
        if (conf.isFree()
                || conf.getDelegateFee() == null
                || conf.getDelegateFee()
                .compareTo(BigDecimal.ZERO) == 0) {
            return null;
        }

        BigDecimal delegateFee = conf.getDelegateFee();
        String confType = conf.getConferenceType().name();

        /*
         * Platform takes perDelegateFee per registration.
         * Capped at delegateFee — can't take more than
         * what delegate paid.
         */
        BigDecimal perDelegate =
                commissionService.getPerDelegateFee(
                        confType);
        BigDecimal platformCut =
                perDelegate.min(delegateFee);

        /*
         * Organizer keeps the rest.
         * Never goes negative.
         */
        BigDecimal organizerCut =
                delegateFee.subtract(platformCut);
        if (organizerCut.compareTo(
                BigDecimal.ZERO) < 0) {
            organizerCut = BigDecimal.ZERO;
        }

        /*
         * Determine payment_for label.
         * BULK_REGISTRATION = came from CSV/Excel upload
         * REGISTRATION      = individual self-registration
         */
        String paymentFor = "REGISTRATION";
        if (reg.getRegistrationType() != null
                && "BULK".equals(
                reg.getRegistrationType()
                        .name())) {
            paymentFor = "BULK_REGISTRATION";
        }

        Payment payment = new Payment();
        payment.setPayerUser(payer);
        payment.setConference(conf);
        payment.setPaymentFor(paymentFor);
        payment.setAmount(delegateFee);
        payment.setPlatformCommission(platformCut);
        payment.setOrganizerAmount(organizerCut);
        payment.setPaymentMethod("SIMULATED");

        /*
         * Unique transaction reference.
         * Format: SIM-XXXX-XXXX-XXXX
         * In production: Razorpay/Stripe order ID here.
         */
        payment.setTransactionRef(
                "SIM-" +
                        UUID.randomUUID()
                                .toString()
                                .substring(0, 8)
                                .toUpperCase());

        /*
         * Simulated payment = COMPLETED immediately.
         * Real payment gateway = stays INITIATED until
         * webhook callback updates status.
         */
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(LocalDateTime.now());

        paymentDao.save(payment);
        return payment;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getPaymentsByConference(
            Long conferenceId) {
        return paymentDao
                .findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getPaymentsByUser(
            Long userId) {
        return paymentDao.findByUserId(userId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalRevenueByConference(
            Long conferenceId) {
        return paymentDao
                .sumAmountByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getPlatformShareByConference(
            Long conferenceId) {
        return paymentDao
                .sumPlatformCommissionByConferenceId(
                        conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getOrganizerShareByConference(
            Long conferenceId) {
        return paymentDao
                .sumOrganizerAmountByConferenceId(
                        conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalPlatformRevenue() {
        return paymentDao.sumAllPlatformCommission();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getAllPayments() {
        return paymentDao.findAll();
    }

    @Override
    @Transactional
    public void markVenuePaymentReceived(
            Long conferenceId,
            Long delegateUserId,
            String paymentMethod,
            String paymentReference,
            String organizerEmail) {

        /*
         * paymentMethod must be VENUE_CASH or VENUE_UPI.
         * Reject anything else to prevent data corruption.
         */
        if (!"VENUE_CASH".equals(paymentMethod)
                && !"VENUE_UPI".equals(paymentMethod)) {
            throw new IllegalArgumentException(
                    "Invalid payment method: " + paymentMethod
                            + ". Must be VENUE_CASH or VENUE_UPI.");
        }

        Payment payment = paymentDao
                .findByConferenceAndUser(
                        conferenceId, delegateUserId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "No payment record found for " +
                                        "this delegate and conference."));

        /*
         * Idempotency: if already confirmed,
         * don't overwrite with same data.
         */
        if ("VENUE_CASH".equals(payment.getPaymentMethod())
                || "VENUE_UPI".equals(
                payment.getPaymentMethod())) {
            return; // already marked, skip silently
        }

        payment.setPaymentMethod(paymentMethod);
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(
                java.time.LocalDateTime.now());

        if (paymentReference != null
                && !paymentReference.trim().isEmpty()) {
            payment.setTransactionRef(
                    paymentReference.trim());
        }

        paymentDao.update(payment);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId) {
        return paymentDao.findByConferenceAndUser(
                conferenceId, userId);
    }

    @Override
    @Transactional
    public org.json.JSONObject createRazorpayOrder(
            Long conferenceId, String delegateEmail)
            throws Exception {

        Conference conf = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found"));

        if (conf.isFree()) {
            throw new RuntimeException(
                    "Free conferences do not need payment.");
        }

        User delegate = userService
                .findByEmail(delegateEmail)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found"));

        /*
         * Amount in paise (Razorpay requires lowest
         * currency unit). ₹1 = 100 paise.
         * BigDecimal → multiply by 100 → intValue.
         */
        int amountInPaise = conf.getDelegateFee()
                .multiply(new BigDecimal("100"))
                .intValue();

        /*
         * Build request JSON for POST /v1/orders.
         * receipt = our internal reference for mapping.
         */
        org.json.JSONObject orderRequest =
                new org.json.JSONObject();
        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt",
                "CONF-" + conferenceId
                        + "-USR-" + delegate.getId());

        /*
         * POST to Razorpay orders API using
         * Basic Auth (key_id:key_secret Base64).
         * No SDK — pure HttpURLConnection for Java 8.
         */
        String credentials =
                RAZORPAY_KEY_ID + ":" + RAZORPAY_KEY_SECRET;
        String encoded = java.util.Base64.getEncoder()
                .encodeToString(
                        credentials.getBytes("UTF-8"));

        java.net.URL url = new java.net.URL(
                "https://api.razorpay.com/v1/orders");
        java.net.HttpURLConnection conn =
                (java.net.HttpURLConnection)
                        url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization",
                "Basic " + encoded);
        conn.setRequestProperty("Content-Type",
                "application/json");
        conn.setDoOutput(true);
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(10000);

        try (java.io.OutputStream os =
                     conn.getOutputStream()) {
            os.write(orderRequest.toString()
                    .getBytes("UTF-8"));
        }

        int responseCode = conn.getResponseCode();
        java.io.InputStream is =
                responseCode == 200
                        ? conn.getInputStream()
                        : conn.getErrorStream();

        StringBuilder sb = new StringBuilder();
        try (java.io.BufferedReader br =
                     new java.io.BufferedReader(
                             new java.io.InputStreamReader(
                                     is, "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        }

        if (responseCode != 200) {
            throw new RuntimeException(
                    "Razorpay order creation failed: "
                            + sb.toString());
        }

        org.json.JSONObject orderResponse =
                new org.json.JSONObject(sb.toString());

        /*
         * Create a PENDING payment record NOW so we have
         * a DB row to update when Razorpay calls back.
         * Status = INITIATED (not COMPLETED yet).
         * razorpayOrderId is set here so we can look it
         * up during verification.
         */
        Payment pending = new Payment();
        pending.setPayerUser(delegate);
        pending.setConference(conf);
        pending.setPaymentFor("REGISTRATION");
        pending.setAmount(conf.getDelegateFee());
        pending.setPlatformCommission(
                commissionService.getPerDelegateFee(
                                conf.getConferenceType().name())
                        .min(conf.getDelegateFee()));
        pending.setOrganizerAmount(
                conf.getDelegateFee()
                        .subtract(pending.getPlatformCommission()));
        pending.setPaymentMethod("RAZORPAY");
        pending.setStatus("INITIATED");
        pending.setTransactionRef(
                "RZP-" + orderResponse
                        .getString("id")
                        .substring(6, 14)
                        .toUpperCase());
        pending.setRazorpayOrderId(
                orderResponse.getString("id"));
        paymentDao.save(pending);

        /*
         * Return order details to the controller.
         * Controller sends order_id + amount + key_id
         * to JSP for the Checkout.js popup.
         */
        org.json.JSONObject result =
                new org.json.JSONObject();
        result.put("orderId",
                orderResponse.getString("id"));
        result.put("amount", amountInPaise);
        result.put("currency", "INR");
        result.put("keyId", RAZORPAY_KEY_ID);
        result.put("conferenceName", conf.getTitle());
        result.put("delegateName",
                delegate.getFullName());
        result.put("delegateEmail",
                delegate.getEmail());
        return result;
    }

    @Override
    @Transactional
    public com.nexmeet.platform.entity.Registration
    verifyAndCompleteRazorpayPayment(
            Long conferenceId,
            String delegateEmail,
            String rzpOrderId,
            String rzpPaymentId,
            String rzpSignature)
            throws Exception {

        /*
         * STEP 1: Verify signature.
         * Razorpay signs: orderId + "|" + paymentId
         * using key_secret as HMAC-SHA256 key.
         * If our computed hash ≠ received signature →
         * payment is tampered → reject immediately.
         */
        String data = rzpOrderId + "|" + rzpPaymentId;
        javax.crypto.Mac mac = javax.crypto.Mac
                .getInstance("HmacSHA256");
        javax.crypto.spec.SecretKeySpec secretKey =
                new javax.crypto.spec.SecretKeySpec(
                        RAZORPAY_KEY_SECRET
                                .getBytes("UTF-8"),
                        "HmacSHA256");
        mac.init(secretKey);
        byte[] hash = mac.doFinal(
                data.getBytes("UTF-8"));

        // Convert to hex string for comparison
        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            hex.append(String.format("%02x", b));
        }
        String computedSignature = hex.toString();

        if (!computedSignature.equals(rzpSignature)) {
            throw new RuntimeException(
                    "Payment verification failed: " +
                            "invalid signature. " +
                            "Do not proceed.");
        }

        /*
         * STEP 2: Update the PENDING payment record
         * we created during createRazorpayOrder().
         */
        Payment payment = paymentDao
                .findByRazorpayOrderId(rzpOrderId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Payment record not found " +
                                        "for order: " + rzpOrderId));

        payment.setRazorpayPaymentId(rzpPaymentId);
        payment.setRazorpaySignature(rzpSignature);
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(LocalDateTime.now());
        paymentDao.update(payment);

        /*
         * STEP 3: Complete the registration.
         * IMPORTANT: We call registerDelegatePostPayment()
         * NOT registerForConference(). The difference:
         * registerDelegatePostPayment() skips the internal
         * createRegistrationPayment() call because the
         * RAZORPAY payment row is already COMPLETED above.
         * Calling registerForConference() would trigger a
         * second SIMULATED payment row → unique constraint
         * violation on transaction_ref → 500 error despite
         * the payment being genuinely confirmed by Razorpay.
         */
        com.nexmeet.platform.entity.Registration reg =
                registrationService
                        .registerDelegatePostPayment(
                                conferenceId,
                                delegateEmail);

        return reg;
    }
}