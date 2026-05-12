package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.InstitutionalAdmin;
import java.util.List;
import java.util.Optional;

public interface InstitutionalAdminDao {


    void save(InstitutionalAdmin admin);
    void update(InstitutionalAdmin admin);
    Optional<InstitutionalAdmin> findByUserId(Long userId);
    Optional<InstitutionalAdmin> findByUserEmail(String email);
    List<InstitutionalAdmin> findByInstitutionId(Long institutionId);
    List<InstitutionalAdmin> findPending();
    boolean existsByUserEmail(String email);
    Optional<InstitutionalAdmin> findById(Long id);


}