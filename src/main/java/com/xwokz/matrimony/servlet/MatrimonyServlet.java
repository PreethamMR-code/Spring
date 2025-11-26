package com.xwokz.matrimony.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(urlPatterns = "/matrimony",loadOnStartup = 1)
public class MatrimonyServlet extends HttpServlet {

    public MatrimonyServlet(){
        System.out.println("servlet started");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("doPost started");

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String profileFor = req.getParameter("profileFor");
        String gender = req.getParameter("gender");
        String dobStr = req.getParameter("dob");
        String motherTongue = req.getParameter("motherTongue");
        String religion = req.getParameter("religion");
        String maritalStatus = req.getParameter("maritalStatus");
        String heightStr = req.getParameter("height");


        req.setAttribute("fullName", fullName);
        req.setAttribute("email", email);
        req.setAttribute("profileFor", profileFor);
        req.setAttribute("gender", gender);
        req.setAttribute("dob", dobStr);
        req.setAttribute("motherTongue", motherTongue);
        req.setAttribute("religion", religion);
        req.setAttribute("maritalStatus", maritalStatus);
        req.setAttribute("height", heightStr);

        try {
            // connexting data base

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/matrimony_db",
                    "root",
                    "0000"
            );

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO matrimony(full_name, email, profile_for, gender, dob, mother_tongue, religion, marital_status, height) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, profileFor);
            ps.setString(4, gender);
            ps.setString(5, dobStr);
            ps.setString(6, motherTongue);
            ps.setString(7, religion);
            ps.setString(8, maritalStatus);
            ps.setString(9, heightStr);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                req.setAttribute("success", "Your details have been successfully saved to the database!");
            } else {
                req.setAttribute("fail", "Failed to save your details. Please try again.");
            }

        } catch (Exception e) {
            req.setAttribute("fail", "Database Error: " + e.getMessage());
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("MatrimonyResult.jsp");
        dispatcher.forward(req, resp);
    }

    }
