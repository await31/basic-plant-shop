<%@page import="java.util.ArrayList"%>
<%@page import="com.plantshop.dto.Plant"%>
<%@page import="com.plantshop.dao.PlantDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Plants</title>
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <style>
        .plantTable tr:first-child {
            background-color: #d3d304;
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
        <section style="height: 65px; background-color: #d3d304;">

        </section>
        <section>
            <div class="container">
                <div class="row">
                    <h1 style="color: #d3d304;" class="text-center">Plants Management</h1>
                    <div style="display: flex;">
                        <form style="margin-top: auto;" action="mainController" method="post">
                            <input class="form-control-sm" type="text" name="txtsearchplt" placeholder="Enter plant name">
                            <input class="btn btn-warning btn-sm text-white" class="" type="submit" value="SearchPlant" name="action">
                        </form>
                        <a style="width: 20%;" class="ms-5 btn btn-warning mt-2 btn-sm text-white" href="admin_createPlant.jsp">Create new Plant</a>
                    </div>
                    <h1></h1>
                    <table class="plantTable">
                        <tr><th> ID</th><th> Name</th><th> Price</th><th> Image Path</th><th>Image</th><th> Description</th><th> Status</th><th> Category ID</th><th> Action 1</th><th> Action 2</th></tr>
                                <c:forEach var="plt" items="${requestScope.plantList}">
                            <tr>
                                <td><c:out value="${plt.getId()}"></c:out></td>
                                <td><c:out value="${plt.getName()}"></c:out></td>
                                <td><c:out value=" $${plt.getPrice()}"></c:out></td>
                                <td><c:out value="${plt.getImgPath()}"></c:out></td>
                                <td><img width="100" height="100" src="${plt.getImgPath()}" alt="Maybe a plant image"></td>
                                <td><c:out value="${plt.getDescription()}"></c:out></td>
                                    <td>
                                    <c:choose>
                                        <c:when test="${plt.getStatus() eq 1}"> <h4 style="color: green;">Available</h4></c:when>
                                        <c:otherwise> <h4 style="color: red;">Out of stock</h4></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${plt.getCateId()}"></c:out></td>
                                    <td>
                                    <c:url var="mylink" value="mainController">
                                        <c:param name="action" value="getPlantData"></c:param>
                                        <c:param name="id" value="${plt.getId()}"></c:param>
                                        <c:param name="name" value="${plt.getName()}"></c:param>
                                        <c:param name="price" value="${plt.getPrice()}"></c:param>
                                        <c:param name="imgpath" value="${plt.getImgPath()}"></c:param>
                                        <c:param name="description" value="${acc.getDescription()}"></c:param>
                                    </c:url>
                                    <a class="text-warning fw-bolder" href="${mylink}">Update</a>
                                </td>
                                <td>
                                    <c:url var="mylink2" value="mainController">
                                        <c:param name="id" value="${plt.getId()}"></c:param>
                                        <c:param name="status" value="${plt.getStatus()}"></c:param>
                                        <c:param name="action" value="updateStatusPlant"></c:param>
                                    </c:url>
                                    <a class="text-dark fw-bolder" href="${mylink2}">Switch status</a>
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
