<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm User mới - Admin Dashboard</title>
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
            
            /* Form Styles */
            .form-label {
                font-weight: 500;
                color: #495057;
                margin-bottom: 0.5rem;
                font-size: 0.95rem;
            }
            
            .form-control {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                box-sizing: border-box;
            }
            
            .form-control:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
                transform: translateY(-1px);
            }
            
            .form-select {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                cursor: pointer;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 7 7 7-7'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 0.75rem center;
                background-size: 16px 12px;
                padding-right: 2.5rem;
            }
            
            .form-select:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
                transform: translateY(-1px);
            }
            
            /* Button Styles */
            .btn-primary {
                background: #333;
                border: none;
                border-radius: 8px;
                padding: 0.75rem 1.5rem;
                font-weight: 500;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                white-space: nowrap;
                text-decoration: none;
                cursor: pointer;
                box-sizing: border-box;
                min-width: 160px;
            }
            
            .btn-primary:hover {
                background: #555;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0,0,0,0.2);
            }
            
            .btn-outline-secondary {
                border: 1px solid #6c757d;
                color: #6c757d;
                background: transparent;
                border-radius: 8px;
                padding: 0.75rem 1.5rem;
                font-weight: 500;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                height: 48px;
                min-height: 48px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                white-space: nowrap;
                text-decoration: none;
                cursor: pointer;
                box-sizing: border-box;
                min-width: 160px;
            }
            
            .btn-outline-secondary:hover {
                background: #6c757d;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
            }
            
            /* Alert Styles */
            .alert {
                border-radius: 8px;
                border: none;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
            }
            
            .alert-success {
                background: #d1e7dd;
                color: #0f5132;
                border-left: 4px solid #198754;
            }
            
            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }
            
            /* Password Section */
            .password-section {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 1.5rem;
                margin: 1.5rem 0;
                border: 1px solid #e9ecef;
            }
            
            .password-section h5 {
                color: #495057;
                font-size: 1.1rem;
                font-weight: 500;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            
            .password-section h5 i {
                color: #6c757d;
                font-size: 1rem;
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
                
                .content-section {
                    padding: 1.5rem;
                }
                
                .form-control,
                .form-select,
                .btn-primary,
                .btn-outline-secondary {
                    height: 44px;
                    min-height: 44px;
                    font-size: 0.9rem;
                }
            }
            
            @media (max-width: 576px) {
                .content-section {
                    padding: 1rem;
                }
                
                .btn-primary,
                .btn-outline-secondary {
                    width: 100%;
                    margin-bottom: 0.5rem;
                }
            }
            
            /* Alert Styles for bottom-right positioning */
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
            
            .btn-close {
                opacity: 0.7;
            }
            
            .btn-close:hover {
                opacity: 1;
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
                            <i class="fas fa-user-plus me-3"></i>
                            Thêm User mới
                        </h1>
                        <p class="mb-0 mt-2">Tạo người dùng mới cho hệ thống K - Auto</p>
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
            <div class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>
                        <i class="fas fa-user-plus me-2"></i>Thêm User mới
                    </h3>
                    <a href="admin?action=users" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
                
                <!-- Alert Messages (Hidden - will show via JavaScript at bottom-right) -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show d-none" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show d-none" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Add User Form -->
                <form action="admin" method="POST" id="addUserForm">
                    <input type="hidden" name="action" value="addUser">
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label">
                                <i class="fas fa-user me-2"></i>Họ và tên <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="fullName" name="fullName" 
                                   placeholder="Nhập họ và tên đầy đủ..." required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-2"></i>Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="Nhập email hợp lệ..." required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone me-2"></i>Số điện thoại
                            </label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   placeholder="Nhập số điện thoại...">
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="role" class="form-label">
                                <i class="fas fa-user-tag me-2"></i>Vai trò <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="">Chọn vai trò...</option>
                                <option value="customer">Customer</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Password Section -->
                    <div class="password-section">
                        <h5>
                            <i class="fas fa-key"></i>
                            Mật khẩu
                        </h5>
                        <div class="row">
                            <div class="col-md-6">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Mật khẩu <span class="text-danger">*</span>
                                </label>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Nhập mật khẩu..." required>
                                <small class="form-text text-muted">Mật khẩu phải có ít nhất 6 ký tự</small>
                            </div>
                            <div class="col-md-6">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu <span class="text-danger">*</span>
                                </label>
                                <input type="password" class="form-control" id="confirmPassword" 
                                       placeholder="Nhập lại mật khẩu..." required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end mt-4">
                        <a href="admin?action=users" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-2"></i>Hủy
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Thêm User
                        </button>
                    </div>
                </form>
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
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('addUserForm');
                const password = document.getElementById('password');
                const confirmPassword = document.getElementById('confirmPassword');
                const email = document.getElementById('email');
                
                // Form validation and AJAX submit
                form.addEventListener('submit', function(e) {
                    e.preventDefault(); // Ngăn form submit mặc định
                    
                    // Kiểm tra mật khẩu
                    if (password.value !== confirmPassword.value) {
                        showAlert('error', 'Mật khẩu xác nhận không khớp!');
                        confirmPassword.focus();
                        return false;
                    }
                    
                    if (password.value.length < 6) {
                        showAlert('error', 'Mật khẩu phải có ít nhất 6 ký tự!');
                        password.focus();
                        return false;
                    }
                    
                    // Kiểm tra email
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(email.value)) {
                        showAlert('error', 'Email không hợp lệ!');
                        email.focus();
                        return false;
                    }
                    
                    // Nếu validation pass, submit form bằng AJAX
                    submitForm();
                });
                
                // Auto-hide alerts after 5 seconds
                setTimeout(function() {
                    const alerts = document.querySelectorAll('.alert');
                    alerts.forEach(function(alert) {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    });
                }, 5000);
            });
            
            // Function to submit form via AJAX
            function submitForm() {
                const form = document.getElementById('addUserForm');
                const formData = new FormData(form);
                
                // Disable submit button để tránh submit nhiều lần
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang thêm...';
                
                fetch('admin?action=addUser', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    // Kiểm tra response để xác định thành công hay thất bại
                    if (data.includes('success:')) {
                        // Thêm user thành công
                        const successMessage = data.replace('success:', '').trim();
                        showAlert('success', successMessage);
                        
                        // Reset form ngay lập tức
                        resetForm();
                        
                        // Chuyển hướng về trang users sau 2 giây
                        setTimeout(function() {
                            window.location.href = 'admin?action=users';
                        }, 2000);
                    } else if (data.includes('error:')) {
                        // Có lỗi xảy ra
                        const errorMessage = data.replace('error:', '').trim();
                        showAlert('error', errorMessage);
                        
                        // Re-enable submit button
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Thêm User';
                    } else {
                        // Response không rõ ràng
                        showAlert('error', 'Có lỗi xảy ra!');
                        
                        // Re-enable submit button
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Thêm User';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('error', 'Có lỗi xảy ra khi thêm user!');
                    
                    // Re-enable submit button
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Thêm User';
                });
            }
            
            // Function to reset form
            function resetForm() {
                const form = document.getElementById('addUserForm');
                
                // Reset form bằng Bootstrap
                form.reset();
                
                // Reset các trường input cụ thể để đảm bảo
                document.getElementById('fullName').value = '';
                document.getElementById('email').value = '';
                document.getElementById('phone').value = '';
                document.getElementById('role').selectedIndex = 0;
                document.getElementById('password').value = '';
                document.getElementById('confirmPassword').value = '';
                
                // Xóa các class validation của Bootstrap nếu có
                const inputs = form.querySelectorAll('.form-control, .form-select');
                inputs.forEach(input => {
                    input.classList.remove('is-valid', 'is-invalid');
                });
                
                // Focus vào trường đầu tiên
                document.getElementById('fullName').focus();
                
                // Re-enable submit button
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Thêm User';
            }
            
            // Function to show alert at bottom-right
            function showAlert(type, message) {
                // Xóa alert cũ nếu có
                const existingAlert = document.querySelector('.alert.position-fixed');
                if (existingAlert) {
                    existingAlert.remove();
                }
                
                // Tạo alert mới
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' alert-dismissible fade show position-fixed';
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
            
            // Check for success message and show alert (for non-AJAX requests)
            document.addEventListener('DOMContentLoaded', function() {
                <c:if test="${not empty success}">
                    showAlert('success', '${success}');
                </c:if>
                <c:if test="${not empty error}">
                    showAlert('error', '${error}');
                </c:if>
            });
        </script>
    </body>
</html>
