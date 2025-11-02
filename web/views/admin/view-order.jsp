<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hóa đơn đơn hàng #${order.id} - AutoShowVN</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: #f8f9fa;
                color: #333;
                line-height: 1.4;
                padding: 20px;
            }
            
            .invoice-container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                border: 2px solid #e3f2fd;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            
            /* Header */
            .invoice-header {
                background: white;
                color: #333;
                padding: 40px 30px;
                text-align: left;
                border-bottom: 1px solid #e3f2fd;
            }
            
            .company-info {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }
            
            .company-logo {
                width: 80px;
                height: 80px;
                background: white;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 20px;
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
            
            .company-name {
                font-size: 32px;
                font-weight: bold;
                color: #333;
            }
            
            .invoice-title {
                text-align: right;
                margin-top: -80px;
            }
            
            .invoice-title h1 {
                font-size: 36px;
                font-weight: bold;
                margin-bottom: 20px;
                color: #333;
                text-transform: uppercase;
            }
            
            .invoice-number, .invoice-date {
                font-size: 16px;
                color: #666;
                margin-bottom: 8px;
                display: flex;
                justify-content: space-between;
            }
            
            .invoice-number span, .invoice-date span {
                font-weight: bold;
                color: #333;
            }
            
            /* Customer Section */
            .customer-section {
                padding: 30px;
                background: white;
                border-bottom: 1px solid #e3f2fd;
            }
            
            .customer-box h3 {
                font-size: 18px;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
                text-transform: uppercase;
            }
            
            .customer-field {
                margin-bottom: 15px;
                display: flex;
                justify-content: space-between;
            }
            
            .customer-label {
                font-weight: bold;
                color: #666;
                font-size: 14px;
                min-width: 120px;
            }
            
            .customer-value {
                font-size: 16px;
                color: #333;
                font-weight: bold;
                text-align: right;
                flex: 1;
            }
            
            /* Products Section */
            .products-section {
                padding: 30px;
                background: white;
            }
            
            .section-title {
                font-size: 20px;
                font-weight: bold;
                color: #333;
                margin-bottom: 25px;
                text-transform: uppercase;
            }
            
            .products-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
                background: white;
                border: 1px solid #e3f2fd;
            }
            
            .products-table th {
                background: #333;
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-weight: bold;
                font-size: 14px;
                text-transform: uppercase;
            }
            
            .products-table td {
                padding: 15px 12px;
                border-bottom: 1px solid #e3f2fd;
                vertical-align: top;
            }
            
            .products-table tr:nth-child(even) {
                background: #f8f9fa;
            }
            
            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border: 1px solid #e3f2fd;
                border-radius: 4px;
            }
            
            .product-info h6 {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }
            
            .quantity-cell, .price-cell, .total-cell {
                text-align: right;
                font-weight: bold;
            }
            
            .price-cell {
                color: #2196f3;
            }
            
            .total-cell {
                color: #333;
            }
            
            /* Summary Section */
            .summary-section {
                padding: 30px;
                background: white;
                border-top: 1px solid #e3f2fd;
            }
            
            .summary-table {
                width: 300px;
                margin-left: auto;
                background: white;
                border: 1px solid #e3f2fd;
            }
            
            .summary-table td {
                padding: 15px 20px;
                border-bottom: 1px solid #e3f2fd;
                font-size: 16px;
            }
            
            .summary-table tr:last-child {
                background: #333;
                color: white;
                font-weight: bold;
                font-size: 18px;
            }
            
            .summary-label {
                font-weight: bold;
                color: #333;
            }
            
            .summary-value {
                text-align: right;
                font-weight: bold;
                color: #333;
            }
            
            .summary-table tr:last-child .summary-value {
                color: white;
            }
            
            .summary-table tr:last-child .summary-label {
                color: white;
            }
            
            /* Actions Section */
            .actions-section {
                padding: 30px;
                text-align: center;
                background: white;
                border-top: 1px solid #e3f2fd;
            }
            
            .btn-action {
                display: inline-block;
                padding: 12px 24px;
                margin: 0 10px;
                text-decoration: none;
                border-radius: 4px;
                font-weight: bold;
                font-size: 14px;
                border: none;
                cursor: pointer;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .btn-back {
                background: #6c757d;
                color: white;
            }
            
            .btn-back:hover {
                background: #5a6268;
            }
            
            .btn-edit {
                background: #2196f3;
                color: white;
            }
            
            .btn-edit:hover {
                background: #1976d2;
            }
            
            .btn-delete {
                background: #f44336;
                color: white;
            }
            
            .btn-delete:hover {
                background: #d32f2f;
            }
            
            /* Footer */
            .invoice-footer {
                background: #f8f9fa;
                color: #666;
                text-align: center;
                padding: 20px;
                font-size: 14px;
                border-top: 1px solid #e3f2fd;
            }
            
            .invoice-footer p {
                margin: 5px 0;
                color: #666;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .customer-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }
                
                .invoice-title {
                    position: static;
                    text-align: center;
                    margin-top: 20px;
                }
                
                .summary-table {
                    width: 100%;
                    margin: 0;
                }
                
                .company-info {
                    flex-direction: column;
                    text-align: center;
                }
                
                .company-logo {
                    margin-right: 0;
                    margin-bottom: 15px;
                }
            }
            
            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: #666;
                background: #f8f9fa;
                border: 1px dashed #e3f2fd;
                border-radius: 4px;
            }
            
            .empty-state i {
                font-size: 48px;
                margin-bottom: 20px;
                color: #ccc;
            }
            
            .empty-state h5 {
                font-size: 20px;
                margin-bottom: 10px;
                color: #666;
            }
        </style>
    </head>
    <body>
        <div class="invoice-container">
            <!-- Invoice Header -->
            <div class="invoice-header">
                <div class="company-info">
                    <div class="company-logo">
                        <img src="assets/icons/logok.png" alt="K - Auto Logo" style="width: 100%; height: 100%; object-fit: contain;">
                    </div>
                    <div class="company-name">K - Auto</div>
                </div>
                
                <div class="invoice-title">
                    <h1>HÓA ĐƠN</h1>
                    <div class="invoice-number">Số hóa đơn: <span>#${order.id}</span></div>
                    <div class="invoice-date">
                        Ngày: <span><c:choose>
                            <c:when test="${not empty order.orderDate}">
                                <c:out value="${order.orderDate}"/>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #6c757d;">Chưa có ngày</span>
                            </c:otherwise>
                        </c:choose></span>
                    </div>
                </div>
            </div>
            
            <!-- Customer and Shipping Section -->
            <div class="customer-section">
                <div class="customer-grid">
                    <div class="customer-box">
                        <h3>Thông tin khách hàng</h3>
                        <div class="customer-field">
                            <div class="customer-label">Họ và tên:</div>
                            <div class="customer-value">
                                ${order.user != null && not empty order.user.fullName ? order.user.fullName : 'Không có thông tin'}
                            </div>
                        </div>
                        <div class="customer-field">
                            <div class="customer-label">Email:</div>
                            <div class="customer-value">
                                ${order.user != null && not empty order.user.email ? order.user.email : 'Không có thông tin'}
                            </div>
                        </div>
                        <div class="customer-field">
                            <div class="customer-label">Số điện thoại:</div>
                            <div class="customer-value">
                                ${order.user != null && not empty order.user.phone ? order.user.phone : 'Không có thông tin'}
                            </div>
                        </div>
                        <div class="customer-field">
                            <div class="customer-label">Mã khách hàng:</div>
                            <div class="customer-value">#${order.userId}</div>
                        </div>
                    </div>
                    
                    <div class="customer-box">
                        <h3>Thông tin đơn hàng</h3>
                        <div class="customer-field">
                            <div class="customer-label">Trạng thái:</div>
                            <div class="customer-value">
                                <c:choose>
                                    <c:when test="${order.status == 'unconfirmed'}">
                                        <span style="color: #f39c12; font-weight: bold;">⏳ Chờ xác nhận</span>
                                    </c:when>
                                    <c:when test="${order.status == 'confirmed'}">
                                        <span style="color: #27ae60; font-weight: bold;">✅ Đã xác nhận</span>
                                    </c:when>
                                    <c:when test="${order.status == 'in delivery'}">
                                        <span style="color: #3498db; font-weight: bold;">🚚 Đang giao</span>
                                    </c:when>
                                    <c:when test="${order.status == 'delivered'}">
                                        <span style="color: #27ae60; font-weight: bold;">🎉 Đã giao</span>
                                    </c:when>
                                    <c:when test="${order.status == 'cancelled'}">
                                        <span style="color: #e74c3c; font-weight: bold;">❌ Đã hủy</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #6c757d; font-weight: bold;">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="customer-field">
                            <div class="customer-label">Ghi chú:</div>
                            <div class="customer-value">
                                ${order.note != null && not empty order.note ? order.note : 'Không có ghi chú'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Products Section -->
            <div class="products-section">
                <h3 class="section-title">Chi tiết sản phẩm</h3>
                
                <c:choose>
                    <c:when test="${not empty order.orderItems}">
                        <table class="products-table">
                            <thead>
                                <tr>
                                    <th style="width: 40%;">Sản phẩm</th>
                                    <th style="width: 15%;">Danh mục</th>
                                    <th style="width: 15%;">Giá đơn vị</th>
                                    <th style="width: 10%;">SL</th>
                                    <th style="width: 20%;">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr>
                                        <td>
                                            <div class="product-info">
                                                <h6>${item.product.name != null ? item.product.name : 'Sản phẩm không xác định'}</h6>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.product.categoryId == 1}">718 Series</c:when>
                                                <c:when test="${item.product.categoryId == 2}">911 Series</c:when>
                                                <c:when test="${item.product.categoryId == 3}">Taycan</c:when>
                                                <c:when test="${item.product.categoryId == 4}">Panamera</c:when>
                                                <c:when test="${item.product.categoryId == 5}">Macan</c:when>
                                                <c:when test="${item.product.categoryId == 6}">Cayenne</c:when>
                                                <c:otherwise>
                                                    <span style="color: #6c757d;">Category ${item.product.categoryId}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="price-cell">
                                            <fmt:formatNumber value="${item.price != null ? item.price : 0}" 
                                                            type="currency" currencySymbol="₫" 
                                                            maxFractionDigits="0"/>
                                        </td>
                                        <td class="quantity-cell">${item.quantity}</td>
                                        <td class="total-cell">
                                            <fmt:formatNumber value="${item.price != null && item.quantity != null ? item.price * item.quantity : 0}" 
                                                            type="currency" currencySymbol="₫" 
                                                            maxFractionDigits="0"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-box-open"></i>
                            <h5>Không có sản phẩm nào</h5>
                            <p>Đơn hàng này không chứa sản phẩm nào</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Summary Section -->
            <div class="summary-section">
                <table class="summary-table">


                    <tr>
                        <td class="summary-label">Tổng cộng:</td>
                        <td class="summary-value">
                            <fmt:formatNumber value="${order.totalAmount != null ? order.totalAmount : 0}" 
                                            type="currency" currencySymbol="₫" 
                                            maxFractionDigits="0"/>
                        </td>
                    </tr>
                </table>
            </div>
            
            <!-- Actions Section -->
            <div class="actions-section">
                <a href="admin?action=orders" class="btn-action btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại
                </a>

                <button class="btn-action btn-delete" onclick="deleteOrder(${order.id})">
                    <i class="fas fa-trash"></i>
                    Xóa đơn hàng
                </button>
            </div>
            
            <!-- Invoice Footer -->
            <div class="invoice-footer">
                <p>K - Auto</p>
                <p>Hóa đơn được tạo tự động bởi hệ thống quản lý</p>
                <p>Trân trọng cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</p>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function deleteOrder(orderId) {
                if (confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')) {
                    fetch('admin?action=deleteOrder&id=' + orderId, {
                        method: 'POST'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Xóa đơn hàng thành công!');
                            window.location.href = 'admin?action=orders';
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
