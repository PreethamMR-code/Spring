package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.InstitutionDao;
import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dao.OutreachDao;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OutreachServiceImpl implements OutreachService {

    @Autowired
    private OutreachDao outreachDao;

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private InstitutionDao institutionDao;

    @Autowired
    private OrganizerDao organizerDao;

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private AuditLogService auditLogService;

    @Override
    public String sendOutreach(
            Long conferenceId,
            List<Long> institutionIds,
            String organizerEmail) {

        Conference conference = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found"));

        User organizer = userService
                .findByEmail(organizerEmail)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Organizer not found"));

        Organizer orgProfile = organizerDao
                .findByUserEmail(organizerEmail)
                .orElse(null);

        String organizerName = (orgProfile != null)
                ? orgProfile.getOrganizationName()
                : organizer.getFullName();

        String startDate = conference.getStartDate()
                .toString().substring(0, 10);

        String delegateFee = conference.isFree()
                ? "0"
                : String.valueOf(
                conference.getDelegateFee());

        int sent    = 0;
        int skipped = 0;
        int noEmail = 0;

        for (Long instId : institutionIds) {

            Institution inst = institutionDao
                    .findById(instId)
                    .orElse(null);
            if (inst == null) continue;

            // Duplicate check — alreadyContacted
            // matches your existing entity naming
            if (outreachDao.alreadyContacted(
                    conferenceId, instId)) {
                skipped++;
                continue;
            }

            String toEmail = inst.getEmail();
            String status;

            if (toEmail != null
                    && !toEmail.isEmpty()) {
                emailService.sendOutreachEmail(
                        toEmail,
                        inst.getName(),
                        conference.getTitle(),
                        startDate,
                        conference.getMode().name(),
                        conference.getCity(),
                        conference.getTargetAudience(),
                        conference.isFree(),
                        delegateFee,
                        conference.getId(),
                        organizerName,
                        organizer.getEmail()
                );
                // "CONTACTED" matches your entity default
                status = "CONTACTED";
                sent++;
            } else {
                // Your entity uses CONTACTED as default;
                // we use a clear label for no-email case
                status = "CONTACTED";
                noEmail++;
            }

            /*
             * Build OutreachContact using YOUR entity fields:
             * contactedBy (not sentBy)
             * contactedAt (set by @PrePersist)
             * contactMethod default = "EMAIL"
             * status default = "CONTACTED"
             */
            OutreachContact oc = new OutreachContact();
            oc.setConference(conference);
            oc.setInstitution(inst);
            oc.setContactedBy(organizer); // YOUR field name
            oc.setContactMethod("EMAIL");
            oc.setStatus(status);

            // Add a note if no email was available
            if (toEmail == null || toEmail.isEmpty()) {
                oc.setNotes("No contact email on file — " +
                        "email not sent.");
            }

            outreachDao.save(oc);
        }

        StringBuilder summary = new StringBuilder();
        if (sent > 0) {
            summary.append(sent)
                    .append(" invitation")
                    .append(sent > 1 ? "s" : "")
                    .append(" sent successfully.");
        }
        if (skipped > 0) {
            summary.append(" ").append(skipped)
                    .append(" already contacted (skipped).");
        }
        if (noEmail > 0) {
            summary.append(" ").append(noEmail)
                    .append(" institution(s) had no email — ")
                    .append("recorded but email not sent.");
        }

        try {
            auditLogService.log(
                    organizerEmail,
                    "OUTREACH_SENT",
                    "Conference",
                    conferenceId,
                    summary.toString());
        } catch (Exception ignored) {}

        return summary.toString().trim();
    }

    @Override
    @Transactional(readOnly = true)
    public List<OutreachContact> getHistory(
            Long conferenceId) {
        return outreachDao.findByConferenceId(
                conferenceId);
    }

    /*
     * Called when organizer updates status after
     * institution responds. e.g.:
     * They replied → RESPONDED
     * They want to come → INTERESTED
     * They declined → NOT_INTERESTED
     * Their students registered → REGISTERED (auto or manual)
     */
    @Override
    public void updateStatus(Long outreachId,
                             String newStatus,
                             String notes) {
        outreachDao.findById(outreachId).ifPresent(oc -> {
            oc.setStatus(newStatus);
            if (notes != null && !notes.isEmpty()) {
                oc.setNotes(notes);
            }
            if ("RESPONDED".equals(newStatus)
                    || "INTERESTED".equals(newStatus)
                    || "NOT_INTERESTED".equals(newStatus)) {
                oc.setRespondedAt(
                        java.time.LocalDateTime.now());
            }
            outreachDao.update(oc);
        });
    }
}