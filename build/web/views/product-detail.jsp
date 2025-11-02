<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${product.name} - K - Auto</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            /* User dropdown hover styling */
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
            
            .dropdown .dropdown-item:hover {
                background-color: transparent;
                transform: none;
            }
            
            .dropdown .dropdown-item.text-danger:hover {
                background-color: #fee;
                color: #dc3545 !important;
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
            
            .dropdown .dropdown-menu {
                margin-top: 0;
                opacity: 0;
                transform: translateY(-10px);
                visibility: hidden;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: block !important;
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
                cursor: pointer;
            }
            
            /* Notification Styles */
            .notification {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
                min-width: 300px;
                max-width: 400px;
                border-radius: 20px;
                border: none;
                padding: 1rem 1.5rem;
                box-shadow: 
                    3px 3px 6px rgba(160, 160, 160, 0.5),
                    -3px -3px 6px rgba(255, 255, 255, 0.9),
                    3px -3px 6px rgba(160, 160, 160, 0.3),
                    -3px 3px 6px rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                animation: slideInRight 0.5s ease-out;
            }
            
            .notification-success {
                background: rgba(144, 238, 144, 0.9);
                color: #2d3748;
                border: 2px solid rgba(144, 238, 144, 0.4);
            }
            
            .notification-error {
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
            
                                                   /* Favorite Button Styles */
              #favoriteBtn {
                  transition: all 0.3s ease;
                  background: none !important;
                  border: none !important;
                  box-shadow: none !important;
              }
              
              #favoriteBtn:hover {
                  transform: scale(1.1);
              }
              
              #favoriteBtn:active {
                  transform: scale(0.95);
              }
              
              #favoriteBtn.btn-danger {
                  background: none !important;
                  border: none !important;
                  box-shadow: none !important;
              }
              
              #favoriteBtn.btn-outline-secondary {
                  background: none !important;
                  border: none !important;
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
            
            .wishlist-btn.has-items img {
                filter: brightness(1);
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
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }
            
            /* Navbar spacing */
            .navbar .container {
                padding: 0 20px;
            }
            
            .navbar-brand {
                margin-right: 0 !important;
            }
            
            .navbar-nav .nav-link {
                margin: 0;
            }
            

            
            .hero-section {
                background: linear-gradient(135deg, #1a1a1a 0%, #333 100%);
                color: white;
                padding: 0;
            }
            .banner-image-container {
                position: relative;
                width: 100%;
                height: 100vh;
                overflow: hidden;
            }
            .banner-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                filter: brightness(0.8);
            }
            .banner-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.2) 50%, rgba(0,0,0,0.6) 100%);
                display: flex;
                align-items: flex-end;
                justify-content: flex-start;
                padding: 0;
            }

            .car-image {
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.3);
                transition: transform 0.3s ease;
                max-height: 600px !important;
                width: 100%;
                object-fit: cover;
                object-position: center;
                display: block;
                margin: 0 auto;
            }
            .car-image:hover {
                transform: scale(1.02);
            }
            .spec-card {
                background: linear-gradient(145deg, #f8f9fa, #e9ecef);
                border: none;
                border-radius: 15px;
                transition: all 0.3s ease;
            }
            .spec-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }
            .price-tag {
                background: linear-gradient(45deg, #dc3545, #c82333);
                color: white;
                padding: 15px 25px;
                border-radius: 25px;
                font-size: 1.5rem;
                font-weight: bold;
                box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            }
            .back-button {
                border-radius: 25px;
                padding: 12px 30px;
                font-weight: 600;
            }
            .back-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            }
            .spec-table {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            }
            .spec-table th {
                background: linear-gradient(45deg, #007bff, #0056b3);
                color: white;
                border: none;
                padding: 15px;
            }
            .spec-table td {
                padding: 15px;
                border: 1px solid #dee2e6;
            }
            .image-container {
                position: relative;
                overflow: hidden;
                border-radius: 20px;
                box-shadow: 0 25px 50px rgba(0,0,0,0.4);
                background: linear-gradient(145deg, #f8f9fa, #e9ecef);
                padding: 20px;
                margin: 20px 0;
            }
            
            /* New Specifications Layout Styles */
            .specs-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 15px 40px rgba(0,0,0,0.1);
                padding: 40px;
                margin: 20px 0;
                width: 100%;
            }
            
                         /* Car Side Section */
             .car-side-section {
                 text-align: center;
                 width: 100%;
                 height: 100%;
                 display: flex;
                 align-items: center;
                 justify-content: center;
             }
             
             
            
            .car-side-image-container {
                margin-bottom: 30px;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .car-side-image {
                width: 100%;
                max-width: 600px;
                height: auto;
                border-radius: 15px;
                object-fit: contain;
                display: block;
                margin: 0 auto;
                max-height: 550px;
                min-height: 350px;
            }
            
            /* Car Dimensions */
            .car-dimensions {
                background: linear-gradient(145deg, #f8f9fa, #e9ecef);
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            }
            
            .dimension-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid rgba(0,0,0,0.1);
            }
            
            .dimension-item:last-child {
                border-bottom: none;
            }
            
            .dimension-label {
                font-weight: 600;
                color: #333;
                font-size: 1rem;
            }
            
            .dimension-value {
                font-weight: 700;
                color: #007bff;
                font-size: 1.1rem;
            }
            
            /* Specifications Table - Placeholder for Enhanced Version Below */
            
            /* Responsive Design */
            @media (max-width: 991px) {
                .specs-container {
                    padding: 25px;
                }
                
                .car-side-image {
                    max-width: 100%;
                }
                
                .specs-table-container {
                    padding-left: 0;
                    margin-top: 30px;
                }
                
                /* spec-row defined in main CSS */
                
                /* spec-value defined in main CSS */
                
                .car-info-card {
                    margin-top: 15px;
                    padding: 15px;
                }
                
                /* specs-title defined in main CSS */
            }
            
            @media (max-width: 768px) {
                .specs-container {
                    padding: 20px;
                }
                
                /* specs-table defined in main CSS */
                
                /* spec-row defined in main CSS */
                
                .title-underline {
                    width: 60px;
                    height: 3px;
                }
                
                .car-info-card h5 {
                    font-size: 1.1rem;
                }
            }
            
            /* Banner Content Styles */
            .banner-content {
                text-align: left;
                color: white;
                z-index: 2;
                padding: 18px 25px;
                background: rgba(0,0,0,0.18);
                border-radius: 12px;
                border: 1px solid rgba(255,255,255,0.08);
                margin: 0 0 18px 18px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.15);
            }
            
            .banner-content h1 {
                font-size: 2.6rem;
                font-weight: 500;
                margin-bottom: 12px;
                text-shadow: 0 2px 8px rgba(0,0,0,0.6);
                letter-spacing: -0.5px;
            }
            
            .banner-content p {
                font-size: 1.5rem;
                margin: 0;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
                font-weight: 400;
            }
            
            .banner-content .price-tag {
                background: linear-gradient(135deg, #dc3545, #c82333);
                color: white;
                padding: 10px 20px;
                border-radius: 20px;
                font-size: 1.3rem;
                font-weight: 500;
                box-shadow: 0 8px 20px rgba(220,53,69,0.3);
                border: none;
                text-shadow: none;
                margin-bottom: 0;
                transition: all 0.3s ease;
            }
             
             .banner-content .price-tag:hover {
                 box-shadow: 0 0 30px rgba(220,53,69,0.6);
             }
            
                         /* Responsive Banner Content */
             @media (max-width: 768px) {
                 .banner-content {
                     padding: 15px 20px;
                     margin: 0 0 15px 15px;
                 }
                 
                 .banner-content h1 {
                     font-size: 2.2rem;
                     letter-spacing: -0.3px;
                 }
                 
                 .banner-content p {
                     font-size: 1rem;
                 }
                 
                 .banner-content .price-tag {
                     font-size: 1.1rem;
                     padding: 8px 16px;
                 }
             }
             
             /* No Images Placeholder */
             .no-images-placeholder {
                 padding: 60px 20px;
                 background: linear-gradient(145deg, #f8f9fa, #e9ecef);
                 border-radius: 20px;
                 border: 2px dashed #dee2e6;
             }
             
             .no-images-placeholder i {
                 color: #adb5bd;
             }
             
             /* Title Underline */
             .title-underline {
                 width: 80px;
                 height: 4px;
                 background: linear-gradient(45deg, #007bff, #0056b3);
                 border-radius: 2px;
                 margin-top: 15px;
             }
             
             /* Car Info Card */
             .car-info-card {
                 background: linear-gradient(145deg, #ffffff, #f8f9fa);
                 border-radius: 15px;
                 padding: 20px;
                 box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                 margin-top: 20px;
                 border: 1px solid rgba(0,0,0,0.05);
             }
             
             .car-info-card h5 {
                 color: #333;
                 font-weight: 600;
                 margin-bottom: 15px;
             }
             
             .info-item {
                 display: flex;
                 justify-content: space-between;
                 align-items: center;
                 padding: 8px 0;
                 border-bottom: 1px solid rgba(0,0,0,0.1);
             }
             
             .info-item:last-child {
                 border-bottom: none;
             }
             
             .info-label {
                 font-weight: 500;
                 color: #666;
                 font-size: 0.9rem;
             }
             
             .info-value {
                 font-weight: 600;
                 color: #007bff;
                 font-size: 0.9rem;
             }
             
             /* Enhanced Specs Table */
             .specs-table {
                 background: linear-gradient(145deg, #ffffff, #f8f9fa);
                 border-radius: 15px;
                 padding: 30px;
                 box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                 border: 1px solid rgba(0,0,0,0.05);
                 max-width: 100%;
                 width: 100%;
                 min-width: auto;
             }
             
             .spec-row {
                 display: flex;
                 justify-content: space-between;
                 align-items: flex-start;
                 padding: 10px 0;
                 border-bottom: 1px solid rgba(0,0,0,0.08);
                 position: relative;
                 gap: 15px;
                 flex-wrap: nowrap;
                 min-height: auto;
             }
             
             .spec-row:last-child {
                 border-bottom: none;
             }
             
             .spec-row.highlight {
                 background: linear-gradient(135deg, #fff3cd, #ffeaa7);
                 border-radius: 12px;
                 padding: 15px 20px;
                 margin: 8px 0;
                 border: 2px solid #ffc107;
                 box-shadow: 0 8px 25px rgba(255,193,7,0.3);
             }
             
             .spec-label {
                 font-weight: 600;
                 color: #333;
                 font-size: 0.9rem;
                 display: inline-block;
                 width: auto;
                 margin-bottom: 0;
                 flex-shrink: 0;
                 white-space: nowrap;
             }
             
             .spec-value {
                 font-weight: 700;
                 color: #007bff;
                 font-size: 0.9rem;
                 text-align: right;
                 max-width: 400px;
                 width: auto;
                 margin-bottom: 0;
                 word-wrap: break-word;
                 white-space: normal;
                 line-height: 1.3;
                 flex-shrink: 0;
                 min-width: 0;
             }
             
             .price-highlight {
                 color: #dc3545 !important;
                 font-size: 1.3rem;
                 text-shadow: 0 1px 2px rgba(220,53,69,0.3);
             }
             
             /* Enhanced Specs Title */
             .specs-title {
                 font-size: 1.5rem;
                 font-weight: 700;
                 color: #333;
                 margin-bottom: 30px;
                 text-align: center;
                 border-bottom: 3px solid #007bff;
                 padding-bottom: 15px;
                 position: relative;
             }
             
             .specs-title::after {
                 content: '';
                 position: absolute;
                 bottom: -3px;
                 left: 50%;
                 transform: translateX(-50%);
                 width: 60px;
                 height: 3px;
                 background: linear-gradient(45deg, #ffc107, #ff8c00);
                 border-radius: 2px;
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
        <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <a class="navbar-brand" href="home">
                        <img src="assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                    
                    <div class="d-flex align-items-center">
                        <!-- Login button -->
                        <div class="navbar-nav">
                            <div class="nav-item">
                                <c:choose>
                                    <c:when test="${sessionScope.user != null}">
                                        <!-- User is logged in - show dropdown -->
                                        <div class="dropdown">
                                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-user me-2"></i>${sessionScope.userName}
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
                        
                        <!-- Wishlist Button -->
                        <a class="wishlist-btn ms-4" href="${pageContext.request.contextPath}/favorite?action=list" title="Sản phẩm yêu thích">
                            <img src="assets/icons/heart.png" alt="Wishlist">
                            <span class="wishlist-count">${sessionScope.favoriteCount != null ? sessionScope.favoriteCount : 0}</span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <c:if test="${not empty product}">
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="banner-image-container">
                    <img src="${product.image}" alt="${product.name}" 
                         class="banner-image">
                    <div class="banner-overlay">
                        <div class="banner-content">
                            <h1 class="display-3 fw-bold mb-4 text-white">${product.name}</h1>
                            <div class="price-tag d-inline-block">
                                <i class="fas fa-tag me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty product.price}">
                                        <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ
                                    </c:when>
                                    <c:otherwise>
                                        Liên hệ để biết giá
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Thông số kỹ thuật -->
            <section class="py-5 bg-light">
                <div class="container">
                    <div class="row mb-5">
                        <div class="col-12 text-center">
                            <h2 class="h3 fw-bold text-dark mb-3">
                                Thông số kỹ thuật
                            </h2>
                            <p class="text-muted small">Khám phá sức mạnh thực sự của ${product.name}</p>
                            <div class="title-underline mx-auto"></div>
                        </div>
                    </div>

                    <!-- Layout 2 cột: Ảnh bên hông + Thông số kỹ thuật -->
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="specs-container">
                                <div class="row align-items-center">
                                                                         <!-- Cột trái: Ảnh xe bên hông -->
                                     <div class="col-lg-7">
                                         <div class="car-side-section">
                                             <div class="car-side-image-container position-relative">
                                                 <c:if test="${not empty listImage}">
                                                     <c:forEach var="image" items="${listImage}">
                                                         <c:if test="${image.productId == product.id}">
                                                             <img src="${image.imageSideUrl}" alt="${product.name}" class="car-side-image">
                                                         </c:if>
                                                     </c:forEach>
                                                 </c:if>
                                                 <c:if test="${empty listImage}">
                                                     <div class="text-center text-muted">
                                                         <i class="fas fa-image fa-3x mb-2"></i>
                                                         <p>Chưa có ảnh bên hông</p>
                                                     </div>
                                                 </c:if>
                                                 
                                                                                                   <!-- Nút yêu thích ở vị trí top-right -->
                                                  <c:if test="${sessionScope.user != null}">
                                                      <button id="favoriteBtn" class="btn btn-link p-0" 
                                                              onclick="toggleFavorite('${product.id}')" 
                                                              style="position: absolute; top: -10px; right: 15px; z-index: 10; border: none; background: none; transition: all 0.3s ease;">
                                                          <i id="favoriteIcon" class="far fa-heart" style="font-size: 2rem; color: #6c757d;"></i>
                                                      </button>
                                                  </c:if>
                                             </div>
                                         </div>
                                     </div>

                                    <!-- Cột phải: Bảng thông số kỹ thuật -->
                                    <div class="col-lg-5">
                                        <div class="specs-table-container">
                                            <div class="specs-table">
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Công suất
                                                    </div>
                                                    <div class="spec-value">${product.horsepower} PS</div>
                                                </div>
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Mô-men xoắn cực đại
                                                    </div>
                                                    <div class="spec-value">${product.torque} Nm</div>
                                                </div>
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Tăng tốc 0 - 100 km/h
                                                    </div>
                                                    <div class="spec-value">4,9 giây (4,7 giây với Gói Sport Chrono)</div>
                                                </div>
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Tốc độ tối đa
                                                    </div>
                                                    <div class="spec-value">${product.topSpeed} km/h</div>
                                                </div>
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Động cơ
                                                    </div>
                                                    <div class="spec-value">${product.engine}</div>
                                                </div>
                                                <div class="spec-row">
                                                    <div class="spec-label">
                                                        Năm sản xuất
                                                    </div>
                                                    <div class="spec-value">${product.year}</div>
                                                </div>
                                                <div class="spec-row highlight">
                                                    <div class="spec-label">
                                                        Giá tiêu chuẩn
                                                    </div>
                                                    <div class="spec-value price-highlight">
                                                        <c:choose>
                                                            <c:when test="${not empty product.price}">
                                                                <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*
                                                            </c:when>
                                                            <c:otherwise>
                                                                Liên hệ để biết giá
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                                         <!-- Nút Thêm vào yêu thích cho người chưa đăng nhập -->
                     <div class="row mt-4">
                         <div class="col-lg-8 mx-auto text-center">
                             <c:if test="${sessionScope.user == null}">
                                 <a href="login" class="btn btn-outline-primary btn-lg px-5 py-3" 
                                    style="border-radius: 25px; transition: all 0.3s ease;">
                                     <i class="fas fa-sign-in-alt me-2"></i>
                                     Đăng nhập để thêm vào yêu thích
                                 </a>
                             </c:if>
                         </div>
                     </div>

                    <!-- Thông báo về giá -->
                    <div class="row mt-4">
                        <div class="col-lg-8 mx-auto">
                            <div class="alert alert-info text-center border-0" style="background: linear-gradient(45deg, #e3f2fd, #bbdefb);">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Lưu ý:</strong> Giá tiêu chuẩn bao gồm thuế nhập khẩu, thuế tiêu thụ đặc biệt và thuế giá trị gia tăng. 
                                Bảng giá và thông số kỹ thuật có thể thay đổi theo từng thời điểm mà không báo trước.
                            </div>
                        </div>
                    </div>
                </div>
            </section>

             <!-- Mô tả chi tiết -->
            <section class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="card border-0 shadow">
                                <div class="card-body p-5">
                                    <h3 class="text-center mb-4">
                                        <i class="fas fa-info-circle text-primary"></i> Mô tả chi tiết
                                    </h3>
                                    <p class="lead text-muted text-center mb-4">${product.description}</p>
                                    
                                    <div class="text-center">
                                        <p class="text-muted">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <br>
                                            <small>Đánh giá 5 sao từ khách hàng</small>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </c:if>

        <c:if test="${empty product}">
            <!-- Thông báo không tìm thấy xe -->
            <div class="container mt-5 pt-5">
                <div class="row justify-content-center">
                    <div class="col-lg-6 text-center">
                        <i class="fas fa-exclamation-triangle fa-5x text-warning mb-4"></i>
                        <h2 class="text-warning mb-3">Không tìm thấy xe</h2>
                        <p class="lead text-muted mb-4">Vui lòng kiểm tra lại ID xe</p>

                    </div>
                </div>
            </div>
        </c:if>

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
        
        <!-- Custom Dropdown Hover Script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const dropdown = document.querySelector('.dropdown');
                const dropdownMenu = document.querySelector('.dropdown .dropdown-menu');
                let timeoutId;
                
                if (dropdown && dropdownMenu) {
                    // Show dropdown on hover with smooth animation
                    dropdown.addEventListener('mouseenter', function() {
                        clearTimeout(timeoutId);
                        dropdownMenu.style.display = 'block';
                        
                        // Trigger reflow for smooth animation
                        dropdownMenu.offsetHeight;
                        
                        // Animate in
                        dropdownMenu.style.opacity = '1';
                        dropdownMenu.style.transform = 'translateY(0)';
                        dropdownMenu.style.visibility = 'visible';
                    });
                    
                    // Hide dropdown when mouse leaves with smooth animation
                    dropdown.addEventListener('mouseleave', function() {
                        // Animate out
                        dropdownMenu.style.opacity = '0';
                        dropdownMenu.style.transform = 'translateY(-10px)';
                        dropdownMenu.style.visibility = 'hidden';
                        
                        timeoutId = setTimeout(function() {
                            dropdownMenu.style.display = 'none';
                        }, 300); // Match transition duration
                    });
                    
                    // Also handle mouseleave on the dropdown menu itself
                    dropdownMenu.addEventListener('mouseleave', function() {
                        // Animate out
                        dropdownMenu.style.opacity = '0';
                        dropdownMenu.style.transform = 'translateY(-10px)';
                        dropdownMenu.style.visibility = 'hidden';
                        
                        timeoutId = setTimeout(function() {
                            dropdownMenu.style.display = 'none';
                        }, 300);
                    });
                }
                
                // Check favorite status when page loads
                checkFavoriteStatus();
                
                // Update navbar wishlist button state
                updateNavbarWishlistState();
            });
            
            // Function to check if product is in favorites
            function checkFavoriteStatus() {
                const productId = '${product.id}';
                
                fetch('${pageContext.request.contextPath}/favorite?action=check&productId=' + productId)
                    .then(response => response.json())
                    .then(data => {
                        if (data.isFavorite) {
                            // Product is already in favorites
                            updateFavoriteButton(true);
                        } else {
                            // Product is not in favorites
                            updateFavoriteButton(false);
                        }
                    })
                    .catch(error => {
                        console.error('Error checking favorite status:', error);
                    });
            }
            
            // Function to update favorite button appearance
            function updateFavoriteButton(isFavorite) {
                const favoriteBtn = document.getElementById('favoriteBtn');
                const favoriteIcon = document.getElementById('favoriteIcon');
                
                if (isFavorite) {
                    favoriteBtn.classList.remove('btn-outline-secondary');
                    favoriteBtn.classList.add('btn-danger');
                    favoriteIcon.classList.remove('far');
                    favoriteIcon.classList.add('fas');
                    favoriteIcon.style.color = '#dc3545';
                } else {
                    favoriteBtn.classList.remove('btn-danger');
                    favoriteBtn.classList.add('btn-outline-secondary');
                    favoriteIcon.classList.remove('fas');
                    favoriteIcon.classList.add('far');
                    favoriteIcon.style.color = '#6c757d';
                }
            }
            
            // Function to toggle favorite status
            function toggleFavorite(productId) {
                const favoriteBtn = document.getElementById('favoriteBtn');
                const favoriteIcon = document.getElementById('favoriteIcon');
                const favoriteText = document.getElementById('favoriteText');
                
                // Check if currently favorite
                const isCurrentlyFavorite = favoriteBtn.classList.contains('btn-danger');
                
                if (isCurrentlyFavorite) {
                    // Remove from favorites
                    removeFromFavorites(productId);
                } else {
                    // Add to favorites
                    addToFavorites(productId);
                }
            }
            
                         // Function to add product to favorites
             function addToFavorites(productId) {
                 fetch('${pageContext.request.contextPath}/favorite?action=add', {
                     method: 'POST',
                     headers: {
                         'Content-Type': 'application/x-www-form-urlencoded',
                     },
                     body: 'action=add&productId=' + productId + '&note='
                 })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Update button appearance
                        updateFavoriteButton(true);
                        
                        // Show success message
                        showMessage('Đã thêm vào yêu thích thành công!', 'success');
                        
                        // Update wishlist count if available
                        if (typeof updateWishlistCount === 'function') {
                            updateWishlistCount(data.count);
                        }
                    } else {
                        showMessage('Không thể thêm vào yêu thích: ' + data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showMessage('Có lỗi xảy ra khi thêm vào yêu thích', 'error');
                });
            }
            
             // Function to remove product from favorites
             function removeFromFavorites(productId) {
                 fetch('${pageContext.request.contextPath}/favorite?action=remove', {
                     method: 'POST',
                     headers: {
                         'Content-Type': 'application/x-www-form-urlencoded',
                     },
                     body: 'action=remove&productId=' + productId
                 })
                 .then(response => response.json())
                 .then(data => {
                     if (data.success) {
                         // Update button appearance
                         updateFavoriteButton(false);
                         
                         // Show removal message with error type for red color
                         showMessage('Đã xóa khỏi yêu thích thành công!', 'error');
                         
                         // Update wishlist count if available
                         if (typeof updateWishlistCount === 'function') {
                             updateWishlistCount(data.count);
                         }
                     } else {
                         showMessage('Không thể xóa khỏi yêu thích: ' + data.message, 'error');
                     }
                 })
                 .catch(error => {
                     console.error('Error:', error);
                     showMessage('Có lỗi xảy ra khi xóa khỏi yêu thích', 'error');
                 });
             }
            
                         // Function to show messages
             function showMessage(message, type) {
                 // Remove existing notifications first
                 const existingNotifications = document.querySelectorAll('.notification');
                 existingNotifications.forEach(notification => {
                     notification.remove();
                 });
                 
                 // Create message element
                 const messageDiv = document.createElement('div');
                 messageDiv.className = 'notification notification-' + (type === 'success' ? 'success' : 'error');
                 messageDiv.innerHTML = 
                     '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-triangle') + ' me-2"></i>' +
                     message +
                     '<button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer; color: #6c757d;"></button>';
                 
                 // Add to page
                 document.body.appendChild(messageDiv);
                 
                 // Auto remove after 5 seconds
                 setTimeout(() => {
                     if (messageDiv.parentNode) {
                         messageDiv.remove();
                     }
                 }, 5000);
             }
            
            // Function to update wishlist count in navbar
            function updateWishlistCount(count) {
                const wishlistCount = document.querySelector('.wishlist-count');
                if (wishlistCount) {
                    wishlistCount.textContent = count;
                    
                    // Add animation class if count > 0
                    const wishlistBtn = document.querySelector('.wishlist-btn');
                    if (count > 0) {
                        wishlistBtn.classList.add('has-items');
                    } else {
                        wishlistBtn.classList.remove('has-items');
                    }
                }
            }
            
            // Function to update navbar wishlist button state
            function updateNavbarWishlistState() {
                const favoriteCount = parseInt('${sessionScope.favoriteCount != null ? sessionScope.favoriteCount : 0}');
                const wishlistBtn = document.querySelector('.wishlist-btn');
                const wishlistCount = document.querySelector('.wishlist-count');
                
                if (wishlistCount) {
                    wishlistCount.textContent = favoriteCount;
                }
                
                if (wishlistBtn && favoriteCount > 0) {
                    wishlistBtn.classList.add('has-items');
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
