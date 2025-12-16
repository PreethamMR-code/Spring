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
import java.util.Optional;

@WebServlet(urlPatterns = "/Update",loadOnStartup = 1)
public class UpdateServlet extends HttpServlet {

    private RealEstateService realEstateService  = new RealEstateServiceImpl();

    public UpdateServlet(){
        System.out.println("update servlet started");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("do post strated");

        String fullname= req.getParameter("fullName");
        String emailId = req.getParameter("email");
        String property = req.getParameter("propertyType");
        double budget = Double.parseDouble(req.getParameter("budget"));
        String message = req.getParameter("message");

        RealEstateDTO realEstateDTO = new RealEstateDTO(fullname,emailId,property,budget,message);

        boolean update = realEstateService.update(realEstateDTO);
        if (update) {
            // reload from DB using email as key
            SearchDTO searchDTO = new SearchDTO(emailId);
            Optional<RealEstateDTO> optionalRealEstateDTO = realEstateService.findByGmail(searchDTO);
            optionalRealEstateDTO.ifPresent(dto -> req.getSession().setAttribute("editDTO", dto));

            req.setAttribute("success", "Successfully updated details");
        } else {
            req.setAttribute("error", "Not valid, update failed");
        }
        req.getRequestDispatcher("Update.jsp").forward(req, resp);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("running do get in update servlet");
        System.out.println("forwarding to registration .jsp");

        String emailId = req.getParameter("emailId");
        SearchDTO searchDTO = new SearchDTO(emailId);

        Optional<RealEstateDTO> optionalRealEstateDTO = realEstateService.findByGmail(searchDTO);
        if(optionalRealEstateDTO.isPresent())
        {
            req.getSession().setAttribute("editDTO",optionalRealEstateDTO.get());

        }else {
            req.setAttribute("message", "record not found");
        }
        req.getRequestDispatcher("Update.jsp").forward(req,resp);
    }
}
