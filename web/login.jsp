<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="assets/login.css" type="text/css">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="stylesheet" href="assets/common.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:choose>
            <c:when test="${name eq null}">
                <header>
                    <%@include file="header.jsp" %>
                </header>
                <section id="content-container">
                    <div class="container-fluid">
                        <div class="row">
                            <form id="login-form" action="mainController" method="post">
                                <h2 style="color: #16B5C4;" class="text-center">Login</h2>
                                <label for="txtemail">Email:</label>
                                <input type="text" autocomplete="off" name="txtemail" required=""><br>
                                <label for="txtpassword">Password:</label>
                                <input type="password" name="txtpassword" required=""><br>
                                <font class="fw-bolder" style='font-size: 14px; color: red;'><%= request.getAttribute("WARNING") == null ? "" : (String) request.getAttribute("WARNING")%></font><br>
                                <tr><td colspan="2"><input class="me-1" type="checkbox" value="savelogin" name="savelogin">Remember me</td></tr>
                                <input type="submit" value="Login" name="action">
                                <p class="mb-0 text-center">Don't have an account yet? <a style="text-decoration: none; color: #16B5C4;" href="register.jsp">Register</a> now!</p>
                            </form>
                        </div>
                    </div>
                </section>
                <footer>
                    <%@include file="footer.jsp" %>
                </footer>
            </c:when>
            <c:otherwise>
                <c:redirect url="index.jsp"></c:redirect>
            </c:otherwise>
        </c:choose>
    </body>
</html>
