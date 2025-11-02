<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Users - Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background: #ffffff;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
                line-height: 1.6;
            }
            
            /* Admin Header */
            .admin-header {
                background: white;
                color: #333;
                padding: 2rem 0;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-bottom: 1px solid #e9ecef;
            }
            
            .admin-header h1 {
                font-weight: 400;
                color: #333;
                font-size: 2.2rem;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
            }
            
            .admin-header h1 i {
                color: #333;
                margin-right: 1rem;
            }
            
            .admin-header p {
                color: #666;
                font-size: 1rem;
                margin: 0;
            }
            
            /* Admin Navigation */
            .admin-navbar {
                background: white;
                border-bottom: 1px solid #e9ecef;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            
            .admin-navbar .nav-link {
                color: #333;
                padding: 1rem 1.5rem;
                border-radius: 0;
                transition: all 0.3s ease;
                font-weight: 400;
                position: relative;
                border-bottom: 3px solid transparent;
                font-size: 1rem;
            }
            
            .admin-navbar .nav-link:hover,
            .admin-navbar .nav-link.active {
                color: #333;
                background-color: #f8f9fa;
                border-bottom-color: #333;
                transform: translateY(-2px);
            }
            
            .admin-navbar .nav-link i {
                margin-right: 0.8rem;
                font-size: 1.1rem;
                width: 20px;
                text-align: center;
                color: #666;
            }
            
            /* User Info Section */
            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }
            
            .user-avatar {
                width: 50px;
                height: 50px;
                background: #f8f9fa;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                font-weight: 600;
                color: #333;
                border: 2px solid #e9ecef;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            
            .logout-btn {
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                color: #333;
                padding: 0.6rem 1.5rem;
                border-radius: 25px;
                transition: all 0.3s ease;
                font-weight: 400;
                font-size: 0.9rem;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }
            
            .logout-btn:hover {
                background: #e9ecef;
                border-color: #dee2e6;
                color: #333;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                text-decoration: none;
            }
            
            /* Content Section */
            .content-section {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                border: 1px solid #f0f0f0;
                margin-bottom: 2rem;
            }
            
            .content-section h3 {
                color: #333;
                font-weight: 400;
                font-size: 1.6rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.8rem;
            }
            
            .content-section h3 i {
                color: #666;
                font-size: 1.2rem;
                width: 24px;
                text-align: center;
            }
            
            /* Table Styles - Minimalist Porsche Theme */
            .table {
                background: white;
                border-radius: 4px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                border: 1px solid #e9ecef;
                margin: 0;
            }
            
            .table thead th {
                background: #f8f9fa;
                border: none;
                color: #495057;
                padding: 0.5rem 0.75rem;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                border-bottom: 1px solid #dee2e6;
                font-family: 'Segoe UI', sans-serif;
            }
            
            /* Date column header width control */
            .table thead th:nth-child(6) {
                width: 120px;
                max-width: 120px;
                min-width: 120px;
                text-align: center;
            }
            
            .table tbody td {
                padding: 0.5rem 0.75rem;
                border: none;
                border-bottom: 1px solid #f8f9fa;
                color: #495057;
                vertical-align: middle;
                font-weight: 400;
                transition: all 0.15s ease;
            }
            
            /* Date column width control */
            .table tbody td:nth-child(6) {
                width: 100px;
                max-width: 100px;
                min-width: 100px;
            }
            
            /* Actions column width control */
            .table thead th:nth-child(7) {
                width: 120px;
                max-width: 120px;
                min-width: 120px;
                text-align: center;
            }
            
            .table tbody td:nth-child(7) {
                width: 120px;
                max-width: 120px;
                min-width: 120px;
                text-align: center;
            }
            
            .table tbody tr {
                transition: all 0.15s ease;
            }
            
            .table tbody tr:hover {
                background: #f8f9fa;
            }
            
            .table tbody tr:hover td {
                color: #212529;
                font-weight: 500;
            }
            
            /* Loại bỏ hiệu ứng hover cho cột email */
            .table tbody tr:hover td:nth-child(3) {
                color: #495057;
                font-weight: 400;
            }
            
            /* Button Styles - Enhanced Sizing - Uniform Buttons */
            .btn-primary,
            .btn-outline-secondary {
                border-radius: 8px;
                font-weight: 500;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.75rem 1.5rem;
                white-space: nowrap;
                text-decoration: none;
                cursor: pointer;
                border: none;
                box-sizing: border-box;
            }
            
            .btn-primary {
                background: #333;
                color: white;
            }
            
            .btn-primary:hover {
                background: #555;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0,0,0,0.2);
            }
            
            /* Clear filter button */
            .btn-outline-secondary {
                border: 1px solid #6c757d;
                color: #6c757d;
                background: transparent;
            }
            
            /* Clear filter button specific styling */
            #clearFilterBtn {
                width: 48px !important;
                min-width: 48px !important;
                border-radius: 8px !important;
                padding: 0 !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                font-size: 1.1rem !important;
            }
            
            .btn-outline-secondary:hover {
                background: #6c757d;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
            }
            
            /* Button container styling */
            .button-container {
                display: flex;
                gap: 0.75rem;
                align-items: center;
                height: 48px;
            }
            
            /* Individual button sizing */
            .btn-primary,
            .btn-outline-secondary {
                flex: 1;
                min-width: 0;
            }
            
            /* Uniform width for all primary buttons */
            .search-filter-section .btn-primary {
                min-width: 160px;
                width: 160px;
                flex-shrink: 0;
            }
            
            /* Uniform button sizing for all primary buttons */
            .btn-primary {
                height: 48px;
                min-height: 48px;
                padding: 0.75rem 1.5rem;
                font-size: 0.95rem;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                white-space: nowrap;
                text-decoration: none;
                cursor: pointer;
                border: none;
                box-sizing: border-box;
                border-radius: 8px;
                transition: all 0.3s ease;
                min-width: 160px; /* Đảm bảo width tối thiểu */
                width: auto; /* Cho phép mở rộng theo nội dung */
            }
            
            .btn-danger {
                background: #dc3545;
                border: none;
                border-radius: 8px;
                padding: 0.6rem 1.2rem;
                font-weight: 400;
                transition: all 0.3s ease;
            }
            
            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            }
            
            .btn-warning {
                background: #ffc107;
                border: none;
                border-radius: 8px;
                padding: 0.6rem 1.2rem;
                font-weight: 400;
                transition: all 0.3s ease;
                color: #333;
            }
            
            .btn-warning:hover {
                background: #e0a800;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
                color: #333;
            }
            
            /* Search and Filter - Enhanced Sizing - Uniform Layout */
            .search-filter-section {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 2rem;
                margin-bottom: 2rem;
                border: 1px solid #e9ecef;
            }
            
            .search-filter-section h5 {
                font-size: 1.1rem;
                font-weight: 500;
                color: #495057;
                margin-bottom: 0;
            }
            
            /* Form controls uniform sizing */
            .form-control {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                box-sizing: border-box;
                width: 100%;
            }
            
            .form-control:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
                transform: translateY(-1px);
            }
            
            /* Custom select styling */
            .form-control[name="role"],
            .form-control[name="status"] {
                cursor: pointer;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 7 7 7-7'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 0.75rem center;
                background-size: 16px 12px;
                padding-right: 2.5rem;
            }
            
            /* Search input specific styling */
            .form-control[name="search"] {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236c757d' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: left 1rem center;
                background-size: 16px 16px;
                padding-left: 2.75rem;
            }
            

            
            /* Role Badge - Minimalist Porsche Theme */
            .role-badge {
                padding: 0.2rem 0.5rem;
                border-radius: 4px;
                font-size: 0.65rem;
                font-weight: 500;
                letter-spacing: 0.2px;
                box-shadow: none;
                transition: all 0.15s ease;
                border: 1px solid transparent;
            }
            
            .role-badge.admin {
                background: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
            
            .role-badge.customer {
                background: #cce5ff;
                color: #004085;
                border-color: #b3d7ff;
            }
            
            .role-badge:hover {
                transform: none;
                box-shadow: none;
            }
            
            /* Action Buttons - Refined Minimalist Porsche Theme */
            .action-btn {
                padding: 0.35rem;
                border-radius: 5px;
                border: 1px solid transparent;
                transition: all 0.2s ease;
                box-shadow: 0 1px 3px rgba(0,0,0,0.08);
                margin: 0 0.1rem;
                font-size: 0.7rem;
                min-width: 28px;
                height: 28px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
            }
            
            .action-btn.edit {
                background: #fff3cd;
                color: #856404;
                border-color: #ffeaa7;
            }
            
            .action-btn.delete {
                background: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
            
            .action-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 2px 6px rgba(0,0,0,0.12);
            }
            
            .action-btn.edit:hover {
                background: #ffeaa7;
                border-color: #fdcb6e;
            }
            
            .action-btn.delete:hover {
                background: #f5c6cb;
                border-color: #f1b0b7;
            }
            
            /* Alert Styles */
            .alert {
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border: none;
                border-radius: 8px;
                font-weight: 500;
            }
            
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border-left: 4px solid #28a745;
            }
            
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }
            
            .alert-delete-success {
                background-color: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }
            
            .btn-close {
                opacity: 0.7;
            }
            
            .btn-close:hover {
                opacity: 1;
            }
            
            /* Button action-btn styles - Unified with .action-btn */
            button.action-btn {
                background: none;
                border: 1px solid;
                border-radius: 5px;
                padding: 0.35rem;
                font-size: 0.7rem;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 28px;
                height: 28px;
                margin: 0 0.1rem;
                box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            }
            
            button.action-btn.delete {
                background: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
            
            button.action-btn.delete:hover {
                background: #f5c6cb;
                border-color: #f1b0b7;
            }
            
            button.action-btn.edit {
                background: #fff3cd;
                color: #856404;
                border-color: #ffeaa7;
            }
            
            button.action-btn.edit:hover {
                background: #ffeaa7;
                border-color: #fdcb6e;
            }
            
            /* Date Column - Enhanced Minimalist Porsche Theme */
            .date-info {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                padding: 0.3rem 0.6rem;
                border-radius: 6px;
                border: 1px solid #dee2e6;
                color: #495057;
                font-weight: 500;
                font-size: 0.7rem;
                text-align: center;
                transition: all 0.2s ease;
                position: relative;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
                width: 90px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.3rem;
            }
            
            .date-info i {
                color: #6c757d;
                font-size: 0.75rem;
            }
            
            .date-info:hover {
                background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                border-color: #adb5bd;
            }
            
            /* Footer */
            footer {
                margin-top: 3rem;
                background: #333;
                border-radius: 16px 16px 0 0;
                padding: 1.5rem 0;
                width: 100%;
                box-sizing: border-box;
            }
            
            footer p {
                margin: 0;
                color: #fff;
                font-size: 0.9rem;
                text-align: center;
            }
            
            /* Responsive - Enhanced Mobile Layout - Uniform Buttons */
            @media (max-width: 768px) {
                .admin-header {
                    padding: 1.5rem 0;
                    margin-bottom: 1.5rem;
                }
                
                .admin-header h1 {
                    font-size: 1.8rem;
                }
                
                .content-section {
                    padding: 1.5rem;
                }
                
                .search-filter-section {
                    padding: 1.5rem;
                }
                
                .search-filter-section h5 {
                    font-size: 1rem;
                    margin-bottom: 1rem;
                }
                
                .form-control {
                    height: 44px;
                    min-height: 44px;
                    font-size: 0.9rem;
                    padding: 0.6rem 0.8rem;
                }
                
                .form-control[name="search"] {
                    padding-left: 2.5rem;
                    background-size: 14px 14px;
                }
                
                .form-control[name="role"],
                .form-control[name="status"] {
                    padding-right: 2rem;
                    background-size: 14px 10px;
                }
                
                /* Uniform button sizing on mobile */
                .btn-primary {
                    height: 44px;
                    min-height: 44px;
                    padding: 0.6rem 1.2rem;
                    font-size: 0.9rem;
                    min-width: 140px;
                    width: 140px;
                }
                
                .btn-outline-secondary {
                    height: 44px;
                    min-height: 44px;
                    padding: 0.6rem 1.2rem;
                    font-size: 0.9rem;
                }
                
                .button-container {
                    height: 44px;
                    gap: 0.5rem;
                }
                
                .table-responsive {
                    font-size: 0.9rem;
                }
                
                /* Mobile layout for search filter section */
                .search-filter-section .d-flex {
                    flex-direction: column;
                    gap: 1rem;
                }
                
                .search-filter-section .flex-grow-1 {
                    flex-direction: column;
                    gap: 0.75rem;
                }
                
                .search-filter-section .form-control {
                    min-width: 100% !important;
                }
                
                .search-filter-section .btn {
                    width: 100%;
                    justify-content: center;
                }
            }
            
            @media (max-width: 576px) {
                .search-filter-section {
                    padding: 1rem;
                }
                
                .form-control {
                    margin-bottom: 0.75rem;
                }
                
                .button-container {
                    flex-direction: column;
                    height: auto;
                    gap: 0.5rem;
                }
                
                /* Uniform button sizing on small mobile */
                .btn-primary {
                    width: 100%;
                    margin-bottom: 0;
                    height: 44px;
                    min-height: 44px;
                    min-width: 100%;
                }
                
                .btn-outline-secondary {
                    width: 100%;
                    margin-bottom: 0;
                    height: 44px;
                    min-height: 44px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Admin Header -->
        <div class="admin-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1 class="mb-0">
                            <i class="fas fa-user-tie me-3"></i>
                            Quản lý Users
                        </h1>
                        <p class="mb-0 mt-2">Quản lý người dùng hệ thống K - Auto</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <div class="d-flex align-items-center justify-content-end gap-3">
                            <div class="user-info">
                                <div class="user-avatar">
                                    ${sessionScope.userName != null ? sessionScope.userName.toUpperCase().charAt(0) : 'A'}
                                </div>
                                <div>
                                    <h6 class="mb-0">${sessionScope.userName != null ? sessionScope.userName : 'Admin'}</h6>
                                    <small class="text-muted">Administrator</small>
                                </div>
                            </div>
                            <a href="admin?action=logout" class="btn logout-btn">
                                <i class="fas fa-door-open me-2"></i>Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Admin Navigation -->
        <nav class="admin-navbar">
            <div class="container">
                <ul class="nav nav-pills">
                    <li class="nav-item">
                        <a class="nav-link" href="admin?action=dashboard">
                            <i class="fas fa-gem me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="admin?action=users">
                            <i class="fas fa-user-tie me-2"></i>Quản lý Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin?action=products">
                            <i class="fas fa-car-side me-2"></i>Quản lý Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin?action=orders">
                            <i class="fas fa-receipt me-2"></i>Quản lý Orders
                        </a>
                    </li>

                </ul>
            </div>
        </nav>
        
        <!-- Main Content -->
        <div class="container">
            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <form action="admin" method="GET" id="filterForm">
                    <input type="hidden" name="action" value="users">
                    <div class="row align-items-center">
                        <div class="col-md-12">
                            <div class="d-flex align-items-center gap-3">
                                <div class="flex-grow-1 d-flex gap-3">
                                    <input type="text" class="form-control" name="search" 
                                           placeholder="Tìm kiếm theo tên..." 
                                           value="${not empty searchTerm ? searchTerm : ''}"
                                           style="min-width: 200px;">
                                    
                                    <select class="form-control" name="role" style="min-width: 150px;">
                                        <option value="">Tất cả vai trò</option>
                                        <option value="admin" ${roleFilter == 'admin' ? 'selected' : ''}>Admin</option>
                                        <option value="customer" ${roleFilter == 'customer' ? 'selected' : ''}>Customer</option>
                                    </select>
                                    

                                    
                                    <button type="button" class="btn btn-outline-secondary" id="clearFilterBtn" title="Xóa lọc">
                                        <i class="fas fa-times"></i>
                                    </button>
                                    
                                    <a href="admin?action=addUser" class="btn btn-primary" style="min-width: 200px;">
                                        <i class="fas fa-plus me-2"></i>Thêm User mới
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Users Table Section -->
            <div class="content-section">
                <h3>
                    <i class="fas fa-users me-2"></i>Danh sách Users
                </h3>
                
                <div class="table-responsive">
                    <table id="usersTable" class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên đăng nhập</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr data-user-id="${user.id}">
                                    <td>${user.id}</td>
                                    <td>
                                        <strong>${user.fullName}</strong>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="role-badge ${user.role == 'admin' ? 'admin' : 'customer'}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="date-info">
                                            <i class="fas fa-calendar-day"></i>
                                            <span>N/A</span>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex gap-1 justify-content-center align-items-center">
                                            <a href="admin?action=editUser&id=${user.id}" class="action-btn edit" 
                                               title="Chỉnh sửa user">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="action-btn delete" 
                                               onclick="deleteUser(${user.id})"
                                               title="Xóa user">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                

            </div>
        </div>
        
        <!-- Footer -->
        <footer class="text-white text-center py-4 mt-5">
            <div class="container">
                <p class="mb-0">&copy; 2024 AutoShowVN Admin Dashboard. All rights reserved.</p>
            </div>
        </footer>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Auto-submit form khi thay đổi select
            document.addEventListener('DOMContentLoaded', function() {
                const roleSelect = document.querySelector('select[name="role"]');
                const searchInput = document.querySelector('input[name="search"]');
                
                // Auto-submit khi thay đổi role
                roleSelect.addEventListener('change', function() {
                    document.getElementById('filterForm').submit();
                });
                
                // Search input - chỉ submit khi nhấn Enter
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault(); // Ngăn form submit mặc định
                        document.getElementById('filterForm').submit();
                    }
                });
                
                // Clear filter button functionality
                function clearFilters() {
                    searchInput.value = '';
                    roleSelect.value = '';
                    document.getElementById('filterForm').submit();
                }
                
                // Add event listener for clear filter button
                const clearFilterBtn = document.getElementById('clearFilterBtn');
                if (clearFilterBtn) {
                    clearFilterBtn.addEventListener('click', clearFilters);
                }
            });
            
            // Xóa user bằng AJAX
            function deleteUser(userId) {
                if (confirm('Bạn có chắc chắn muốn xóa user này?')) {
                    fetch('admin?action=deleteUser&id=' + userId)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Hiển thị thông báo xóa thành công với màu đỏ
                                showAlert('delete-success', data.message);
                                
                                // Cập nhật thống kê
                                updateUserStats(data);
                                
                                // Cập nhật bảng users
                                updateUsersTable(data.users);
                                
                                // Cập nhật số lượng users
                                updateUserCount();
                            } else {
                                showAlert('error', data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            showAlert('error', 'Có lỗi xảy ra khi xóa user!');
                        });
                }
            }
            
            // Cập nhật thống kê users
            function updateUserStats(data) {
                // Cập nhật các số liệu thống kê
                if (document.getElementById('totalUsers')) {
                    document.getElementById('totalUsers').textContent = data.totalUsers;
                }
                if (document.getElementById('activeUsers')) {
                    document.getElementById('activeUsers').textContent = data.activeUsers;
                }
                if (document.getElementById('newUsers')) {
                    document.getElementById('newUsers').textContent = data.newUsers;
                }
                if (document.getElementById('activeUsers')) {
                    document.getElementById('adminUsers').textContent = data.adminUsers;
                }
            }
            
            // Cập nhật bảng users
            function updateUsersTable(users) {
                const tbody = document.querySelector('#usersTable tbody');
                if (!tbody) return;
                
                // Xóa tất cả rows hiện tại
                tbody.innerHTML = '';
                
                // Thêm users mới
                users.forEach(user => {
                    const row = document.createElement('tr');
                    row.setAttribute('data-user-id', user.id);
                    row.innerHTML = 
                        '<td>' + user.id + '</td>' +
                        '<td>' +
                            '<strong>' + (user.fullName || '') + '</strong>' +
                        '</td>' +
                        '<td>' + (user.email || '') + '</td>' +
                        '<td>' +
                            '<span class="role-badge ' + (user.role === 'admin' || user.role === 'A' ? 'admin' : 'customer') + '">' +
                                (user.role === 'admin' || user.role === 'A' ? 'Admin' : 'Customer') +
                            '</span>' +
                        '</td>' +
                        '<td>' +
                            '<span class="status-badge active">' +
                                '<i class="fas fa-check-circle me-1"></i>Hoạt động' +
                            '</span>' +
                        '</td>' +
                        '<td class="text-center">' +
                            '<div class="date-info">' +
                                '<i class="fas fa-calendar-day"></i>' +
                                '<span>N/A</span>' +
                            '</div>' +
                        '</td>' +
                        '<td class="text-center">' +
                            '<div class="d-flex gap-1 justify-content-center align-items-center">' +
                                '<a href="admin?action=editUser&id=' + user.id + '" class="action-btn edit" ' +
                                   'title="Chỉnh sửa user">' +
                                    '<i class="fas fa-edit"></i>' +
                                '</a>' +
                                '<button type="button" class="action-btn delete" ' +
                                       'onclick="deleteUser(' + user.id + ')"' +
                                       'title="Xóa user">' +
                                    '<i class="fas fa-trash"></i>' +
                                '</button>' +
                            '</div>' +
                        '</td>';
                    tbody.appendChild(row);
                });
            }
            
            // Cập nhật số lượng users
            function updateUserCount() {
                const tbody = document.querySelector('#usersTable tbody');
                if (tbody) {
                    const userCount = tbody.children.length;
                    const countElement = document.querySelector('.user-count');
                    if (countElement) {
                        countElement.textContent = userCount;
                    }
                }
            }
            
            // Hiển thị alert
            function showAlert(type, message) {
                // Xóa alert cũ nếu có
                const existingAlert = document.querySelector('.alert.position-fixed');
                if (existingAlert) {
                    existingAlert.remove();
                }
                
                // Tạo alert mới
                const alertDiv = document.createElement('div');
                let alertClass = 'alert alert-';
                if (type === 'success') {
                    alertClass += 'success';
                } else if (type === 'delete-success') {
                    alertClass += 'delete-success';
                } else {
                    alertClass += 'danger';
                }
                alertDiv.className = alertClass + ' alert-dismissible fade show position-fixed';
                alertDiv.style.cssText = 'bottom: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                alertDiv.innerHTML = 
                    message + 
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                
                document.body.appendChild(alertDiv);
                
                // Tự động ẩn sau 3 giây
                setTimeout(function() {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }
        </script>
    </body>
</html>
