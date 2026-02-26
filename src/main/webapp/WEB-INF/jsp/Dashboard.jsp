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

        <div class="card shadow-sm">
            <div class="card-body">

                <h4 class="text-primary mb-4">Sales Dashboard</h4>
                <div class="col-md-4">
                    <label class="form-label">Product</label>
                    <select id="productSelect" name="productId" class="form-select rounded-pill" required>
                        <c:forEach var="product" items="${products}">
                            <option value="${product.productId}" data-name="${product.productName}"
                                    data-category="${product.category.categoryName}"
                                    data-price="${product.sellingPrice}"> ${product.productName}</option>
                        </c:forEach>
                    </select>
                </div>
                <hr class="my-4">

                <div class="table-responsive">
                    <table class="table table-bordered table-striped align-middle" id="salesTable">
                        <thead class="table-primary">
                        <tr>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th width="120">Qty</th>
                            <th>Total</th>
                            <th width="80">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div class="text-end mt-3">
                    <h4>Grand Total: ₹ <span id="grandTotal">0.00</span></h4>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        var productSelect = document.getElementById("productSelect");
        var salesTableBody = document.querySelector("#salesTable tbody");
        var grandTotalSpan = document.getElementById("grandTotal");

        // Add product to table
        productSelect.addEventListener("change", function () {
            var selected = this.options[this.selectedIndex];
            var id = selected.value;
            var name = selected.getAttribute("data-name");
            var category = selected.getAttribute("data-category");
            var price = parseFloat(selected.getAttribute("data-price"));

            if (!id) return;

            // Prevent duplicate
            if (document.getElementById("row-" + id)) {
                alert("Product already added!");
                return;
            }

            var row = document.createElement("tr");
            row.id = "row-" + id;

            row.innerHTML =
                "<td>" + name + "</td>" +
                "<td>" + category + "</td>" +
                "<td class='price'>" + price.toFixed(2) + "</td>" +
                "<td><input type='number' class='qty' value='1' min='1' data-id='" + id + "'></td>" +
                "<td class='rowTotal'>" + price.toFixed(2) + "</td>" +
                "<td><button class='removeBtn' data-id='" + id + "'>X</button></td>";

            salesTableBody.appendChild(row);
            calculateGrandTotal();
        });

        // Quantity change
        salesTableBody.addEventListener("input", function (e) {
            if (e.target && e.target.className === "qty") {
                var row = e.target.parentNode.parentNode;
                var price = parseFloat(row.querySelector(".price").innerText);
                var qty = parseInt(e.target.value, 10);
                row.querySelector(".rowTotal").innerText = (price * qty).toFixed(2);
                calculateGrandTotal();
            }
        });

        // Remove product
        salesTableBody.addEventListener("click", function (e) {
            if (e.target && e.target.className === "removeBtn") {
                var id = e.target.getAttribute("data-id");
                var row = document.getElementById("row-" + id);
                if (row) row.parentNode.removeChild(row);
                calculateGrandTotal();
            }
        });

        // Calculate grand total
        function calculateGrandTotal() {
            var total = 0;
            var rows = salesTableBody.querySelectorAll(".rowTotal");
            for (var i = 0; i < rows.length; i++) {
                total += parseFloat(rows[i].innerText);
            }
            grandTotalSpan.innerText = total.toFixed(2);
        }

    });

</script>
</body>
</html>
