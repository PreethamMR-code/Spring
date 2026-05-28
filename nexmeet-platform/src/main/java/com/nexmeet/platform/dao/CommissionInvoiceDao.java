package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.CommissionInvoice;
import java.util.List;
import java.util.Optional;

public interface CommissionInvoiceDao {

    void save(CommissionInvoice invoice);

    void update(CommissionInvoice invoice);

    Optional<CommissionInvoice> findById(Long id);

    // One invoice per conference (enforced by DB unique key too)
    Optional<CommissionInvoice> findByConferenceId(Long conferenceId);

    // All invoices for admin overview
    List<CommissionInvoice> findAll();

    // All invoices for one organizer
    List<CommissionInvoice> findByOrganizerId(Long organizerId);

    // Pending invoices only — admin dashboard badge
    long countPending();
}