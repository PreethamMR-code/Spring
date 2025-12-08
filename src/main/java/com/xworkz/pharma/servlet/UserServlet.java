package com.xworkz.pharma.servlet;

import com.xworkz.pharma.dto.SearchDTO;
import com.xworkz.pharma.dto.UserDto;
import com.xworkz.pharma.exception.InvalidException;
import com.xworkz.pharma.service.UserServiceImpl;
import com.xworkz.pharma.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;


@WebServlet(urlPatterns = "/UserServlet",loadOnStartup = 1)
public class UserServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

   public UserServlet(){
       System.out.println("user servlet created");
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("do post started");
        resp.setContentType("text/html");

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        int age = Integer.parseInt(req.getParameter("age"));

        UserDto userDto = new UserDto(firstName,lastName,email,phone,age);

        try {
            userService.validateAndSave(userDto);


            req.setAttribute("firstName", firstName);
            req.setAttribute("lastName", lastName);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("age", age);

            RequestDispatcher rd = req.getRequestDispatcher("UserResult.jsp");
            rd.forward(req , resp);
//
            System.out.println("DTO:"+userDto);

        }catch (InvalidException e){
            System.out.println("data invalid");
            e.printStackTrace();
        }


        System.out.println("do post end");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

       String phone = req.getParameter("phone");
        SearchDTO searchDTO = new SearchDTO(phone);

        Optional<UserDto> optionalUserDto = this.userService.findByPhone(searchDTO);

        if(optionalUserDto.isPresent()){
            req.setAttribute("message","search results not found");
        }
        req.getRequestDispatcher("Search.jsp").forward(req,resp);
    }
}

