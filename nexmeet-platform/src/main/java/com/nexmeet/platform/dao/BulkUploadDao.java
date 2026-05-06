package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.BulkUpload;
import java.util.List;

public interface BulkUploadDao {

    void save(BulkUpload upload);

    void update(BulkUpload upload);

    List<BulkUpload> findByConferenceId(Long conferenceId);
}