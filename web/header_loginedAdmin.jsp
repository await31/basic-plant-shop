<%-- 
    Document   : header_loginedAdmin
    Created on : Mar 4, 2023, 10:42:32 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>header admin</title>
        <link rel="stylesheet" href="assets/main.css" type="text/css" />
        <link rel="stylesheet" href="assets/common.css" type="text/css">
    </head>
    <body>
        <header>
            <nav class="navbar fixed-top navbar-expand-lg navbar-dark">
                <div class="container-fluid">
                    <a class="navbar-brand me-0 ms-2 pt-0 pb-0" href="index.jsp">
                        <img src="images/logo.png" alt="" width="50" height="50" class="d-inline-block align-text-right">
                    </a>
                    <a id="title-switch-color" class="navbar-brand mb-1 ms-2" href="index.jsp">

                    </a>
                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNav"
                        aria-controls="navbarNav"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="d-flex navbar-nav">
                            <li class="nav-item">
                                <a href="adminIndex.jsp" style="white-space: nowrap; 
                                   width: 170px; 
                                   overflow: hidden;
                                   text-overflow: ellipsis;" 
                                   class="nav-link active text-break" href="adminIndex.jsp">Welcome, ${sessionScope.name}</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="admin_manageAccounts.jsp">Manage accounts</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="admin_manageOrders.jsp">Manage orders</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="admin_managePlants.jsp">Manage plants</a>
                            </li><li class="nav-item">
                                <a class="nav-link active" href="admin_manageCategories.jsp">Manage categories</a>
                            </li><li class="nav-item">
                                <a class="nav-link active" href="mainController?action=logout">Logout</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
            <script>
                var nav = document.querySelector('nav');
                var title = document.getElementById('title-switch-color');

                window.addEventListener('scroll', function () {
                    if (window.pageYOffset > 20) {
                        nav.classList.add('bg-light', 'shadow', 'navbar-light');
                        nav.classList.remove('navbar-dark');
                        title.classList.add('invisible')
                    } else {
                        nav.classList.remove('bg-light', 'shadow', 'navbar-light');
                        nav.classList.add('navbar-dark');
                        title.classList.remove('invisible')
                        title.style.color = "white";
                    }
                });
            </script>
        </header>
    </body>
</html>
