<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán - K - Auto</title>
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
                display: flex;
                flex-direction: column;
            }
            
            .navbar {
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.5),
                    -4px -4px 8px rgba(255, 255, 255, 0.9),
                    4px -4px 8px rgba(160, 160, 160, 0.3),
                    -4px 4px 8px rgba(255, 255, 255, 0.7);
                background: rgba(255, 255, 255, 0.9) !important;
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .navbar-brand {
                color: #2d3748 !important;
                font-weight: 600;
            }
            
            .checkout-container {
                max-width: 900px;
                margin: 0 auto;
                padding: 2rem;
                flex: 1;
            }
            
            .checkout-card {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 30px;
                box-shadow: 
                    20px 20px 60px rgba(180, 180, 180, 0.4),
                    -20px -20px 60px rgba(255, 255, 255, 0.9),
                    20px -20px 60px rgba(180, 180, 180, 0.3),
                    -20px 20px 60px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                overflow: hidden;
            }
            
            .checkout-header {
                background: rgba(255, 255, 255, 0.9);
                color: #2d3748;
                padding: 3rem 2rem;
                text-align: center;
                border-bottom: 1px solid rgba(180, 180, 180, 0.2);
            }
            
            .checkout-header h1 {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }
            
            .checkout-header i {
                color: #4a5568;
            }
            
            .checkout-body {
                padding: 2.5rem;
            }
            
            .product-info {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 
                    8px 8px 20px rgba(180, 180, 180, 0.4),
                    -8px -8px 20px rgba(255, 255, 255, 0.9),
                    8px -8px 20px rgba(180, 180, 180, 0.3),
                    -8px 8px 20px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .product-info h5 {
                color: #2d3748;
                font-weight: 600;
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }
            
            .product-info .text-muted {
                color: #718096 !important;
                font-size: 0.95rem;
                line-height: 1.4;
            }
            
            .product-info .text-primary {
                color: #2d3748 !important;
                font-weight: 700;
                font-size: 1.8rem;
            }
            

            
            .product-title {
                color: #2d3748;
                font-weight: 600;
                font-size: 1.4rem;
                line-height: 1.3;
                margin-bottom: 0.5rem;
            }
            

            
            .product-meta {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .meta-item {
                display: flex;
                align-items: center;
                color: #4a5568;
                font-size: 0.95rem;
            }
            
            .meta-item i {
                color: #2d3748;
                width: 20px;
                text-align: center;
            }
            
            .meta-item strong {
                color: #2d3748;
                font-weight: 600;
            }
            
                         .total-price-box {
                 background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(248, 250, 252, 0.95) 100%);
                 border-radius: 20px;
                 padding: 2rem;
                 box-shadow: 
                     8px 8px 20px rgba(160, 160, 160, 0.4),
                     -8px -8px 20px rgba(255, 255, 255, 0.9),
                     8px -8px 20px rgba(160, 160, 160, 0.3),
                     -8px 8px 20px rgba(255, 255, 255, 0.7);
                 backdrop-filter: blur(15px);
                 -webkit-backdrop-filter: blur(15px);
                 border: none;
                 margin-top: 1rem;
                 position: relative;
                 overflow: hidden;
             }
            
            
            
            .price-label {
                color: #4a5568;
                font-size: 0.85rem;
                font-weight: 600;
                margin-bottom: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-align: center;
                opacity: 0.8;
            }
            
                         .price-value {
                 color: #28a745;
                 font-size: 1.8rem;
                 font-weight: 800;
                 line-height: 1.1;
                 text-align: center;
                 text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
                border-radius: 15px;
                padding: 15px 20px;
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
                transition: all 0.2s ease;
                margin-bottom: 1rem;
            }
            
            .form-control:focus {
                transform: translateY(-1px);
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.5),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9),
                    inset 2px -2px 4px rgba(160, 160, 160, 0.3),
                    inset -2px 2px 4px rgba(255, 255, 255, 0.7);
            }
            
            .form-control::placeholder {
                color: #a0aec0;
            }
            
            .btn-checkout {
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 20px;
                padding: 18px 40px;
                font-size: 18px;
                font-weight: 600;
                color: #2d3748;
                cursor: pointer;
                box-shadow: 
                    8px 8px 16px rgba(160, 160, 160, 0.5),
                    -8px -8px 16px rgba(255, 255, 255, 0.9),
                    8px -8px 16px rgba(160, 160, 160, 0.3),
                    -8px 8px 16px rgba(255, 255, 255, 0.7);
                transition: all 0.2s ease;
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
            }
            
            .btn-checkout:hover {
                transform: translateY(0px);
                box-shadow: 
                    inset 3px 3px 6px rgba(160, 160, 160, 0.5),
                    inset -3px -3px 6px rgba(255, 255, 255, 0.9),
                    inset 3px -3px 6px rgba(160, 160, 160, 0.3),
                    inset -3px 3px 6px rgba(255, 255, 255, 0.7);
                color: #2d3748;
            }
            
            .btn-checkout:active {
                transform: translateY(1px);
            }
            
            .payment-methods {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin-bottom: 2rem;
            }
            
            .payment-method {
                padding: 1.5rem;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 15px;
                text-align: center;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 
                    6px 6px 12px rgba(160, 160, 160, 0.5),
                    -6px -6px 12px rgba(255, 255, 255, 0.9),
                    6px -6px 12px rgba(160, 160, 160, 0.3),
                    -6px 6px 12px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                color: #4a5568;
            }
            
            .payment-method:hover {
                transform: translateY(-2px);
                box-shadow: 
                    8px 8px 16px rgba(160, 160, 160, 0.6),
                    -8px -8px 16px rgba(255, 255, 255, 1),
                    8px -8px 16px rgba(160, 160, 160, 0.4),
                    -8px 8px 16px rgba(255, 255, 255, 0.8);
            }
            
            .payment-method.selected {
                background: rgba(144, 238, 144, 0.9);
                color: #2d3748;
                border: 2px solid rgba(144, 238, 144, 0.4);
                transform: translateY(-1px);
            }
            
            .payment-method i {
                font-size: 2.5rem;
                margin-bottom: 1rem;
                display: block;
            }
            
            .payment-method div {
                font-weight: 500;
                font-size: 0.9rem;
            }
            
            .payment-info {
                margin-bottom: 2rem;
            }
            
            .deposit-details {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 
                    8px 8px 20px rgba(180, 180, 180, 0.4),
                    -8px -8px 20px rgba(255, 255, 255, 0.9),
                    8px -8px 20px rgba(180, 180, 180, 0.3),
                    -8px 8px 20px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .deposit-item {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem 0;
                border-bottom: 1px solid rgba(180, 180, 180, 0.2);
                color: #4a5568;
            }
            
            .deposit-item:last-child {
                border-bottom: none;
            }
            
            .deposit-item i {
                font-size: 1.5rem;
                color: #2d3748;
                width: 30px;
                text-align: center;
            }
            
            .deposit-item span {
                font-size: 1rem;
                line-height: 1.5;
            }
            
            .deposit-item strong {
                color: #2d3748;
                font-weight: 600;
            }
            
            .deposit-amount {
                color: #28a745 !important;
                font-size: 1.1rem !important;
            }
            
            .total-section {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 20px;
                padding: 2rem;
                margin-top: 2rem;
                box-shadow: 
                    8px 8px 20px rgba(180, 180, 180, 0.4),
                    -8px -8px 20px rgba(255, 255, 255, 0.9),
                    8px -8px 20px rgba(180, 180, 180, 0.3),
                    -8px 8px 20px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .total-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.8rem;
                color: #4a5568;
                font-size: 1rem;
            }
            
            .total-row.final {
                font-size: 1.3rem;
                font-weight: 700;
                color: #2d3748;
                border-top: 2px solid rgba(180, 180, 180, 0.3);
                padding-top: 1rem;
                margin-top: 1rem;
            }
            
            h5 {
                color: #2d3748;
                font-weight: 600;
                font-size: 1.3rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            
            h5 i {
                color: #4a5568;
            }
            
            .badge {
                background: rgba(255, 255, 255, 0.9) !important;
                color: #2d3748 !important;
                border-radius: 10px;
                padding: 8px 12px;
                font-weight: 500;
                box-shadow: 
                    2px 2px 4px rgba(160, 160, 160, 0.5),
                    -2px -2px 4px rgba(255, 255, 255, 0.9);
            }
            
            @media (max-width: 768px) {
                .checkout-container {
                    padding: 1rem;
                }
                
                .checkout-header {
                    padding: 2rem 1rem;
                }
                
                .checkout-header h1 {
                    font-size: 2rem;
                }
                
                .checkout-body {
                    padding: 1.5rem;
                }
                
                .payment-methods {
                    grid-template-columns: 1fr;
                }
                
                .product-info {
                    padding: 1.5rem;
                }
                
                .product-info .row {
                    text-align: left;
                }
                
                .product-title {
                    font-size: 1.2rem;
                    text-align: left;
                }
                
                .product-meta {
                    align-items: flex-start;
                    gap: 0.5rem;
                }
                
                .meta-item {
                    justify-content: flex-start;
                    font-size: 0.9rem;
                }
                
                .total-price-box {
                    margin-top: 1.5rem;
                    padding: 1.5rem;
                }
                
                .price-value {
                    font-size: 1.5rem;
                }
                
                .deposit-details {
                    padding: 1.5rem;
                }
                
                .deposit-item {
                    padding: 0.75rem 0;
                    font-size: 0.9rem;
                }
                
                .deposit-item i {
                    font-size: 1.25rem;
                }
            }
            
            @media (max-width: 576px) {
                .checkout-container {
                    padding: 0.5rem;
                }
                
                .checkout-header {
                    padding: 1.5rem 1rem;
                }
                
                .checkout-header h1 {
                    font-size: 1.75rem;
                }
                
                .checkout-body {
                    padding: 1rem;
                }
                
                .product-info {
                    padding: 1rem;
                }
                
                .product-meta {
                    flex-direction: column;
                    gap: 0.5rem;
                }
                
                .total-price-box {
                    margin-top: 1rem;
                    padding: 1.25rem;
                }
                
                .price-value {
                    font-size: 1.3rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <a class="navbar-brand" href="home">
                        <img src="${pageContext.request.contextPath}/assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                    
                    <div class="d-flex align-items-center">
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user me-2"></i>${sessionScope.userName}
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item" href="profile">
                                        <i class="fas fa-user-circle me-2"></i>Hồ sơ
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="checkout-container">
                <div class="checkout-card">
                    <div class="checkout-header">
                        <h1><i class="fas fa-credit-card me-2"></i>Thanh toán</h1>
                        <p class="mb-0">Hoàn tất đơn hàng của bạn</p>
                    </div>
                    
                    <div class="checkout-body">
                        <!-- Product Information -->
                        <div class="product-info">
                            <div class="row align-items-center g-4">
                                <div class="col-md-5 col-sm-8">
                                    <h5 class="product-title mb-3">${product.name}</h5>
                                    <div class="product-meta">
                                        <div class="meta-item">
                                            <i class="fas fa-list-ol me-2"></i>
                                            <span>Số lượng: <strong>${quantity}</strong></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-7 col-sm-12 text-center">
                                    <div class="total-price-box">
                                        <div class="price-label">Tổng tiền</div>
                                                                                 <div class="price-value">
                                             <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> ₫
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Checkout Form -->
                        <form id="checkoutForm" action="order" method="POST">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" value="${quantity}">
                            
                            <!-- Customer Information -->
                            <h5 class="mb-3"><i class="fas fa-user me-2"></i>Thông tin khách hàng</h5>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label">Họ và tên</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ của bạn" required>
                                </div>
                            </div>
                            
                            <!-- Payment Method -->
                            <h5 class="mb-3"><i class="fas fa-hand-holding-usd me-2"></i>Hình thức đặt cọc</h5>
                            <div class="payment-info">
                                <div class="deposit-details">
                                    <div class="deposit-item">
                                        <i class="fas fa-percentage"></i>
                                        <span>Mức cọc: <strong>25%</strong> giá trị đơn hàng</span>
                                    </div>
                                    <div class="deposit-item">
                                        <i class="fas fa-calculator"></i>
                                                                                 <span>Số tiền cọc: <strong class="deposit-amount"><fmt:formatNumber value="${totalAmount * 0.25}" type="number" maxFractionDigits="0"/> ₫</strong></span>
                                    </div>
                                    <div class="deposit-item">
                                        <i class="fas fa-info-circle"></i>
                                        <span>Số tiền còn lại sẽ thanh toán khi nhận hàng</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Note -->
                            <div class="mb-3">
                                <label for="note" class="form-label">Ghi chú</label>
                                <textarea class="form-control" id="note" name="note" rows="3" placeholder="Ghi chú cho đơn hàng (tùy chọn)"></textarea>
                            </div>
                            
                            <!-- Total Section -->
                            <div class="total-section">
                                <div class="total-row">
                                    <span>Giá sản phẩm:</span>
                                                                         <span><fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="total-row">
                                    <span>Số lượng:</span>
                                    <span>${quantity}</span>
                                </div>
                                <div class="total-row">
                                    <span>Phí vận chuyển:</span>
                                    <span>Miễn phí</span>
                                </div>
                                <div class="total-row">
                                    <span>Tổng cộng:</span>
                                                                         <span><fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="total-row">
                                    <span>Số tiền cọc (25%):</span>
                                                                         <span class="deposit-amount"><fmt:formatNumber value="${totalAmount * 0.25}" type="number" maxFractionDigits="0"/> ₫</span>
                                </div>
                                <div class="total-row final">
                                    <span>Số tiền còn lại:</span>
                                                                         <span><fmt:formatNumber value="${totalAmount * 0.75}" type="number" maxFractionDigits="0"/> ₫</span>
                                </div>
                            </div>
                            
                            <!-- Submit Button -->
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-checkout">
                                    <i class="fas fa-lock me-2"></i>Xác nhận đặt hàng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Form submission
            document.getElementById('checkoutForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Add payment method to form data (always deposit)
                const paymentMethodInput = document.createElement('input');
                paymentMethodInput.type = 'hidden';
                paymentMethodInput.name = 'paymentMethod';
                paymentMethodInput.value = 'deposit';
                this.appendChild(paymentMethodInput);
                
                // Submit form
                this.submit();
            });
        </script>
    </body>
</html>
