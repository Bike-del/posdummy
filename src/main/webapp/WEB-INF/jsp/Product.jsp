<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Product page</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css"/>
    <script src="https://cdn.datatables.net/2.3.7/js/dataTables.js"></script>

    <style>
        /* ── Layout ── */
        body {
            margin: 0;
            overflow-x: hidden;
        }

        /* Main content sits beside the fixed sidebar */
        #main-content {
            margin-left: 220px;          /* matches EXPANDED_WIDTH */
            transition: margin-left 0.3s ease;
            min-height: 100vh;
            box-sizing: border-box;
            overflow-x: hidden;         /* prevent horizontal scroll on the page */
        }

        /* When sidebar collapses, JS switches this class */
        #main-content.sidebar-collapsed {
            margin-left: 60px;           /* matches COLLAPSED_WIDTH */
        }

        /* Make the DataTable container never overflow its parent */
        #product_wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table#product {
            width: 100% !important;
        }
    </style>
</head>
<body class="bg-light">

<div class="d-flex">

    <!-- Include Sidebar -->
    <%@ include file="Sidebar.jsp" %>

    <!-- Main Content -->
    <div id="main-content" class="flex-grow-1 p-4">

        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body p-2">
                        <table id="product" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>ItemCode</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Name</th>
                                <th>Qty</th>
                                <th>MRP</th>
                                <th>Selling Price</th>
                                <th>Show Online</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /main-content -->
</div>

<script>
    /* ── DataTable init ── */
    $(document).ready(function () {
        const table = $('#product').DataTable({
            responsive: true,
            scrollX: true,
            ajax: {
                url: '/product/getAll',
                type: 'GET',
                dataSrc: function(json) {
                    console.log(json[0]); // <-- check what fields your JSON actually has
                    return json;
                }
            },
            columns: [
                {
                    data: null,
                    render: function (data, type, row, meta) { return meta.row + 1; },
                    orderable: false,
                    searchable: false
                },
                { data: 'itemCode' },
                { data: 'category.categoryName' },
                { data: 'brand.brandName' },
                { data: 'productName' },
                { data: 'qty' },
                { data: 'MRP' },
                { data: 'sellingPrice' },
                {
                    data: 'showOnline',
                    render: function (data, type, row) {
                        if (type !== 'display') return data;
                        return `<div class="form-check form-switch">
                                    <input class="form-check-input toggle-online" type="checkbox" data-id="${row.productId}">
                                </div>`;
                    }
                },
                {
                    data: 'status',
                    render: function (data, type, row) {
                        return data
                            ? `<span class="badge bg-primary rounded-pill">Active</span>`
                            : `<span class="badge bg-danger rounded-pill">Deactive</span>`;
                    }
                },
                {
                    data: null,
                    orderable: false,
                    render: function (data, type, row) {

                        if (type !== 'display') {
                            return '';
                        }

                        return '<button class="btn btn-sm btn-primary edit-btn" data-id="'
                            + row.productId + '">Edit</button>' +
                            '<button class="btn btn-sm btn-danger ms-1">Delete</button>';
                    }
                }
            ],
            columnDefs: [
                { searchable: false, orderable: false, targets: 0 }
            ],
            createdRow: function (row, data) {
                $(row).find('.toggle-online').prop('checked', Boolean(data.showOnline));
            }
        });

        $('#product tbody').on('click', '.edit-btn', function () {

            const id = this.getAttribute("data-id");

            console.log("Clicked ID:", id);

            if (id) {
                window.location.href = '/EditPage/' + id;
            } else {
                console.log("ID missing!");
            }
        });
    });




</script>

</body>
</html>
