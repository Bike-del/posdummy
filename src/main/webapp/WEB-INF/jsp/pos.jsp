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

                <h4 class="text-primary mb-4">National Handloom</h4>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label class="form-label">Product</label>
                        <select id="productSelect" name="productId" class="form-select rounded-pill" required>
                            <c:forEach var="product" items="${products}">
                                <c:if test="${product.status}">
                                    <option value="${product.productId}">
                                            ${product.productName}
                                    </option>
                                </c:if>

                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Customer Name:</label>
                        <input type="text" name="customerName" class="form-control rounded-pill"
                               placeholder="Walk-In-Customer">

                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Order No:</label>
                        <input type="text" name="orderNo" class="form-control rounded-pill" placeholder="Auto-Generated"
                               readonly>

                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Sale Date</label>
                        <input type="date"
                               id="saleDate"
                               name="saleDate"
                               class="form-control rounded-pill">
                    </div>
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

                <div class="text-end mt-3">
                    <button class="btn  btn-sm btn-secondary" onclick="SubmitData()">Submit</button>
                </div>
            </div>
        </div>

    </div>
</div>

<script>

    $(document).ready(function () {
        const $productSelect = $('#productSelect');
        const $salesTableBody = $('#salesTable tbody');
        const $grandTotal = $('#grandTotal');

        //add product using ajax
        $productSelect.on("change", function () {

            const ProductId = $(this).val();
            if (!ProductId) return;

            //prevent the duplicate row
            if ($("#row-" + ProductId).length) {
                alert("Product already added!")
                return;
            }

            $.ajax({
                url: "/product/" + ProductId,
                type: 'GET',
                dataType: "json",
                success: function (product) {
                    const price = parseFloat(product.sellingPrice);

                    const row =
                        '<tr id="row-' + product.productId + '">' +


                        '<td>' + product.productName + '</td>' +

                        '<td>' + product.category.categoryName + '</td>' +

                        '<td class="price">' + price.toFixed(2) + '</td>' +

                        '<td><input type="number" class="form-control qty" value="1" min="1"/></td>' +

                        '<td class="rowTotal">' + price.toFixed(2) + '</td>' +

                        '<td><button class="btn btn-sm btn-danger removeBtn">X</button></td>' +

                        '</tr>';
                    $salesTableBody.append(row);
                    $productSelect.val("");
                    calculateGrandTotal();
                },
                error: function () {
                    alert("Failed to fetch productDetails.");
                }


            })

        });

        //quantity change
        $salesTableBody.on("input", ".qty", function () {
            const $row = $(this).closest("tr");
            const price = parseFloat($row.find(".price").text());
            const qty = parseInt($(this).val()) || 0;

            $row.find(".rowTotal").text((price * qty).toFixed(2));
            calculateGrandTotal();
        });

        //remove table
        $salesTableBody.on("click", ".removeBtn", function () {
            $(this).closest("tr").remove();
            calculateGrandTotal();
        })

        //grand total calculation
        function calculateGrandTotal() {

            let total = 0;
            $(".rowTotal").each(function () {
                total += parseFloat($(this).text() || 0);
            });

            $grandTotal.text(total.toFixed(2));

        }


    });


    //save all the sells data in sale and saleItem table
    function SubmitData() {


        const rowCount = $('#salesTable tbody tr').length;
        if(rowCount == 0 ){
            showToast('Waring','please add the product for sale')
            return;
        }


        // Collect sale items
        const items = [];
        $('#salesTable tbody tr').each(function() {
            const $row = $(this);
            items.push({
                productId: parseInt($row.attr('id').replace('row-', '')),
                salesQty: parseInt($row.find('.qty').val()),
                // price: parseFloat($row.find('.price').text()),
                totalPrice: parseFloat($row.find('.rowTotal').text())
            });
        });

        const saleData = {
            customerName: $('input[name="customerName"]').val() || "Walk-In-Customer",
            orderNo: $('input[name="orderNo"]').val() || null,
            saleDate: $('input[name="saleDate"]').val()
                ? $('input[name="saleDate"]').val() + "T00:00:00"
                : null,
            items: items
        };




        console.log(JSON.stringify(saleData));

        $.ajax({
            url: "sales/create",
            type: "POST",
            data: JSON.stringify(saleData),
            contentType: "application/json",
            success: function (response) {
                showToast('Success', 'Sale submitted Successfully!');

                $('#salesTable tbody').empty();
                $('input[name="customerName"]').val('');
                $('input[name="saleDate"]').val('');
                $('#productSelect').val('');
                $('#grandTotal').text('0.00');
                // alert("done")
                console.log(response)
                $('#salesTable').reset;
            },
            error: function (err) {
                showToast('Error', 'Failed to add product. Please try again.');
                console.log(err);
            }

        });

        function showToast(title, message) {
            $('#toastTitle').text(title);
            $('#toastBody').text(message);
            var toastEl = document.getElementById('productToast');
            var toast = new bootstrap.Toast(toastEl);
            toast.show();
        }
    }


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
