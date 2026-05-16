package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.OutreachContact;
import java.util.List;

public interface OutreachDao {


    void save(OutreachContact contact);

    void update(OutreachContact contact);

    List<OutreachContact> findByConferenceId(Long conferenceId);

    boolean alreadyContacted(Long conferenceId,
                             Long institutionId);

    /*
     * For admin/organizer to update status after
     * institution responds (RESPONDED, INTERESTED etc.)
     */
    java.util.Optional<OutreachContact> findById(Long id);
}