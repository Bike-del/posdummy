<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Sales Dashboard</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
            overflow-x: hidden;
        }

        #main-content {
            margin-left: 220px;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
            box-sizing: border-box;
        }

        #main-content.sidebar-collapsed {
            margin-left: 60px;
        }
    </style>
</head>
<body class="bg-light">

<div class="d-flex">

    <%@ include file="Sidebar.jsp" %>

    <div id="main-content" class="flex-grow-1 p-4">
                <h2>Dashboard</h2>
    </div>
</div>

<script>






    //save data in saleItem






</script>
// tost for alret


<div class="position-fixed top-0 start-50 translate-middle-x p-3" style="z-index:1080;">
    <div id="productToast" class="toast" role="alert">
        <div class="toast-header">
            <strong class="me-auto" id="toastTitle">Notification </strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body" id="toastBody"></div>
    </div>
</div>



</body>
</html>
