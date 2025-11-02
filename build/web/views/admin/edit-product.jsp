<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa Sản phẩm - Admin Dashboard</title>
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
                font-weight: bold;
                color: #333;
                border: 2px solid #e9ecef;
            }
            
            .logout-btn {
                background: #dc3545;
                color: white;
                border: none;
                border-radius: 8px;
                padding: 0.5rem 1rem;
                text-decoration: none;
                transition: all 0.3s ease;
                font-weight: 400;
            }
            
            .logout-btn:hover {
                background: #c82333;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            }
            
            /* Content Section */
            .content-section {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }
            
            .content-section h3 {
                color: #333;
                font-weight: 500;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #f8f9fa;
            }
            
            /* Form Styles */
            .form-label {
                font-weight: 500;
                color: #333;
                margin-bottom: 0.5rem;
            }
            
            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #fff;
            }
            
            .form-control:focus, .form-select:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
                outline: none;
            }
            
            .form-textarea {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                min-height: 100px;
                resize: vertical;
            }
            
            .form-textarea:focus {
                border-color: #333;
                box-shadow: 0 0 0 0.2rem rgba(51, 51, 51, 0.25);
            }
            
            /* Button Styles */
            .btn-primary {
                background: #333;
                border: none;
                border-radius: 8px;
                padding: 0.6rem 1.2rem;
                font-weight: 400;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                background: #555;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .btn-secondary {
                background: #6c757d;
                border: none;
                border-radius: 8px;
                padding: 0.6rem 1.2rem;
                font-weight: 400;
                transition: all 0.3s ease;
            }
            
            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
            }
            
            /* File Upload */
            .file-upload {
                border: 2px dashed #e9ecef;
                border-radius: 8px;
                padding: 2rem;
                text-align: center;
                background: #f8f9fa;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            
            .file-upload:hover {
                border-color: #333;
                background: #f0f0f0;
            }
            
            .file-upload i {
                font-size: 2rem;
                color: #666;
                margin-bottom: 1rem;
            }
            
            /* Current Image Preview */
            .current-image {
                margin-bottom: 1rem;
                text-align: center;
            }
            
            .current-image img {
                max-width: 100%;
                max-height: 200px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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
                
                .content-section {
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
                            <i class="fas fa-edit me-3"></i>
                            Chỉnh sửa Sản phẩm
                        </h1>
                        <p class="mb-0 mt-2">Cập nhật thông tin sản phẩm xe Porsche trong hệ thống K - Auto</p>
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
                        <a class="nav-link active" href="admin?action=products">
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
                <h3>
                    <i class="fas fa-car me-2"></i>Thông tin sản phẩm
                </h3>
                
                <!-- Thông báo lỗi -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Thông báo thành công -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty product}">
                    <form action="admin?action=updateProduct" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <input type="hidden" name="id" value="${product.id}">
                        
                        <div class="row">
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="name" class="form-label">Tên sản phẩm *</label>
                                        <input type="text" class="form-control" id="name" name="name" required 
                                               value="${product.name}" placeholder="VD: 911 Carrera S">
                                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="category" class="form-label">Danh mục *</label>
                                        <select class="form-select" id="category" name="category" required>
                                            <option value="">Chọn danh mục</option>
                                            <option value="1" ${product.categoryId == 1 ? 'selected' : ''}>718 (Boxster/Cayman)</option>
                                            <option value="2" ${product.categoryId == 2 ? 'selected' : ''}>911 (Carrera/GTS)</option>
                                            <option value="3" ${product.categoryId == 3 ? 'selected' : ''}>Taycan</option>
                                            <option value="4" ${product.categoryId == 4 ? 'selected' : ''}>Panamera</option>
                                            <option value="5" ${product.categoryId == 5 ? 'selected' : ''}>Macan</option>
                                            <option value="6" ${product.categoryId == 6 ? 'selected' : ''}>Cayenne</option>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn danh mục</div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="price" class="form-label">Giá (VNĐ) *</label>
                                        <input type="number" class="form-control" id="price" name="price" required 
                                               value="${product.price}" placeholder="5000000000" min="0">
                                        <div class="invalid-feedback">Vui lòng nhập giá sản phẩm</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="year" class="form-label">Năm sản xuất</label>
                                        <input type="number" class="form-control" id="year" name="year" 
                                               value="${product.year > 0 ? product.year : ''}" min="1900" max="2030" placeholder="2024">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="engine" class="form-label">Động cơ</label>
                                        <input type="text" class="form-control" id="engine" name="engine" 
                                               value="${product.engine != null ? product.engine : ''}" placeholder="VD: 3.0L Twin-Turbo">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="horsepower" class="form-label">Công suất (HP)</label>
                                        <input type="number" class="form-control" id="horsepower" name="horsepower" 
                                               value="${product.horsepower > 0 ? product.horsepower : ''}" placeholder="450" min="0">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="torque" class="form-label">Mô-men xoắn (Nm)</label>
                                        <input type="number" class="form-control" id="torque" name="torque" 
                                               value="${product.torque > 0 ? product.torque : ''}" placeholder="550" min="0">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="topSpeed" class="form-label">Tốc độ tối đa (km/h)</label>
                                        <input type="number" class="form-control" id="topSpeed" name="topSpeed" 
                                               value="${product.topSpeed > 0 ? product.topSpeed : ''}" placeholder="308" min="0">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả sản phẩm</label>
                                    <textarea class="form-textarea form-control" id="description" name="description" rows="4" 
                                              placeholder="Mô tả chi tiết về sản phẩm, tính năng nổi bật...">${product.description != null ? product.description : ''}</textarea>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">Hình ảnh hiện tại</label>
                                    <c:if test="${not empty product.image}">
                                        <div class="current-image">
                                            <img src="${product.image}" alt="Current product image" class="img-fluid">
                                            <p class="text-muted mt-2">Hình ảnh hiện tại</p>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Cập nhật hình ảnh</label>
                                    <div class="file-upload" onclick="document.getElementById('imageInput').click()">
                                        <i class="fas fa-cloud-upload-alt"></i>
                                        <p class="mb-2">Click để chọn hình ảnh mới</p>
                                        <small class="text-muted">Hỗ trợ: JPG, PNG, GIF (Max: 5MB)</small>
                                        <input type="file" id="imageInput" name="image" accept="image/*" style="display: none;">
                                    </div>
                                    <small class="form-text text-muted mt-2">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Để trống nếu không muốn thay đổi hình ảnh. Hình ảnh mới sẽ thay thế hình cũ.
                                    </small>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Trạng thái</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="status" id="statusActive" value="active" checked>
                                        <label class="form-check-label" for="statusActive">
                                            Hoạt động
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="status" id="statusInactive" value="inactive">
                                        <label class="form-check-label" for="statusInactive">
                                            Không hoạt động
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Cập nhật sản phẩm
                                    </button>
                                    <a href="admin?action=products" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
                
                <c:if test="${empty product}">
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Không tìm thấy thông tin sản phẩm. Vui lòng kiểm tra lại ID sản phẩm.
                    </div>
                    <a href="admin?action=products" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách sản phẩm
                    </a>
                </c:if>
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
            // File upload preview
            document.getElementById('imageInput').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const fileUpload = document.querySelector('.file-upload');
                    fileUpload.innerHTML = 
                        '<i class="fas fa-check-circle text-success"></i>' +
                        '<p class="mb-2">' + file.name + '</p>' +
                        '<small class="text-muted">Kích thước: ' + (file.size / 1024 / 1024).toFixed(2) + ' MB</small>';
                }
            });
            
            // Form validation
            (function() {
                'use strict';
                window.addEventListener('load', function() {
                    var forms = document.getElementsByClassName('needs-validation');
                    var validation = Array.prototype.filter.call(forms, function(form) {
                        form.addEventListener('submit', function(event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
            
            // Custom validation
            document.addEventListener('DOMContentLoaded', function() {
                const yearInput = document.getElementById('year');
                const horsepowerInput = document.getElementById('horsepower');
                const torqueInput = document.getElementById('torque');
                const topSpeedInput = document.getElementById('topSpeed');
                
                // Validate year range
                if (yearInput) {
                    yearInput.addEventListener('blur', function() {
                        const year = parseInt(this.value);
                        if (year && (year < 1900 || year > 2030)) {
                            this.setCustomValidity('Năm sản xuất phải từ 1900 đến 2030');
                        } else {
                            this.setCustomValidity('');
                        }
                    });
                }
                
                // Validate positive numbers
                [horsepowerInput, torqueInput, topSpeedInput].forEach(input => {
                    if (input) {
                        input.addEventListener('blur', function() {
                            const value = parseInt(this.value);
                            if (this.value && value <= 0) {
                                this.setCustomValidity('Giá trị phải lớn hơn 0');
                            } else {
                                this.setCustomValidity('');
                            }
                        });
                    }
                });
                
                // Show loading state on form submit
                document.querySelector('form').addEventListener('submit', function(e) {
                    const submitBtn = document.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                    submitBtn.disabled = true;
                    
                    // Re-enable after a delay (in case of validation failure)
                    setTimeout(() => {
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 3000);
                });
            });
        </script>
    </body>
</html>
