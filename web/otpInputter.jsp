<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter OTP</title>
        <link rel="stylesheet" href="assets/login.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="stylesheet" href="assets/common.css" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <style>
        .unselectable {
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
    </style>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:if test="${!name eq null}">
            <c:redirect url="index.jsp"></c:redirect>
        </c:if>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <c:set var="email" value="${requestScope.email_handle_newAccount}"></c:set>
        <c:set var="correctOTP" value="${requestScope.correctOTP}"></c:set>
        <c:set var="password" value="${requestScope.password_handle_newAccount}"></c:set>
        <c:set var="fullname" value="${requestScope.fullname_handle_newAccount}"></c:set>
        <c:set var="phone" value="${requestScope.phone_handle_newAccount}"></c:set>
        <c:set var="warningmsg" value="${requestScope.warningMSG_handle}"></c:set>
            <section style="height: 600px;" id="content-container">
                <div class="container-fluid">
                    <div style="margin-top: 2%;" class="row">
                        <form id="login-form" action="mainController" method="post">
                            <p class="mt-3 text-danger fst-italic text-center">*Enter the captcha below to complete registration!</p>
                            <div class="text-center text-warning bg-dark mb-2 pb-2 pt-2 unselectable"><p style="font-family: MV Boli;" class="mb-0">${correctOTP}</p></div>
                        <input type="text" class="d-none" name="correctOTP" value="${correctOTP}">
                        <input type="text" class="d-none" name="txtemail" value="${email}">
                        <input type="text" class="d-none" name="txtpassword" value="${password}">
                        <input type="text" class="d-none" name="txtfullname" value="${fullname}">
                        <input type="text" class="d-none" name="txtphone" value="${phone}">
                        <input type="text" autocomplete="off" name="OTP" placeholder="Enter captcha here"><br>
                        <c:if test="${warningmsg eq 1}">
                            <p class="text-danger">*Your input is wrong, please try again</p>
                        </c:if>
                        <input type="submit" value="Submit captcha" name="action">
                    </form>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
