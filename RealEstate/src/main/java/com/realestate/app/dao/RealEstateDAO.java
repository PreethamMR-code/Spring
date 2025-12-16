package com.realestate.app.dao;

import com.realestate.app.dto.RealEstateDTO;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

public interface RealEstateDAO {

    boolean save(RealEstateDTO realEstateDTO);
    boolean existsByEmail(String email);

    boolean update(RealEstateDTO realEstateDTO);

    default Optional<RealEstateDTO> findByEmail(String gmail){
        return Optional.empty();
    }

    default List<RealEstateDTO>  findByPropertyType(String propertyType){
        return Collections.emptyList();
    }
}
