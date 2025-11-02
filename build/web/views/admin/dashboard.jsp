<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - K - Auto</title>
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
                word-wrap: break-word;
                overflow-wrap: break-word;
                hyphens: auto;
                max-width: 100%;
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
            
            /* CSS đặc biệt cho phần tổng doanh thu */
            .stat-card:nth-child(4) .stat-number,
            .revenue-number {
                font-size: 1rem;
                line-height: 1.1;
                word-break: break-all;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                max-width: 100%;
                min-height: 2.4rem;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                font-weight: 700;
            }
            
            /* CSS cho tooltip khi hover */
            .revenue-number:hover {
                overflow: visible;
                white-space: normal;
                word-break: break-word;
                z-index: 10;
                position: relative;
            }
            
            /* CSS để đảm bảo số tiền không bị tràn */
            .stat-card:nth-child(4) .stat-content {
                min-width: 0;
                flex: 1;
                overflow: hidden;
            }
            
            .stat-card:nth-child(4) .stat-number {
                max-width: 100%;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            
            /* CSS để bỏ hiệu ứng hover và click cho phần tổng doanh thu */
            .revenue-card {
                cursor: default;
                pointer-events: none;
            }
            
            .revenue-card:hover {
                transform: none !important;
                box-shadow: 0 8px 32px rgba(0,0,0,0.08) !important;
                border-color: rgba(255,255,255,0.8) !important;
            }
            
            .revenue-card:hover::before {
                opacity: 0 !important;
            }
            
            .revenue-card:hover .stat-icon::before {
                transform: rotate(45deg) !important;
            }
            
            .revenue-card:active {
                transform: none !important;
            }
            
            /* Responsive cho số tiền lớn */
            @media (max-width: 1200px) {
                .stat-card:nth-child(4) .stat-number,
                .revenue-number {
                    font-size: 0.9rem;
                }
            }
            
            @media (max-width: 992px) {
                .stat-card:nth-child(4) .stat-number,
                .revenue-number {
                    font-size: 0.85rem;
                }
            }
            
            @media (max-width: 768px) {
                .stat-card:nth-child(4) .stat-number,
                .revenue-number {
                    font-size: 0.8rem;
                    min-height: 2rem;
                }
            }
            
            .stat-label {
                margin: 0.4rem 0 0 0;
                color: #6b7280;
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: none;
                letter-spacing: 0.025em;
            }
            
                         /* System Info */
             .system-info {
                 background: white;
                 border-radius: 16px;
                 padding: 2rem;
                 box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                 border: 1px solid #f0f0f0;
                 margin-bottom: 2rem;
             }
             
             .system-info h5 {
                 color: #333;
                 font-weight: 400;
                 font-size: 1.4rem;
                 margin-bottom: 1.5rem;
                 display: flex;
                 align-items: center;
                 gap: 0.8rem;
             }
             
             .system-info h5 i {
                 color: #666;
                 font-size: 1.2rem;
                 width: 24px;
                 text-align: center;
             }
            
            /* System Info */
            .info-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.8rem 0;
                border-bottom: 1px solid #f0f0f0;
                font-size: 1rem;
            }
            
            .info-item:last-child {
                border-bottom: none;
            }
            
            .info-label {
                color: #666;
                font-weight: 400;
            }
            
            .info-value {
                color: #333;
                font-weight: 400;
            }
            
            .status-badge {
                padding: 0.3rem 0.8rem;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }
            
            .status-badge.online {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
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
                 
                 .system-info {
                     padding: 1.5rem;
                 }
                 
                 .welcome-section {
                     padding: 1.5rem;
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
                            <i class="fas fa-crown me-3"></i>
                            Admin Dashboard
                        </h1>
                        <p class="mb-0 mt-2">Quản lý hệ thống K - Auto - Bảng điều khiển quản trị viên</p>
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
                        <a class="nav-link active" href="admin?action=dashboard">
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
                        <a class="nav-link" href="admin?action=orders">
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
                        <h3>Chào mừng trở lại, ${sessionScope.userName != null ? sessionScope.userName : 'Admin'}! 👋</h3>
                        <p class="mb-0">Đây là bảng điều khiển quản trị viên của K - Auto. Bạn có thể quản lý toàn bộ hệ thống từ đây.</p>
                    </div>
                    <div class="col-md-4 text-end">
                        <small class="text-muted">
                            <i class="fas fa-clock me-1"></i>
                            Vừa đăng nhập
                        </small>
                    </div>
                </div>
            </div>
            
            <!-- Statistics Summary -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <a href="admin?action=products" class="text-decoration-none">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-boxes"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number">${totalProducts}</h3>
                                <p class="stat-label">Tổng sản phẩm</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="admin?action=users" class="text-decoration-none">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number">${totalUsers}</h3>
                                <p class="stat-label">Tổng người dùng</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="admin?action=orders" class="text-decoration-none">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number">${totalOrders}</h3>
                                <p class="stat-label">Tổng đơn hàng</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <div class="stat-card revenue-card">
                        <div class="stat-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number revenue-number" title="<fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0" /> VNĐ">
                                <fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0" />
                            </h3>
                            <p class="stat-label">Tổng doanh thu (VNĐ)</p>
                        </div>
                    </div>
                </div>
            </div>
            
                         <!-- System Info -->
             <div class="row">
                 <div class="col-lg-12">
                     <div class="system-info">
                         <h5><i class="fas fa-server me-2"></i>Thông tin hệ thống</h5>
                         <div class="info-item">
                             <span class="info-label">Phiên bản:</span>
                             <span class="info-value">1.0.0</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Database:</span>
                             <span class="info-value">MySQL 8.0</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Server:</span>
                             <span class="info-value">Apache Tomcat 10</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Framework:</span>
                             <span class="info-value">Jakarta EE 10</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Java Version:</span>
                             <span class="info-value">JDK 17</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Trạng thái:</span>
                             <span class="status-badge online">Online</span>
                         </div>
                         <div class="info-item">
                             <span class="info-label">Uptime:</span>
                             <span class="info-value">99.9%</span>
                         </div>
                     </div>
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
            // Auto-refresh dashboard every 30 seconds
            setInterval(function() {
                // You can add AJAX call here to refresh data
                console.log('Dashboard auto-refresh...');
            }, 30000);
            
            // Add click handlers for quick actions
            document.addEventListener('DOMContentLoaded', function() {
                // Handle task checkboxes
                const checkboxes = document.querySelectorAll('.form-check-input');
                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function() {
                        if (this.checked) {
                            this.parentElement.style.textDecoration = 'line-through';
                            this.parentElement.style.opacity = '0.6';
                        } else {
                            this.parentElement.style.textDecoration = 'none';
                            this.parentElement.style.opacity = '1';
                        }
                    });
                });
                
                // Add loading states to buttons
                const buttons = document.querySelectorAll('.btn');
                buttons.forEach(button => {
                    button.addEventListener('click', function() {
                        if (!this.classList.contains('btn-outline-primary') && 
                            !this.classList.contains('btn-outline-success') && 
                            !this.classList.contains('btn-outline-info') && 
                            !this.classList.contains('btn-outline-warning')) {
                            return;
                        }
                        
                        const originalText = this.innerHTML;
                        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                        this.disabled = true;
                        
                        setTimeout(() => {
                            this.innerHTML = originalText;
                            this.disabled = false;
                        }, 2000);
                    });
                });
            });
        </script>
    </body>
</html>
