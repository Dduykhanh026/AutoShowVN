<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm yêu thích - K - Auto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            /* Navbar Styles */
            .navbar {
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                background-color: white !important;
            }
            
                         /* Navbar spacing */
            .navbar .container {
                padding: 0 20px;
            }
            
            .navbar-brand {
                margin-right: 30px !important;
            }
            
            .navbar-nav .nav-link {
                margin: 0 15px;
            }
            
            .wishlist-btn {
                margin-left: 25px;
            }
            
            /* Navbar nav-link styling to match home.jsp */
            .navbar-nav .nav-link {
                color: #333 !important;
                font-weight: 400;
                padding: 15px 20px;
                transition: all 0.3s ease;
            }
            
            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link:focus {
                color: #333 !important;
                background-color: transparent;
            }
            
            .navbar-brand {
                color: #333 !important;
                font-weight: 400;
            }
            
            /* User dropdown styling to match home.jsp */
            .dropdown .nav-link {
                color: #333 !important;
                font-weight: 400;
                padding: 15px 20px;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            
            .dropdown .nav-link:hover,
            .dropdown .nav-link:focus {
                color: #333 !important;
                background-color: transparent;
            }
            
            .dropdown .dropdown-menu {
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
                border: none;
                padding: 0.5rem 0;
                margin-top: 20px;
            }
            
            .dropdown .dropdown-item {
                padding: 0.75rem 1.5rem;
                transition: all 0.3s ease;
                border-radius: 8px;
                margin: 0 0.5rem;
                width: calc(100% - 1rem);
            }
            
            .dropdown .dropdown-divider {
                margin: 0.5rem 1rem;
                border-color: #e9ecef;
            }
            
            /* Hover dropdown effect */
            .dropdown:hover .dropdown-menu {
                display: block !important;
                opacity: 1;
                transform: translateY(0);
                visibility: visible;
            }
            
            .dropdown-menu {
                margin-top: 0;
                opacity: 0;
                transform: translateY(-10px);
                visibility: hidden;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: block !important;
                background: white;
                border: none;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            }
            
            /* Disable click effect */
            .dropdown-toggle {
                cursor: default;
                pointer-events: none;
            }
            
            .dropdown-toggle:hover {
                cursor: default;
            }
            
            .dropdown-toggle::after {
                display: none;
            }
            
            .dropdown-item {
                padding: 15px 20px;
                border-bottom: 1px solid #f0f0f0;
                transition: all 0.3s ease;
                display: block;
                width: 100%;
                text-align: left;
            }
            
            .dropdown-item:last-child {
                border-bottom: none;
            }
            
            .dropdown-item i {
                color: #666;
                font-size: 0.9rem;
                width: 20px;
                text-align: center;
                margin-right: 8px;
            }
            
            /* Wishlist Button Styles */
            .wishlist-btn {
                background: none;
                border: none;
                padding: 8px 12px;
                border-radius: 8px;
                transition: all 0.3s ease;
                position: relative;
                margin: 0;
                text-decoration: none;
                display: inline-block;
            }
            
            .wishlist-btn:hover {
                background-color: #f8f9fa;
                transform: translateY(-2px);
                text-decoration: none;
            }
            
            .wishlist-btn img {
                width: 24px;
                height: 24px;
                object-fit: contain;
                filter: brightness(0.7);
                transition: all 0.3s ease;
            }
            
            .wishlist-btn:hover img {
                filter: brightness(1);
                transform: scale(1.1);
            }
            
            .wishlist-btn.has-items {
                animation: pulse 2s infinite;
            }
            
            .wishlist-btn.has-items img {
                filter: brightness(1);
            }
            
            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }
            
            .wishlist-count {
                position: absolute;
                top: -5px;
                right: -5px;
                background-color: #dc3545;
                color: white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 12px;
                display: none;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }
            
            /* Page Header */
            .page-header {
                background: url('assets/images/cartbanner.jpg') center center/cover no-repeat;
                color: white;
                padding: 330px 0;
                margin-bottom: 20px;
                position: relative;
            }
            
            .page-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.4);
                z-index: 1;
            }
            
            .page-header .container {
                position: absolute;
                bottom: 0;
                left: 0;
                z-index: 2;
                padding: 60px 40px;
                width: 100%;
                box-sizing: border-box;
            }
            
            .page-header .page-title i {
                margin-right: 15px;
                font-size: 0.9em;
                opacity: 0.9;
            }
            
            .page-header .page-title,
            .page-header .page-subtitle {
                text-align: left;
                margin: 0;
            }
            
            .page-header .page-title {
                margin-bottom: 15px;
            }
            
            .page-title {
                font-size: 3.5rem;
                font-weight: 600;
                margin-bottom: 15px;
                text-shadow: 1px 1px 3px rgba(0,0,0,0.6);
                letter-spacing: 1px;
            }
            
                         .page-subtitle {
                 font-size: 1.3rem;
                 font-weight: 300;
                 opacity: 0.9;
                 text-shadow: 1px 1px 2px rgba(0,0,0,0.6);
                 letter-spacing: 0.5px;
             }
             
             /* Porsche Logo Section */
             .porsche-logo-section {
                 text-align: center;
                 margin: 40px 0;
             }
             
             .porsche-logo {
                 height: 110px;
                 width: auto;
                 object-fit: contain;
             }
            
            /* Favorites Section */
                         .favorites-section {
                 padding: 32px 0;
             }
            
                         .favorite-item {
                 background: white;
                 border-radius: 16px;
                 box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                 padding: 24px;
                 margin-bottom: 64px;
                 transition: all 0.3s ease;
             }
            
            
            
                         .favorite-item-header {
                 display: flex;
                 justify-content: space-between;
                 align-items: flex-start;
                 margin-bottom: 16px;
             }
            
            .favorite-item-title {
                flex: 1;
            }
            
                         .favorite-item-actions {
                 display: flex;
                 gap: 10px;
             }
             
             .favorite-item-actions-bottom {
                 display: flex;
                 justify-content: flex-start;
                 margin-top: 20px;
                 width: 100%;
             }
             
             .heart-button {
                 background: none;
                 border: none;
                 padding: 8px;
                 cursor: pointer;
                 transition: all 0.3s ease;
                 border-radius: 50%;
             }
             
             .heart-button:hover {
                 background-color: #f8f9fa;
                 transform: scale(1.1);
             }
             
             .heart-icon {
                 font-size: 1.5rem;
                 color: #dc3545;
                 transition: all 0.3s ease;
             }
             
             .heart-icon.fa-heart-broken {
                 color: #6c757d;
             }
             
            .btn-edit-note {
                background: #17a2b8;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }
            
            .btn-edit-note:hover {
                background: #138496;
                transform: scale(1.05);
            }
            
                         .favorite-item-content {
                 display: flex;
                 gap: 32px;
                 align-items: flex-start;
             }
             
             .car-image-wrapper {
                 flex: 0 0 60%;
                 max-width: 60%;
             }
             
             .favorite-item-image {
                 width: 100%;
                 height: 280px;
                 object-fit: cover;
             }
             
             .favorite-item-details {
                 flex: 0 0 40%;
                 max-width: 40%;
                 padding-left: 20px;
                 position: relative;
             }
             
             .favorite-item-details::before {
                 content: '';
                 position: absolute;
                 left: -16px;
                 top: 0;
                 height: 238px;
                 width: 1px;
                 background: #dee2e6;
             }
            
                         .favorite-item-name {
                 font-size: 1.6rem;
                 font-weight: 500;
                 color: #333;
                 margin-bottom: 12px;
             }
            
                         .favorite-item-price {
                 font-size: 1.9rem;
                 color: #28a745;
                 font-weight: 700;
                 margin-bottom: 16px;
                 position: relative;
                 text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
                 letter-spacing: 1px;
                 background: linear-gradient(135deg, #28a745, #20c997);
                 -webkit-background-clip: text;
                 -webkit-text-fill-color: transparent;
                 background-clip: text;
                 padding: 8px 0;
                 border-bottom: 3px solid #28a745;
                 display: inline-block;
             }
            
                         .favorite-item-specs {
                 display: grid;
                 grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                 gap: 15px;
                 margin-bottom: 20px;
             }
             
             .favorite-item-description {
                 color: #6c757d;
                 font-style: italic;
                 max-height: 120px;
                 overflow-y: auto;
                 padding: 10px;
                 border-radius: 8px;
                 margin-bottom: 15px;
                 line-height: 1.5;
             }
             
             .favorite-item-description::-webkit-scrollbar {
                 width: 6px;
             }
             
             .favorite-item-description::-webkit-scrollbar-track {
                 background: #f1f1f1;
                 border-radius: 3px;
             }
             
             .favorite-item-description::-webkit-scrollbar-thumb {
                 background: #c1c1c1;
                 border-radius: 3px;
             }
             
             .favorite-item-description::-webkit-scrollbar-thumb:hover {
                 background: #a8a8a8;
             }
            
            .spec-item {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #666;
            }
            
            .spec-item i {
                color: #007bff;
                width: 20px;
            }
            
                         
            
            /* Empty State */
            .empty-favorites {
                text-align: center;
                padding: 80px 20px;
                color: #6c757d;
            }
            
            .empty-favorites i {
                font-size: 4rem;
                color: #dee2e6;
                margin-bottom: 20px;
            }
            
            .empty-favorites h3 {
                font-size: 1.8rem;
                margin-bottom: 15px;
                color: #495057;
            }
            
            .empty-favorites p {
                font-size: 1.1rem;
                margin-bottom: 30px;
            }
            
            .btn-browse-products {
                background: #007bff;
                color: white;
                padding: 12px 30px;
                border-radius: 8px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-block;
            }
            
            .btn-browse-products:hover {
                background: #0056b3;
                transform: translateY(-2px);
                color: white;
                text-decoration: none;
            }
            
                         /* Button Styles */
             button {
                 position: relative;
                 display: inline-block;
                 cursor: pointer;
                 outline: none;
                 border: 0;
                 vertical-align: middle;
                 text-decoration: none;
                 background: transparent;
                 padding: 0;
                 font-size: inherit;
                 font-family: inherit;
             }
             
             button.learn-more {
                 width: 12rem;
                 height: auto;
             }
             
             button.learn-more .circle {
                 transition: all 0.45s cubic-bezier(0.65, 0, 0.076, 1);
                 position: relative;
                 display: block;
                 margin: 0;
                 width: 3rem;
                 height: 3rem;
                 background: #282936;
                 border-radius: 1.625rem;
             }
             
             button.learn-more .circle .icon {
                 transition: all 0.45s cubic-bezier(0.65, 0, 0.076, 1);
                 position: absolute;
                 top: 0;
                 bottom: 0;
                 margin: auto;
                 background: #fff;
             }
             
             button.learn-more .circle .icon.arrow {
                 transition: all 0.45s cubic-bezier(0.65, 0, 0.076, 1);
                 left: 0.625rem;
                 width: 1.125rem;
                 height: 0.125rem;
                 background: none;
             }
             
             button.learn-more .circle .icon.arrow::before {
                 position: absolute;
                 content: "";
                 top: -0.29rem;
                 right: 0.0625rem;
                 width: 0.625rem;
                 height: 0.625rem;
                 border-top: 0.125rem solid #fff;
                 border-right: 0.125rem solid #fff;
                 transform: rotate(45deg);
             }
             
             button.learn-more .button-text {
                 transition: all 0.45s cubic-bezier(0.65, 0, 0.076, 1);
                 position: absolute;
                 top: 0;
                 left: 0;
                 right: 0;
                 bottom: 0;
                 padding: 0.75rem 0;
                 margin: 0 0 0 1.85rem;
                 color: #282936;
                 font-weight: 700;
                 line-height: 1.6;
                 text-align: center;
                 text-transform: uppercase;
             }
             
             button:hover .circle {
                 width: 100%;
             }
             
             button:hover .circle .icon.arrow {
                 background: #fff;
                 transform: translate(1rem, 0);
             }
             
                         button:hover .button-text {
                color: #fff;
            }
            
            /* Checkout Button Styles */
            .btn-checkout-now {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                border-radius: 25px;
                padding: 12px 24px;
                color: white;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-left: 15px;
                display: inline-flex;
                align-items: center;
                text-decoration: none;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            }
            
            .btn-checkout-now:hover {
                background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
                color: white;
                text-decoration: none;
            }
            
            .btn-checkout-now:active {
                transform: translateY(0);
            }
            
            .favorite-item-actions-bottom {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-top: 20px;
            }
             

             
                           /* Responsive */
              @media (max-width: 768px) {
                  .page-title {
                      font-size: 2.2rem;
                  }
                  
                  .favorite-item-content {
                      flex-direction: column;
                      text-align: center;
                      gap: 20px;
                  }
                  
                  .car-image-wrapper {
                      flex: 0 0 100%;
                      max-width: 100%;
                  }
                  
                  .favorite-item-image {
                      width: 100%;
                      max-width: 400px;
                      height: 250px;
                  }
                  
                  .favorite-item-details {
                      flex: 0 0 100%;
                      max-width: 100%;
                      padding-left: 0;
                      text-align: center;
                  }
                  
                  .favorite-item-actions {
                      justify-content: center;
                      margin-top: 15px;
                  }
              }
            /* Footer Styles */
            .footer {
                margin-top: 5rem;
                border-top: 1px solid #e9ecef;
            }
            
            .footer-upper {
                background-color: white;
                padding: 3rem 0;
            }
            
            .footer-lower {
                background-color: #2c2c2c;
                padding: 1.5rem 0;
            }
            
            .footer-section-title {
                color: #6c757d;
                font-weight: 400;
                font-size: 1rem;
                margin-bottom: 1.5rem;
            }
            
            .contact-heading {
                color: #333;
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }
            
            .contact-text {
                color: #6c757d;
                margin-bottom: 0.25rem;
                font-size: 0.95rem;
            }
            
            .btn-share {
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 6px;
                font-weight: 500;
                transition: all 0.3s ease;
            }
            
            .btn-share:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .social-section {
                margin-top: 2rem;
            }
            
            .social-icons {
                display: flex;
                gap: 1rem;
                justify-content: flex-end;
            }
            
            .social-icon {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                background-color: #6c757d;
                color: white;
                border-radius: 6px;
                text-decoration: none;
                transition: all 0.3s ease;
            }
            
            .social-icon:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                color: white;
            }
            
            .footer-bottom {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .copyright {
                color: white;
                margin: 0;
                font-size: 0.9rem;
            }
            
            .privacy-policy {
                color: white;
                text-decoration: underline;
                font-size: 0.9rem;
                transition: color 0.3s ease;
            }
            
            .privacy-policy:hover {
                color: #adb5bd;
            }
            
            /* Responsive Footer */
            @media (max-width: 768px) {
                .footer-upper {
                    padding: 2rem 0;
                }
                
                .social-icons {
                    justify-content: center;
                }
                
                .footer-section.text-lg-end {
                    text-align: center !important;
                }
                
                .footer-bottom {
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container d-flex justify-content-between align-items-center">
                <!-- Left side: Logo only -->
                <div class="d-flex align-items-center">
                    <a class="navbar-brand me-4" href="home">
                        <img src="assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                </div>
                
                <!-- Right side: User/Login Section only -->
                <div class="d-flex align-items-center">
                    <!-- User/Login Section -->
                    <div class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <!-- User is logged in - show dropdown -->
                                <div class="dropdown">
                                                                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user me-2"></i>${sessionScope.user.fullName}
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item" href="profile">
                                                <i class="fas fa-user-circle me-2"></i>Profile
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
                            </c:when>
                            <c:otherwise>
                                <!-- User is not logged in - show login button -->
                                <a href="login" class="nav-link">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>

                 <!-- Page Header -->
         <div class="page-header">
             <div class="container">
                 <h1 class="page-title">
                     <i class="fas fa-heart me-3"></i>
                     Porsche Vietnam
                 </h1>
                 <p class="page-subtitle">
                     Bước vào thế giới cuốn hút của Porsche
                 </p>
             </div>
         </div>
         
         <!-- Porsche Logo Section -->
         <div class="porsche-logo-section">
             <div class="container text-center">
                 <img src="assets/icons/porsche.png" alt="Porsche Logo" class="porsche-logo">
             </div>
         </div>

        <!-- Favorites Section -->
        <div class="favorites-section">
            <div class="container">
                <c:choose>
                    <c:when test="${empty userFavorites}">
                        <!-- Empty State -->
                        <div class="empty-favorites">
                            <i class="fas fa-heart-broken"></i>
                            <h3>Chưa có sản phẩm yêu thích nào</h3>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Favorites List -->
                                                 <div class="row">
                             <div class="col-12">
                                 <h2 class="mb-4">
                                     <i class="fas fa-list me-2"></i>
                                     Danh sách sản phẩm yêu thích
                                 </h2>
                             </div>
                         </div>
                         
                         <div style="margin-top: 30px;">
                        
                        <c:forEach var="favorite" items="${userFavorites}">
                            <div class="favorite-item" data-product-id="${favorite.productId}">
                                <div class="favorite-item-header">
                                    <div class="favorite-item-title">
                                        <h3 class="favorite-item-name">${favorite.product.name} ${favorite.product.year}</h3>
                                    </div>
                                    <div class="favorite-item-actions">
                                         <button class="heart-button" onclick="toggleFavorite(${favorite.productId})" title="Xóa khỏi yêu thích">
                                             <i class="fas fa-heart heart-icon" data-product-id="${favorite.productId}"></i>
                                         </button>
                                     </div>
                                </div>
                                
                                                                 <div class="favorite-item-content">
                                     <div class="car-image-wrapper mb-3">
                                         <c:set var="productImage" value=""/>
                                         <c:forEach var="image" items="${listImage}">
                                             <c:if test="${image.productId == favorite.productId}">
                                                 <c:set var="productImage" value="${image.imageSideUrl}"/>
                                             </c:if>
                                         </c:forEach>
                                         <c:choose>
                                             <c:when test="${not empty productImage}">
                                                 <img src="${productImage}" alt="${favorite.product.name}" class="favorite-item-image">
                                             </c:when>
                                             <c:otherwise>
                                                 <img src="/assets/images/${favorite.product.image}" alt="${favorite.product.name}" class="favorite-item-image">
                                             </c:otherwise>
                                         </c:choose>
                                     </div>
                                     
                                     <div class="favorite-item-details">
                                         <div class="favorite-item-price">
                                             <fmt:formatNumber value="${favorite.product.price}" type="number" pattern="#,##0"/> VNĐ
                                         </div>
                                         
                                         <div class="favorite-item-description">
                                             <p>${favorite.product.description}</p>
                                         </div>
                                         
                                                                                 <div class="favorite-item-actions-bottom">
                                            <button class="learn-more" onclick="window.location.href='home?action=detail&id=${favorite.productId}'">
                                                <span class="circle" aria-hidden="true">
                                                    <span class="icon arrow"></span>
                                                </span>
                                                <span class="button-text">Xem chi tiết</span>
                                            </button>
                                            
                                            <button class="btn-checkout-now" onclick="window.location.href='order?action=checkout&productId=${favorite.productId}&quantity=1'">
                                                <i class="fas fa-shopping-cart me-2"></i>
                                                Mua ngay
                                            </button>
                                        </div>
                                     </div>
                                 </div>
                            </div>
                                                 </c:forEach>
                         </div>
                     </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Footer Section -->
        <footer class="footer mt-5">
            <!-- Upper Section - White Background -->
            <div class="footer-upper">
                <div class="container">
                    <div class="row">
                        <!-- Left Column - Contact Information -->
                        <div class="col-lg-6">
                            <div class="footer-section">
                                <h5 class="footer-section-title">Thông tin liên lạc</h5>
                                
                                <div class="contact-group mb-3">
                                    <h6 class="contact-heading">Porsche Việt Nam</h6>
                                    <p class="contact-text">Liên hệ chung: info@porsche-vietnam.com</p>
                                    <p class="contact-text">Dịch vụ Khách hàng: crm@porsche-vietnam.com</p>
                                </div>
                                
                                <div class="contact-group">
                                    <h6 class="contact-heading">Các Trung Tâm Porsche</h6>
                                    <p class="contact-text">Trung Tâm Porsche Sài Gòn</p>
                                    <p class="contact-text">Trung Tâm Porsche Hà Nội</p>
                                    <p class="contact-text">Porsche Studio Hà Nội</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column - Social Media and Share -->
                        <div class="col-lg-6">
                            <div class="footer-section text-lg-end">
                                <!-- Share Page Button -->
                                <div class="mb-4">
                                    <button class="btn btn-share">
                                        <i class="fas fa-share-alt me-2"></i>
                                        Chia sẻ trang
                                    </button>
                                </div>
                                
                                <!-- Social Media Section -->
                                <div class="social-section">
                                    <h5 class="footer-section-title">Kết nối với Porsche</h5>
                                    <div class="social-icons">
                                        <a href="#" class="social-icon" title="Facebook">
                                            <i class="fab fa-facebook-f"></i>
                                        </a>
                                        <a href="#" class="social-icon" title="YouTube">
                                            <i class="fab fa-youtube"></i>
                                        </a>
                                        <a href="#" class="social-icon" title="Instagram">
                                            <i class="fab fa-instagram"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Lower Section - Dark Background -->
            <div class="footer-lower">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="footer-bottom">
                                <p class="copyright">© Porsche Việt Nam 2024</p>
                                <a href="#" class="privacy-policy">Chính sách quyền riêng tư</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Function to open wishlist (redirect to current page)
            function openWishlist() {
        
                window.location.href = '${pageContext.request.contextPath}/favorite?action=list';
            }
            
            // Function to toggle favorite (add/remove)
            function toggleFavorite(productId) {

                
                if (!favoriteItem) {
                    // Try alternative selector
                    favoriteItem = document.querySelector('[data-product-id="' + productId + '"]');
                    console.log('Selector 2 result:', favoriteItem);
                }
                
                if (!favoriteItem) {
                    // Try finding by the heart button's parent
                    const heartButton = document.querySelector('.heart-button[onclick*="' + productId + '"]');
                    console.log('Heart button found:', heartButton);
                    if (heartButton) {
                        favoriteItem = heartButton.closest('.favorite-item');
                        console.log('Found by heart button parent:', favoriteItem);
                    }
                }
                
                // Try to find by onclick attribute content
                if (!favoriteItem) {
                    const buttons = document.querySelectorAll('.heart-button');
                    buttons.forEach((btn, index) => {
                        const onclick = btn.getAttribute('onclick');
                        console.log('Button ' + index + ' onclick:', onclick);
                        if (onclick && onclick.includes(productId.toString())) {
                            favoriteItem = btn.closest('.favorite-item');
                            console.log('Found by button onclick content:', favoriteItem);
                        }
                    });
                }
                
                console.log('Final favorite item found:', favoriteItem);
                console.log('=== DEBUG END ===');
                
                if (!favoriteItem) {
                    console.error('Could not find favorite item with ID:', productId);
                    alert('Không thể tìm thấy sản phẩm để xóa! Vui lòng kiểm tra console để debug.');
                    return;
                }
                
                // Remove from favorites
                if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích?')) {
                    console.log('User confirmed deletion, removing item immediately');
                    
                    // Remove the item from the page immediately
                    favoriteItem.remove();
                    console.log('Item removed from DOM successfully');
                    
                    fetch('${pageContext.request.contextPath}/favorite?action=remove', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'action=remove&productId=' + productId
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log('API response:', data);
                        if (data.success) {
                            // Update wishlist count
                            updateWishlistCount(data.count);
                            
                            // Show success message
                            alert('Đã xóa khỏi yêu thích thành công!');
                            
                            // Check if no more favorites and update the page accordingly
                            if (data.count === 0) {
                                // Update the page to show empty state without reloading
                                const favoritesSection = document.querySelector('.favorites-section .container');
                                favoritesSection.innerHTML = `
                                    <div class="empty-favorites">
                                        <i class="fas fa-heart-broken"></i>
                                        <h3>Chưa có sản phẩm yêu thích nào</h3>
                                        <p>Bạn chưa thêm chiếc xe nào vào danh sách yêu thích. Hãy khám phá các dòng xe và thêm vào yêu thích!</p>
                                        <a href="home" class="btn-browse-products">
                                            <i class="fas fa-car me-2"></i>
                                            Khám phá xe
                                        </a>
                                    </div>
                                `;
                            }
                        } else {
                            alert('Không thể xóa khỏi yêu thích: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi xóa khỏi yêu thích');
                    });
                }
            }
            
            // Function to update wishlist count
            function updateWishlistCount(count) {
                const wishlistCount = document.querySelector('.wishlist-count');
                if (wishlistCount) {
                    wishlistCount.textContent = count;
                    wishlistCount.style.display = count > 0 ? 'flex' : 'none';
                }
            }
            
            // Footer functionality
            function sharePage() {
                if (navigator.share) {
                    navigator.share({
                        title: 'K - Auto - Porsche Việt Nam',
                        text: 'Khám phá những chiếc xe thể thao hàng đầu thế giới',
                        url: window.location.href
                    });
                } else {
                    // Fallback for browsers that don't support Web Share API
                    const url = window.location.href;
                    const text = 'K - Auto - Porsche Việt Nam';
                    
                    // Copy to clipboard
                    navigator.clipboard.writeText(text + '\n' + url).then(() => {
                        alert('Đã sao chép link vào clipboard!');
                    }).catch(() => {
                        // Fallback: show share dialog
                        prompt('Chia sẻ trang này:', url);
                    });
                }
            }
            
            // Initialize footer functionality
            document.addEventListener('DOMContentLoaded', function() {
                // Add click event to share button
                const shareBtn = document.querySelector('.btn-share');
                if (shareBtn) {
                    shareBtn.addEventListener('click', sharePage);
                }
                
                // Add click events to social media icons
                const socialIcons = document.querySelectorAll('.social-icon');
                socialIcons.forEach(icon => {
                    icon.addEventListener('click', function(e) {
                        e.preventDefault();
                        const platform = this.title.toLowerCase();
                        const url = window.location.href;
                        const text = 'K - Auto - Porsche Việt Nam';
                        
                        let shareUrl = '';
                        switch(platform) {
                            case 'facebook':
                                shareUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url);
                                break;
                            case 'youtube':
                                // YouTube doesn't have direct share, redirect to channel
                                shareUrl = 'https://www.youtube.com/@porsche';
                                break;
                            case 'instagram':
                                // Instagram doesn't have direct share, redirect to profile
                                shareUrl = 'https://www.instagram.com/porsche/';
                                break;
                        }
                        
                        if (shareUrl) {
                            window.open(shareUrl, '_blank', 'width=600,height=400');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
