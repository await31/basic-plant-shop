<%-- 
    Document   : errorPage.jsp
    Created on : Feb 10, 2023, 4:49:30 PM
    Author     : DELL
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oops, something went wrong</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body class="bg-dark">
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
        <div class="d-flex h-100 text-center text-bg-dark">
            <div class="container-fluid d-flex w-100 h-100 p-3 mx-auto flex-column">
                <main style="margin-top: 22%; margin-bottom: 15%;" class="px-3 justify-content-center row">
                    <h1>Oops, something went wrong.</h1>
                    <p class="lead text-center mx-5">Some thing went wrong. Please try again.</p>
                    <p class="lead">
                        <a href="index.jsp" class="btn btn-lg btn-light fw-bold border-white bg-white">Home</a>
                    </p>
                </main>
            </div>
        </div>

    </body>
</html>
