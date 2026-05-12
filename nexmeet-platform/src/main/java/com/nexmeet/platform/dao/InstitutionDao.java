package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Institution;
import java.util.List;
import java.util.Optional;

public interface InstitutionDao {


    void save(Institution institution);
    void update(Institution institution);
    Optional<Institution> findById(Long id);
    List<Institution> findAll();
    List<Institution> findByActive(boolean active);
    long countAll();


}