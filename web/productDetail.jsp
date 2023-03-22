<%-- 
    Document   : productDetail
    Created on : Mar 3, 2023, 7:25:26 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dao.PlantDAO"%>
<%@page import="com.plantshop.dto.Plant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <style>body{background-color: #000}.card{border:none}.product{background-color: #eee}.brand{font-size: 13px}.act-price{color:red;font-weight: 700}.dis-price{text-decoration: line-through}.about{font-size: 14px}.color{margin-bottom:10px}label.radio{cursor: pointer}label.radio input{position: absolute;top: 0;left: 0;visibility: hidden;pointer-events: none}label.radio span{padding: 2px 9px;border: 2px solid #ff0000;display: inline-block;color: #ff0000;border-radius: 3px;text-transform: uppercase}label.radio input:checked+span{border-color: #ff0000;background-color: #ff0000;color: #fff}.btn-danger{background-color: #ff0000 !important;border-color: #ff0000 !important}.btn-danger:hover{background-color: #da0606 !important;border-color: #da0606 !important}.btn-danger:focus{box-shadow: none}.cart i{margin-right: 10px}</style>
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:choose>
            <c:when test="${name eq null}">
                <header>
                    <%@include file="header.jsp" %>
                </header>
            </c:when>
            <c:when test="${role eq 'USER_HANDLE'}">
                <header>
                    <%@include file="header_loginedUser.jsp" %>
                </header>
            </c:when>
            <c:when test="${role eq 'ADMIN_HANDLE'}">
                <header>
                    <%@include file="header_loginedAdmin.jsp" %>
                </header>
            </c:when>
        </c:choose>
        <section>
            <c:set var="productId" value="${param.productid}"></c:set>
            <c:set var="plant" value="${PlantDAO.getPlantDetail(productId)}"></c:set>
                <section style="height: 65px;" class="bg-dark"></section>
                <div class="container mt-5 mb-5">
                    <div class="row d-flex justify-content-center">
                        <div class="col-md-10">
                            <div class="card">
                                <div class="row">
                                    <div class="col-md-6 pe-0">
                                        <div style="max-height: 506px;" class="images w-100 h-100">
                                            <img id="main-image" class="img-fluid w-100 h-100" src="${plant.getImgPath()}"/>
                                    </div>
                                </div>
                                <div class="col-md-6 ps-0">
                                    <div class="product p-4 pt-3 h-100 position-relative">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <a class="text-decoration-none text-dark" href="index.jsp#shop-zone"><div class="d-flex align-items-center"> <i class="fa fa-long-arrow-left me-1"></i> <span class="ml-1">Back</span></div></a> <i class="fa-solid fa-seedling text-success"></i>
                                        </div>
                                        <div class="mt-4 mb-3"> <span class="text-uppercase text-muted brand">${plant.getCateName()}</span>
                                            <h5 class="text-uppercase">${plant.getName()}</h5>
                                            <div class="price d-flex flex-row align-items-center"> <span class="act-price text-danger">$${plant.getPrice()}</span>
                                                <div class="ml-2"> <small class="dis-price ms-2">$${plant.getPrice()*2}</small> <span style="background-color: red;" class="badge">50% OFF</span> </div>
                                            </div>
                                        </div>
                                        <h1>${requestScope.productid}</h1>
                                        <p class="about"><c:out value="${plant.getDescription()}"></c:out></p>
                                        <c:choose>
                                            <c:when test="${plant.getStatus() eq 1}"><p>Status: <span class="fw-bolder text-success">Available</span></p></c:when>
                                            <c:otherwise><p>Status: <span class="fw-bolder text-danger">Out of stock</span></p></c:otherwise>
                                        </c:choose>
                                        <div style="padding-bottom: 14%;" class="sizes mt-5">

                                        </div>
                                        <c:choose>
                                            <c:when test="${plant.getStatus() eq 1}"><div style="bottom: 3%; left: 37%;" class="cart mt-4 align-items-center position-absolute"><a href="mainController?action=addtocart&pid=${plant.getId()}" class="btn btn-danger text-uppercase mr-2 px-4 me-3">Add to cart</a></div></c:when>
                                            <c:otherwise><div style="bottom: 3%; left: 37%;" class="cart mt-4 align-items-center position-absolute"><a href="mainController?action=addtocart&pid=${plant.getId()}" class="disabled btn btn-secondary text-uppercase mr-2 px-4 me-3">Add to cart</a></div></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
