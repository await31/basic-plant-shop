/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.plantshop.dao.AccountDAO;
import com.plantshop.dto.Account;

/**
 *
 * @author khoad
 */
public class handleOTPServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String OTP = request.getParameter("OTP");
            String correctOTP = request.getParameter("correctOTP");
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String fullName = request.getParameter("txtfullname");
            String phone = request.getParameter("txtphone");
            int status = 1;
            int role = 0;
            try {
                if (OTP.equals(correctOTP)) {
                    int temp = AccountDAO.insertAccount(email, password, fullName, phone, status, role);
                    if (temp == 1) {
                        response.sendRedirect("login.jsp");
                    } else {
                        response.sendRedirect("errorPage.jsp");
                    }
                } else {
                    request.setAttribute("email_handle_newAccount", email);
                    request.setAttribute("password_handle_newAccount", password);
                    request.setAttribute("fullname_handle_newAccount", fullName);
                    request.setAttribute("phone_handle_newAccount", phone);
                    request.setAttribute("correctOTP", correctOTP);
                    request.setAttribute("warningMSG_handle" , 1);
                    request.getRequestDispatcher("otpInputter.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
