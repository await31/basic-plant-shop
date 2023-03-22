<%-- 
    Document   : register
    Created on : Feb 10, 2023, 11:29:13 AM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="assets/register.css" type="text/css">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="assets/common.css" type="text/css">
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
                            <form id="signup-form" action="mainController" method="post">
                                <h2 style="color: #16B5C4;" class="text-center">Register</h2>
                                <label for="txtemail">Email:</label>
                                <input type="email" autocomplete="off" name="txtemail" required=""><br>
                                <font class="fw-bolder" style='font-size: 14px; color: red;'><%= request.getAttribute("WARNING") == null ? "" : (String) request.getAttribute("WARNING")%></font><br>
                                <label for="txtfullname">Full name:</label>
                                <input type="text" autocomplete="off" id="txtfullname" name="txtfullname" required="" pattern="^[A-Za-z ]{5,30}$"><br>
                                <div id="message3">
                                    <h4>Full name must follow these conditions:</h4>
                                    <p id="letter3" class="invalid"><b>Contains only letters and spaces</b></p>
                                    <p id="length3" class="invalid"><b>Length must be from 5-30 characters</b></p>
                                </div>
                                <label for="txtpassword">Password:</label>
                                <input type="password" id="txtpassword" name="txtpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required=""><br>
                                <div id="message">
                                    <h4>Password must follow these conditions:</h4>
                                    <p id="letter" class="invalid"><b>At least 1 lowercase letter</b></p>
                                    <p id="capital" class="invalid"> <b>At least 1 uppercase letter</b></p>
                                    <p id="number" class="invalid"> <b>At least 1 digit</b></p>
                                    <p id="length" class="invalid"> <b>Length must be 8 characters or more</b></p>
                                </div>
                                <label for="txtphone">Phone number:</label>
                                <input type="text" autocomplete="off" id="txtphone" name="txtphone" pattern="^[0-9]{10,11}$" required=""><br>
                                <div id="message4">
                                    <h4>Phone number must follow these conditions:</h4>
                                    <p id="letter4" class="invalid"> <b>Length from 10-11 digits</b></p>
                                </div>
                                <input type="submit" value="Register" name="action">
                                <p class="mb-0 text-center">Already have an account? <a style="text-decoration: none; color: #16B5C4;" href="login.jsp">Log in</a> now!</p>
                            </form>
                        </div>
                    </div>
                </section>
                <footer>
                    <%@include file="footer.jsp" %>
                </footer>
                <script>
                    var myInput = document.getElementById("txtpassword");
                    var myInput3 = document.getElementById("txtfullname");
                    var myInput4 = document.getElementById("txtphone");

                    //myInput for txtpassword
                    var letter = document.getElementById("letter");
                    var capital = document.getElementById("capital");
                    var number = document.getElementById("number");
                    var length = document.getElementById("length");

                    //myInput3 for txtfullname
                    var letter3 = document.getElementById("letter3");
                    var length3 = document.getElementById("length3");

                    //myInput4 for txtphone
                    var letter4 = document.getElementById("letter4");

                    // When the user clicks on the password field, show the message box
                    myInput.onfocus = function () {
                        document.getElementById("message").style.display = "block";
                    }
                    // When the user clicks outside of the password field, hide the message box
                    myInput.onblur = function () {
                        document.getElementById("message").style.display = "none";
                    }

                    // When the user clicks on the password field, show the message box
                    myInput3.onfocus = function () {
                        document.getElementById("message3").style.display = "block";
                    }
                    // When the user clicks outside of the password field, hide the message box
                    myInput3.onblur = function () {
                        document.getElementById("message3").style.display = "none";
                    }

                    // When the user clicks on the password field, show the message box
                    myInput4.onfocus = function () {
                        document.getElementById("message4").style.display = "block";
                    }
                    // When the user clicks outside of the password field, hide the message box
                    myInput4.onblur = function () {
                        document.getElementById("message4").style.display = "none";
                    }

                    // When the user starts to type something inside the password field
                    // (?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}
                    myInput.onkeyup = function () {
                        // Validate lowercase letters
                        var lowerCaseLetters = /[a-z]/g;
                        if (myInput.value.match(lowerCaseLetters)) {
                            letter.classList.remove("invalid");
                            letter.classList.add("valid");
                        } else {
                            letter.classList.remove("valid");
                            letter.classList.add("invalid");
                        }

                        // Validate capital letters
                        var upperCaseLetters = /[A-Z]/g;
                        if (myInput.value.match(upperCaseLetters)) {
                            capital.classList.remove("invalid");
                            capital.classList.add("valid");
                        } else {
                            capital.classList.remove("valid");
                            capital.classList.add("invalid");
                        }

                        // Validate numbers
                        var numbers = /[0-9]/g;
                        if (myInput.value.match(numbers)) {
                            number.classList.remove("invalid");
                            number.classList.add("valid");
                        } else {
                            number.classList.remove("valid");
                            number.classList.add("invalid");
                        }

                        // Validate length
                        if (myInput.value.length >= 8) {
                            length.classList.remove("invalid");
                            length.classList.add("valid");
                        } else {
                            length.classList.remove("valid");
                            length.classList.add("invalid");
                        }
                    }

                    // When the user starts to type something inside the password field
                    // ^[A-Za-z ]{5,30}$
                    myInput3.onkeyup = function () {

                        var regex3 = /^[A-Za-z ]+$/g;

                        if (myInput3.value.match(regex3)) {
                            letter3.classList.remove("invalid");
                            letter3.classList.add("valid");
                        } else {
                            letter3.classList.remove("valid");
                            letter3.classList.add("invalid");
                        }

                        if (myInput3.value.length >= 5 && myInput3.value.length <= 30) {
                            length3.classList.remove("invalid");
                            length3.classList.add("valid");
                        } else {
                            length3.classList.remove("valid");
                            length3.classList.add("invalid");
                        }
                    }

                    // When the user starts to type something inside the password field
                    // ^[0-9]{10,11}$
                    myInput4.onkeyup = function () {

                        var regex4 = /^[0-9]{10,11}$/g;

                        if (myInput4.value.match(regex4)) {
                            letter4.classList.remove("invalid");
                            letter4.classList.add("valid");
                        } else {
                            letter4.classList.remove("valid");
                            letter4.classList.add("invalid");
                        }
                    }
                </script>
            </c:when>
            <c:otherwise>
                <c:redirect url="index.jsp"></c:redirect>
            </c:otherwise>
        </c:choose>
    </body>
</html>
