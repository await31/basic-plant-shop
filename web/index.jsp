<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.plantshop.dao.PlantDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.Plant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plant Shop</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <style>
            .cover-container {
                max-width: 42em;
            }

            .container {
                padding: 0 10px;
                max-width: 1260px;
                min-width: 1260px;
            }

            .product-information p {
                margin-bottom: 4px;
            }

            .addToCart:hover {
                cursor: pointer;
            }

            .my-hover:hover {
                opacity: 0.9;
            }


        </style>
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
        <section style="background-image: linear-gradient(to right, #0F3443, #34E89E);" class="pb-5">
            <div class="container-fluid col-xxl-8 px-4 py-5">
                <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
                    <div class="col-10 col-sm-8 col-lg-6 col-sm-12 col-xs-12">
                        <img src="images/banner-img.jpg" class="img-fluid mx-lg-auto rounded-3 border border-success border-2" alt="banner" width="700" height="500" loading="lazy">
                    </div>
                    <div class="col-lg-6" style="margin-top: 7%;">
                        <h2 style="color: aquamarine;" class="display-3 fw-bold lh-1 mb-3">"To plant a garden is to believe in tomorrow"</h2>
                        <p style="color: floralwhite;" class="lead">Welcome to our place! We are thrilled to offer you a wide variety of high-quality plants that will brighten up any space. Whether you're a seasoned plant parent or just starting out, we have something for everyone. Our inventory includes succulents, houseplants, and even rare finds that are hard to come by. Happy shopping!</p>
                        <c:if test="${name eq null}">
                            <div class="d-grid gap-2 d-md-flex justify-content-md-start mt-2">
                                <a href="register.jsp" type="button" class="btn btn-success btn-lg px-4 me-md-2">Register</a>
                                <a href="login.jsp" type="button" class="btn btn-outline-light btn-lg px-4">Login</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
        <section style="background-color: #fcfaf1;">
            <h1 style="color: #34E89E;" class="text-center pt-4 mb-4">Our products</h1>
            <div id="shop-zone" class="container">
                <div class="row justify-content-center">
                    <form action="mainController" method="post" class="d-flex mb-3">
                        <input style="width: 66.4%; margin-left: 5.4%;" placeholder="Enter keyword" class="form-control me-4" type="text" name="txtsearch" value="<%= (request.getParameter("txtsearch") == null) ? "" : request.getParameter("txtsearch")%>">
                        <select style="width: 14%;" class="form-select form-select-sm mx-1" name="searchBy">
                            <option>Search by name</option>
                            <option>Search by category</option>
                        </select>
                        <input style="width: 6.2%;" class="btn btn-dark me-2" type="submit" value="Search" name="action">
                    </form>
                    <c:set var="defaultList" value="${PlantDAO.getPlants(&quot;&quot;, &quot;&quot;)}"></c:set>
                    <c:set var="list" value="${requestScope.list}"></c:set>
                    <c:choose>
                        <c:when test="${list.size() < defaultList.size()}">
                            <c:forEach var="p" items="${list}">
                                <div style="width: 20%; height:400px" class="card mt-2 mb-3 mx-3 px-0 col-md-3 col-xs-12 col-sm-12">
                                    <img style="height: 50%; width: 100%;" src='${p.getImgPath()}' class="my-hover card-img-top" alt="Not update yet!">
                                    <a class="text-muted text-decoration-none" href="productDetail.jsp?productid=${p.getId()}"><h5 class="mt-2 text-center card-title">${p.getName()}</h5></a>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">Price: <span style="font-weight: bolder;">$${p.getPrice()}</span></li>
                                        <li class="list-group-item">Category: ${p.getCateName()}</li>
                                            <c:choose>
                                                <c:when test="${p.getStatus() eq 1}">
                                                <li class="list-group-item"><p class="mb-0">Status: <span style="color: green; font-weight: bolder;"> Available</span></p></li>
                                                <a class="btn btn-success" href="mainController?action=addtocart&pid=${p.getId()}">Add to cart</a>
                                            </c:when>
                                            <c:otherwise> 
                                                <li class="list-group-item"><p class="mb-0">Status: <span style="color: red; font-weight: bolder;"> Out of stock</span></p></li>
                                                <a class="btn btn-secondary disabled" href="mainController?action=addtocart&pid=${p.getId()}">Add to cart</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise> 
                            <c:forEach var="p" items="${defaultList}">
                                <div style="width: 20%; height:400px" class="card mt-2 mb-3 mx-3 px-0 col-md-3 col-xs-12 col-sm-12">
                                    <img style="height: 50%; width: 100%;" src='${p.getImgPath()}' class="my-hover card-img-top" alt="Not update yet!">
                                    <a class="text-muted text-decoration-none" href="productDetail.jsp?productid=${p.getId()}"><h5 class="mt-2 text-center card-title">${p.getName()}</h5></a>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">Price: <span style="font-weight: bolder;">$${p.getPrice()}</span></li>
                                        <li class="list-group-item">Category: ${p.getCateName()}</li>
                                            <c:choose>
                                                <c:when test="${p.getStatus() eq 1}">
                                                <li class="list-group-item"><p class="mb-0">Status: <span style="color: green; font-weight: bolder;"> Available</span></p></li>
                                                <a class="btn btn-success" href="mainController?action=addtocart&pid=${p.getId()}">Add to cart</a>
                                            </c:when>
                                            <c:otherwise> 
                                                <li class="list-group-item"><p class="mb-0">Status: <span style="color: red; font-weight: bolder;"> Out of stock</span></p></li>
                                                <a class="btn btn-secondary disabled" href="mainController?action=addtocart&pid=${p.getId()}">Add to cart</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>


