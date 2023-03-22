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
        .categoryTable tr:first-child {
            background-color: #ab0000;
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
        <section style="height: 65px; background-color: #ab0000;">

        </section>
        <section>
            <div class="container">
                <div class="row">
                    <h1 style="color: red;" class="text-center">Categories Management</h1>
                    <div style="display: flex;">
                        <form style="margin-top: auto;" action="mainController" method="post">
                            <input class="form-control-sm" type="text" name="txtsearchcate" placeholder="Enter category name">
                            <input class="btn btn-danger btn-sm" type="submit" value="SearchCategory" name="action">
                        </form>
                        <a style="width: 20%;" class="ms-5 btn btn-danger mt-2 btn-sm" href="admin_createCategory.jsp">Create new Category</a>
                    </div>
                    <h1></h1>
                    <table class="categoryTable">
                        <tr><th> Category ID</th><th> Category Name</th><th>Action 1</th></tr>
                                <c:forEach var="cate" items="${requestScope.categoryList}">
                            <tr>
                                <td><c:out value="${cate.getCateID()}"></c:out></td>
                                <td><c:out value="${cate.getCateName()}"></c:out></td>
                                    <td>
                                    <c:url var="mylink2" value="mainController">
                                        <c:param name="action" value="getCategoryData"></c:param>
                                        <c:param name="id" value="${cate.getCateID()}"></c:param>
                                        <c:param name="name" value="${cate.getCateName()}"></c:param>
                                    </c:url>
                                    <a class="text-danger fw-bolder" href="${mylink2}">Update</a>
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
