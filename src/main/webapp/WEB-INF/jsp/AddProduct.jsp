<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-custom {
            border-radius: 50px;
        }

        #main-content {
            margin-left: 220px;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        #main-content.sidebar-collapsed {
            margin-left: 60px;
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="Sidebar.jsp" %>

    <div id="main-content" class="flex-grow-1 p-4">
        <div class="card p-4">
            <h3 class="mb-4 text-primary">Add Product</h3>

            <form id="addProductForm">

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Item Code</label>
                        <input type="text" name="itemCode" class="form-control rounded-pill" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Product Name</label>
                        <input type="text" name="productName" class="form-control rounded-pill" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" name="qty" class="form-control rounded-pill" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Brand</label>
                        <select name="brandId" class="form-select rounded-pill" required>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.brandId}">${brand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Category</label>
                        <select name="categoryId" class="form-select rounded-pill" required>
                            <c:forEach var="cat" items="${ParentCategory}">
                                <option value="${cat.categoryId}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

<%--                    sub category--%>
                    <div class="col-md-4">
                        <label class="form-label">Sub-Category</label>
                        <select name="subCategoryId" id="subCategorySelect" class="form-select rounded-pill" required>
                            <option value="">Select Sub-Category</option>
                        </select>
                    </div>


                    <div class="col-md-4">
                        <label class="form-label">MRP</label>
                        <input type="number" name="MRP" class="form-control rounded-pill" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Selling Price</label>
                        <input type="number" name="sellingPrice" class="form-control rounded-pill" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label d-block">Show Online</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="showOnline" checked>
                            <label class="form-check-label">Enable</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select rounded-pill">
                            <option value="true" selected>Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="mt-4 d-flex justify-content-end">
                    <a href="/product" class="btn btn-secondary btn-custom me-2">Cancel</a>
                    <button type="submit" class="btn btn-primary btn-custom">Add Product</button>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- Toast for success/error -->
<div class="position-fixed top-0 start-50 translate-middle-x p-3" style="z-index:1080;">
    <div id="productToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="toastTitle">Notification</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toastBody"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function() {
        $('#addProductForm').submit(function(e) {
            e.preventDefault(); // prevent normal form submission

            var formData = {
                itemCode: $('input[name="itemCode"]').val(),
                productName: $('input[name="productName"]').val(),
                qty: $('input[name="qty"]').val(),
                brandId: $('select[name="brandId"]').val(),
                categoryId: $('select[name="categoryId"]').val(),
                subCategoryId:$('#subCategorySelect').val(),
                MRP: $('input[name="MRP"]').val(),
                sellingPrice: $('input[name="sellingPrice"]').val(),
                showOnline: $('input[name="showOnline"]').is(':checked'),
                status: $('select[name="status"]').val() === "true"
            };


            $.ajax({
                url: '/product/create', // your backend endpoint
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify( formData),
                success: function(response) {
                    showToast('Success', 'Product added successfully!');
                    $('#addProductForm')[0].reset();
                },
                error: function(xhr) {
                    showToast('Error', 'Failed to add product. Please try again.');
                }
            });
        });

        function showToast(title, message) {
            $('#toastTitle').text(title);
            $('#toastBody').text(message);
            var toastEl = document.getElementById('productToast');
            var toast = new bootstrap.Toast(toastEl);
            toast.show();
        }
    });

    // When parent category changes
    $('select[name="categoryId"]').change(function() {
        var parentId = $(this).val(); // selected parent category id

        if(parentId) {
            $.ajax({
                url: '/category/subCategory/' + parentId,
                type: 'GET',
                success: function(subCategories) {
                    var subCategorySelect = $('#subCategorySelect');
                    subCategorySelect.empty(); // clear old options
                    subCategorySelect.append('<option value="">Select Sub-Category</option>');

                    $.each(subCategories, function(i, subCat) {
                        subCategorySelect.append(
                            '<option value="' + subCat.categoryId + '">' + subCat.categoryName + '</option>'
                        );
                    });
                },
                error: function() {
                    alert('Failed to load subcategories');
                }
            });
        } else {
            $('#subCategorySelect').empty().append('<option value="">Select Sub-Category</option>');
        }
    });

</script>

</body>
</html>