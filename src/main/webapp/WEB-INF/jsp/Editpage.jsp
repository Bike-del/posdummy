<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <title>Edit Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
                body { background-color: #f8f9fa; }
                .card { border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
                .btn-custom { border-radius: 50px; }
                #main-content {
                        margin-left: 220px;
                        transition: margin-left 0.3s ease;
                        min-height: 100vh;
                }
                #main-content.sidebar-collapsed { margin-left: 60px; }
        </style>
</head>
<body>

<div class="d-flex">
        <%@ include file="Sidebar.jsp" %>

        <div id="main-content" class="flex-grow-1 p-4">
                <div class="card p-4">
                        <h3 class="mb-4 text-primary">Edit Product</h3>

                        <form action="/product/edit" method="post">

                                <div class="row g-3">
                                        <div class="col-md-6">

                                                <input type="hidden" name="productId" value="${product.productId}">

                                                <label class="form-label">Item Code</label>
                                                <input type="text" name="itemCode" class="form-control rounded-pill"
                                                       value="${product.itemCode}">
                                        </div>
                                        <div class="col-md-6">
                                                <label class="form-label">Product Name</label>
                                                <input type="text" name="productName" class="form-control rounded-pill"
                                                       value="${product.productName}">
                                        </div>
                                        <div class="col-md-4">
                                                <label class="form-label">Quantity</label>
                                                <input type="number" name="qty" class="form-control rounded-pill"
                                                       value="${product.qty}">
                                        </div>

                                        <div class="col-md-4">
                                                <label class="form-label">Brand</label>
                                                <input type="number" name="brandId" class="form-control rounded-pill"
                                                       value="${product.brand.brandId}">
                                        </div>


                                        <div class="col-md-4">
                                                <label class="form-label">Category</label>
                                                <input type="number" name="categoryId" class="form-control rounded-pill"
                                                       value="${product.category.categoryId}">
                                        </div>


                                        <div class="col-md-4">
                                                <label class="form-label">MRP</label>
                                                <input type="number" name="MRP" class="form-control rounded-pill"
                                                       value="${product.MRP}">
                                        </div>
                                        <div class="col-md-4">
                                                <label class="form-label">Selling Price</label>
                                                <input type="number" name="sellingPrice" class="form-control rounded-pill"
                                                       value="${product.sellingPrice}">
                                        </div>
                                        <div class="col-md-6">
                                                <label class="form-label d-block">Show Online</label>
                                                <div class="form-check form-switch">
                                                        <input class="form-check-input" type="checkbox" name="showOnline"
                                                        ${product.showOnline ? 'checked' : ''}>
                                                        <label class="form-check-label">Enable</label>
                                                </div>
                                        </div>
                                        <div class="col-md-6">
                                                <label class="form-label">Status</label>
                                                <select name="status" class="form-select rounded-pill">
                                                        <option value="true"  ${product.status ? 'selected' : ''}>Active</option>
                                                        <option value="false" ${!product.status ? 'selected' : ''}>Inactive</option>
                                                </select>
                                        </div>
                                </div>

                                <div class="mt-4 d-flex justify-content-end">
                                        <a href="/product" class="btn btn-secondary btn-custom me-2">Cancel</a>
                                        <button type="submit" class="btn btn-primary btn-custom">Save Changes</button>
                                </div>

                        </form>
                </div>
        </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>