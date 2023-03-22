<%-- 
    Document   : header_loginedUser
    Created on : Feb 10, 2023, 4:56:25 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/main.css" type="text/css" />
        <link rel="stylesheet" href="assets/common.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
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
                            <li class="nav-item me-1 ms-1">
                                <a href="index.jsp" style="white-space: nowrap; 
                                   width: 170px; 
                                   overflow: hidden;
                                   text-overflow: ellipsis;" 
                                   class="nav-link active text-break disabled" href="index.jsp">Welcome, ${sessionScope.name}</a>
                            </li>
                            <li class="nav-item me-1 ms-1">
                                <a class="nav-link active" href="personalPage.jsp">My Account &nbsp;<i class="fa-solid fa-user"></i></a>
                            </li>
                            <li class="nav-item me-1 ms-1">
                                <a class="nav-link active" href="viewCart.jsp">View cart &nbsp;<i class="fa-solid fa-cart-shopping"></i></a>
                            </li>
                            <li class="nav-item me-1 ms-1">
                                <a class="nav-item nav-link active" href="mainController?action=logout">Sign out &nbsp;<i class="fa-solid fa-right-from-bracket"></i></a>
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
