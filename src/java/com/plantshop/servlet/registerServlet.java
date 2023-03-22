package com.plantshop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.plantshop.dao.AccountDAO;
import com.plantshop.dto.Account;

/**
 *
 * @author DELL
 */
public class registerServlet extends HttpServlet {

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
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String fullName = request.getParameter("txtfullname");
            String phone = request.getParameter("txtphone");
//            int status = 1;
//            int role = 0;
            Account kq = AccountDAO.getAccount(email);
            if (kq == null) {
                request.setAttribute("email_newAccount", email);
                request.setAttribute("password_newAccount", password);
                request.setAttribute("fullname_newAccount", fullName);
                request.setAttribute("phone_newAccount", phone);
                request.getRequestDispatcher("sendOTPServlet").forward(request, response);
//                int temp = AccountDAO.insertAccount(email, password, fullName, phone, status, role);
//                if (temp == 1) {
//                } else {
//                    response.sendRedirect("errorPage.jsp");
//                }
            } else {
                request.setAttribute("WARNING", "Your email has already been taken, please try to use another email!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
