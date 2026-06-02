package com.nexmeet.platform.controller.admin;


import com.nexmeet.platform.dao.InstitutionDao;
import com.nexmeet.platform.dao.InstitutionalAdminDao;
import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dto.InstitutionDto;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.InstitutionType;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.enums.VerificationStatus;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrganizerDao organizerDao;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private CommissionService commissionService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private InstitutionDao institutionDao;

    @Autowired
    private InstitutionalAdminDao institutionalAdminDao;

    @Autowired
    private AuditLogService auditLogService;

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private CertificateService certificateService;

    @Autowired
    private CommissionInvoiceService invoiceService;


    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {

        // Auto-complete any expired conferences first
        conferenceService.autoCompleteExpiredConferences();

        List<Conference> pending =
                conferenceService.getPendingConferences();
        long totalUsers = userService.countAllUsers();
        long activeConferences = conferenceService
                .countByStatus(ConferenceStatus.APPROVED);

        // Add currentUser for welcome message
        userService.findByEmail(auth.getName())
                .ifPresent(u -> model.addAttribute("currentUser", u));

        long pendingOrganizersCount = organizerDao
                .findByVerificationStatus(VerificationStatus.PENDING).size();

        model.addAttribute("pendingOrganizersCount",
                pendingOrganizersCount);

        model.addAttribute("totalRevenue",
                paymentService.getTotalPlatformRevenue());

        model.addAttribute("projectedRevenue",
                commissionService.getTotalPlatformEarnings());

        model.addAttribute("pendingConferences", pending);
        model.addAttribute("pendingCount", pending.size());
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("activeConferences", activeConferences);

        model.addAttribute("totalAuditLogs",
                auditLogService.getTotalCount());

        model.addAttribute("pendingInvoicesCount",
                invoiceService.countPending());

        return "admin/dashboard";
    }
    @PostMapping("/conference/{id}/approve")
    public String approve(@PathVariable Long id,
                          Authentication auth,
                          RedirectAttributes flash) {
        conferenceService.approveConference(id, auth.getName());

        // Phase 45: audit log
        try {
            auditLogService.log(
                    auth.getName(),
                    "CONFERENCE_APPROVED",
                    "Conference",
                    id,
                    "Admin approved conference ID " + id);
        } catch (Exception ignored) {}


        flash.addFlashAttribute("success", "Conference approved!");
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/conference/{id}/reject")
    public String reject(@PathVariable Long id,
                         @RequestParam String reason,
                         Authentication auth,
                         RedirectAttributes flash) {
        conferenceService.rejectConference(id, null, reason);

        try {
            auditLogService.log(
                    auth.getName(),
                    "CONFERENCE_REJECTED",
                    "Conference",
                    id,
                    "Reason: " + reason);
        } catch (Exception ignored) {}


        flash.addFlashAttribute("error", "Conference rejected.");
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/conference/{id}")
    public String viewConference(@PathVariable Long id,
                                 Model model) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Not found"));
        model.addAttribute("conf", conf);

        // Pass flag whether end date has passed
        boolean endDatePassed = conf.getEndDate()
                .isBefore(java.time.LocalDateTime.now());
        model.addAttribute("endDatePassed", endDatePassed);


        // ── Delegate + Attendance data for admin ──────
        List<Registration> registrations =
                registrationService
                        .findByConferenceId(id);

        long confirmedCount = registrations.stream()
                .filter(r -> r.getStatus()
                        == RegistrationStatus.CONFIRMED)
                .count();
        long cancelledCount = registrations.stream()
                .filter(r -> r.getStatus()
                        == RegistrationStatus.CANCELLED)
                .count();

        /*
         * Build attendance set — which registration IDs
         * have an attendance record (delegate was present).
         * N queries but acceptable for admin-only view.
         */
        Set<Long> attendedRegIds = new HashSet<>();
        for (Registration reg : registrations) {
            if (attendanceService
                    .hasAttended(reg.getId())) {
                attendedRegIds.add(reg.getId());
            }
        }

        long attendedCount = attendedRegIds.size();

        /*
         * Build certificate map — regId → Certificate.
         * Used to show whether each attended delegate
         * received their certificate.
         */
        Map<Long, Certificate> certMap =
                new HashMap<>();
        for (Registration reg : registrations) {
            certificateService
                    .getCertificateRecord(reg.getId())
                    .ifPresent(cert ->
                            certMap.put(reg.getId(), cert));
        }

        long certIssuedCount = certMap.size();

        model.addAttribute("registrations",
                registrations);
        model.addAttribute("attendedRegIds",
                attendedRegIds);
        model.addAttribute("certMap", certMap);
        model.addAttribute("confirmedCount",
                confirmedCount);
        model.addAttribute("cancelledCount",
                cancelledCount);
        model.addAttribute("attendedCount",
                attendedCount);
        model.addAttribute("certIssuedCount",
                certIssuedCount);

        model.addAttribute("platformEarnings",
                commissionService.calculatePlatformEarnings(id));
        model.addAttribute("organizerPayout",
                commissionService.calculateOrganizerPayout(id));
        model.addAttribute("baseFee",
                commissionService.getBaseFee(conf.getConferenceType().name()));
        model.addAttribute("perDelegateFee",
                commissionService.getPerDelegateFee(conf.getConferenceType().name()));

        // Commission Invoice for this conference
        invoiceService.findByConferenceId(id).ifPresent(inv ->
                        model.addAttribute("commissionInvoice", inv));

        return "admin/conference-detail";
    }


    @GetMapping("/conferences")
    public String allConferences(@RequestParam(required = false) String status,
                                 Model model) {
        List<Conference> conferences;
        if (status != null && !status.isEmpty()) {
            conferences = conferenceService.findByStatus(
                    ConferenceStatus.valueOf(status));
        } else {
            conferences = conferenceService.getAllConferences();
        }
        model.addAttribute("conferences", conferences);
        model.addAttribute("selectedStatus", status);
        return "admin/conferences";
    }

    @GetMapping("/users")
    public String allUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }



    @GetMapping("/organizers")
    public String allOrganizers(Model model) {
        model.addAttribute("pendingOrganizers",
                organizerDao.findByVerificationStatus(
                        VerificationStatus.PENDING));
        model.addAttribute("approvedOrganizers",
                organizerDao.findByVerificationStatus(
                        VerificationStatus.APPROVED));
        return "admin/organizers";
    }

    @PostMapping("/organizer/{id}/approve")
    public String approveOrganizer(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        organizerDao.findByOrganizerId(id).ifPresent(org -> {
            org.setVerificationStatus(VerificationStatus.APPROVED);
            org.setVerifiedAt(java.time.LocalDateTime.now());
            userService.findByEmail(auth.getName())
                    .ifPresent(org::setVerifiedBy);
            organizerDao.update(org);

            auditLogService.log(
                    auth.getName(),
                    "ORGANIZER_VERIFIED",
                    "Organizer",
                    id,
                    "Organizer: " + org.getUser().getEmail());

            // Notify organizer
            notificationService.createNotification(
                    org.getUser().getEmail(),
                    "Account Verified",
                    "Your organizer account has been verified! " +
                            "You can now create and submit conferences.",
                    "IN_APP"
            );

            emailService.sendOrganizerVerified(
                    org.getUser().getEmail(),
                    org.getUser().getFullName()
            );

        });
        flash.addFlashAttribute("success",
                "Organizer approved successfully!");
        return "redirect:/admin/organizers";
    }

    @PostMapping("/organizer/{id}/reject")
    public String rejectOrganizer(
            @PathVariable Long id,
            @RequestParam String reason,
            RedirectAttributes flash) {
        organizerDao.findByOrganizerId(id).ifPresent(org -> {
            org.setVerificationStatus(VerificationStatus.REJECTED);
            org.setRejectionReason(reason);
            organizerDao.update(org);

            notificationService.createNotification(
                    org.getUser().getEmail(),
                    "Account Verification Rejected",
                    "Your organizer account was not verified. " +
                            "Reason: " + reason,
                    "IN_APP"
            );
        });
        flash.addFlashAttribute("error",
                "Organizer rejected.");
        return "redirect:/admin/organizers";
    }

//    Update AdminController to auto-complete and add manual button     //auto complete done in dashboard method
//    Adding manual complete endpoint
    @PostMapping("/conference/{id}/complete")
    public String completeConference(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            conferenceService.markAsCompleted(id, auth.getName());
            flash.addFlashAttribute("success",
                    "Conference marked as completed. " +
                            "Delegates have been notified.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Could not complete: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }

    @PostMapping("/conference/{id}/cancel")
    public String cancelConference(
            @PathVariable Long id,
            @RequestParam String reason,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            conferenceService.cancelConference(
                    id, auth.getName(), reason);
            flash.addFlashAttribute("success",
                    "Conference cancelled. All delegates notified.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }

    @PostMapping("/user/{id}/toggle-active")
    public String toggleUserActive(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        // Prevent admin from deactivating themselves
        userService.findById(id).ifPresent(user -> {
            if (user.getEmail().equals(auth.getName())) {
                flash.addFlashAttribute("error",
                        "You cannot deactivate your own account.");
                return;
            }
            userService.toggleUserActive(id);

            String actionName = user.isActive()
                    ? "USER_DEACTIVATED"
                    : "USER_ACTIVATED";
            auditLogService.log(
                    auth.getName(),
                    actionName,
                    "User",
                    id,
                    "Toggled user: " + user.getEmail());


            flash.addFlashAttribute("success",
                    user.isActive()
                            ? "User deactivated successfully."
                            : "User activated successfully.");
        });
        return "redirect:/admin/users";
    }

    @GetMapping("/commission")
    public String commissionSettings(Model model) {
        model.addAttribute("settings",
                commissionService.getAllCommissionSettings());
        model.addAttribute("totalRevenue",
                paymentService.getTotalPlatformRevenue());
        model.addAttribute("projectedRevenue",           // ← ADD THIS
                commissionService.getTotalPlatformEarnings());
        model.addAttribute("allPayments",
                paymentService.getAllPayments());
        return "admin/commission";
    }

    /*
     * POST /admin/commission/update
     * Updates base fee and per-delegate fee for a
     * specific conference type. Uses conference type
     * string as identifier (unique in commission_settings).
     * Changes take effect for future invoice generation only.
     */
    @PostMapping("/commission/update")
    public String updateCommissionRate(
            @RequestParam String conferenceType,
            @RequestParam java.math.BigDecimal baseFee,
            @RequestParam java.math.BigDecimal perDelegateFee,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            commissionService.updateRate(
                    conferenceType, baseFee, perDelegateFee);

            try {
                auditLogService.log(
                        auth.getName(),
                        "COMMISSION_RATE_UPDATED",
                        "CommissionSetting",
                        null,
                        "Type: " + conferenceType
                                + " | Base: ₹" + baseFee
                                + " | Per-delegate: ₹"
                                + perDelegateFee);
            } catch (Exception ignored) {}

            flash.addFlashAttribute("success",
                    "Commission rate updated for "
                            + conferenceType
                            + ". New rates apply to future invoices.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Update failed: " + e.getMessage());
        }
        return "redirect:/admin/commission";
    }

    @GetMapping("/institutions")
    public String allInstitutions(Model model) {
        model.addAttribute("institutions",
                institutionDao.findAll());
        model.addAttribute("pendingAdmins",
                institutionalAdminDao.findPending());
        model.addAttribute("dto", new InstitutionDto());
        model.addAttribute("institutionTypes",
                InstitutionType.values());
        return "admin/institutions";
    }

    @PostMapping("/institution/add")
    public String addInstitution(
            @ModelAttribute("dto") InstitutionDto dto,
            RedirectAttributes flash) {
        try {
            Institution inst = new Institution();
            inst.setName(dto.getName());
            inst.setType(dto.getType());
            inst.setContactPerson(dto.getContactPerson());
            inst.setContactRole(dto.getContactRole());
            inst.setEmail(dto.getEmail());
            inst.setPhone(dto.getPhone());
            inst.setWebsite(dto.getWebsite());
            inst.setAddress(dto.getAddress());
            inst.setCity(dto.getCity());
            inst.setState(dto.getState());
            inst.setPincode(dto.getPincode());
            inst.setDomains(dto.getDomains());
            inst.setActive(true);
            institutionDao.save(inst);

            auditLogService.log(
                    null,
                    "INSTITUTION_ADDED",
                    "Institution",
                    null,
                    "Added: " + dto.getName()
                            + " (" + dto.getType() + ")");


            flash.addFlashAttribute("success",
                    "Institution added successfully!");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/institutions";
    }

    @PostMapping("/institution/{id}/toggle")
    public String toggleInstitution(
            @PathVariable Long id,
            RedirectAttributes flash) {
        institutionDao.findById(id).ifPresent(inst -> {
            inst.setActive(!inst.isActive());
            institutionDao.update(inst);
            flash.addFlashAttribute("success",
                    inst.isActive()
                            ? "Institution activated."
                            : "Institution deactivated.");
        });
        return "redirect:/admin/institutions";
    }

    @PostMapping("/institutional-admin/{id}/approve")
    public String approveInstitutionalAdmin(
            @PathVariable Long id,
            RedirectAttributes flash) {
        institutionalAdminDao.findById(id).ifPresent(ia -> {
            ia.setVerified(true);
            institutionalAdminDao.update(ia);


            auditLogService.log(
                    null,
                    "INSTITUTIONAL_ADMIN_APPROVED",
                    "InstitutionalAdmin",
                    id,
                    "Approved: "
                            + ia.getUser().getEmail()
                            + " for "
                            + ia.getInstitution().getName());


            notificationService.createNotification(
                    ia.getUser().getEmail(),
                    "Account Verified",
                    "Your institutional admin account for " +
                            ia.getInstitution().getName() +
                            " has been verified!",
                    "IN_APP"
            );
            flash.addFlashAttribute("success",
                    "Institutional admin approved.");
        });
        return "redirect:/admin/institutions";
    }


    /*
     * GET /admin/audit-logs
     * Shows recent audit log entries.
     * Supports action filter via request param.
     */
    @GetMapping("/audit-logs")
    public String auditLogs(
            @RequestParam(required = false)
            String action,
            Model model,
            Authentication auth) {

        userService.findByEmail(auth.getName())
                .ifPresent(u ->
                        model.addAttribute(
                                "currentUser", u));

        int limit = 200; // last 200 events

        List<com.nexmeet.platform.entity.AuditLog>
                logs;

        if (action != null && !action.isEmpty()) {
            logs = auditLogService
                    .filterByAction(action, limit);
        } else {
            logs = auditLogService.getRecent(limit);
        }

        model.addAttribute("logs", logs);
        model.addAttribute("totalCount",
                auditLogService.getTotalCount());
        model.addAttribute("selectedAction",
                action != null ? action : "");

        // All distinct action types for filter dropdown
        model.addAttribute("actionTypes",
                java.util.Arrays.asList(
                        "CONFERENCE_APPROVED",
                        "CONFERENCE_REJECTED",
                        "CONFERENCE_CANCELLED",
                        "CONFERENCE_COMPLETED",
                        "CONFERENCE_CREATED",
                        "ORGANIZER_VERIFIED",
                        "ORGANIZER_REJECTED",
                        "USER_REGISTERED",
                        "USER_DEACTIVATED",
                        "USER_ACTIVATED",
                        "DELEGATE_REGISTERED",
                        "DELEGATE_CANCELLED",
                        "BULK_UPLOAD_COMPLETED",
                        "INSTITUTIONAL_ADMIN_APPROVED",
                        "INSTITUTION_ADDED",
                        "OUTREACH_SENT",
                        "CERTIFICATE_ISSUED"
                ));

        return "admin/audit-logs";
    }




    /*
     * POST /admin/conference/{id}/reissue-certificates
     * One-time fix for conferences that were auto-completed
     * before certificate issuance logic was fixed.
     * Admin-only. Idempotent — safe to run multiple times.
     */
    @PostMapping("/conference/{id}/reissue-certificates")
    public String reissueCertificates(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            conferenceService
                    .reissueMissingCertificates(id);
            flash.addFlashAttribute("success",
                    "Certificates reissued for all "
                            + "attended delegates!");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }


    /*
     * POST /admin/conference/{id}/generate-invoice
     * Generates the platform commission invoice for a
     * completed conference. Idempotent — safe to call
     * multiple times.
     */
    @PostMapping("/conference/{id}/generate-invoice")
    public String generateInvoice(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            CommissionInvoice inv =
                    invoiceService.generateInvoice(
                            id, auth.getName());

            flash.addFlashAttribute("success",
                    "Invoice " + inv.getInvoiceNumber()
                            + " generated for ₹"
                            + inv.getTotalAmount()
                            + ". Organizer has been notified.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Could not generate invoice: "
                            + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }

    /*
     * POST /admin/invoice/{invoiceId}/mark-paid
     * Admin confirms payment received from organizer.
     * paymentReference = UTR / UPI transaction ID.
     */
    @PostMapping("/invoice/{invoiceId}/mark-paid")
    public String markInvoicePaid(
            @PathVariable Long invoiceId,
            @RequestParam String paymentReference,
            @RequestParam Long conferenceId,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            invoiceService.markAsPaid(
                    invoiceId, paymentReference,
                    auth.getName());
            flash.addFlashAttribute("success",
                    "Payment confirmed! Invoice marked as PAID.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + conferenceId;
    }

    /*
     * POST /admin/invoice/{invoiceId}/waive
     * Admin waives commission (NGO/GOVT/goodwill).
     */
    @PostMapping("/invoice/{invoiceId}/waive")
    public String waiveInvoice(
            @PathVariable Long invoiceId,
            @RequestParam String notes,
            @RequestParam Long conferenceId,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            invoiceService.waiveInvoice(
                    invoiceId, notes, auth.getName());
            flash.addFlashAttribute("success",
                    "Invoice waived successfully.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + conferenceId;
    }

    /*
     * GET /admin/invoices
     * Central invoice overview for admin.
     * Shows all commission invoices across all conferences
     * with filter by status (PENDING / PAID / WAIVED).
     */
    @GetMapping("/invoices")
    public String allInvoices(
            @RequestParam(required = false) String status,
            Model model,
            Authentication auth) {

        userService.findByEmail(auth.getName())
                .ifPresent(u ->
                        model.addAttribute("currentUser", u));

        List<CommissionInvoice> invoices;
        if (status != null && !status.trim().isEmpty()) {
            // Filter by status — done in-memory since
            // volume is small (one invoice per conference)
            invoices = invoiceService.findAll().stream()
                    .filter(inv -> inv.getStatus()
                            .equals(status.toUpperCase()))
                    .collect(java.util.stream.Collectors
                            .toList());
        } else {
            invoices = invoiceService.findAll();
        }

        // Summary counts for stat cards
        long pendingCount = invoiceService.countPending();
        long paidCount = invoiceService.findAll().stream()
                .filter(inv -> "PAID".equals(inv.getStatus()))
                .count();
        long waivedCount = invoiceService.findAll().stream()
                .filter(inv -> "WAIVED".equals(inv.getStatus()))
                .count();

        // Total amount pending (what organizers still owe)
        java.math.BigDecimal totalPending =
                invoiceService.findAll().stream()
                        .filter(inv -> "PENDING".equals(inv.getStatus()))
                        .map(CommissionInvoice::getTotalAmount)
                        .reduce(java.math.BigDecimal.ZERO,
                                java.math.BigDecimal::add);

        // Total amount collected (PAID invoices)
        java.math.BigDecimal totalCollected =
                invoiceService.findAll().stream()
                        .filter(inv -> "PAID".equals(inv.getStatus()))
                        .map(CommissionInvoice::getTotalAmount)
                        .reduce(java.math.BigDecimal.ZERO,
                                java.math.BigDecimal::add);

        model.addAttribute("invoices", invoices);
        model.addAttribute("selectedStatus",
                status != null ? status : "");
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("paidCount", paidCount);
        model.addAttribute("waivedCount", waivedCount);
        model.addAttribute("totalPending", totalPending);
        model.addAttribute("totalCollected", totalCollected);

        return "admin/invoices";
    }
}
