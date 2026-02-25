<%@ page contentType="text/html;charset=UTF-8" %>
<!-- sidebar.jsp -->
<div id="sidebar" class="d-flex flex-column bg-dark text-white vh-100 position-fixed" style="width: 220px; transition: all 0.3s; z-index: 1000;">

    <!-- Hamburger Button -->
    <div class="d-flex justify-content-between align-items-center p-3 border-bottom border-secondary">
        <span id="sidebarTitle" class="fs-4">My Admin</span>
        <button id="sidebarToggle" class="btn btn-sm btn-outline-light">
            <i class="bi bi-list"></i>
        </button>
    </div>

    <ul class="nav nav-pills flex-column mb-auto mt-2">
        <li class="nav-item mb-1">
            <a href="dashboard.jsp" class="nav-link text-white d-flex align-items-center">
                <i class="bi bi-speedometer2 me-2"></i>
                <span class="link-text">Dashboard</span>
            </a>
        </li>
        <li class="nav-item mb-1">
            <a href="${pageContext.request.contextPath}/product" class="nav-link text-white d-flex align-items-center">
                <i class="bi bi-box-seam me-2"></i>
                <span class="link-text">Product</span>
            </a>
        </li>
        <li class="nav-item mb-1">
            <a href="${pageContext.request.contextPath}/EditPage" class="nav-link text-white d-flex align-items-center">
                <i class="bi bi-gear me-2"></i>
                <span class="link-text">EditPage</span>
            </a>
        </li>
    </ul>

    <div class="text-center mt-auto p-3 border-top border-secondary">
        <small>© 2026 MyCompany</small>
    </div>
</div>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    /* Collapsed Sidebar */
    #sidebar.collapsed {
        width: 60px !important;
    }
    #sidebar.collapsed .link-text,
    #sidebar.collapsed #sidebarTitle {
        display: none;
    }
    #sidebar .nav-link {
        white-space: nowrap;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const sidebar     = document.getElementById('sidebar');
        const toggleBtn   = document.getElementById('sidebarToggle');
        const mainContent = document.getElementById('main-content');

        toggleBtn.addEventListener('click', function () {
            sidebar.classList.toggle('collapsed');

            /* Toggle a CSS class instead of hard-coding inline style.
               The class is defined in Product.jsp (or whatever page includes this sidebar). */
            if (mainContent) {
                mainContent.classList.toggle('sidebar-collapsed');
            }

            /* Give the CSS transition time to finish, then tell DataTable to recalculate column widths */
            setTimeout(function () {
                if (typeof $ !== 'undefined' && $.fn.DataTable) {
                    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                }
            }, 310); // slightly longer than the 0.3s CSS transition
        });
    });
</script>
