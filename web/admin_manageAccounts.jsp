<%-- 
    Document   : manageAccounts
    Created on : Mar 4, 2023, 11:45:16 AM
    Author     : DELL
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.Account"%>
<%@page import="com.plantshop.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Account</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <style>

        .accountTable tr:first-child {
            background-color: #74a973;
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
        <section style="height: 65px; background-color: #74a973;">

        </section>
        <section>
            <div class="container">
                <div class="row">
                    <h1 class="text-center text-success">Accounts Management</h1>
                    <form action="mainController" method="post">
                        <input class="form-control-sm" type="text" name="txtsearchacc" placeholder="Enter account name">
                        <input class="btn btn-success btn-sm" type="submit" value="Search account" name="action">
                    </form>
                    <h1></h1>
                    <table class="accountTable">
                        <tr><th> ID</th><th> Email</th><th> Full name</th><th> Status</th><th> Phone</th><th> Role</th><th> Action 1</th><th> Action 2</th></tr>
                                <c:forEach var="acc" items="${requestScope.accountList}">
                            <tr>
                                <td><c:out value="${acc.getId()}"></c:out></td>
                                <td><c:out value="${acc.getEmail()}"></c:out></td>
                                <td><c:out value="${acc.getFullName()}"></c:out></td>
                                    <td>
                                    <c:choose>
                                        <c:when test="${acc.getStatus() eq 1}"> Active</c:when>
                                        <c:otherwise> Blocked</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${acc.getPhone()}"></c:out></td>
                                    <td>
                                    <c:choose>
                                        <c:when test="${acc.getRole() eq 1}">Admin</c:when>
                                        <c:otherwise>User</c:otherwise>
                                    </c:choose></td>
                                <td>
                                    <c:if test="${acc.getRole() eq 0}">
                                        <c:url var="mylink" value="mainController">
                                            <c:param name="email" value="${acc.getEmail()}"></c:param>
                                            <c:param name="status" value="${acc.getStatus()}"></c:param>
                                            <c:param name="action" value="updateStatusAccount"></c:param>
                                        </c:url>
                                        <c:if test="${acc.getStatus() eq 1}"><a class="text-danger fw-bolder" href="${mylink}">Block</a></c:if>
                                        <c:if test="${acc.getStatus() eq 0}"><a class="text-success fw-bolder" href="${mylink}">Unblock</a></c:if>
                                    </c:if>
                                </td>
                                <td class="d-none">
                                    <c:if test="${acc.getRole() eq 0}">
                                        <c:url var="mylink3" value="mainController">
                                            <c:param name="action" value="deleteAccount"></c:param>
                                            <c:param name="id" value="${acc.getId()}"></c:param>
                                        </c:url>
                                        <a class="text-danger fw-bolder" href="${mylink3}">Delete</a>
                                    </c:if>
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
