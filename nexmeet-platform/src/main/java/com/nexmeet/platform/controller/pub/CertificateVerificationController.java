package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.dao.CertificateDao;
import com.nexmeet.platform.service.CertificateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/*
 * Public certificate verification page.
 * No login required — anyone can verify a certificate.
 *
 * URL: /verify/{certificateNumber}
 * Example: /verify/NM-CERT-2026-A3F7K2
 *
 * Real-world use: delegate shares their cert number
 * with an employer / college. Employer visits this URL
 * to confirm the certificate is genuine and issued by NexMeet.
 *
 * This is the same pattern used by:
 * - Coursera: coursera.org/verify/XXXX
 * - LinkedIn Learning: linkedin.com/learning/certificates/XXXX
 * - HackerRank: hackerrank.com/certificates/XXXX
 */
@Controller
public class CertificateVerificationController {

    @Autowired
    private CertificateService certificateService;

    /*
     * GET /verify/{certNumber}
     * Look up the certificate and show its details.
     * Shows "valid" or "not found" clearly.
     */
    @GetMapping("/verify/{certNumber}")
    public String verifyCertificate(
            @PathVariable String certNumber,
            Model model) {

        model.addAttribute("certNumber", certNumber);

        certificateService
                .findByCertificateNumber(certNumber)
                .ifPresent(cert -> {
                    model.addAttribute("cert", cert);
                    model.addAttribute("valid", true);
                });

        return "pub/verify";
    }

    /*
     * GET /verify — show empty search form
     * So anyone can look up any certificate number
     * without needing the direct URL.
     */
    @GetMapping("/verify")
    public String verifyPage() {
        return "pub/verify";
    }
}