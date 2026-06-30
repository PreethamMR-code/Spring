package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.PaymentDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    private static final Logger log =
            LoggerFactory.getLogger(PaymentServiceImpl.class);

    /*
     * Reads razorpay.key.id and razorpay.key.secret
     * from application.properties at runtime.
     * That file is gitignored — keys never reach GitHub.
     */
    @Autowired
    private org.springframework.core.env.Environment env;

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

        if (conf.isFree()
                || conf.getDelegateFee() == null
                || conf.getDelegateFee()
                .compareTo(BigDecimal.ZERO) == 0) {
            return null;
        }

        BigDecimal delegateFee = conf.getDelegateFee();
        String confType = conf.getConferenceType().name();

        BigDecimal perDelegate =
                commissionService.getPerDelegateFee(
                        confType);
        BigDecimal platformCut =
                perDelegate.min(delegateFee);

        BigDecimal organizerCut =
                delegateFee.subtract(platformCut);
        if (organizerCut.compareTo(
                BigDecimal.ZERO) < 0) {
            organizerCut = BigDecimal.ZERO;
        }

        String paymentFor = "REGISTRATION";
        if (reg.getRegistrationType() != null
                && "BULK".equals(
                reg.getRegistrationType().name())) {
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
        payment.setTransactionRef(
                "SIM-" + UUID.randomUUID()
                        .toString()
                        .substring(0, 8)
                        .toUpperCase());
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
    public List<Payment> getPaymentsByUser(Long userId) {
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

        if ("VENUE_CASH".equals(payment.getPaymentMethod())
                || "VENUE_UPI".equals(
                payment.getPaymentMethod())) {
            return;
        }

        payment.setPaymentMethod(paymentMethod);
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(LocalDateTime.now());

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

        int amountInPaise = conf.getDelegateFee()
                .multiply(new BigDecimal("100"))
                .intValue();

        org.json.JSONObject orderRequest =
                new org.json.JSONObject();
        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt",
                "CONF-" + conferenceId
                        + "-USR-" + delegate.getId());

        String razorpayKeyId =
                env.getProperty("razorpay.key.id");
        String razorpayKeySecret =
                env.getProperty("razorpay.key.secret");

        if (razorpayKeyId == null
                || razorpayKeyId.startsWith(
                "rzp_test_REPLACE")
                || razorpayKeySecret == null
                || razorpayKeySecret.equals(
                "REPLACE_WITH_YOUR_KEY_SECRET")) {
            throw new RuntimeException(
                    "Razorpay keys not configured. " +
                            "Set razorpay.key.id and " +
                            "razorpay.key.secret in " +
                            "application.properties.");
        }

        String credentials =
                razorpayKeyId + ":" + razorpayKeySecret;
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

        org.json.JSONObject result =
                new org.json.JSONObject();
        result.put("orderId",
                orderResponse.getString("id"));
        result.put("amount", amountInPaise);
        result.put("currency", "INR");
        result.put("keyId", razorpayKeyId);
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

        String data = rzpOrderId + "|" + rzpPaymentId;
        javax.crypto.Mac mac = javax.crypto.Mac
                .getInstance("HmacSHA256");
        String razorpayKeySecret =
                env.getProperty("razorpay.key.secret");

        if (razorpayKeySecret == null
                || razorpayKeySecret.equals(
                "REPLACE_WITH_YOUR_KEY_SECRET")) {
            throw new RuntimeException(
                    "Razorpay key.secret not configured.");
        }

        javax.crypto.spec.SecretKeySpec secretKey =
                new javax.crypto.spec.SecretKeySpec(
                        razorpayKeySecret
                                .getBytes("UTF-8"),
                        "HmacSHA256");
        mac.init(secretKey);
        byte[] hash = mac.doFinal(
                data.getBytes("UTF-8"));

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

        com.nexmeet.platform.entity.Registration reg =
                registrationService
                        .registerDelegatePostPayment(
                                conferenceId,
                                delegateEmail);

        return reg;
    }

    @Override
    @Transactional
    public void initiateRazorpayRefund(
            Long conferenceId, Long userId) {

        /*
         * Look up the payment for this conference+user.
         * If none exists (free conference) — nothing to do.
         */
        Optional<Payment> paymentOpt =
                paymentDao.findByConferenceAndUser(
                        conferenceId, userId);

        if (!paymentOpt.isPresent()) {
            log.info("[Refund] No payment record for " +
                            "conference {} user {} — nothing to " +
                            "refund (likely a free conference)",
                    conferenceId, userId);
            return;
        }

        Payment payment = paymentOpt.get();

        /*
         * Only RAZORPAY payments go through the gateway
         * refund API. SIMULATED and VENUE_CASH/VENUE_UPI
         * payments never charged real money via Razorpay —
         * nothing to refund through the API for those.
         */
        if (!"RAZORPAY".equals(payment.getPaymentMethod())) {
            log.info("[Refund] Payment method is {} " +
                            "(not RAZORPAY) for conference {} " +
                            "user {} — skipping gateway refund",
                    payment.getPaymentMethod(),
                    conferenceId, userId);
            return;
        }

        /*
         * Only refund COMPLETED payments. A REFUNDED
         * payment being cancelled again, or an INITIATED
         * payment that never actually completed, should
         * not attempt a second/invalid refund call.
         */
        if (!"COMPLETED".equals(payment.getStatus())) {
            log.info("[Refund] Payment status is {} " +
                            "(not COMPLETED) for conference {} " +
                            "user {} — skipping gateway refund",
                    payment.getStatus(),
                    conferenceId, userId);
            return;
        }

        if (payment.getRazorpayPaymentId() == null
                || payment.getRazorpayPaymentId()
                .trim().isEmpty()) {
            log.error("[Refund] Payment {} marked RAZORPAY " +
                            "COMPLETED but has no razorpay_payment_id " +
                            "— cannot issue refund. Manual " +
                            "investigation required.",
                    payment.getId());
            return;
        }

        String razorpayKeyId =
                env.getProperty("razorpay.key.id");
        String razorpayKeySecret =
                env.getProperty("razorpay.key.secret");

        if (razorpayKeyId == null
                || razorpayKeySecret == null
                || razorpayKeySecret.equals(
                "REPLACE_WITH_YOUR_KEY_SECRET")) {
            log.error("[Refund] Razorpay keys not " +
                    "configured — cannot refund payment {}. " +
                    "Manual refund required via Razorpay " +
                    "Dashboard.", payment.getId());
            return;
        }

        try {
            /*
             * POST /v1/payments/{payment_id}/refund
             * No "amount" field in body = full refund of
             * the original charge. Same Basic Auth pattern
             * as order creation.
             */
            String credentials =
                    razorpayKeyId + ":" + razorpayKeySecret;
            String encoded = java.util.Base64.getEncoder()
                    .encodeToString(
                            credentials.getBytes("UTF-8"));

            String refundUrl =
                    "https://api.razorpay.com/v1/payments/"
                            + payment.getRazorpayPaymentId()
                            + "/refund";

            java.net.URL url = new java.net.URL(refundUrl);
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

            /*
             * Empty JSON body — full refund, no partial
             * amount specified. notes field optional but
             * helps with reconciliation in Razorpay Dashboard.
             */
            org.json.JSONObject refundRequest =
                    new org.json.JSONObject();
            org.json.JSONObject notes =
                    new org.json.JSONObject();
            notes.put("reason", "Delegate cancelled " +
                    "registration");
            notes.put("conference_id",
                    conferenceId.toString());
            notes.put("user_id", userId.toString());
            refundRequest.put("notes", notes);

            try (java.io.OutputStream os =
                         conn.getOutputStream()) {
                os.write(refundRequest.toString()
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
                /*
                 * Refund failed at Razorpay's end.
                 * Logged at ERROR for manual follow-up.
                 * Does NOT throw — cancellation must still
                 * proceed even if the refund call fails.
                 * Common causes: payment already refunded,
                 * payment too old, insufficient gateway
                 * balance in test mode.
                 */
                log.error("[Refund] Razorpay refund failed " +
                                "for payment {} (razorpay_payment_id={}): " +
                                "HTTP {} — {}",
                        payment.getId(),
                        payment.getRazorpayPaymentId(),
                        responseCode, sb.toString());
                return;
            }

            /*
             * Success — mark payment as REFUNDED.
             * Razorpay response includes the refund id,
             * but we don't currently have a column for it.
             * status=REFUNDED is sufficient for our tracking.
             */
            payment.setStatus("REFUNDED");
            paymentDao.update(payment);

            log.info("[Refund] Successfully refunded " +
                            "payment {} (₹{}) for conference {} " +
                            "user {}",
                    payment.getId(), payment.getAmount(),
                    conferenceId, userId);

        } catch (Exception e) {
            /*
             * Network failure, malformed response, etc.
             * Logged but never thrown — refund failure
             * must not block the delegate's cancellation.
             * This needs manual follow-up via Razorpay
             * Dashboard or a retry job.
             */
            log.error("[Refund] Exception while refunding " +
                            "payment {} for conference {} user {}: {}",
                    payment.getId(), conferenceId, userId,
                    e.getMessage());
        }
    }
}
