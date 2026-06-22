package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    /*
     * POST /payment/create-order
     * Called by JS fetch() when delegate clicks "Pay Now".
     * Creates a Razorpay order server-side and returns
     * the order details as JSON to the browser.
     * The browser uses order_id to open Checkout.js popup.
     *
     * Returns JSON directly (not a view) because this is
     * called via fetch() from the JSP page's JS block.
     * We write manually to response rather than using
     * @ResponseBody to avoid adding Jackson config.
     */
    @PostMapping("/payment/create-order")
    public void createOrder(
            @RequestParam Long conferenceId,
            Authentication auth,
            HttpServletResponse response)
            throws Exception {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            org.json.JSONObject order =
                    paymentService.createRazorpayOrder(
                            conferenceId,
                            auth.getName());
            response.setStatus(200);
            out.print(order.toString());
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\""
                    + e.getMessage()
                    .replace("\"", "'")
                    + "\"}");
        }
        out.flush();
    }

    /*
     * POST /payment/verify
     * Called by JS after Razorpay Checkout popup succeeds.
     * Razorpay sends razorpay_order_id, razorpay_payment_id,
     * razorpay_signature to browser → browser POSTs here.
     * We verify HMAC, complete payment, create registration.
     * Redirects to delegate dashboard on success.
     */
    @PostMapping("/payment/verify")
    public String verifyPayment(
            @RequestParam Long conferenceId,
            @RequestParam String razorpayOrderId,
            @RequestParam String razorpayPaymentId,
            @RequestParam String razorpaySignature,
            Authentication auth,
            RedirectAttributes flash) {

        try {
            paymentService.verifyAndCompleteRazorpayPayment(
                    conferenceId,
                    auth.getName(),
                    razorpayOrderId,
                    razorpayPaymentId,
                    razorpaySignature);

            flash.addFlashAttribute("success",
                    "Payment successful! " +
                            "You are now registered. " +
                            "Check your email for the ticket.");

        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Payment verification failed: "
                            + e.getMessage());
        }
        return "redirect:/delegate/dashboard";
    }
}