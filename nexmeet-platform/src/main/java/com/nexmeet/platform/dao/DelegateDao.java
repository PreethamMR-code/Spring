package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Delegate;

import java.util.Optional;

public interface DelegateDao {

    boolean existsByUserEmail(String email);

    Optional<Delegate> findByUserEmail(String email);

    void save(Delegate delegate);

    void update(Delegate delegate);
}
