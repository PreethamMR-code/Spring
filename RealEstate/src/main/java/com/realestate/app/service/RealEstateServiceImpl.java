package com.realestate.app.service;

import com.realestate.app.dao.RealEstateDAO;
import com.realestate.app.dao.RealEstateDAOImpl;
import com.realestate.app.dto.RealEstateDTO;
import com.realestate.app.dto.SearchDTO;
import com.realestate.app.exception.RealEstateException;
import com.sun.org.apache.regexp.internal.RE;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class RealEstateServiceImpl implements RealEstateService{

    RealEstateDAO realEstateDAO = new RealEstateDAOImpl();


    @Override
    public void validateAndSave(RealEstateDTO realEstateDTO) throws RealEstateException {

        boolean invalid =false;

        if(realEstateDTO == null){
            throw new RealEstateException("data is null");
        }

        if(realEstateDTO.getFullName() == null || realEstateDTO.getFullName().trim().length()< 4){
            invalid = true;
        }

        if(realEstateDTO.getEmail() == null || !realEstateDTO.getEmail().contains("@")){
            invalid = true;
        }

        if(realEstateDTO.getPropertyType() ==null || realEstateDTO.getPropertyType().isEmpty()){
            invalid =true;
        }

        if(realEstateDTO.getBudget() <= 0){
            invalid = true;
        }

        if(realEstateDTO.getMessage() == null || realEstateDTO.getMessage().length() < 5){
            invalid = true;
        }

        if(invalid){
            throw  new RealEstateException("DATA is not valid");
        }

        //for email
        boolean exists = realEstateDAO.existsByEmail(realEstateDTO.getEmail());
        if(exists){
            throw new RealEstateException("email already registered");
        }

        boolean saved = realEstateDAO.save(realEstateDTO);
        System.out.println("Saved:"+ saved);
    }

    @Override
    public boolean update(RealEstateDTO realEstateDTO ) {

        boolean invalid = false;

        if (realEstateDTO == null) {
            return false;
        }

        if (realEstateDTO.getFullName() == null ||
                realEstateDTO.getFullName().trim().length() < 4) {
            invalid = true;
        }

        if (realEstateDTO.getEmail() == null ||
                !realEstateDTO.getEmail().contains("@")) {
            invalid = true;
        }

        if (realEstateDTO.getPropertyType() == null ||
                realEstateDTO.getPropertyType().isEmpty()) {
            invalid = true;
        }

        if (realEstateDTO.getBudget() <= 0) {
            invalid = true;
        }

        if (realEstateDTO.getMessage() == null ||
                realEstateDTO.getMessage().length() < 5) {
            invalid = true;
        }

        if (invalid) {
            return false;
        }

        return realEstateDAO.update(realEstateDTO);
    }

    @Override
    public Optional<RealEstateDTO> findByGmail(SearchDTO searchDTO) {

        String mail = searchDTO.getEmailID();
        boolean invalid = false;

        if(mail == null || !mail.contains("@"))
        {
            System.err.println("mail is not valid..");
            invalid = true;
        }

        if(!invalid)
        {
            System.out.println("mail is valid call dao..");
            Optional<RealEstateDTO> optionalRealEstateDTO = this.realEstateDAO.findByEmail(mail);
            System.out.println("optional real estate:"+optionalRealEstateDTO.isPresent());
            return optionalRealEstateDTO;

        }
        return RealEstateService.super.findByGmail(searchDTO);
    }

    @Override
    public List<RealEstateDTO> findByPropertyType(SearchDTO searchDTO) {

        System.out.println("running find by property type:"+searchDTO);
        String property = searchDTO.getPropertyType();
        if(property != null && property.length()>3)
        {
            System.out.println("property type is valid");
            List<RealEstateDTO> realEstateDTOS = this.realEstateDAO.findByPropertyType(property);
            System.out.println("total real estate from DAO:"+realEstateDTOS.size());
            return realEstateDTOS;
        }
        System.out.println("property not valid");
        return Collections.emptyList();
    }
}
