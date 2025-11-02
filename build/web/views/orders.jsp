<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đơn hàng của tôi - K - Auto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            body {
                padding-top: 80px;
                background-color: #f8f9fa;
            }
            
            .navbar {
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                background-color: white !important;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
            }
            
            .page-header {
                background: white;
                color: #333;
                padding: 3rem 0;
                margin-bottom: 2rem;
                border-bottom: 1px solid #e3f2fd;
            }
            
            .page-header h1 {
                font-weight: 600;
                margin-bottom: 0.5rem;
            }
            
            .page-header p {
                opacity: 0.9;
                margin: 0;
            }
            
            .order-card {
                background: white;
                border: 2px solid #e3f2fd;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 1.5rem;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .order-header {
                background: white;
                padding: 2rem 1.5rem;
                border-bottom: 1px solid #e3f2fd;
            }
            
            .order-id {
                font-size: 1.3rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
            }
            
            .order-date {
                color: #6c757d;
                font-size: 0.9rem;
            }
            
            .order-status {
                display: inline-block;
                padding: 0.75rem 1.5rem;
                border-radius: 4px;
                font-size: 0.9rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .status-unconfirmed { background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
            .status-confirmed { background-color: #d1ecf1; color: #0c5460; border: 1px solid #b8e6f1; }
            .status-delivery { background-color: #cce5ff; color: #004085; border: 1px solid #b3d9ff; }
            .status-delivered { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
            .status-cancelled { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
            
            .order-body {
                padding: 2rem 1.5rem;
            }
            
                                     .order-item {
                padding: 1.5rem 0;
                border-bottom: 1px solid #e3f2fd;
            }
            
            .order-item:last-child {
                border-bottom: none;
            }
            
            
            
            
            
            .item-name {
                font-weight: 700;
                color: #333;
                margin-bottom: 0.5rem;
                font-size: 1.1rem;
            }
            
            .item-details {
                color: #6c757d;
                font-size: 0.9rem;
            }
            
            .item-price {
                font-weight: 600;
                color: #2196f3;
                text-align: right;
            }
            
            .order-footer {
                background: white;
                padding: 2rem 1.5rem;
                border-top: 1px solid #e3f2fd;
            }
            
            .total-amount {
                font-size: 1.4rem;
                font-weight: 700;
                color: #333;
            }
            
            .btn-view-detail {
                background: #2196f3;
                border: none;
                color: white;
                padding: 1rem 2rem;
                border-radius: 4px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .btn-view-detail:hover {
                background: #1976d2;
                color: white;
            }
            
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #6c757d;
            }
            
            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }
            
            .empty-state h3 {
                margin-bottom: 1rem;
                color: #495057;
            }
            
            .btn-shop-now {
                background: #28a745;
                border: none;
                color: white;
                padding: 1rem 2rem;
                border-radius: 4px;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
            }
            
            .btn-shop-now:hover {
                background: #218838;
                color: white;
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
                    
                                         
                </div>
            </div>
        </nav>

        <!-- Page Header -->
        <div class="page-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1><i class="fas fa-shopping-bag me-3"></i>Đơn hàng của tôi</h1>
                        <p>Xem lại tất cả đơn hàng và trạng thái giao hàng</p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <c:if test="${not empty userOrders and fn:length(userOrders) > 0}">
                            <span class="badge bg-primary fs-6">${userOrders.size()} đơn hàng</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>



            <!-- Orders List -->
            <c:choose>
                <c:when test="${not empty userOrders and fn:length(userOrders) > 0}">
                    <c:forEach var="order" items="${userOrders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <div class="order-id">
                                            <i class="fas fa-receipt me-2"></i>
                                            Đơn hàng #${order.id}
                                        </div>
                                        <!-- Hiển thị ngày tháng -->
                                        <div class="order-date">
                                            <i class="fas fa-calendar me-2"></i>
                                            ${order.orderDate}
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <span class="order-status status-${order.status}">
                                            <c:choose>
                                                <c:when test="${order.status == 'unconfirmed'}">
                                                    <i class="fas fa-clock me-1"></i>Chờ xác nhận
                                                </c:when>
                                                <c:when test="${order.status == 'confirmed'}">
                                                    <i class="fas fa-check me-1"></i>Đã xác nhận
                                                </c:when>
                                                <c:when test="${order.status == 'in delivery'}">
                                                    <i class="fas fa-truck me-1"></i>Đang giao
                                                </c:when>
                                                <c:when test="${order.status == 'delivered'}">
                                                    <i class="fas fa-box-open me-1"></i>Đã giao
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <i class="fas fa-times me-1"></i>Đã hủy
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-info-circle me-1"></i>${order.status}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                                                         <div class="order-body">
                                 <c:if test="${not empty order.orderItems}">
                                     <c:forEach var="item" items="${order.orderItems}">
                                         <div class="order-item">
                                             <!-- THÔNG TIN SẢN PHẨM -->
                                             <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <div class="item-name">
                                                            <c:choose>
                                                                <c:when test="${not empty item.product and not empty item.product.name}">
                                                                    ${item.product.name}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Sản phẩm không xác định
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                                                                                 <small class="text-muted">
                                                             Số lượng: 
                                                             <c:choose>
                                                                 <c:when test="${not empty item.quantity}">
                                                                     ${item.quantity}
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     0
                                                                 </c:otherwise>
                                                             </c:choose>
                                                             | 
                                                             Đơn giá: 
                                                             <c:choose>
                                                                 <c:when test="${not empty item.price}">
                                                                     <fmt:formatNumber value="${item.price}" type="number" maxFractionDigits="0"/> ₫
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     0 ₫
                                                                 </c:otherwise>
                                                             </c:choose>
                                                         </small>
                                                    </div>
                                                                                                         <div class="text-end">
                                                         <strong class="text-primary">
                                                             <c:choose>
                                                                 <c:when test="${not empty item.price and not empty item.quantity}">
                                                                     <fmt:formatNumber value="${item.price * item.quantity}" type="number" maxFractionDigits="0"/> ₫
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     0 ₫
                                                                 </c:otherwise>
                                                             </c:choose>
                                                         </strong>
                                                     </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            
                            <div class="order-footer">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                                                                 <div class="total-amount">
                                             <i class="fas fa-money-bill-wave me-2"></i>
                                             Tổng tiền: <fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="0"/> ₫
                                         </div>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <a href="order?action=detail&id=${order.id}" class="btn btn-view-detail">
                                            <i class="fas fa-eye me-2"></i>
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-shopping-bag"></i>
                        <h3>Chưa có đơn hàng nào</h3>
                        <p>Bạn chưa đặt đơn hàng nào. Hãy khám phá các sản phẩm tuyệt vời của chúng tôi!</p>
                        <a href="home" class="btn-shop-now">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Mua sắm ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
