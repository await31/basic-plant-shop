<%-- 
    Document   : adminIndex
    Created on : Mar 4, 2023, 10:40:31 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin home</title>
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
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
        <section id="index-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12 col-xs-12 px-0">
                        <div style="background-image: url(images/main-banner.png); background-repeat: no-repeat; background-size: cover;" class="banner-image w-100 vh-100 d-flex justify-content-center align-items-center">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
