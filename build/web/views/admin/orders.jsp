<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý đơn hàng - Admin Dashboard</title>
        
        <!-- ✅ SỬA: CSS với font tiếng Việt -->
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
            
            .user-details h6 {
                margin: 0;
                font-weight: 600;
                color: #333;
                font-size: 0.9rem;
            }
            
            .user-details small {
                color: #6b7280;
                font-size: 0.8rem;
            }
            
            /* Logout Button */
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
            
            /* Welcome Section */
            .welcome-section {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                border: 1px solid #f0f0f0;
            }
            
            .welcome-section h3 {
                color: #333;
                font-weight: 400;
                font-size: 1.6rem;
                margin-bottom: 1rem;
            }
            
            .welcome-section p {
                color: #666;
                font-size: 1rem;
                margin: 0;
            }
            
            .welcome-section small {
                color: #adb5bd;
                font-size: 0.9rem;
            }
            
            .admin-header {
                background: white;
                color: #333;
                padding: 2rem 0;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-bottom: 1px solid #e9ecef;
            }
            
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
            }
            
            .admin-navbar .nav-link:hover,
            .admin-navbar .nav-link.active {
                color: #333;
                background-color: #f8f9fa;
                border-bottom-color: #333;
                transform: translateY(-2px);
            }
            
            /* Statistics Cards */
            .stat-card {
                background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 8px 32px rgba(0,0,0,0.08);
                border: 1px solid rgba(255,255,255,0.8);
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                height: 100%;
                display: flex;
                align-items: center;
                gap: 2rem;
                position: relative;
                overflow: hidden;
                margin-bottom: 2rem;
                text-decoration: none;
                color: inherit;
                backdrop-filter: blur(10px);
            }
            
            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, #3b82f6, #8b5cf6, #06b6d4);
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            
            .stat-card:hover::before {
                opacity: 1;
            }
            
            .stat-card:hover {
                transform: translateY(-4px) scale(1.01);
                box-shadow: 0 12px 30px rgba(59, 130, 246, 0.12);
                text-decoration: none;
                color: inherit;
                border-color: rgba(59, 130, 246, 0.15);
            }
            
            .stat-card:active {
                transform: scale(0.98);
            }
            
            .stat-icon {
                width: 80px;
                height: 80px;
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: white;
                position: relative;
                overflow: hidden;
                flex-shrink: 0;
                box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            }
            
            .stat-icon::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
                transform: rotate(45deg);
                transition: transform 0.6s ease;
            }
            
            .stat-card:hover .stat-icon::before {
                transform: rotate(45deg) translate(50%, 50%);
            }
            
            .stat-card:nth-child(1) .stat-icon {
                background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            }
            
            .stat-card:nth-child(2) .stat-icon {
                background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            }
            
            .stat-card:nth-child(3) .stat-icon {
                background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            }
            
            .stat-card:nth-child(4) .stat-icon {
                background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            }
            
            .stat-content {
                flex: 1;
                min-width: 0;
            }
            
            .stat-number {
                font-size: 1.5rem;
                font-weight: 800;
                margin: 0;
                line-height: 1.2;
                letter-spacing: -0.025em;
            }
            
            .stat-card:nth-child(1) .stat-number {
                color: #667eea;
            }
            
            .stat-card:nth-child(2) .stat-number {
                color: #f093fb;
            }
            
            .stat-card:nth-child(3) .stat-number {
                color: #4facfe;
            }
            
            .stat-card:nth-child(4) .stat-number {
                color: #43e97b;
            }
            
            .stat-label {
                margin: 0.4rem 0 0 0;
                color: #6b7280;
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: none;
                letter-spacing: 0.025em;
            }
            
            /* Filters Section */
            .filters-section {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 2rem;
                margin-bottom: 2rem;
                border: 1px solid #e9ecef;
            }
            
            .filter-row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 1rem;
                align-items: end;
            }
            
            /* CSS để xử lý nút không bị tràn */
            .filter-row .d-flex {
                grid-column: span 1;
                min-width: 0;
                flex-wrap: wrap;
                gap: 0.5rem;
            }
            
            .filter-row .btn {
                flex: 1;
                min-width: 0;
                max-width: 100%;
            }
            
            /* ✅ THÊM: CSS responsive để tránh tràn */
            @media (max-width: 768px) {
                .filter-row {
                    grid-template-columns: 1fr;
                    gap: 0.75rem;
                }
                
                .filter-row .d-flex {
                    flex-direction: column;
                    width: 100%;
                }
                
                .filter-row .btn {
                    width: 100%;
                    margin: 0.25rem 0;
                }
                
                .btn-filter, .btn-refresh {
                    padding: 0.75rem 0.5rem;
                    font-size: 0.9rem;
                }
            }
            
            .form-control, .form-select {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                box-sizing: border-box;
                width: 100%;
                background: #ffffff;
                color: #333;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
                outline: none;
            }
            
            .btn-filter, .btn-refresh {
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
                padding: 0.75rem 1rem;
                white-space: nowrap;
                text-decoration: none;
                cursor: pointer;
                border: none;
                box-sizing: border-box;
                min-width: auto;
                width: auto;
                flex-shrink: 0;
            }
            
            .btn-filter {
                background: #333;
                color: white;
            }
            
            .btn-refresh {
                border: 1px solid #6c757d;
                color: #6c757d;
                background: transparent;
            }
            
            .orders-table {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                border: 1px solid #f0f0f0;
                margin-bottom: 2rem;
            }
            
            .table {
                background: white;
                border-radius: 4px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                border: none;
                margin: 0;
            }
            
            .table thead th {
                background: #f8f9fa;
                border: none;
                color: #495057;
                padding: 0.5rem 0.75rem;
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                border-bottom: none;
                font-weight: 600;
            }
            
            .table tbody td {
                padding: 0.5rem 0.75rem;
                border: none;
                border-bottom: none;
                color: #495057;
                vertical-align: middle;
                font-weight: 400;
                font-size: 0.9rem;
            }
            
            .status-badge {
                padding: 0.3rem 0.6rem;
                border-radius: 6px;
                font-size: 0.75rem;
                font-weight: 600;
                letter-spacing: 0.2px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                border: 1px solid transparent;
                display: inline-block;
                min-width: 90px;
                text-align: center;
                transition: all 0.2s ease;
            }
            
            /* ✅ THÊM: CSS cho database status mới */
            .status-unconfirmed {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                color: #856404;
                border-color: #ffeaa7;
            }

            .status-confirmed {
                background: linear-gradient(135deg, #d1e7dd 0%, #badbcc 100%);
                color: #0f5132;
                border-color: #badbcc;
            }
            
            /* ✅ THÊM: CSS cho trạng thái "in delivery" */
            .status-in-delivery {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%);
                color: #004085;
                border-color: #b3d7ff;
            }

            /* ✅ SỬA: CSS cho trạng thái "in delivery" với độ ưu tiên cao */
            .status-badge.status-in-delivery,
            .status-badge[class*="in-delivery"],
            .status-badge.status-in-delivery {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                color: #004085 !important;
                border-color: #b3d7ff !important;
                font-weight: 600 !important;
                text-shadow: 0 1px 2px rgba(0,0,0,0.1) !important;
            }

            /* ✅ THÊM: CSS cho trạng thái "in delivery" khi hover */
            .status-badge.status-in-delivery:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%) !important;
                transform: translateY(-1px) !important;
                box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
            }

            /* ✅ THÊM: CSS cho trạng thái "in delivery" khi active */
            .status-badge.status-in-delivery:active {
                background: linear-gradient(135deg, #99ccff 0%, #80bfff 100%) !important;
                transform: translateY(0) !important;
            }

            .status-delivered {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border-color: #c3e6cb;
            }

            .status-cancelled {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border-color: #f5c6cb;
            }
            
            .btn-status-update {
                padding: 0.25rem 0.5rem;
                font-size: 0.7rem;
                border-radius: 6px;
                border: 2px solid #e9ecef;
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                color: #495057;
                transition: all 0.3s ease;
                min-width: 28px;
                height: 28px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                font-weight: 500;
            }
            
            .btn-status-update:hover {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                border-color: #007bff;
                color: #007bff;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,123,255,0.2);
            }
            
            .btn-status-update:active {
                transform: translateY(0);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            /* ✅ THÊM: Màu phân biệt cho dropdown button theo trạng thái */
            .btn-status-update.status-pending {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                border-color: #ffc107;
                color: #856404;
            }
            
            .btn-status-update.status-pending:hover {
                background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%);
                border-color: #e17055;
                color: #6c5ce7;
                box-shadow: 0 4px 8px rgba(255,193,7,0.3);
            }
            
            .btn-status-update.status-confirmed {
                background: linear-gradient(135deg, #d1e7dd 0%, #badbcc 100%);
                border-color: #28a745;
                color: #0f5132;
            }
            
            .btn-status-update.status-confirmed:hover {
                background: linear-gradient(135deg, #badbcc 0%, #a7d7bd 100%);
                border-color: #20c997;
                color: #0c5460;
                box-shadow: 0 4px 8px rgba(40,167,69,0.3);
            }
            
            .btn-status-update.status-in-delivery {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%);
                border-color: #007bff;
                color: #004085;
            }
            
            .btn-status-update.status-in-delivery:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%);
                border-color: #0056b3;
                color: #002752;
                box-shadow: 0 4px 8px rgba(0,123,255,0.3);
            }
            
            .btn-status-update.status-delivered {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                border-color: #20c997;
                color: #155724;
            }
            
            .btn-status-update.status-delivered:hover {
                background: linear-gradient(135deg, #c3e6cb 0%, #b1dfbb 100%);
                border-color: #17a2b8;
                color: #0c5460;
                box-shadow: 0 4px 8px rgba(32,201,151,0.3);
            }
            
            .btn-status-update.status-cancelled {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                border-color: #dc3545;
                color: #721c24;
            }
            
            .btn-status-update.status-cancelled:hover {
                background: linear-gradient(135deg, #f5c6cb 0%, #f1b0b7 100%);
                border-color: #c82333;
                color: #5a1a1f;
                box-shadow: 0 4px 8px rgba(220,53,69,0.3);
            }
            
            /* ✅ THÊM: CSS cho các trạng thái khác có thể có */
            .btn-status-update.status-unconfirmed {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                border-color: #ffc107;
                color: #856404;
            }
            
            .btn-status-update.status-unconfirmed:hover {
                background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%);
                border-color: #e17055;
                color: #6c5ce7;
                box-shadow: 0 4px 8px rgba(255,193,7,0.3);
            }
            
            /* ✅ THÊM: CSS cho trạng thái "in delivery" với dấu cách */
            .btn-status-update[class*="in-delivery"],
            .btn-status-update[class*="in delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
            }
            
            .btn-status-update[class*="in-delivery"]:hover,
            .btn-status-update[class*="in delivery"]:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%) !important;
                border-color: #0056b3 !important;
                color: #002752 !important;
                box-shadow: 0 4px 8px rgba(0,123,255,0.3) !important;
            }
            
            /* ✅ THÊM: CSS cho icon trong dropdown button */
            .btn-status-update i {
                font-size: 0.8rem;
                transition: all 0.3s ease;
            }
            
            .btn-status-update:hover i {
                transform: scale(1.1);
            }
            
            /* ✅ THÊM: CSS cho dropdown button khi đang mở */
            .btn-status-update.active,
            .btn-status-update[aria-expanded="true"] {
                background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
                border-color: #0056b3 !important;
                color: white !important;
                box-shadow: 0 4px 12px rgba(0,123,255,0.4) !important;
                transform: translateY(-1px);
            }
            
            /* ✅ THÊM: CSS cho dropdown button khi bị disable */
            .btn-status-update:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none !important;
                box-shadow: none !important;
            }
            
            /* ✅ THÊM: CSS cho dropdown button với animation */
            .btn-status-update {
                animation: fadeInUp 0.3s ease-out;
            }
            
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            /* ✅ THÊM: CSS cho dropdown menu */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-menu {
                position: absolute;
                top: 100%;
                left: 0;
                z-index: 99999; /* ✅ TĂNG: z-index cao hơn nữa */
                display: none;
                min-width: 200px;
                padding: 0.5rem 0;
                margin: 0.125rem 0 0;
                font-size: 0.875rem;
                color: #212529;
                text-align: left;
                list-style: none;
                background-color: #fff;
                background-clip: padding-box;
                border: 1px solid rgba(0, 0, 0, 0.15);
                border-radius: 0.375rem;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.175);
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown hiển thị đúng vị trí */
            .dropdown-menu.show {
                display: block !important;
                opacity: 1 !important;
                visibility: visible !important;
                transform: none !important;
                z-index: 99999 !important;
            }

            /* ✅ THÊM: CSS để xử lý dropdown ở cuối danh sách */
            .dropdown-menu.dropup {
                top: auto !important;
                bottom: 100% !important;
                margin-bottom: 0.125rem !important;
                margin-top: 0 !important;
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown không bị che */
            .table-responsive {
                overflow: visible !important;
            }

            .table {
                overflow: visible !important;
            }

            .table tbody tr {
                position: relative;
            }

            /* ✅ THÊM: CSS để xử lý dropdown ở những bản ghi cuối */
            .table tbody tr:last-child .dropdown-menu,
            .table tbody tr:nth-last-child(2) .dropdown-menu {
                top: auto !important;
                bottom: 100% !important;
                margin-bottom: 0.125rem !important;
                margin-top: 0 !important;
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown luôn hiển thị đúng */
            .dropdown-menu {
                position: fixed !important;
                z-index: 999999 !important;
            }

            /* ✅ THÊM: CSS để xử lý vị trí dropdown */
            .dropdown-menu.show {
                position: absolute !important;
            }

            .dropdown-menu.dropup.show {
                position: absolute !important;
                bottom: 100% !important;
                top: auto !important;
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown không bị che bởi các phần tử khác */
            .orders-table {
                position: relative;
                z-index: 1;
            }

            .table-responsive {
                position: relative;
                z-index: 1;
            }

            /* ✅ THÊM: CSS để xử lý dropdown ở cuối trang */
            .dropdown-menu.show {
                max-height: 300px;
                overflow-y: auto;
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown luôn hiển thị trên cùng */
            .dropdown-menu.show {
                z-index: 999999 !important;
                position: absolute !important;
                background: white !important;
                border: 1px solid #e9ecef !important;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15) !important;
            }
            
            /* ✅ THÊM: CSS debug để xem tất cả trạng thái */
            .btn-status-update[class*="status-"] {
                position: relative;
            }
            
            .btn-status-update[class*="status-"]::after {
                content: attr(class);
                position: absolute;
                top: -25px;
                left: 50%;
                transform: translateX(-50%);
                background: rgba(0,0,0,0.8);
                color: white;
                padding: 2px 6px;
                border-radius: 4px;
                font-size: 10px;
                white-space: nowrap;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
                z-index: 1000000;
            }
            
            .btn-status-update[class*="status-"]:hover::after {
                opacity: 1;
            }
            
            /* ✅ THÊM: CSS mạnh hơn để đảm bảo màu xanh dương cho "Đang giao" */
            .btn-status-update[class*="in-delivery"],
            .btn-status-update[class*="in delivery"],
            .btn-status-update[class*="shipped"],
            .btn-status-update[class*="delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
                box-shadow: 0 2px 4px rgba(0,123,255,0.2) !important;
            }
            
            .btn-status-update[class*="in-delivery"]:hover,
            .btn-status-update[class*="in delivery"]:hover,
            .btn-status-update[class*="shipped"]:hover,
            .btn-status-update[class*="delivery"]:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%) !important;
                border-color: #0056b3 !important;
                color: #002752 !important;
                box-shadow: 0 4px 8px rgba(0,123,255,0.3) !important;
            }
            
            /* ✅ THÊM: CSS để override tất cả các trường hợp có thể */
            .btn-status-update[class*="giao"],
            .btn-status-update[class*="delivery"],
            .btn-status-update[class*="shipped"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
            }
            
            /* ✅ THÊM: CSS cực mạnh để đảm bảo màu xanh dương */
            .btn-status-update[data-status*="delivery"],
            .btn-status-update[data-status*="shipped"],
            .btn-status-update[data-status-text*="giao"],
            .btn-status-update[data-status-text*="delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
                box-shadow: 0 2px 4px rgba(0,123,255,0.2) !important;
            }
            
            /* ✅ THÊM: CSS đặc biệt cho "in delivery" với dấu cách */
            .btn-status-update[data-status="in delivery"],
            .btn-status-update[data-status*="in delivery"],
            .btn-status-update[class*="in delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
                box-shadow: 0 2px 4px rgba(0,123,255,0.2) !important;
            }
            
            .btn-status-update[data-status="in delivery"]:hover,
            .btn-status-update[data-status*="in delivery"]:hover,
            .btn-status-update[class*="in delivery"]:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%) !important;
                border-color: #0056b3 !important;
                color: #002752 !important;
                box-shadow: 0 4px 8px rgba(0,123,255,0.3) !important;
            }
            
            /* ✅ THÊM: CSS cho tất cả button có data attribute */
            .btn-status-update[data-status] {
                position: relative;
            }
            
            .btn-status-update[data-status]::before {
                content: attr(data-status);
                position: absolute;
                top: -20px;
                left: 50%;
                transform: translateX(-50%);
                background: rgba(0,0,0,0.9);
                color: white;
                padding: 2px 6px;
                border-radius: 4px;
                font-size: 10px;
                white-space: nowrap;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
                z-index: 1000000;
            }
            
            .btn-status-update[data-status]:hover::before {
                opacity: 1;
            }
            
            /* ✅ THÊM: CSS cho class mới được thêm vào */
            .btn-status-update.status-delivery {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
                box-shadow: 0 2px 4px rgba(0,123,255,0.2) !important;
            }
            
            .btn-status-update.status-delivery:hover {
                background: linear-gradient(135deg, #b3d7ff 0%, #99ccff 100%) !important;
                border-color: #0056b3 !important;
                color: #002752 !important;
                box-shadow: 0 4px 8px rgba(0,123,255,0.3) !important;
            }
            
            /* ✅ THÊM: CSS để đảm bảo tất cả button đều có style */
            .btn-status-update:not([class*="status-"]) {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%) !important;
                border-color: #6c757d !important;
                color: #495057 !important;
            }
            
            /* ✅ THÊM: CSS cuối cùng để đảm bảo "in delivery" có màu xanh dương */
            .btn-status-update[data-status="in delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
                box-shadow: 0 2px 4px rgba(0,123,255,0.2) !important;
            }
            
            /* ✅ THÊM: CSS để override tất cả các trường hợp khác */
            .btn-status-update[data-status*="delivery"] {
                background: linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%) !important;
                border-color: #007bff !important;
                color: #004085 !important;
            }

            .dropdown-menu.show {
                display: block !important; /* ✅ THÊM: Force display */
            }

            /* ✅ THÊM: CSS để đảm bảo dropdown hiển thị */
            .dropdown-menu.show {
                display: block !important;
                opacity: 1 !important;
                visibility: visible !important;
                transform: none !important;
            }

            .dropdown-header {
                display: block;
                padding: 0.5rem 1rem;
                margin-bottom: 0;
                font-size: 0.875rem;
                color: #6c757d;
                white-space: nowrap;
                font-weight: 600;
            }

            .dropdown-divider {
                height: 0;
                margin: 0.5rem 0;
                overflow: hidden;
                border-top: 1px solid #e9ecef;
            }

            .dropdown-item {
                display: block;
                width: 100%;
                padding: 0.5rem 1rem;
                clear: both;
                font-weight: 400;
                color: #212529;
                text-align: inherit;
                text-decoration: none;
                white-space: nowrap;
                background-color: transparent;
                border: 0;
                cursor: pointer;
            }

            .dropdown-item:hover,
            .dropdown-item:focus {
                color: #1e2125;
                background-color: #e9ecef;
            }

            .dropdown-item:active {
                color: #fff;
                text-decoration: none;
                background-color: #0d6efd;
            }
            
            .dropdown-menu {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                padding: 0.5rem 0;
            }
            
            .dropdown-header {
                font-size: 0.8rem;
                font-weight: 600;
                color: #495057;
                padding: 0.5rem 1rem;
                margin-bottom: 0.25rem;
            }
            
            .dropdown-item {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
                color: #495057;
                transition: all 0.2s ease;
            }
            
            .dropdown-item:hover {
                background: #f8f9fa;
                color: #333;
            }
            
            .dropdown-item i {
                width: 16px;
                margin-right: 0.5rem;
            }
            
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
            
            .action-btn.delete {
                background: #f8d7da;
                color: #721c24;
                border-color: #f5c6cb;
            }
            
            .action-btn.btn-info {
                background: #d1ecf1;
                color: #0c5460;
                border-color: #bee5eb;
            }
            
            .date-info {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                padding: 0.3rem 0.6rem;
                border-radius: 6px;
                border: 1px solid #dee2e6;
                color: #495057;
                font-weight: 500;
                font-size: 0.7rem;
                text-align: center;
                position: relative;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
                width: 90px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.3rem;
            }
            
            .price-info {
                background: none;
                padding: 0;
                border-radius: 0;
                border: none !important;
                outline: none !important;
                color: #2f855a;
                font-weight: 600;
                font-size: 0.9rem;
                text-align: left;
                position: static;
                box-shadow: none;
                min-width: auto;
                display: inline;
                align-items: normal;
                justify-content: normal;
                gap: 0;
            }
            
            /* ✅ THÊM: CSS đơn giản cho phần số tiền */
            .price-info * {
                border: none !important;
                outline: none !important;
                background: none !important;
                box-shadow: none !important;
            }
            
            .price-info strong {
                color: #2f855a;
                font-size: 0.9rem;
                font-weight: 600;
            }
            
            .pagination {
                justify-content: center;
                margin-top: 2rem;
            }
            
            .page-link {
                background: white;
                border: 1px solid #e9ecef;
                color: #333;
                border-radius: 12px;
                margin: 0 0.25rem;
                padding: 0.75rem 1rem;
                text-decoration: none;
            }
            
            .page-item.active .page-link {
                background: #333;
                border-color: #333;
                color: white;
            }
            
            .no-orders {
                text-align: center;
                padding: 4rem 2rem;
                color: #6b7280;
            }
            
            .alert {
                border-radius: 8px;
                border: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                font-weight: 500;
            }
            
            .alert-success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border-left: 4px solid #28a745;
            }
            
            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border-left: 4px solid #dc3545;
            }
            
            .alert-info {
                background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
                color: #0c5460;
                border-left: 4px solid #17a2b8;
            }
            
            .alert-warning {
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
                color: #856404;
                border-left: 4px solid #ffc107;
            }
            
            /* Footer */
            footer {
                margin-top: 3rem;
                background: #333;
                border-radius: 16px 16px 0 0;
                padding: 1.5rem 0;
            }
            
            footer p {
                margin: 0;
                color: #fff;
                font-size: 0.9rem;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .admin-header {
                    padding: 1.5rem 0;
                    margin-bottom: 1.5rem;
                }
                
                .admin-header h1 {
                    font-size: 1.8rem;
                }
                
                .stat-card {
                    margin-bottom: 1.5rem;
                    padding: 1.5rem;
                }
                
                .admin-header .row {
                    text-align: center;
                }
                
                .admin-header .text-end {
                    text-align: center !important;
                    margin-top: 1rem;
                }
                
                .stat-icon {
                    width: 60px;
                    height: 60px;
                    font-size: 1.5rem;
                }
                
                .stat-number {
                    font-size: 2rem;
                }
                
                .chart-container, .system-info {
                    padding: 1.5rem;
                }
                
                .welcome-section {
                    padding: 1.5rem;
                }
                
                .filter-row {
                    grid-template-columns: 1fr;
                    gap: 0.75rem;
                }
                
                .filter-row .d-flex {
                    flex-direction: column;
                    width: 100%;
                }
                
                .filter-row .btn {
                    width: 100%;
                    margin: 0.25rem 0;
                }
                
                .btn-filter, .btn-refresh {
                    padding: 0.75rem 0.5rem;
                    font-size: 0.9rem;
                }
                
                .admin-navbar .nav-link {
                    padding: 0.75rem 1rem;
                    font-size: 0.9rem;
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
                            <i class="fas fa-shopping-cart me-3"></i>
                            Quản lý đơn hàng
                        </h1>
                        <p class="mb-0 mt-2">Theo dõi và quản lý tất cả đơn hàng trong hệ thống K - Auto</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <div class="d-flex align-items-center justify-content-end gap-3">
                            <div class="user-info">
                                <div class="user-avatar">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.userName}">
                                            ${fn:substring(sessionScope.userName.toUpperCase(), 0, 1)}
                                        </c:when>
                                        <c:otherwise>A</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="user-details">
                                    <h6 class="mb-0">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.userName}">
                                                ${sessionScope.userName}
                                            </c:when>
                                            <c:otherwise>Admin</c:otherwise>
                                        </c:choose>
                                    </h6>
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
                        <a class="nav-link" href="admin?action=users">
                            <i class="fas fa-user-tie me-2"></i>Quản lý Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin?action=products">
                            <i class="fas fa-car-side me-2"></i>Quản lý Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="admin?action=orders">
                            <i class="fas fa-receipt me-2"></i>Quản lý Orders
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <!-- Main Content -->
        <div class="container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h3>Quản lý đơn hàng K - Auto 📋</h3>
                        <p class="mb-0">Theo dõi, cập nhật và quản lý tất cả đơn hàng trong hệ thống. Bạn có thể xem chi tiết, cập nhật trạng thái và xử lý đơn hàng từ đây.</p>
                    </div>
                    <div class="col-md-4 text-end">
                        <small class="text-muted">
                            <i class="fas fa-clock me-1"></i>
                            Cập nhật real-time
                        </small>
                    </div>
                </div>
            </div>
            
            <!-- Statistics Summary -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">${totalOrders}</h3>
                            <p class="stat-label">Tổng đơn hàng</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">${pendingOrders}</h3>
                            <p class="stat-label">Chờ xác nhận</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">${shippedOrders}</h3>
                            <p class="stat-label">Đang giao</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">${deliveredOrders}</h3>
                            <p class="stat-label">Đã giao</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filters Section -->
            <div class="filters-section">
                <h5><i class="fas fa-filter me-2"></i>Bộ lọc</h5>
                <form method="GET" action="admin">
                    <input type="hidden" name="action" value="orders">
                    <div class="filter-row">
                        <div>
                            <label for="status" class="form-label">Trạng thái</label>
                            <select class="form-select" id="status" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="unconfirmed" ${param.status eq 'unconfirmed' ? 'selected' : ''}>Chờ xác nhận</option>
                                <option value="confirmed" ${param.status eq 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                <option value="in delivery" ${param.status eq 'in delivery' ? 'selected' : ''}>Đang giao</option>
                                <option value="delivered" ${param.status eq 'delivered' ? 'selected' : ''}>Đã giao</option>
                                <option value="cancelled" ${param.status eq 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                        <div>
                            <label for="dateFrom" class="form-label">Từ ngày</label>
                            <input type="date" class="form-control" id="dateFrom" name="dateFrom" value="${param.dateFrom}">
                        </div>
                        <div>
                            <label for="dateTo" class="form-label">Đến ngày</label>
                            <input type="date" class="form-control" id="dateTo" name="dateTo" value="${param.dateTo}">
                        </div>
                        <div>
                            <label for="search" class="form-label">Tìm kiếm</label>
                            <input type="text" class="form-control" id="search" name="search" placeholder="Tên khách hàng, email..." value="${param.search}">
                        </div>
                        <div class="d-flex align-items-end">
                            <button type="submit" class="btn btn-filter me-2">
                                <i class="fas fa-search me-2"></i>Lọc
                            </button>
                            <a href="admin?action=orders" class="btn btn-refresh">
                                <i class="fas fa-undo me-2"></i>Làm mới
                            </a>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Orders Table -->
            <div class="orders-table">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh sách đơn hàng</h5>
                </div>
                
                <c:choose>
                    <c:when test="${not empty orders and fn:length(orders) > 0}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Khách hàng</th>
                                        <th>Trạng thái</th>
                                        <th>Tổng tiền</th>
                                        <th>Ngày đặt</th>
                                        <th>Ghi chú</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}" varStatus="status">
                                        <tr>
                                            <td>
                                                <strong>#${order.id}</strong>
                                            </td>
                                            <td>
                                                <c:if test="${not empty order.user}">
                                                    <div>
                                                        <strong>${order.user.fullName}</strong>
                                                        <br>
                                                        <small class="text-muted">${order.user.email}</small>
                                                        <br>
                                                        <small class="text-muted">${order.user.phone}</small>
                                                    </div>
                                                </c:if>
                                                <c:if test="${empty order.user}">
                                                    <span class="text-muted">Không có thông tin</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <!-- ✅ SỬA: Sử dụng database status cho CSS class -->
                                                    <span class="status-badge status-${order.status}">
                                                        ${order.statusDisplay}
                                                    </span>
                                                    <!-- ✅ SỬA: Thêm class trạng thái cho dropdown button -->
                                                    <div class="dropdown">
                                                        <button class="btn-status-update status-${order.status} dropdown-toggle" 
                                                                type="button" 
                                                                title="Cập nhật trạng thái"
                                                                data-status="${order.status}"
                                                                data-status-text="${order.statusDisplay}">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><h6 class="dropdown-header">Cập nhật trạng thái</h6></li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" 
                                                                   data-order-id="${order.id}" 
                                                                   data-status="unconfirmed">
                                                                    <i class="fas fa-clock text-warning"></i> Chờ xác nhận
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" 
                                                                   data-order-id="${order.id}" 
                                                                   data-status="confirmed">
                                                                    <i class="fas fa-check text-success"></i> Đã xác nhận
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" 
                                                                   data-order-id="${order.id}" 
                                                                   data-status="in delivery">
                                                                    <i class="fas fa-truck text-primary"></i> Đang giao
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" 
                                                                   data-order-id="${order.id}" 
                                                                   data-status="delivered">
                                                                    <i class="fas fa-check-circle text-success"></i> Đã giao
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item" href="#" 
                                                                   data-order-id="${order.id}" 
                                                                   data-status="cancelled">
                                                                    <i class="fas fa-times text-danger"></i> Đã hủy
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="price-info">
                                                    <strong><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></strong>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="date-info">
                                                    <i class="fas fa-calendar-alt"></i>
                                                    ${order.formattedOrderDate}
                                                </div>
                                            </td>
                                            <td>
                                                <c:if test="${not empty order.note}">
                                                    <span class="text-muted" title="${order.note}">
                                                        <c:choose>
                                                            <c:when test="${fn:length(order.note) > 30}">
                                                                ${fn:substring(order.note, 0, 30)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${order.note}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty order.note}">
                                                    <span class="text-muted">-</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1">
                                                    <a href="admin?action=viewOrder&id=${order.id}" 
                                                       class="action-btn btn-info" 
                                                       title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <button type="button" 
                                                            class="action-btn delete" 
                                                            onclick="deleteOrder(${order.id})" 
                                                            title="Xóa đơn hàng">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Orders pagination">
                                <ul class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="admin?action=orders&page=${currentPage - 1}&status=${fn:escapeXml(param.status)}&dateFrom=${fn:escapeXml(param.dateFrom)}&dateTo=${fn:escapeXml(param.dateTo)}&search=${fn:escapeXml(param.search)}">
                                                <i class="fas fa-chevron-left"></i> Trước
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                        <li class="page-item ${pageNum eq currentPage ? 'active' : ''}">
                                            <a class="page-link" href="admin?action=orders&page=${pageNum}&status=${fn:escapeXml(param.status)}&dateFrom=${fn:escapeXml(param.dateFrom)}&dateTo=${fn:escapeXml(param.dateTo)}&search=${fn:escapeXml(param.search)}">
                                                ${pageNum}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="admin?action=orders&page=${currentPage + 1}&status=${fn:escapeXml(param.status)}&dateFrom=${fn:escapeXml(param.dateFrom)}&dateTo=${fn:escapeXml(param.dateTo)}&search=${fn:escapeXml(param.search)}">
                                                Sau <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="no-orders">
                            <i class="fas fa-shopping-cart"></i>
                            <h4>Không có đơn hàng nào</h4>
                            <p>Hiện tại chưa có đơn hàng nào trong hệ thống.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Footer -->
        <footer class="text-white text-center py-4 mt-5">
            <div class="container">
                <p class="mb-0">&copy; 2024 AutoShowVN Admin Dashboard. All rights reserved.</p>
            </div>
        </footer>
        
        <!-- ✅ SỬA: Thêm Popper.js trước Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <script>
            // ✅ SỬA: JavaScript đơn giản cho dropdown
            document.addEventListener('DOMContentLoaded', function() {
                console.log('DOM loaded, setting up dropdown...');
                
                // Tìm tất cả dropdown toggle buttons
                const dropdownToggles = document.querySelectorAll('.btn-status-update');
                console.log('Found dropdown toggles:', dropdownToggles.length);
                
                dropdownToggles.forEach(function(toggle, index) {
                    console.log(`Setting up dropdown ${index + 1}:`, toggle);
                    
                    toggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        console.log('Dropdown toggle clicked:', this);
                        
                        // Tìm dropdown menu tương ứng
                        const dropdownMenu = this.parentElement.querySelector('.dropdown-menu');
                        console.log('Found dropdown menu:', dropdownMenu);
                        
                        if (dropdownMenu) {
                            // Toggle dropdown
                            const isOpen = dropdownMenu.classList.contains('show');
                            console.log('Dropdown is open:', isOpen);
                            
                            // Đóng tất cả dropdown khác
                            document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
                                if (menu !== dropdownMenu) {
                                    menu.classList.remove('show');
                                    // Xóa class active cho button tương ứng
                                    const otherToggle = menu.parentElement.querySelector('.btn-status-update');
                                    if (otherToggle) {
                                        otherToggle.classList.remove('active');
                                        otherToggle.setAttribute('aria-expanded', 'false');
                                    }
                                    console.log('Closed other dropdown');
                                }
                            });
                            
                            // ✅ THÊM: Kiểm tra vị trí để quyết định hiển thị dropdown
                            const rect = toggle.getBoundingClientRect();
                            const windowHeight = window.innerHeight;
                            const dropdownHeight = 200; // Ước tính chiều cao dropdown
                            
                            // Nếu dropdown sẽ bị che ở dưới, chuyển thành dropup
                            if (rect.bottom + dropdownHeight > windowHeight) {
                                dropdownMenu.classList.add('dropup');
                                console.log('Dropdown converted to dropup');
                            } else {
                                dropdownMenu.classList.remove('dropup');
                                console.log('Dropdown remains normal');
                            }
                            
                            // ✅ THÊM: Xử lý vị trí dropdown để tránh bị che
                            const tableRow = toggle.closest('tr');
                            const isLastRow = tableRow === tableRow.parentElement.lastElementChild;
                            const isSecondLastRow = tableRow === tableRow.parentElement.children[tableRow.parentElement.children.length - 2];
                            
                            if (isLastRow || isSecondLastRow) {
                                dropdownMenu.classList.add('dropup');
                                console.log('Last rows detected, using dropup');
                            }
                            
                            // Toggle dropdown hiện tại
                            if (isOpen) {
                                dropdownMenu.classList.remove('show');
                                toggle.classList.remove('active');
                                toggle.setAttribute('aria-expanded', 'false');
                                console.log('Dropdown closed');
                            } else {
                                dropdownMenu.classList.add('show');
                                toggle.classList.add('active');
                                toggle.setAttribute('aria-expanded', 'true');
                                console.log('Dropdown opened');
                            }
                        } else {
                            console.error('Dropdown menu not found!');
                        }
                    });
                });
                
                // Add click event to dropdown items
                const dropdownItems = document.querySelectorAll('.dropdown-item[data-order-id]');
                console.log('Found dropdown items:', dropdownItems.length);
                
                dropdownItems.forEach(function(item) {
                    item.addEventListener('click', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        
                        const orderId = this.getAttribute('data-order-id');
                        const newStatus = this.getAttribute('data-status');
                        
                        console.log('Dropdown item clicked:', {orderId, newStatus});
                        updateOrderStatus(orderId, newStatus);
                        
                        // Đóng dropdown sau khi click
                        const dropdownMenu = this.closest('.dropdown');
                        if (dropdownMenu) {
                            dropdownMenu.classList.remove('show');
                        }
                    });
                });
                
                // ✅ THÊM: Debug để xem trạng thái của mỗi button
                console.log('=== DEBUG: Checking status buttons ===');
                const statusButtons = document.querySelectorAll('.btn-status-update');
                statusButtons.forEach(function(button, index) {
                    const classes = button.className;
                    const statusClass = classes.match(/status-[^\s]+/);
                    console.log(`Button ${index + 1}:`, {
                        element: button,
                        classes: classes,
                        statusClass: statusClass ? statusClass[0] : 'No status class found'
                    });
                });
                
                // ✅ THÊM: Tự động thêm class CSS dựa trên trạng thái hiển thị
                console.log('=== AUTO-ADDING CSS CLASSES ===');
                statusButtons.forEach(function(button, index) {
                    // Tìm trạng thái hiển thị gần nhất
                    const statusBadge = button.closest('td').querySelector('.status-badge');
                    if (statusBadge) {
                        const statusText = statusBadge.textContent.trim();
                        console.log(`Button ${index + 1} status text:`, statusText);
                        
                        // Thêm class CSS dựa trên text
                        if (statusText.includes('Đang giao') || statusText.includes('In Delivery')) {
                            button.classList.add('status-in-delivery');
                            console.log(`Added delivery classes to button ${index + 1}`);
                        } else if (statusText.includes('Chờ xác nhận') || statusText.includes('Pending')) {
                            button.classList.add('status-pending', 'status-unconfirmed');
                            console.log(`Added pending classes to button ${index + 1}`);
                        } else if (statusText.includes('Đã xác nhận') || statusText.includes('Confirmed')) {
                            button.classList.add('status-confirmed');
                            console.log(`Added confirmed classes to button ${index + 1}`);
                        } else if (statusText.includes('Đã giao') || statusText.includes('Delivered')) {
                            button.classList.add('status-delivered');
                            console.log(`Added delivered classes to button ${index + 1}`);
                        } else if (statusText.includes('Đã hủy') || statusText.includes('Cancelled')) {
                            button.classList.add('status-cancelled');
                            console.log(`Added cancelled classes to button ${index + 1}`);
                        }
                    }
                });
                
                // ✅ THÊM: Debug data attributes
                console.log('=== DEBUG DATA ATTRIBUTES ===');
                statusButtons.forEach(function(button, index) {
                    const dataStatus = button.getAttribute('data-status');
                    const dataStatusText = button.getAttribute('data-status-text');
                    console.log(`Button ${index + 1} data:`, {
                        dataStatus: dataStatus,
                        dataStatusText: dataStatusText,
                        classes: button.className
                    });
                    
                    // Thêm style inline nếu cần
                    if (dataStatus && (dataStatus.includes('delivery') || dataStatus.includes('shipped'))) {
                        button.style.background = 'linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%)';
                        button.style.borderColor = '#007bff';
                        button.style.color = '#004085';
                        console.log(`Applied inline styles to button ${index + 1}`);
                    }
                    
                    // ✅ THÊM: Xử lý đặc biệt cho "in delivery" với dấu cách
                    if (dataStatus === 'in delivery') {
                        button.style.background = 'linear-gradient(135deg, #cce5ff 0%, #b3d7ff 100%)';
                        button.style.borderColor = '#007bff';
                        button.style.color = '#004085';
                        button.style.boxShadow = '0 2px 4px rgba(0,123,255,0.2)';
                        console.log(`Applied special inline styles for "in delivery" to button ${index + 1}`);
                    }
                });
                
                // Đóng dropdown khi click bên ngoài
                document.addEventListener('click', function(e) {
                    if (!e.target.closest('.dropdown')) {
                        document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
                            menu.classList.remove('show');
                            // Xóa class active cho button tương ứng
                            const toggle = menu.parentElement.querySelector('.btn-status-update');
                            if (toggle) {
                                toggle.classList.remove('active');
                                toggle.setAttribute('aria-expanded', 'false');
                            }
                        });
                    }
                });
            });
            
            // Update order status function
            // ✅ SỬA: Bỏ mapping trung gian, gửi trực tiếp database status
            function updateOrderStatus(orderId, newStatus) {
                console.log('updateOrderStatus called with:', {orderId, newStatus});
                
                // Validate parameters
                if (!orderId || !newStatus) {
                    console.error('Invalid parameters:', {orderId, newStatus});
                    showNotification('Tham số không hợp lệ', 'error');
                    return;
                }
                
                // ✅ BỎ MAPPING: Gửi trực tiếp status từ dropdown
                const statusLabel = newStatus; // Use the status directly
                
                if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái đơn hàng #' + orderId + ' thành "' + statusLabel + '"?')) {
                    console.log('User confirmed, sending request...');
                    
                    // Find the button to disable - use a more reliable selector
                    const dropdownItem = document.querySelector(`.dropdown-item[data-order-id="${orderId}"]`);
                    console.log('Found dropdown item:', dropdownItem);
                    
                    let button = null;
                    
                    if (dropdownItem) {
                        const dropdownContainer = dropdownItem.closest('.dropdown');
                        console.log('Found dropdown container:', dropdownContainer);
                        
                        if (dropdownContainer) {
                            button = dropdownContainer.querySelector('.btn-status-update');
                            console.log('Found button:', button);
                        }
                    }
                    
                    if (button) {
                        button.disabled = true;
                        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                        console.log('Button disabled and spinner added');
                    } else {
                        console.log('Button not found, continuing without disabling');
                    }
                    
                    // ✅ SỬA: Gửi trực tiếp status, không cần mapping
                    fetch('admin?action=updateOrderStatus', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'id=' + orderId + '&status=' + newStatus  // Gửi trực tiếp newStatus
                    })
                    .then(response => {
                        console.log('Response received:', response);
                        console.log('Response status:', response.status);
                        
                        // Kiểm tra response type
                        const contentType = response.headers.get('content-type');
                        console.log('Content-Type:', contentType);
                        
                        if (!response.ok) {
                            throw new Error('HTTP error! status: ' + response.status);
                        }
                        
                        // Kiểm tra response có phải JSON không
                        if (contentType && contentType.includes('application/json')) {
                            return response.json();
                        } else {
                            // Xử lý response không phải JSON
                            return response.text().then(text => {
                                console.log('Non-JSON response:', text);
                                throw new Error('Server returned non-JSON response: ' + text);
                            });
                        }
                    })
                    .then(data => {
                        console.log('Data received:', data);
                        console.log('Response type:', typeof data);
                        console.log('Response content:', JSON.stringify(data));
                        
                        if (data && data.success) {
                            // Show success message
                            showNotification('Cập nhật trạng thái đơn hàng thành công!', 'success');
                            console.log('Success! Reloading page in 1 second...');
                            
                            // Force reload ngay lập tức
                            setTimeout(() => {
                                console.log(' Reloading page now...');
                                window.location.reload(true); // Force reload từ server
                            }, 1000);
                        } else {
                            const errorMsg = data && data.message ? data.message : 'Không có thông báo lỗi từ server';
                            console.error('Server returned error:', errorMsg);
                            showNotification('Có lỗi xảy ra: ' + errorMsg, 'error');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showNotification('Có lỗi xảy ra khi cập nhật trạng thái đơn hàng: ' + error.message, 'error');
                    })
                    .finally(() => {
                        // Re-enable the button
                        if (button) {
                            button.disabled = false;
                            button.innerHTML = '<i class="fas fa-edit"></i>';
                        }
                    });
                }
            }
            
            // Notification function
            function showNotification(message, type) {
                console.log('Showing notification:', {message, type});
                
                // Determine alert class based on type
                let alertClass = 'alert-info'; // default
                switch(type) {
                    case 'success':
                        alertClass = 'alert-success';
                        break;
                    case 'error':
                    case 'danger':
                        alertClass = 'alert-danger';
                        break;
                    case 'warning':
                        alertClass = 'alert-warning';
                        break;
                    case 'info':
                        alertClass = 'alert-info';
                        break;
                }
                
                // Create notification element
                const notification = document.createElement('div');
                notification.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed';
                notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                notification.innerHTML = message + 
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                
                // Add to page
                document.body.appendChild(notification);
                
                // Auto remove after 5 seconds
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 5000);
            }

            // Delete order function
            function deleteOrder(orderId) {
                if (confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')) {
                    fetch('admin?action=deleteOrder&id=' + orderId, {
                        method: 'POST'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Xóa đơn hàng thành công!');
                            location.reload();
                        } else {
                            alert('Có lỗi xảy ra: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi xóa đơn hàng');
                    });
                }
            }
        </script>
    </body>
</html>
