<%-- 
    Document   : manageAccounts
    Created on : Mar 4, 2023, 11:45:16 AM
    Author     : DELL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.Order"%>
<%@page import="com.plantshop.dao.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Order</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <style>
        .orderTable tr:first-child {
            background-color: #27b8ef;
            color: white;
            font-size: 20px;
        }
    </style>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:choose>
            <c:when test="${name eq null}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:when>
            <c:when test="${role eq 'USER_HANDLE'}">
                <c:redirect url="personalPage.jsp"></c:redirect>
            </c:when>
            <c:when test="${role eq 'ADMIN_HANDLE'}">
                <header>
                    <%@include file="header_loginedAdmin.jsp" %>
                </header>
            </c:when>
        </c:choose>
        <section style="height: 65px; background-color: #27b8ef;">

        </section>
        <section>
            <div class="container">
                <div class="row">
                    <h1 class="text-center text-info">Orders Management</h1>
                    <div style="height:30px; display: flex; flex-direction: row;" class="mb-4 mt-3">
                        <form style="margin-top: auto;" action="mainController" method="post">
                            <input class="form-control-sm" type="text" name="txtsearchord" placeholder="Enter account name">
                            <input class="btn btn-info btn-sm text-white" type="submit" value="SearchOrder" name="action">
                        </form>
                        <form style="height: 30px; margin-left: auto; display: flex; flex-direction: row;" method="post" action="mainController">
                            <label for="fromDate">From:</label>
                            <input class="form-control-sm mx-2" type="date" name="fromDate" id="fromDate" class="ms-2 me-2" required>
                            <br><br>
                            <label for="toDate">&#10140; To:</label>
                            <input class="form-control-sm mx-2" type="date" name="toDate" id="toDate" class="ms-2 me-2" required>
                            <input class="btn btn-info text-white btn-sm" type="submit" value="Filter" name="action">
                        </form>
                    </div>
                    <h4><span style="color: red;">*ATTENTION: </span> Enter account name to track their orders!</h4>
                    <table class="orderTable">
                        <tr><th> ID</th><th> Order Date</th><th> Ship Date</th><th> Status</th><th> Account ID</th><th> Account name</th><th>Action 1</th><th>Action 2</th><th>Action 3</th><th>Action 4</th></tr>
                                <c:forEach var="ord" items="${requestScope.orderList}">
                            <tr>
                                <td><c:out value="${ord.getOrderID()}"></c:out></td>
                                <td><c:out value="${ord.getOrderDate()}"></c:out></td>
                                    <td>
                                    <c:choose>
                                        <c:when test="${ord.getShipDate() eq null}"> Not yet</c:when>
                                        <c:otherwise>${ord.getShipDate()}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ord.getStatus() eq 1}">  <h5 style="color: #30bcc3;">Processing</h5></c:when>
                                        <c:when test="${ord.getStatus() eq 2}">  <h5 style="color: #18c418;">Completed</h5></c:when>
                                        <c:when test="${ord.getStatus() eq 3}">  <h5 style="color: #e74b4b;">Canceled</h5></c:when>
                                    </c:choose>
                                </td>
                                <td><c:out value="${ord.getAccID()}"></c:out></td>
                                <td><c:out value="${ord.getAccName()}"></c:out></td>
                                    <td>
                                    <c:if test="${ord.getStatus() eq 1}">
                                        <c:url var="mylink1" value="mainController">
                                            <c:param name="action" value="completeOrder"></c:param>
                                            <c:param name="id" value="${ord.getOrderID()}"></c:param>
                                        </c:url>
                                        <a class="text-success fw-bolder" href="${mylink1}">Complete</a>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${ord.getStatus() eq 1}">
                                        <c:url var="mylink2" value="mainController">
                                            <c:param name="action" value="cancelOrder"></c:param>
                                            <c:param name="id" value="${ord.getOrderID()}"></c:param>
                                        </c:url>
                                        <a class="text-warning fw-bolder" href="${mylink2}">Cancel</a>
                                    </c:if>
                                </td>
                                <td class="d-none">
                                    <c:url var="mylink3" value="mainController">
                                        <c:param name="action" value="deleteOrder"></c:param>
                                        <c:param name="id" value="${ord.getOrderID()}"></c:param>
                                    </c:url>
                                    <a class="text-danger fw-bolder" href="${mylink3}">Delete</a>
                                </td>
                                <td>
                                    <c:url var="mylink4" value="orderDetails.jsp?id=${ord.getOrderID()}">
                                    </c:url>
                                    <a class="text-info fw-bolder" href="${mylink4}">Detail</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
