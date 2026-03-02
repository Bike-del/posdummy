<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Sales Data</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- DataTables -->
    <link rel="stylesheet"
          href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

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
        <h2 class="mb-4">Dashboard</h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <h4 class="mb-3">Sales List</h4>

                <table id="salesTable" class="table table-bordered table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Order No</th>
                        <th>Date</th>
                        <th>View Items</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sale" items="${sales}">
                        <tr>
                            <td>${sale.salesId}</td>
                            <td>${sale.customerName}</td>
                            <td>${sale.orderNo}</td>
                            <td>${sale.saleDate}</td>
                            <td>
                                <button class="btn btn-sm btn-primary"
                                        onclick="showItems(${sale.salesId})">
                                    View
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<!-- ================= MODAL ================= -->

<div class="modal fade" id="itemsModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Sale Items</h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <table class="table table-bordered table-striped">
                    <thead class="table-secondary">
                    <tr>
                        <th>Sale ID</th>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Total Price</th>
                    </tr>
                    </thead>
                    <tbody id="itemsBody">
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<!-- ================= JAVASCRIPT ================= -->

<script>

    // Load all sale items into JS array
    var allItems = [
        <c:forEach var="item" items="${salesItem}" varStatus="status">
        {
            saleId: ${item.sales.salesId},
            product: "${item.product.productName}",
            qty: ${item.salesQty},
            total: ${item.totalPrice}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    function showItems(saleId) {

        var tbody = $("#itemsBody");
        tbody.empty();

        allItems.forEach(function (item) {
            if (item.saleId === saleId) {
                tbody.append(
                    "<tr>" +
                    "<td>" + item.saleId + "</td>" +
                    "<td>" + item.product + "</td>" +
                    "<td>" + item.qty + "</td>" +
                    "<td>₹ " + item.total + "</td>" +
                    "</tr>"
                );
            }
        });

        var modal = new bootstrap.Modal(document.getElementById('itemsModal'));
        modal.show();
    }

    $(document).ready(function () {
        $('#salesTable').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25, 50]
        });
    });

</script>

</body>
</html>