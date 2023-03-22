
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class mainController extends HttpServlet {

    private String url = "errorPage.jsp";

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
            String action = request.getParameter("action");
            if (action == null || action.equals("") || action.equals("search")) {
                url = "index.jsp";
            } else if (action.equals("Login")) {
                url = "loginServlet";
            } else if (action.equals("Register")) {
                url = "registerServlet";
            } else if (action.equals("logout")) {
                url = "logoutServlet";
            } else if (action.equals("Search")) {
                url = "searchServlet";
            } else if (action.equals("Change")) {
                url = "changeProfileServlet";
            } else if (action.equals("Order again")) {
                url = "orderAgainServlet";
            } else if (action.equals("Cancel order")) {
                url = "cancelOrderServlet";
            } else if (action.equals("addtocart")) {
                url = "addToCartServlet";
            } else if (action.equals("viewcart")) {
                url = "viewCart.jsp";
            } else if (action.equals("Update")) {
                url = "updateCartServlet";
            } else if (action.equals("Delete")) {
                url = "deleteCartServlet";
            } else if (action.equals("Order")) {
                url = "saveShoppingCartServlet";
            } else if (action.equals("Filter order")) {
                url = "filterByUserServlet";
            } else if (action.equals("Submit captcha")) {
                url = "handleOTPServlet";
            } else if (action.equals("getdetail")) {
                url = "getProductDetail";
                // -----------  ADMIN PLACE ---------------------
                // ----------- ACCOUNT MANAGE ---------------------
            } else if (action.equals("Search account")) {
                url = "manageAccountServlet";
            } else if (action.equals("updateStatusAccount")) {
                url = "updateStatusAccountServlet";
            } else if (action.equals("Modify")) {
                url = "adminModifyAccountServlet";
            } else if (action.equals("deleteAccount")) {
                url = "deleteAccountServlet";
                //----------- END OF ACCOUNT MANAGE ----------------
                // ----------- PLANT MANAGE ---------------------
            } else if (action.equals("SearchPlant")) {
                url = "managePlantServlet";
            } else if (action.equals("Update plant")) {
                url = "adminUpdatePlantServlet";
            } else if (action.equals("getPlantData")) {
                url = "adminGetPlantDataServlet";
            } else if (action.equals("updateStatusPlant")) {
                url = "updateStatusPlantServlet";
            } else if (action.equals("Create plant")) {
                url = "adminCreatePlantServlet";
                //----------- END OF PLANT MANAGE ----------------
                //-----------  ORDER MANAGE ----------------
            } else if (action.equals("SearchOrder")) {
                url = "manageOrderServlet";
            } else if (action.equals("completeOrder")) {
                url = "adminCompleteOrderServlet";
            } else if (action.equals("cancelOrder")) {
                url = "adminCancelOrderServlet";
            } else if (action.equals("deleteOrder")) {
                url = "adminDeleteOrderServlet";
            } else if (action.equals("Filter")) {
                url = "filterOrderServlet";
            } //----------- END OF ORDER MANAGE ----------------
            //----------- CATEGORY MANAGE ----------------
            else if (action.equals("SearchCategory")) {
                url = "manageCategoryServlet";
            } else if (action.equals("Create category")) {
                url = "adminCreateCategoryServlet";
            } else if (action.equals("getCategoryData")) {
                url = "adminGetCategoryDataServlet";
            } else if (action.equals("Update category")) {
                url = "adminUpdateCategoryServlet";
            }
            //----------- END OF CATEGORY MANAGE ----------------
            // -----------  END OF ADMIN PLACE ------------
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
