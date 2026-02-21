package com.xworkz.forms.service;

import com.xworkz.forms.DTO.*;
import com.xworkz.forms.entity.*;
import com.xworkz.forms.repository.RegistrationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegistrationServiceImpl implements RegistrationService {


    @Autowired
    private RegistrationDAO registrationDAO;

    @Override
    public boolean saveStudent(StudentDTO dto) {
        StudentEntity entity = new StudentEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveEmployee(EmployeeDTO dto) {
        EmployeeEntity entity = new EmployeeEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveCustomer(CustomerDTO dto) {
        CustomerEntity entity = new CustomerEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveVendor(VendorDTO dto) {
        VendorEntity entity = new VendorEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveDoctor(DoctorDTO dto) {
        DoctorEntity entity = new DoctorEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveTrainer(TrainerDTO dto) {
        TrainerEntity entity = new TrainerEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveCourse(CourseDTO dto) {
        CourseEntity entity = new CourseEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveEvent(EventDTO dto) {
        EventEntity entity = new EventEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveProduct(ProductDTO dto) {
        ProductEntity entity = new ProductEntity(dto);
        return registrationDAO.save(entity);
    }

    @Override
    public boolean saveService(ServiceDTO dto) {
        ServiceEntity entity = new ServiceEntity(dto);
        return registrationDAO.save(entity);
    }


}
