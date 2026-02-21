package com.xworkz.forms.service;

import com.xworkz.forms.DTO.*;

public interface RegistrationService {

    boolean saveStudent(StudentDTO dto);

    boolean saveEmployee(EmployeeDTO dto);

    boolean saveCustomer(CustomerDTO dto);

    boolean saveVendor(VendorDTO dto);

    boolean saveDoctor(DoctorDTO dto);

    boolean saveTrainer(TrainerDTO dto);

    boolean saveCourse(CourseDTO dto);

    boolean saveEvent(EventDTO dto);

    boolean saveProduct(ProductDTO dto);

    boolean saveService(ServiceDTO dto);
}
