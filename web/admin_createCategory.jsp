<%-- 
    Document   : admin_createPlant
    Created on : Mar 8, 2023, 10:10:36 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Category</title>
        <link rel="stylesheet" href="assets/login.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="stylesheet" href="assets/common.css" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:set var="email" value="${sessionScope.email}"></c:set>
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
        <section style="height: 600px;" id="content-container">
            <div class="container-fluid">
                <div style="margin-top: 7%;" class="row">
                    <form id="login-form" action="mainController" method="post">
                        <h2 style="color: #16B5C4;" class="text-center">Create new Category</h2>
                        <label for="txtname">Category name:</label>
                        <input type="text" autocomplete="off" name="txtname" required="" pattern="^[A-Za-z ]{3,30}$" placeholder="Contains from 3 to 30 letters including spaces"><br>
                        <input type="submit" value="Create category" name="action">
                    </form>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
