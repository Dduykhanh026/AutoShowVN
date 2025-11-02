<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ sơ cá nhân - K - Auto</title>
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
                padding-top: 80px;
                min-height: 100vh;
            }
            
            .navbar {
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.5),
                    -4px -4px 8px rgba(255, 255, 255, 0.9),
                    4px -4px 8px rgba(160, 160, 160, 0.3),
                    -4px 4px 8px rgba(255, 255, 255, 0.7);
                background: rgba(255, 255, 255, 0.9) !important;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .navbar-brand {
                color: #2d3748 !important;
                font-weight: 600;
            }
            
            .profile-container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 2rem;
            }
            
            .profile-header {
                background: rgba(255, 255, 255, 0.9);
                color: #2d3748;
                padding: 3rem 2rem;
                border-radius: 30px;
                margin-bottom: 2rem;
                text-align: center;
                box-shadow: 
                    8px 8px 20px rgba(180, 180, 180, 0.4),
                    -8px -8px 20px rgba(255, 255, 255, 0.9),
                    8px -8px 20px rgba(180, 180, 180, 0.3),
                    -8px 8px 20px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .profile-avatar {
                width: 120px;
                height: 120px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                font-size: 3rem;
                color: #4a5568;
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.5),
                    -4px -4px 8px rgba(255, 255, 255, 0.9),
                    4px -4px 8px rgba(160, 160, 160, 0.3),
                    -4px 4px 8px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
                transition: all 0.2s ease;
            }
            
            .profile-avatar:hover {
                transform: translateY(-2px);
                box-shadow: 
                    6px 6px 12px rgba(160, 160, 160, 0.6),
                    -6px -6px 12px rgba(255, 255, 255, 1),
                    6px -6px 12px rgba(160, 160, 160, 0.4),
                    -6px 6px 12px rgba(255, 255, 255, 0.8);
            }
            
            .profile-name {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: #2d3748;
            }
            
            .profile-email {
                font-size: 1.1rem;
                color: #718096;
                margin-bottom: 0.5rem;
                font-weight: 500;
            }
            

            
            .profile-section {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 30px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 
                    8px 8px 20px rgba(180, 180, 180, 0.4),
                    -8px -8px 20px rgba(255, 255, 255, 0.9),
                    8px -8px 20px rgba(180, 180, 180, 0.3),
                    -8px 8px 20px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .section-title {
                color: #2d3748;
                font-weight: 600;
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            
            .section-title i {
                color: #4a5568;
                font-size: 1.3rem;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-label {
                font-weight: 500;
                color: #4a5568;
                margin-bottom: 0.5rem;
                font-size: 1rem;
            }
            
            .form-control {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 20px;
                padding: 20px 20px 20px 20px;
                font-size: 16px;
                color: #2d3748;
                outline: none;
                box-shadow: 
                    3px 3px 6px rgba(160, 160, 160, 0.5),
                    -3px -3px 6px rgba(255, 255, 255, 0.9),
                    3px -3px 6px rgba(160, 160, 160, 0.3),
                    -3px 3px 6px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-0.5px);
                transition: all 0.2s ease;
            }
            
            .form-control:focus {
                transform: translateY(0px);
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.5),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9),
                    inset 2px -2px 4px rgba(160, 160, 160, 0.3),
                    inset -2px 2px 4px rgba(255, 255, 255, 0.7);
            }
            
            .form-control::placeholder {
                color: #a0aec0;
            }
            
            .btn-primary {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 20px;
                padding: 18px 2rem;
                font-size: 18px;
                font-weight: 600;
                color: #2d3748;
                cursor: pointer;
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.5),
                    -4px -4px 8px rgba(255, 255, 255, 0.9),
                    4px -4px 8px rgba(160, 160, 160, 0.3),
                    -4px 4px 8px rgba(255, 255, 255, 0.7);
                transition: all 0.2s ease;
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
            }
            
            .btn-primary:hover {
                transform: translateY(0px);
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.5),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9),
                    inset 2px -2px 4px rgba(160, 160, 160, 0.3),
                    inset -2px 2px 4px rgba(255, 255, 255, 0.7);
            }
            
            .btn-primary:active {
                transform: translateY(1px);
            }
            
            .btn-danger {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 20px;
                padding: 18px 2rem;
                font-size: 18px;
                font-weight: 600;
                color: #2d3748;
                cursor: pointer;
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.5),
                    -4px -4px 8px rgba(255, 255, 255, 0.9),
                    4px -4px 8px rgba(160, 160, 160, 0.3),
                    -4px 4px 8px rgba(255, 255, 255, 0.7);
                transition: all 0.2s ease;
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
            }
            
            .btn-danger:hover {
                transform: translateY(0px);
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.5),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9),
                    inset 2px -2px 4px rgba(160, 160, 160, 0.3),
                    inset -2px 2px 4px rgba(255, 255, 255, 0.7);
            }
            
            .btn-danger:active {
                transform: translateY(1px);
            }
            
            .alert {
                border-radius: 20px;
                border: none;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 
                    3px 3px 6px rgba(160, 160, 160, 0.5),
                    -3px -3px 6px rgba(255, 255, 255, 0.9),
                    3px -3px 6px rgba(160, 160, 160, 0.3),
                    -3px 3px 6px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
                min-width: 300px;
                max-width: 400px;
                margin-bottom: 0;
                animation: slideInRight 0.5s ease-out;
            }
            
            .alert-success {
                background: rgba(144, 238, 144, 0.9);
                color: #2d3748;
                border: 2px solid rgba(144, 238, 144, 0.4);
            }
            
            .alert-danger {
                background: rgba(255, 182, 193, 0.9);
                color: #2d3748;
                border: 2px solid rgba(255, 182, 193, 0.4);
            }
            
            @keyframes slideInRight {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 0.75rem;
                margin-bottom: 2rem;
            }
            
            .stat-card {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 12px;
                padding: 0.75rem;
                text-align: center;
                box-shadow: 
                    3px 3px 6px rgba(160, 160, 160, 0.5),
                    -3px -3px 6px rgba(255, 255, 255, 0.9),
                    3px -3px 6px rgba(160, 160, 160, 0.3),
                    -3px 3px 6px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .stat-icon {
                width: 35px;
                height: 35px;
                background: none;
                border-radius: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 0.5rem;
                color: #4a5568;
                font-size: 1rem;
                box-shadow: none;
                backdrop-filter: none;
                -webkit-backdrop-filter: none;
                border: none;
            }
            
            .stat-value {
                font-size: 1.2rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 0.3rem;
            }
            
            .stat-label {
                color: #718096;
                font-size: 0.75rem;
                font-weight: 500;
            }
            
            @media (max-width: 768px) {
                .profile-container {
                    padding: 1rem;
                }
                
                .profile-header {
                    padding: 2rem 1rem;
                }
                
                .profile-name {
                    font-size: 2rem;
                }
                
                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <a class="navbar-brand" href="home">
                        <img src="${pageContext.request.contextPath}/assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                    
                    <div class="d-flex align-items-center">

                        
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="profile-container">

                
                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <h1 class="profile-name">${user.fullName}</h1>
                    <p class="profile-email">${user.email}</p>
                    
                </div>
                
                <!-- Success/Error Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer; color: #6c757d;"></button>
                    </div>
                    <c:remove var="successMessage" scope="request" />
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer; color: #6c757d;"></button>
                    </div>
                    <c:remove var="error" scope="request" />
                </c:if>
                
                <!-- Statistics Grid -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="stat-value">${sessionScope.favoriteCount != null ? sessionScope.favoriteCount : 0}</div>
                        <div class="stat-label">Sản phẩm yêu thích</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="stat-value">
                            <a href="order?action=list" style="color: inherit; text-decoration: none;">
                                Xem đơn hàng
                            </a>
                        </div>
                        <div class="stat-label">Quản lý đơn hàng</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-eye"></i>
                        </div>
                        <div class="stat-value">${user.id}</div>
                        <div class="stat-label">ID người dùng</div>
                    </div>
                    
                    
                </div>
                
                <!-- Profile Information Section -->
                <div class="profile-section">
                    <h2 class="section-title">
                        <i class="fas fa-user-edit"></i>
                        Thông tin cá nhân
                    </h2>
                    
                    <form action="profile" method="POST">
                        <input type="hidden" name="action" value="update">
                        
                                                 <div class="row">
                             <div class="col-md-4">
                                 <div class="form-group">
                                     <label for="fullName" class="form-label">
                                         <i class="fas fa-user me-2"></i>Họ và tên
                                     </label>
                                     <input type="text" class="form-control" id="fullName" name="fullName" 
                                            value="${user.fullName}" required>
                                 </div>
                             </div>
                             
                             <div class="col-md-4">
                                 <div class="form-group">
                                     <label for="email" class="form-label">
                                         <i class="fas fa-envelope me-2"></i>Email
                                     </label>
                                     <input type="email" class="form-control" id="email" name="email" 
                                            value="${user.email}" required>
                                 </div>
                             </div>
                             
                             <div class="col-md-4">
                                 <div class="form-group">
                                     <label for="phone" class="form-label">
                                         <i class="fas fa-phone me-2"></i>Số điện thoại
                                     </label>
                                     <input type="tel" class="form-control" id="phone" name="phone" 
                                            value="${user.phone}" required>
                                 </div>
                             </div>
                         </div>
                        
                                                                         <div class="d-flex gap-3 justify-content-end">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                <i class="fas fa-save me-2"></i>Cập nhật thông tin
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Change Password Section -->
                <div class="profile-section">
                    <h2 class="section-title">
                        <i class="fas fa-lock"></i>
                        Đổi mật khẩu
                    </h2>
                    
                    <form action="profile" method="POST">
                        <input type="hidden" name="action" value="changePassword">
                        
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="currentPassword" class="form-label">
                                        <i class="fas fa-key me-2"></i>Mật khẩu hiện tại
                                    </label>
                                    <input type="password" class="form-control" id="currentPassword" 
                                           name="currentPassword" required>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="newPassword" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Mật khẩu mới
                                    </label>
                                    <input type="password" class="form-control" id="newPassword" 
                                           name="newPassword" required>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="confirmPassword" class="form-label">
                                        <i class="fas fa-check-circle me-2"></i>Xác nhận mật khẩu
                                    </label>
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           name="confirmPassword" required>
                                </div>
                            </div>
                        </div>
                        
                                                                         <div class="d-flex gap-3 justify-content-end">
                            <button type="submit" class="btn btn-danger" style="width: 100%;">
                                <i class="fas fa-key me-2"></i>Đổi mật khẩu
                            </button>
                        </div>
                    </form>
                </div>
                
                
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Auto-hide alerts after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    setTimeout(() => {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000);
                });
                
                // Password confirmation validation
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');
                
                function validatePassword() {
                    if (newPassword.value !== confirmPassword.value) {
                        confirmPassword.setCustomValidity('Mật khẩu không khớp');
                    } else {
                        confirmPassword.setCustomValidity('');
                    }
                }
                
                newPassword.addEventListener('change', validatePassword);
                confirmPassword.addEventListener('keyup', validatePassword);
                
                // Prevent auto-scroll to top after successful form submission
                const forms = document.querySelectorAll('form');
                forms.forEach(form => {
                    form.addEventListener('submit', function(e) {
                        // Store current scroll position
                        localStorage.setItem('scrollPosition', window.scrollY);
                    });
                });
                
                // Restore scroll position after page reload
                const savedScrollPosition = localStorage.getItem('scrollPosition');
                if (savedScrollPosition) {
                    // Use setTimeout to ensure DOM is fully loaded
                    setTimeout(() => {
                        window.scrollTo(0, parseInt(savedScrollPosition));
                        localStorage.removeItem('scrollPosition');
                    }, 100);
                }
            });
        </script>
    </body>
</html>
