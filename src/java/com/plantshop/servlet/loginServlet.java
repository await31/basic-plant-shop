package com.plantshop.servlet;

import com.plantshop.dao.AccountDAO;
import com.plantshop.dto.Account;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class loginServlet extends HttpServlet {

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
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String save = request.getParameter("savelogin");
            Account acc = null;
            try {
                if (email == null || email.equals("") || password == null || password.equals("")) {
                    Cookie[] c = request.getCookies();
                    String token = "";
                    if (c != null) {
                        for (Cookie aCookie : c) {
                            if (aCookie.getName().equals("selector")) {
                                token = aCookie.getValue();
                            }
                        }
                    }
                    if (!token.equals("")) {
                        response.sendRedirect("index.jsp");
                    } else {
                        response.sendRedirect("errorPage.jsp");
                    }
                } else {
                    acc = AccountDAO.getAccount(email, password);
                    if (acc != null) {
                        if (acc.getRole() == 1) {
                            HttpSession session = request.getSession(true);
                            if (session != null) {
                                session.setAttribute("name", acc.getFullName());
                                session.setAttribute("email", acc.getEmail());
                                session.setAttribute("role", "ADMIN_HANDLE");
                                if (save != null) {
                                    String token = "ABC123"; // sample
                                    AccountDAO.updateToken(token, email);
                                    Cookie cookie = new Cookie("selector", token);
                                    cookie.setMaxAge(60 * 2); // sample
                                    response.addCookie(cookie);
                                }
                                response.sendRedirect("adminIndex.jsp");
                            }
                        } else {
                            if (acc.getStatus() == 1) {
                                HttpSession session = request.getSession(true);
                                if (session != null) {
                                    session.setAttribute("name", acc.getFullName());
                                    session.setAttribute("email", acc.getEmail());
                                    session.setAttribute("phone", acc.getPhone());
                                    session.setAttribute("role", "USER_HANDLE");
                                    if (save != null) {
                                        String token = "ABC123"; // sample
                                        AccountDAO.updateToken(token, email);
                                        Cookie cookie = new Cookie("selector", token);
                                        cookie.setMaxAge(60 * 2); // sample
                                        response.addCookie(cookie);
                                    }
                                    response.sendRedirect("index.jsp");
                                }
                            } else {
                                request.setAttribute("WARNING", "Your account has been blocked!");
                                request.getRequestDispatcher("login.jsp").forward(request, response);
                            }
                        }
                    } else {
                        request.setAttribute("WARNING", "Your email or password is incorrect, please try again!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
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
