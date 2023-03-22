<%-- 
    Document   : orderDetails
    Created on : Feb 10, 2023, 7:09:53 PM
    Author     : DELL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.OrderDetail"%>
<%@page import="com.plantshop.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:set var="email" value="${sessionScope.email}"></c:set>
        <c:choose>
            <c:when test="${name eq null}">
                <header>
                    <c:redirect url="login.jsp"/>
                </header>
            </c:when>
            <c:when test="${name eq 'USER_HANDLE'}">
                <header>
                    <%@include file="header_loginedUser.jsp" %>
                </header>
            </c:when>
            <c:otherwise>
                <header>
                    <%@include file="header_loginedAdmin.jsp" %>
                </header>
            </c:otherwise>
        </c:choose>
        <section style="height: 65px; background-color: black;">
        </section>
        <section>
            <c:set var="orderId" value="${param.id}"></c:set>
            <c:set var="list" value="${OrderDAO.getOrderDetail(orderId)}"></c:set>
                <div class="container">
                    <div class="row">
                        <h1 class="text-center mt-3">Order #${orderId}</h1>
                    <table class="table table-sm table-hover mb-5 mt-3" width="100%">
                        <c:set var="totalPrice" value="0"/>
                        <thead class="table-dark"><th scope="col"> #</th><th scope="col"> Name</th><th scope="col"> Image</th><th scope="col"> Price</th><th scope="col"> Quantity</th><th scope="col"> Subtotal</th></thead>
                            <c:forEach var="detail" items="${list}">
                            <tbody>
                                <c:set var="subtotal" value="${detail.getPrice() * detail.getQuantity()}"/>
                                <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
                            <th scope="row"><c:out value="${detail.getPlantID()}"></c:out></th>
                            <td><c:out value="${detail.getPlantName()}"></c:out></td>
                            <td><img style="width: 80px; height: 80px;" src="${detail.getImgPath()}"></td>
                            <td>$<c:out value="${detail.getPrice()}"></c:out></td>
                            <td><c:out value="${detail.getQuantity()}"></c:out></td>
                            <td>$<c:out value="${subtotal}"></c:out></td>
                                </tbody>
                        </c:forEach>
                        <tfoot class="table-dark">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="fw-bolder text-warning">Total price: $<c:out value="${totalPrice}"></c:out></td>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </section>
            <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
