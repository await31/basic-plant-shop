<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Plant</title>
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
        <c:set var="plantId" value="${requestScope.plantId}"></c:set>
        <c:set var="plantPrice" value="${requestScope.plantPrice}"></c:set>
        <c:set var="plantName" value="${requestScope.plantName}"></c:set>
        <c:set var="plantImgPath" value="${requestScope.plantImgPath}"></c:set>
        <c:set var="plantDescription" value="${requestScope.plantDescription}"></c:set>
        <c:set var="displayImgPath" value="${plantImgPath.substring(7, imgPath.length())}"></c:set>
            <section style="height: auto;" id="content-container">
                <div class="container-fluid">
                    <div style="margin-top: 2%;" class="row">
                        <form id="login-form" action="mainController" method="post">
                            <h2 style="color: #16B5C4;" class="text-center">Update Plant</h2>
                            <label for="txtid">Plant ID:</label>
                            <input type="text" autocomplete="off" name="txtid" value="${plantId}" readonly='true'><br>
                        <label for="txtname">Plant name:</label>
                        <input type="text" autocomplete="off" name="txtname" required="" value="${plantName}" readonly><br>
                        <label for="txtprice">Price:</label>
                        <input type="number" autocomplete="off" name="txtprice" required="" min="1" max="100000" placeholder="Price must be from 1 to 100000"><br>
                        <p class="text-danger">*Old price: $${plantPrice}</p>
                        <label for="txtimgpath">Image path:</label>
                        <input type="text" autocomplete="off" name="txtimgpath" required="" placeholder="Example: your_img.jpg"><br>
                        <p class="text-danger">*Old image path: ${displayImgPath}></p>
                        <label for="txtdescription">Plant description:</label>
                        <input type="text" autocomplete="off" name="txtdescription" required="" pattern="^[A-Za-z ]{3,200}$" placeholder="Contains from 3 to 200 letters including spaces"><br>
                        <input type="submit" value="Update plant" name="action">
                    </form>
                </div>
            </div>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
