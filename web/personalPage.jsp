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
        <link rel="stylesheet" href="assets/circula.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <title>My Account</title>
    </head>
    <style>
        .my-pseudo {
            content: "";
            height: 100%;
            width: 3px;
            background-color: #5200ff63;
            position: absolute;
            left: 0;
            bottom: 0;
        }
    </style>
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
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-dark p-3 position-relative" href="personalPage.jsp"><div class="my-pseudo"></div><i class="fa-solid fa-address-card"></i> Profile</a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="filterOrders.jsp"><i class="fa-sharp fa-solid fa-list"></i> Filter orders</a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="processingOrder.jsp" ><i class="fa-sharp fa-solid fa-gears"></i> Processing orders<span style="right: 10px;" class=" position-absolute badge bg-info rounded-pill">${processCount}</span></a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="canceledOrder.jsp"><i class="fa-sharp fa-solid fa-xmark"></i> Canceled orders<span style="right: 10px;" class=" position-absolute badge bg-danger rounded-pill">${cancelCount}</span></a>
                                                <a style="font-family: Century Gothic;" class="list-group-item list-group-item-action list-group-item-light p-3 position-relative" href="completedOrder.jsp"><i class="fa-sharp fa-solid fa-check"></i> Completed orders<span style="right: 10px;" class=" position-absolute badge bg-success rounded-pill">${completeCount}</span></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="height: 520px; overflow-x: hidden; background: linear-gradient(to right, #ddd6f3 0%, #faaca8 100%);" class="col-md-9 px-0">
                                        <main id="main" class="main ps-5" style="height: 520px;">
                                            <div class="pt-3 pagetitle">
                                                <nav>
                                                    <ol class="breadcrumb">
                                                        <li class="breadcrumb-item"><a class="text-decoration-none text-muted" href="index.jsp"><i class="fa-solid fa-user"></i> My Account</a></li>
                                                        <li class="breadcrumb-item active">Profile</li>
                                                    </ol>
                                                </nav>
                                            </div><!-- End Page Title -->

                                            <section class="section profile overflow-hidden">
                                                <div class="row">
                                                    <div class="col-xl-4 col-md-4 col-xs-12">
                                                        <div class="card me-sm-5 me-md-0 me-xl-0 mb-sm-3">
                                                            <div class="card-body profile-card d-flex flex-column align-items-center">
                                                                <img style="width: 100px; height: 100px;" src="images/profile-img.jpg" alt="Profile" class="rounded-circle img-fluid">
                                                                <h2 class="mt-2">${name}</h2>
                                                                <h5 style="color: #9ad3e0;" class="fw-bolder mb-0"><i class="fa-sharp fa-solid fa-gem"></i> Diamond membership </h5>
                                                                <div class="social-links mt-2">
                                                                    <a onclick="alert('This feature is not supported yet!')"><i style="color:#1DA1F2;" class="fa-brands fa-twitter"></i></a>
                                                                    <a onclick="alert('This feature is not supported yet!')"><i style="color:#4267B2;" class="fa-brands fa-facebook"></i></a>
                                                                    <a onclick="alert('This feature is not supported yet!')"><i style="color:#8a3ab9;" class="fa-brands fa-instagram"></i></a>
                                                                    <a onclick="alert('This feature is not supported yet!')"><i style="color:#2867B2;" class="fa-brands fa-linkedin"></i></a>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="col-xl-8 col-md-8 col-xs-12">

                                                        <div class="card me-5 mb-3">
                                                            <div class="card-body pt-3">
                                                                <!-- Bordered Tabs -->
                                                                <ul class="nav nav-tabs nav-tabs-bordered">
                                                                    <li class="nav-item">
                                                                        <button class="text-dark nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <button class="text-dark nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <button class="text-dark nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">Statistics</button>
                                                                    </li>
                                                                </ul>
                                                                <div class="tab-content pt-2">
                                                                    <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                                                        <h5 style="color: #4267B2;" class="card-title mt-2 mb-4">About</h5>
                                                                        <p class="small fst-italic">“Happiness held is the seed, Happiness shared is the flower.”</p>

                                                                        <h5 style="color: #4267B2;" class="card-title mb-4">Profile Details</h5>

                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label ">Full Name</div>
                                                                            <div class="col-lg-9 col-md-8">${name}</div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label">Phone</div>
                                                                            <div class="col-lg-9 col-md-8">${phone}</div>
                                                                        </div>

                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label">Email</div>
                                                                            <div class="col-lg-9 col-md-8">${email}</div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label">Address</div>
                                                                            <div class="col-lg-9 col-md-8">District 7, Ho Chi Minh City</div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label">Country</div>
                                                                            <div class="col-lg-9 col-md-8">Vietnam</div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-lg-3 col-md-4 label">Continents</div>
                                                                            <div class="col-lg-9 col-md-8">Asia</div>
                                                                        </div>
                                                                        <p class="text-danger fst-italic mt-4 mb-0">*Your profile details will be updated at the next login.</p>
                                                                    </div>
                                                                    <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                                                                        <!-- Profile Edit Form -->
                                                                        <div class="row mb-3">
                                                                            <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                                                                            <div class="col-md-8 col-lg-9">
                                                                                <img style="height: 100px; width: 100px;" src="images/profile-img.jpg" alt="Profile">
                                                                                <div class="pt-2">
                                                                                    <a onclick="alert('This feature is not supported yet!')" class="btn btn-primary btn-sm" title="Upload new profile image"><i class="fa-solid fa-upload"></i></a>
                                                                                    <a onclick="alert('This feature is not supported yet!')" class="btn btn-danger btn-sm" title="Remove my profile image"><i class="fa-solid fa-trash"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <form action="mainController" method="post">
                                                                            <div class="row mb-3">
                                                                                <label for="txtfullname" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <input name="txtfullname" type="text" class="form-control" pattern="^[A-Za-z ]{5,30}$" placeholder="Contains only letter, length must be from 5-30" required>
                                                                                </div>
                                                                            </div>

                                                                            <div class="row mb-3">
                                                                                <label for="txtphonehone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <input name="txtphone" type="text" class="form-control" pattern="^[0-9]{10,11}$" placeholder="Contains only 10-11 digits" required>
                                                                                </div>
                                                                            </div>

                                                                            <div class="row mb-3">
                                                                                <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <input name="email" type="email" class="form-control" id="Email" value="${email}" disabled>
                                                                                </div>
                                                                            </div>

                                                                            <div class="row mb-3">
                                                                                <label for="about" class="col-md-4 col-lg-3 col-form-label">About</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <textarea name="about" class="form-control" id="about" style="height: 100px" disabled> “Happiness held is the seed, Happiness shared is the flower.”</textarea>
                                                                                </div>
                                                                            </div>

                                                                            <div class="row mb-3">
                                                                                <label for="Country" class="col-md-4 col-lg-3 col-form-label">Country</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <input name="country" type="text" class="form-control" id="Country" value="Vietnam" disabled>
                                                                                </div>
                                                                            </div>

                                                                            <div class="row mb-3">
                                                                                <label for="Address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                                                                <div class="col-md-8 col-lg-9">
                                                                                    <input name="address" type="text" class="form-control" id="Address" value="District 7, Ho Chi Minh City" disabled>
                                                                                </div>
                                                                            </div>
                                                                            <div class="text-center">
                                                                                <input class="btn btn-success" type="submit" value="Change" name="action">
                                                                            </div>
                                                                        </form><!-- End Profile Edit Form -->
                                                                        <p class="text-danger fst-italic mt-4 mb-0">*Your profile details will be updated at the next login.</p>
                                                                    </div>

                                                                    <div class="tab-pane fade pt-3" id="profile-settings">
                                                                        <p class="text-center mt-3 mb-3 fw-bolder text-dark" style="font-size: 24px;">Order status ratio (%)</p>
                                                                        <div class="mb-5">
                                                                            <div class="d-flex justify-content-between mb-3">
                                                                                <div class="text-info fw-bolder">Processing <i class="fa-solid fa-square"></i></div>
                                                                                <div class="text-danger fw-bolder">Canceled <i class="fa-solid fa-square"></i></div>
                                                                                <div class="text-success fw-bolder">Complete <i class="fa-solid fa-square"></i></div>
                                                                            </div>
                                                                            <div class="progress-stacked">
                                                                                <div class="progress" role="progressbar" aria-label="Segment one" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: ${processPercent}%">
                                                                                    <div class="progress-bar bg-info"></div>
                                                                                </div>
                                                                                <div class="progress" role="progressbar" aria-label="Segment two" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: ${cancelPercent}%">
                                                                                    <div class="progress-bar bg-danger"></div>
                                                                                </div>
                                                                                <div class="progress" role="progressbar" aria-label="Segment three" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: ${completePercent}%">
                                                                                    <div class="progress-bar bg-success"></div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <p class="text-center mt-3 mb-3 fw-bolder text-dark border-top border-dark pt-3" style="font-size: 22px;">Spend for this year ($USD)</p>
                                                                        <canvas class="my-4 w-100 mt-1" id="myChart" width="900" height="380"></canvas>
                                                                    </div>
                                                                </div><!-- End Bordered Tabs -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                        </main><!-- End #main -->

                                    </div>
                                </div>
                            </div>
                        </section>

                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
                        <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js" integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha" crossorigin="anonymous"></script><script src="dashboard.js"></script>
                        <script>
                                                                                        (() => {
                                                                                            'use strict'

                                                                                            feather.replace({'aria-hidden': 'true'})

                                                                                            // Graphs
                                                                                            const ctx = document.getElementById('myChart')
                                                                                            // eslint-disable-next-line no-unused-vars
                                                                                            const myChart = new Chart(ctx, {
                                                                                                type: 'line',
                                                                                                data: {
                                                                                                    labels: [
                                                                                                        'January',
                                                                                                        'February',
                                                                                                        'March',
                                                                                                        'April',
                                                                                                        'May',
                                                                                                        'June',
                                                                                                        'July',
                                                                                                        'August',
                                                                                                        'September',
                                                                                                        'October',
                                                                                                        'November',
                                                                                                        'December'
                                                                                                    ],
                                                                                                    datasets: [{
                                                                                                            data: [
                                                                                                                2525,
                                                                                                                1287,
                                                                                                                2876,
                                                                                                                1915,
                                                                                                                2710,
                                                                                                                1493,
                                                                                                                2075,
                                                                                                                1123,
                                                                                                                2766,
                                                                                                                1437,
                                                                                                                2389,
                                                                                                                1678,
                                                                                                            ],
                                                                                                            lineTension: 0,
                                                                                                            backgroundColor: 'transparent',
                                                                                                            borderColor: '#007bff',
                                                                                                            borderWidth: 4,
                                                                                                            pointBackgroundColor: '#007bff'
                                                                                                        }]
                                                                                                },
                                                                                                options: {
                                                                                                    scales: {
                                                                                                        yAxes: [{
                                                                                                                ticks: {
                                                                                                                    beginAtZero: false
                                                                                                                }
                                                                                                            }]
                                                                                                    },
                                                                                                    legend: {
                                                                                                        display: false
                                                                                                    }
                                                                                                }
                                                                                            })
                                                                                        })()

                        </script>
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
