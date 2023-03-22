<%-- 
    Document   : viewCart
    Created on : Mar 1, 2023, 9:37:22 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.plantshop.dao.PlantDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.Plant"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <title>Your cart</title>
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
        <section style="height: 65px; background-color: black;">
        </section>
        <section>
            <h1 class="text-center mt-3 mb-4">Shopping cart</h1>
            <c:set var="price" value="0"></c:set>
            <c:set var="list" value="${PlantDAO.getPlants('','')}"></c:set>
            <font style='color: red;'><%= request.getAttribute("WARNING") == null ? "" : (String) request.getAttribute("WARNING")%></font>
            <c:set var="cart" value="${sessionScope.cart}"></c:set>
            <c:set var="money" value="0"></c:set>
                <table width="100%" class="table table-lg table-bordered table-hover mb-0">
                    <thead class="table-primary"><tr class="mb-5"><td>#ID</td><td>Image</td><td>Price</td><td>Quantity</td><td>Action 1</td><td>Action 2</td></tr></thead>
                <c:choose>
                    <c:when test="${not empty cart}">
                        <c:set var="pids" value="${cart.keySet()}"></c:set>
                        <c:forEach var="pid" items="${pids}">
                            <c:set var="quantity" value="${cart.get(pid)}"></c:set>
                                <tbody>
                                <form action="mainController" method="post">
                                    <tr>
                                        <th scope="row"><input type="hidden" value="${pid}" name="pid"><a class="btn text-dark" href="productDetail.jsp?productid=${pid}">${pid}</a></th>
                                        <c:forEach var="p" items="${list}">
                                            <c:set var="plantid" value="${p.getId()}"></c:set>    
                                            <c:if test="${plantid eq pid}">
                                            <td><img style='width: 120px; height: 120px;' src='${p.getImgPath()}'></td>
                                            <td>$${p.getPrice()}</td>
                                            <c:set var="money" value="${money + (p.getPrice()*quantity)}"></c:set>
                                        </c:if>
                                    </c:forEach>
                                    <td><input type="number" value="${quantity}" name="quantity" min="1" max="10"></td>
                                    <td><input class="btn btn-success" type="submit" value="Update" name="action"></td>
                                    <td><input class="btn btn-danger" type="submit" value="Delete" name="action"></td>
                                </tr>
                            </form>
                            </tbody>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="height: 280px;"></div>
                    </c:otherwise>
                </c:choose>
                <tfoot class="table-primary"><tr><td></td><td></td><td>Order date: <%=(new Date()).toString()%></td><td>Ship date: N/A</td><td>Total cost: $${money}</td><td><form action="mainController" method="post"><input type="submit" value="Order" name="action" class="submitorder btn btn-success mt-4 mb-4 ms-auto"></form></td></tr></tfoot>
            </table>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
