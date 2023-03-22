<%-- 
    Document   : admin_createPlant
    Created on : Mar 8, 2023, 10:10:36 AM
    Author     : DELL
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.plantshop.dto.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Plant</title>
        <link rel="stylesheet" href="assets/login.css" type="text/css">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="assets/common.css" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:set var="list" value="${CategoryDAO.getCategoriesByAdminForChoices()}"></c:set>
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
        <section id="content-container">
            <div class="container-fluid">
                <div class="row">
                    <form id="login-form" action="mainController" method="post">
                        <h2 style="color: #16B5C4;" class="text-center">Create new Plant</h2>
                        <label for="txtname">Plant name:</label>
                        <input type="text" autocomplete="off" name="txtname" required="" pattern="^[A-Za-z ]{3,30}$" placeholder="Contains only 3-30 letters including space"><br>
                        <label for="txtprice">Price: $</label>
                        <input class="form-control-sm" type="number" autocomplete="off" name="txtprice" required="" min="1" max="100000" placeholder="Price must be from 1 to 100000"><br>
                        <label for="txtimgpath">Image path:</label>
                        <input type="text" autocomplete="off" name="txtimgpath" required="" placeholder="Example: your_img.jpg"><br>
                        <label for="txtdescription">Description:</label>
                        <input type="text" autocomplete="off" name="txtdescription" required="" pattern="^[A-Za-z ]{3,200}$" placeholder="Contains only 3-200 letters including space"><br>
                        <div class="form-check form-switch">
                            <label class="form-check-label" for="flexSwitchCheckDefault">Available</label>
                            <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" name="txtstatus">
                        </div>
                        <label class="mb-2" for="categorySelect">Select a category:</label>
                        <select class="form-select" id="categorySelect" name="categoryId">
                            <c:forEach var="cate" items="${list}">
                                <option value="${cate.getCateID()}">${cate.getCateName()}</option>
                            </c:forEach>

                        </select>
                        <input type="submit" value="Create plant" name="action">
                    </form>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
