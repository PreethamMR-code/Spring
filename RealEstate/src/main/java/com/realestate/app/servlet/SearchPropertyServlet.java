package com.realestate.app.servlet;

import com.realestate.app.dto.RealEstateDTO;
import com.realestate.app.dto.SearchDTO;
import com.realestate.app.service.RealEstateService;
import com.realestate.app.service.RealEstateServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/property",loadOnStartup = 1)
public class SearchPropertyServlet extends HttpServlet {

    private RealEstateService realEstateService = new RealEstateServiceImpl();

    public SearchPropertyServlet(){
        System.out.println("SearchPropertyServlet created");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("running doget in SearchPropertyServlet ");

        String property = req.getParameter("propertyType");
        SearchDTO searchDTO =new SearchDTO();
        searchDTO.setPropertyType(property);

        System.out.println("search DTO:"+searchDTO);
        List<RealEstateDTO> realEstateDTOS = realEstateService.findByPropertyType(searchDTO);
        System.out.println("total found:"+realEstateDTOS.size() + " for property : "+property);

        req.setAttribute("realEstateList",realEstateDTOS);
        req.getRequestDispatcher("RealEstateSearch.jsp").forward(req,resp);
    }
}
