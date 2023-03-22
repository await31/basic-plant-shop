<%@page import="com.plantshop.dao.AccountDAO"%>
<%@page import="com.plantshop.dto.Account"%>
<%@page import="com.plantshop.dao.OrderDAO"%>
<%@page import="com.plantshop.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/main.css" type="text/css">
        <link rel="icon" type="image/png" href="images/logo.png" sizes="16x16">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <title>Filter orders</title>
        <style>
            .my-pseudo {
                content: "";
                height: 100%;
                width: 3px;
                position: absolute;
                left: 0;
                bottom: 0;
            }
        </style>
    </head>
    <body>
        <c:set var="name" value="${sessionScope.name}"></c:set>
        <c:set var="role" value="${sessionScope.role}"></c:set>
        <c:set var="email" value="${sessionScope.email}"></c:set>
        <c:choose>
            <c:when test="${name eq null}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:when>
            <c:otherwise>
                <c:set var="list" value="${OrderDAO.getOrders(email)}"></c:set>
                <c:set var="processCount" value="0"></c:set>
                <c:set var="completeCount" value="0"></c:set>
                <c:set var="cancelCount" value="0"></c:set>
                <c:forEach var="ord" items="${list}">
                    <c:if test="${ord.getStatus() eq 1}">
                        <c:set var="processCount" value="${processCount+1}"></c:set>
                    </c:if>
                    <c:if test="${ord.getStatus() eq 2}">
                        <c:set var="completeCount" value="${completeCount+1}"></c:set>
                    </c:if>
                    <c:if test="${ord.getStatus() eq 3}">
                        <c:set var="cancelCount" value="${cancelCount+1}"></c:set>
                    </c:if>
                </c:forEach>
                <c:set var="allCount" value="${processCount + completeCount + cancelCount}"></c:set>
                <c:set var="processPercent" value="${(processCount/allCount)*100}"></c:set>
                <c:set var="completePercent" value="${(completeCount/allCount)*100}"></c:set>
                <c:set var="cancelPercent" value="${(cancelCount/allCount)*100}"></c:set>
                <c:set var="c" value="${cookieList}"></c:set>
                <c:set var="login" value="false"></c:set>
                <c:choose>
                    <c:when test="${name eq null}">
                        <c:set var="token" value=""></c:set>
                        <c:forEach var="aCookie" items="${c}">
                            <c:if test="${aCookie.getName() eq 'selector'}">
                                <c:set var="token" value="${aCookie.getValue()}"></c:set>
                                <c:set var="acc" value="${AccountDAO.getAccount(token)}"></c:set>
                                <c:if test="${!acc eq null}">
                                    <c:set var="name" value="${acc.getFullName()}"></c:set>
                                    <c:set var="email" value="${acc.getEmail()}"></c:set>
                                    <c:set var="login" value="true"></c:set>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:set var="login" value="true"></c:set>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${login eq true}">
                        <header>
                            <%@include file="header_loginedUser.jsp"%>
                        </header>
                        <section style="background-color:black; height: 65px;">
                        </section>
                        <section style="height: 520px;">
                            <div style="height: auto;" class="container-fluid">
                                <div class="row">
                                    <div style="background-color: #f4f4f4; border-right: 2px solid gray" class="col-md-3 px-0">
                                        <div class="bg-dark" id="sidebar-wrapper">
                                            <div style="height: auto;" class="list-group list-group-flush">
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3" href="personalPage.jsp"><i class="fa-solid fa-address-card"></i> Profile</a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-dark p-3 position-relative" href="filterOrders.jsp"><i class="fa-sharp fa-solid fa-list"><div class="my-pseudo bg-warning"></div></i> Filter orders</a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="processingOrder.jsp" ><i class="fa-sharp fa-solid fa-gears"></i> Processing orders<span style="right: 10px;" class=" position-absolute badge bg-info rounded-pill">${processCount}</span></a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="canceledOrder.jsp"><i class="fa-sharp fa-solid fa-xmark"></i> Canceled orders<span style="right: 10px;" class=" position-absolute badge bg-danger rounded-pill">${cancelCount}</span></a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="completedOrder.jsp"><i class="fa-sharp fa-solid fa-check"></i> Completed orders<span style="right: 10px;" class=" position-absolute badge bg-success rounded-pill">${completeCount}</span></a>
                                            </div>
                                        </div>

                                    </div>
                                    <div style="height: 520px; overflow-x: hidden;" class="col-md-9 px-0">
                                        <div class="ps-5 pt-3 pagetitle">
                                            <nav>
                                                <ol class="breadcrumb">
                                                    <li class="breadcrumb-item"><a class="text-decoration-none text-muted" href="index.jsp"><i class="fa-solid fa-user"></i> My Account</a></li>
                                                    <li class="breadcrumb-item active">Filter orders</li>
                                                </ol>
                                            </nav>
                                        </div>
                                        <form action="mainController" method="post">
                                            <input type="hidden" name="txtemail" value="${email}">
                                            <div class="d-flex flex-column ms-3 w-50">
                                                <div class="d-flex flex-row">
                                                    <label for="fromDate"><i class="fa-solid fa-calendar-days"></i> From:</label>
                                                    <input style="width: 40%" class="form-control-sm mx-2" type="date" name="fromDate" id="fromDate" class="ms-2 me-2" required>
                                                </div>
                                                <div class="d-flex flex-row mt-3">
                                                    <label style="margin-right: 3.4%;" for="toDate"><i class="fa-solid fa-calendar-days"></i> To:</label>
                                                    <input style="width: 40%" class="form-control-sm mx-2" type="date" name="toDate" id="toDate" class="ms-2 me-2" required>
                                                </div>
                                                <div class="d-flex flex-row mt-3">
                                                    <p class="me-4">Order status (Multiple options): </p>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="myCheckbox" value="process">
                                                        <label class="form-check-label text-info fw-bolder" for="inlineCheckbox1">Processing</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="inlineCheckbox2" name="myCheckbox" value="cancel">
                                                        <label class="form-check-label text-danger fw-bolder" for="inlineCheckbox2">Canceled</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="checkbox" id="inlineCheckbox3" name="myCheckbox" value="complete">
                                                        <label class="form-check-label text-success fw-bolder" for="inlineCheckbox3">Completed</label>
                                                    </div>
                                                </div>
                                                <font class="mb-3" style='color: red;'><%= request.getAttribute("WARNING") == null ? "" : (String) request.getAttribute("WARNING")%></font>
                                                <input type="submit" style="width: 18%;" class="btn bg-warning text-light btn-sm mb-3 ms-2" value="Filter order" name="action">
                                            </div>
                                        </form>
                                        <c:set var="myList" value="${requestScope.orderList}"></c:set>
                                            <table class="table table-sm table-hover table-bordered mb-0" width="100%">
                                            <c:if test="${orderList.size() >= 1}"><caption>Data updated at: <%=(new Date()).toString()%></caption></c:if>
                                                <thead class="table-dark"><th scope="col"> #</th><th scope="col"> Order date</th><th scope="col"> Ship date</th><th scope="col"> Status</th><th scope="col"> Action</th></thead>
                                                <c:forEach var="ord" items="${myList}">
                                                <tbody>
                                                <th scope="row"><c:out value="${ord.getOrderID()}"></c:out></td>
                                                <td><c:out value="${ord.getOrderDate()}"></c:out></td>
                                                    <td>
                                                    <c:choose>
                                                        <c:when test="${ord.getShipDate() eq null}">Not yet</c:when>
                                                        <c:otherwise> ${ord.getShipDate()}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${ord.getStatus() eq 1}"><h6 class="text-info">Processing</h6></c:when>
                                                        <c:when test="${ord.getStatus() eq 2}"><h6 class="text-success">Completed</h6></c:when>
                                                        <c:when test="${ord.getStatus() eq 3}"><h6 class="text-danger">Canceled</h6></c:when>
                                                        <c:otherwise> null</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:url var="mylink" value="orderDetails.jsp?id=${ord.getOrderID()}">
                                                    </c:url>
                                                    <a class="text-warning fw-bolder text-decoration-none" href="${mylink}">Check detail <i class="fa-solid fa-circle-info"></i></a>
                                                </td>
                                                </tbody>
                                            </c:forEach>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </section>
                        <script src ="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
                        <!--Load all orders of the user at here -->
                        <footer>
                            <%@include file="footer.jsp" %>
                        </footer>
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="login.jsp"></c:redirect>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
</html>
