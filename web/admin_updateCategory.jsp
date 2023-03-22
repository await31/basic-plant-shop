<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Category</title>
        <link rel="stylesheet" href="assets/login.css" type="text/css">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
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
        <c:set var="cateId" value="${param.id}"></c:set>
        <c:set var="cateName" value="${param.name}"></c:set>
            <section style="height: 600px;" id="content-container">
                <div class="container-fluid">
                    <div style="margin-top: 2%;" class="row">
                        <form id="login-form" action="mainController" method="post">
                            <h2 style="color: #16B5C4;" class="text-center">Update category</h2>
                            <label for="txtid">Category ID:</label>
                            <input type="text" autocomplete="off" name="txtid" value="${cateId}" readonly='true'><br>
                        <label for="txtname">New category name:</label>
                        <input type="text" autocomplete="off" name="txtname" required="" pattern="^[A-Za-z ]{3,30}$" placeholder="Contains from 3 to 30 letters including spaces"><br>
                        <p class="text-danger">*Old name: ${cateName}</p>
                        <input type="submit" value="Update category" name="action">
                    </form>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>

    </body>
</html>
