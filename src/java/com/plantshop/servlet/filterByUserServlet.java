/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.servlet;

import com.plantshop.dao.OrderDAO;
import com.plantshop.dto.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author khoad
 */
public class filterByUserServlet extends HttpServlet {

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
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String[] checkboxValues = request.getParameterValues("myCheckbox");
            Date fromDate = Objects.nonNull(fromDateStr) ? Date.valueOf(fromDateStr) : null;
            Date toDate = Objects.nonNull(toDateStr) ? Date.valueOf(toDateStr) : null;
            if (checkboxValues == null || checkboxValues.length < 1) {
                ArrayList<Order> orderList = OrderDAO.getFilteredOrders(email, fromDate, toDate);
                request.setAttribute("orderList", orderList);
                request.getRequestDispatcher("filterOrders.jsp").forward(request, response);
            } else if (checkboxValues != null || checkboxValues.length >= 1) {
                ArrayList<Order> orderList = OrderDAO.getFilteredOrders(email, fromDate, toDate, checkboxValues);
                request.setAttribute("orderList", orderList);
                request.getRequestDispatcher("filterOrders.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(filterOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
