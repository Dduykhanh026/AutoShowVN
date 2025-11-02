<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>K - Auto </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            /* Body padding for fixed navbar */
            body {
                padding-top: 80px;
            }
            
            /* Navbar Styles */
            .navbar {
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                background-color: white !important;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                transition: all 0.3s ease;
            }
            
            .navbar.scrolled {
                background-color: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            }
            
            /* Navbar spacing */
            .navbar .container {
                padding: 0 20px;
            }
            
            .navbar-brand {
                margin-right: 0 !important;
            }
            

            
            /* Test button styles */
            .btn-outline-secondary {
                border-color: #6c757d;
                color: #6c757d;
                background-color: transparent;
            }
            
            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: white;
            }
            

            
            .navbar-nav .nav-link {
                margin: 0;
                display: flex;
                align-items: center;
                height: 100%;
                min-height: 48px;
            }
            
            .wishlist-btn {
                margin: 0;
            }
            
            .navbar-nav {
                height: 100%;
                display: flex;
                align-items: center;
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
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                height: 100%;
                min-height: 48px;
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
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }
            
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
            
            .mega-dropdown {
                width: 350px;
                padding: 0;
                border: none;
                border-radius: 8px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                margin-top: 10px;
            }
            
            .dropdown-item {
                padding: 15px 20px;
                border-bottom: 1px solid #f0f0f0;
                transition: all 0.3s ease;
                display: block;
                width: 100%;
            }
            
            .dropdown-item:last-child {
                border-bottom: none;
            }
            

            
            .car-model-name {
                font-weight: 400;
                font-size: 1.1rem;
                color: #333;
                min-width: 80px;
            }
            
            .car-thumbnail {
                width: 110px;
                height: 60px;
                object-fit: cover;
                border-radius: 6px;
                margin: 0 15px;
            }
            
            .dropdown-item i {
                color: #666;
                font-size: 0.9rem;
            }
            
            /* Product Section Styles */
            .product-version-section {
                background: transparent;
                padding: 2rem;
                margin-bottom: 2rem;
                border-radius: 0;
                box-shadow: none;
            }












            
            .version-header {
                margin-bottom: 2rem;
            }
            
            .version-title {
                color: #333;
                font-weight: 400;
                margin: 0;
                font-size: 1.8rem;
                display: flex;
                align-items: center;
            }
            
            .version-title i {
                color: #333;
                font-size: 1.2rem;
            }
            
            .car-item {
                padding: 2rem;
                background: white;
                border-radius: 16px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                height: 100%;
                width: 100%;
                max-width: 100%;
                margin: 0 auto;
            }
            
            /* Tăng width của mỗi sản phẩm */
            .col-lg-3 .car-item {
                min-width: 320px;
                margin: 0 10px;
            }
            
            .car-item:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 35px rgba(0,0,0,0.2);
            }
            
            .car-image-wrapper {
                position: relative;
                margin-bottom: 2rem;
            }
            
            .car-image {
                width: 100%;
                height: auto;
                max-height: 380px;
                object-fit: cover;
                object-position: center;
                filter: drop-shadow(0 6px 12px rgba(0,0,0,0.15));
                transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                cursor: pointer;
            }
            
            .car-image:hover {
                transform: scale(1.25);
                filter: drop-shadow(0 15px 30px rgba(0,0,0,0.3));
                z-index: 10;
            }
            
            .car-name {
                color: #333;
                font-weight: 400;
                font-size: 1.4rem;
                margin: 1.5rem 0 1rem 0;
            }
            
            .car-price {
                color: #333;
                font-size: 0.95rem;
                line-height: 1.4;
                margin-bottom: 25px;
            }
            
            .car-price .price-amount {
                color: #dc3545;
                font-weight: 600;
            }
            
            .action-buttons {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 10px;
                flex-wrap: wrap;
            }
            
            .btn-discover-link {
                align-items: center;
                appearance: none;
                background-image: radial-gradient(100% 100% at 100% 0, #ffffff 0, #f8f9fa 100%);
                border: 1px solid #e9ecef;
                border-radius: 10px;
                box-shadow: rgba(0, 0, 0, 0.1) 0 3px 6px, rgba(0, 0, 0, 0.08) 0 8px 16px -3px, rgba(255, 255, 255, 0.8) 0 -3px 0 inset;
                box-sizing: border-box;
                color: #333;
                cursor: pointer;
                display: inline-flex;
                font-family: inherit;
                height: 64px;
                justify-content: center;
                line-height: 1;
                list-style: none;
                overflow: hidden;
                padding-left: 24px;
                padding-right: 24px;
                position: relative;
                text-align: center;
                text-decoration: none;
                transition: box-shadow .15s, transform .15s;
                user-select: none;
                -webkit-user-select: none;
                touch-action: manipulation;
                white-space: nowrap;
                will-change: box-shadow, transform;
                font-size: 20px;
                font-weight: 600;
                width: 100%;
                max-width: 100%;
            }
            
            .btn-discover-link:focus {
                box-shadow: #6c757d 0 0 0 1.5px inset, rgba(0, 0, 0, 0.1) 0 2px 4px, rgba(0, 0, 0, 0.08) 0 7px 13px -3px, rgba(255, 255, 255, 0.8) 0 -3px 0 inset;
            }
            
            .btn-discover-link:hover {
                box-shadow: rgba(0, 0, 0, 0.15) 0 4px 8px, rgba(0, 0, 0, 0.1) 0 7px 13px -3px, rgba(255, 255, 255, 0.9) 0 -3px 0 inset;
                transform: translateY(-2px);
            }
            
            .btn-discover-link:active {
                box-shadow: #6c757d 0 3px 7px inset;
                transform: translateY(2px);
            }
            
            .btn-discover-link i {
                font-size: 14px;
                margin-right: 8px;
            }
            
            .btn-primary {
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(0,123,255,0.3);
            }
            
            /* Porsche Logo Styles */
            .porsche-logo {
                max-width: 200px;
                height: auto;
                margin-bottom: 20px;
                filter: drop-shadow(0 4px 8px rgba(0,0,0,0.1));
                transition: all 0.3s ease;
            }
            
            .porsche-logo:hover {
                transform: scale(1.05);
                filter: drop-shadow(0 6px 12px rgba(0,0,0,0.2));
            }
            
            /* Banner Section Styles */
            .banner-section {
                width: 100%;
                height: 700px;
                position: relative;
                overflow: hidden;
                margin-bottom: 30px;
                background: #000;
            }
            
            .banner-container {
                position: relative;
                width: 100%;
                height: 100%;
            }
            
            .banner-slider {
                width: 100%;
                height: 100%;
                position: relative;
                overflow: hidden;
                background: #000;
            }
            
            .banner-slide {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.8s ease-in-out, visibility 0.8s ease-in-out;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .banner-slide.active {
                opacity: 1;
                visibility: visible;
            }
            
            .banner-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
            }
            
            .banner-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.1) 50%, rgba(0,0,0,0.3) 100%);
                display: flex;
                align-items: flex-end;
                justify-content: flex-start;
                pointer-events: none;
                z-index: 1;
            }
            
            .banner-content {
                text-align: left;
                color: white;
                z-index: 2;
                padding: 20px 25px;
                background: rgba(0,0,0,0.25);
                border-radius: 15px;
                backdrop-filter: blur(1px);
                border: 1px solid rgba(255,255,255,0.15);
                margin: 0 0 30px 30px;
                pointer-events: auto;
                position: relative;
            }
            
            .banner-content h2 {
                font-size: 4rem;
                font-weight: 700;
                margin-bottom: 15px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
            }
            
            .banner-content p {
                font-size: 1.2rem;
                margin: 0;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
                font-weight: 400;
            }
            
            /* Banner Navigation Dots */
            .banner-dots {
                position: absolute;
                bottom: 20px;
                left: 50%;
                transform: translateX(-50%);
                display: flex;
                gap: 10px;
                z-index: 10;
                pointer-events: auto;
            }
            
            .dot {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background: rgba(255,255,255,0.5);
                cursor: pointer;
                transition: all 0.3s ease;
                border: 2px solid rgba(255,255,255,0.8);
                pointer-events: auto;
            }
            
            .dot:hover {
                background: rgba(255,255,255,0.8);
                transform: scale(1.2);
            }
            
            .dot.active {
                background: white;
                box-shadow: 0 0 10px rgba(255,255,255,0.8);
            }
            
            /* Banner Navigation Arrows */
            .banner-prev,
            .banner-next {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                width: 50px;
                height: 50px;
                background: rgba(0,0,0,0.6);
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                border-radius: 50%;
                transition: all 0.3s ease;
                z-index: 10;
                backdrop-filter: blur(3px);
                border: 1px solid rgba(255,255,255,0.2);
                pointer-events: auto;
                cursor: pointer;
            }
            
            .banner-prev {
                left: 20px;
            }
            
            .banner-next {
                right: 20px;
            }
            
            .banner-prev:hover,
            .banner-next:hover {
                background: rgba(0,0,0,0.8);
                transform: translateY(-50%) scale(1.1);
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }
            
            /* Responsive Banner */
            @media (max-width: 768px) {
                .banner-section {
                    height: 400px;
                }
                
                .banner-content h2 {
                    font-size: 3.2rem;
                }
                
                .banner-content p {
                    font-size: 1.2rem;
                }
                
                .banner-prev,
                .banner-next {
                    width: 40px;
                    height: 40px;
                    font-size: 20px;
                }
                

            }
            


            /* User dropdown styling */
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
            <div class="container">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <a class="navbar-brand" href="home">
                        <img src="${pageContext.request.contextPath}/assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                    

                    
                    <div class="d-flex align-items-center">
                        <!-- Menu Dropdown -->
                        <div class="navbar-nav me-4">
                            <div class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" onclick="return false;">
                                    Các dòng xe
                                </a>
                                <ul class="dropdown-menu mega-dropdown" aria-labelledby="navbarDropdown" data-bs-auto-close="false">
                                <li>
                                    <a class="dropdown-item" href="#718-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">718</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/718_boxster_side_nav.png" alt="718" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#911-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">911</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/911_carrera_side_nav.png" alt="911" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#taycan-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">Taycan</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/taycan_side_nav.png" alt="Taycan" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#panamera-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">Panamera</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/panamera_side_nav.png" alt="Panamera" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#macan-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">Macan</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/macan_side_nav.png" alt="Macan" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="#cayenne-section">
                                        <div class="d-flex align-items-center">
                                            <span class="car-model-name">Cayenne</span>
                                            <img src="${pageContext.request.contextPath}/assets/images/cayenne_side_nav.png" alt="Cayenne" class="car-thumbnail ms-auto">
                                            <i class="fas fa-chevron-right ms-2"></i>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        
                        <!-- Login button -->
                        <div class="navbar-nav me-3">
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
                                                <li>
                                                    <a class="dropdown-item" href="order?action=list">
                                                        <i class="fas fa-shopping-bag me-2"></i>Đơn hàng của tôi
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
                        <a class="wishlist-btn" href="${pageContext.request.contextPath}/favorite?action=list" title="Sản phẩm yêu thích">
                            <img src="${pageContext.request.contextPath}/assets/icons/heart.png" alt="Wishlist">
                            <span class="wishlist-count">${sessionScope.favoriteCount != null ? sessionScope.favoriteCount : 0}</span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Banner Section -->
        <div class="banner-section">
            <div class="banner-container">
                <div class="banner-slider">
                    <div class="banner-slide active">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/taycanbanner.jpg" alt="Taycan Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>Taycan</h2>
                                <p>Tương lai điện, hiệu suất vượt trội</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/panamerabanner.jpg" alt="Panamera Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>Panamera</h2>
                                <p>Sedan thể thao, sang trọng đẳng cấp</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/macansbanner.jpg" alt="Macan S Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>Macan S</h2>
                                <p>Hiệu suất cao cấp, thiết kế tinh tế</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/macanbanner.jpg" alt="Macan Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>Macan</h2>
                                <p>SUV nhỏ gọn, thể thao đích thực</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/cayennebanner.jpg" alt="Cayenne Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>Cayenne</h2>
                                <p>SUV thể thao, sức mạnh vượt trội</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/911banner.jpg" alt="911 Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>911 Carrera</h2>
                                <p>Huyền thoại thể thao, biểu tượng của sự hoàn hảo</p>
                            </div>
                        </div>
                    </div>
                    <div class="banner-slide">
                        <img src="${pageContext.request.contextPath}/assets/images/banner/718boxster_caymanbanner.jpg" alt="718 Boxster & Cayman Banner" class="banner-image">
                        <div class="banner-overlay">
                            <div class="banner-content">
                                <h2>718 Boxster & Cayman</h2>
                                <p>Thể thao thuần túy, hiệu suất tối ưu</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Banner Navigation Dots -->
                <div class="banner-dots">
                    <span class="dot active" onclick="currentSlide(1)"></span>
                    <span class="dot" onclick="currentSlide(2)"></span>
                    <span class="dot" onclick="currentSlide(3)"></span>
                    <span class="dot" onclick="currentSlide(4)"></span>
                    <span class="dot" onclick="currentSlide(5)"></span>
                    <span class="dot" onclick="currentSlide(6)"></span>
                    <span class="dot" onclick="currentSlide(7)"></span>
                </div>
                
                <!-- Banner Navigation Arrows -->
                <a class="banner-prev" onclick="changeSlide(-1)">&#10094;</a>
                <a class="banner-next" onclick="changeSlide(1)">&#10095;</a>
            </div>
        </div>

        <div class="container-fluid mt-4 px-4">

            <!-- Search Results Info -->
            <c:if test="${not empty searchKeyword || not empty searchType}">
                <div class="search-results-info mb-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="mb-0">
                                        <i class="fas fa-search me-2"></i>Kết quả tìm kiếm
                                    </h4>
                                    
                                    <div class="filter-results-info">
                                        <c:if test="${not empty searchKeyword}">
                                            <span class="badge bg-primary me-2">
                                                <i class="fas fa-search me-1"></i>Tìm: "${searchKeyword}"
                                            </span>
                                        </c:if>
                                        <c:if test="${searchType == 'category'}">
                                            <span class="badge bg-success me-2">
                                                <i class="fas fa-tag me-1"></i>Danh mục: ${searchKeyword}
                                            </span>
                                        </c:if>
                                        <span class="badge bg-secondary">
                                            <i class="fas fa-list me-1"></i>Kết quả: ${searchResultsCount != null ? searchResultsCount : listProduct.size()} sản phẩm
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Thông báo thành công -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>
            
            <!-- Tiêu đề và nút thêm xe mới -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="text-center">
                        <img src="${pageContext.request.contextPath}/assets/icons/porsche.png" alt="Porsche Logo" class="porsche-logo">
                    </div>
                    <p class="text-center text-muted">Khám phá những chiếc xe thể thao hàng đầu thế giới</p>
                </div>
            </div>

            <!-- Section 1: 718 -->
            <div id="718-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản 718
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 1}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Section 2: 911 -->
            <div id="911-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản 911
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 2}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Section 3: Taycan -->
            <div id="taycan-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản Taycan
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 3}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Section 4: Panamera -->
            <div id="panamera-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản Panamera
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 4}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Section 5: Macan -->
            <div id="macan-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản Macan
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 5}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Section 6: Cayenne -->
            <div id="cayenne-section" class="product-version-section mb-5">
                <div class="version-header mb-4">
                    <h3 class="version-title">
                        <i class="fas fa-chevron-right me-2"></i>
                        Phiên bản Cayenne
                    </h3>
                </div>
                
                <div class="row">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <c:if test="${product.categoryId == 6}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="car-item text-center">
                                    <div class="car-image-wrapper mb-3">
                                        <c:set var="productImage" value=""/>
                                        <c:forEach var="image" items="${listImage}">
                                            <c:if test="${image.productId == product.id}">
                                                <c:set var="productImage" value="${image.imageSideUrl}"/>
                                            </c:if>
                                        </c:forEach>
                                        <a href="home?action=detail&id=${product.id}" style="text-decoration: none; display: block;">
                                            <img src="${not empty productImage ? productImage : product.image}" alt="${product.name}" class="car-image" />
                                        </a>
                                    </div>
                                    <h4 class="car-name mb-2">${product.name}</h4>
                                    <div class="car-price mb-3">
                                        Giá tiêu chuẩn: 
                                        <c:choose>
                                            <c:when test="${not empty product.price}">
                                                <span class="price-amount"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0" /> VNĐ*</span>
                                            </c:when>
                                            <c:otherwise>
                                                Liên hệ để biết giá
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- Thông báo không có xe -->
            <c:if test="${empty listProduct}">
                <div class="text-center py-5">
                    <i class="fas fa-car fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">Chưa có xe nào trong bộ sưu tập</h4>
                </div>
            </c:if>
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
        
        <!-- Custom Dropdown Hover Script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Navbar scroll effect
                const navbar = document.querySelector('.navbar');
                
                window.addEventListener('scroll', function() {
                    if (window.scrollY > 50) {
                        navbar.classList.add('scrolled');
                    } else {
                        navbar.classList.remove('scrolled');
                    }
                });
                
                // Existing dropdown code
                const dropdown = document.querySelector('.dropdown');
                const dropdownMenu = document.querySelector('.dropdown-menu');
                const dropdownToggle = document.querySelector('.dropdown-toggle');
                let timeoutId;
                
                // Prevent clicking on dropdown toggle
                dropdownToggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    return false;
                });
                
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
            });
        </script>
        



            

            

            
            // Enhanced collectProducts function
            window.collectProducts = function() {
                try {
                    // Find all car items on the page
                    const carItems = document.querySelectorAll('.car-item');
                    
                    if (carItems.length === 0) {
                        throw new Error('No car items found on page');
                    }
                    
                    window.allProducts = [];
                    
                    carItems.forEach((carItem, index) => {
                        
                        const nameElement = carItem.querySelector('.car-name');
                        const linkElement = carItem.querySelector('a[href*="action=detail"]');
                        const imageElement = carItem.querySelector('.car-image');
                        
                        if (nameElement && linkElement) {
                            const href = linkElement.getAttribute('href');
                            const productId = href.match(/id=(\d+)/)?.[1] || index;
                            
                            // Determine category from section
                            let category = 'Porsche';
                            const section718 = carItem.closest('[id="718-section"]');
                            const section911 = carItem.closest('[id="911-section"]');
                            const sectionTaycan = carItem.closest('[id="taycan-section"]');
                            const sectionPanamera = carItem.closest('[id="panamera-section"]');
                            const sectionMacan = carItem.closest('[id="macan-section"]');
                            const sectionCayenne = carItem.closest('[id="cayenne-section"]');
                            
                            if (section718) category = '718 Series';
                            else if (section911) category = '911 Series';
                            else if (sectionTaycan) category = 'Taycan Series';
                            else if (sectionPanamera) category = 'Panamera Series';
                            else if (sectionMacan) category = 'Macan Series';
                            else if (sectionCayenne) category = 'Cayenne Series';
                            
                            // Ensure detailUrl is properly formatted
                            let detailUrl = 'home?action=detail&id=' + productId;
                            if (href && !href.startsWith('http')) {
                                const idMatch = href.match(/id=(\d+)/);
                                if (idMatch) {
                                    detailUrl = 'home?action=detail&id=' + idMatch[1];
                                }
                            }
                            
                            // Tìm imageSideUrl từ DOM nếu có
                            let imageSideUrl = '';
                            if (imageElement && imageElement.src) {
                                if (imageElement.src.includes('side') || imageElement.src.includes('_side')) {
                                    imageSideUrl = imageElement.src;
                                }
                            }
                            
                            const product = {
                                id: productId,
                                name: nameElement.textContent.trim(),
                                category: category,
                                imageSideUrl: imageSideUrl,
                                image: imageElement ? imageElement.src : '',
                                detailUrl: detailUrl,
                                element: carItem
                            };
                            
                            window.allProducts.push(product);
                        }
                    });
                    
                    if (window.allProducts.length === 0) {
                        throw new Error('No products could be collected');
                    }
                    
                    return window.allProducts.length > 0;
                    
                } catch (error) {
                    console.error('Product collection error:', error);
                    return false;
                }
            };
            
            // Initialize
            document.addEventListener('DOMContentLoaded', function() {
                // Collect products immediately when page loads
                collectProducts();
            });
            
            // ... existing code ...
        </script>



        <!-- Chatbot -->
        <div class="chatbot-container" id="chatbotContainer">
            <!-- Chatbot Toggle Button -->
            <div class="chatbot-toggle" id="chatbotToggle">
                <i class="fas fa-headset"></i>
                <span class="chatbot-toggle-text">Chat với chúng tôi</span>
            </div>
            
            <!-- Chatbot Window -->
            <div class="chatbot-window" id="chatbotWindow">
                <div class="chatbot-header">
                    <div class="chatbot-title">
                    </div>
                    <button class="chatbot-close" id="chatbotClose">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                
                <div class="chatbot-messages" id="chatbotMessages">

                                    
                </div>
                
                <div class="chatbot-input">
                    <input type="text" id="chatbotInput" placeholder="Nhập tin nhắn của bạn..." maxlength="200">
                    <button id="chatbotSend">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </div>
        </div>


            .search-results-info {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 1.5rem;
                border: 1px solid #e9ecef;
                margin-bottom: 2rem;
            }
            
            .search-results-info h4 {
                color: #495057;
                font-weight: 500;
                font-size: 1.2rem;
            }
            
            .filter-results-info {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                align-items: center;
            }
            
            .filter-results-info .badge {
                font-size: 0.75rem;
                padding: 0.4rem 0.6rem;
                border-radius: 6px;
                font-weight: 500;
            }
            
            /* Responsive */
            @media (max-width: 768px) {
                .search-container {
                    top: 90px;
                    left: 20px;
                    right: 20px;
                    transform: none;
                    min-width: auto;
                    width: calc(100% - 40px);
                }
                
                .search-form {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .search-input-group {
                    flex-direction: column;
                    gap: 10px;
                    padding: 15px;
                }
                
                .search-input,
                .search-category-select {
                    min-width: 100%;
                    border-left: none;
                    border-top: 1px solid #e9ecef;
                    padding-top: 15px;
                    padding-left: 15px;
                }
                
                .search-button,
                .clear-search-btn {
                    width: 100%;
                    border-radius: 20px;
                }
                
                .search-results-info {
                    padding: 1rem;
                }
                
                .search-results-info .d-flex {
                    flex-direction: column;
                    gap: 1rem;
                    text-align: center;
                }
                
                .filter-results-info {
                    justify-content: center;
                }
            }
        </style>

        <!-- Chatbot Styles -->
        <style>
            .chatbot-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            /* Toggle Button - Circular Design */
            .chatbot-toggle {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                cursor: pointer;
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid rgba(255, 255, 255, 0.2);
                position: relative;
                overflow: hidden;
            }
            
            .chatbot-toggle:hover {
                transform: translateY(-3px) scale(1.1);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
                border-color: rgba(255, 255, 255, 0.3);
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4c93 100%);
            }
            
            .chatbot-toggle:active {
                transform: translateY(-1px) scale(0.95);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }
            
            .chatbot-toggle i {
                font-size: 26px;
                filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
                transition: all 0.3s ease;
            }
            
            .chatbot-toggle:hover i {
                transform: scale(1.15);
            }
            
            .chatbot-toggle-text {
                display: none;
            }
            
            /* Chat Window - Enhanced Layout */
            .chatbot-window {
                position: absolute;
                bottom: 85px;
                right: 0;
                width: 380px;
                height: 520px;
                background: white;
                border-radius: 24px;
                box-shadow: 0 15px 50px rgba(0,0,0,0.25);
                display: none;
                flex-direction: column;
                overflow: hidden;
                animation: slideIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid rgba(102, 126, 234, 0.1);
            }
            
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(30px) scale(0.9);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }
            
            /* Header - Refined Design */
            .chatbot-header {
                background: transparent;
                color: #333;
                padding: 0;
                height: 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: none;
                overflow: hidden;
            }
            
            .chatbot-title {
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 700;
                font-size: 17px;
                letter-spacing: 0.5px;
            }
            
            .chatbot-title i {
                font-size: 20px;
                filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
            }
            
            .chatbot-close {
                background: rgba(0, 0, 0, 0.1);
                border: none;
                color: #333;
                font-size: 16px;
                cursor: pointer;
                padding: 8px;
                border-radius: 50%;
                transition: all 0.3s ease;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .chatbot-close:hover {
                background: rgba(0, 0, 0, 0.2);
                transform: scale(1.1);
            }
            
            /* Messages Area - Better Spacing */
            .chatbot-messages {
                flex: 1;
                padding: 24px;
                overflow-y: auto;
                background: linear-gradient(180deg, #f8f9fa 0%, #ffffff 100%);
                scroll-behavior: smooth;
            }
            
            .chatbot-messages::-webkit-scrollbar {
                width: 6px;
            }
            
            .chatbot-messages::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 3px;
            }
            
            .chatbot-messages::-webkit-scrollbar-thumb {
                background: #c1c1c1;
                border-radius: 3px;
            }
            
            .chatbot-messages::-webkit-scrollbar-thumb:hover {
                background: #a8a8a8;
            }
            
            /* Message Bubbles - Enhanced Design */
            .message {
                margin-bottom: 18px;
                display: flex;
                flex-direction: column;
                animation: messageSlideIn 0.3s ease;
            }
            
            @keyframes messageSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .bot-message {
                align-items: flex-start;
            }
            
            .user-message {
                align-items: flex-end;
            }
            
            .message-content {
                max-width: 85%;
                padding: 14px 18px;
                border-radius: 20px;
                display: flex;
                align-items: flex-start;
                gap: 10px;
                position: relative;
            }
            
            .bot-message .message-content {
                background: white;
                color: #333;
                box-shadow: 0 3px 15px rgba(0,0,0,0.08);
                border: 1px solid rgba(102, 126, 234, 0.1);
                padding: 0;
                background: transparent;
                box-shadow: none;
                border: none;
            }
            
            .user-message .message-content {
                background: linear-gradient(135deg, #667eea 0%, #5a6fd8 100%);
                color: white;
                flex-direction: row-reverse;
                box-shadow: 0 3px 15px rgba(102, 126, 234, 0.2);
            }
            
            .message-content i {
                font-size: 15px;
                margin-top: 2px;
                opacity: 0.8;
            }
            
            .message-text {
                font-size: 14px;
                line-height: 1.6;
                font-weight: 400;
                white-space: pre-line;
            }
            
            /* Product Suggestions - Very Simple */
            .product-suggestion {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 12px;
                padding: 16px 18px;
                margin-top: 12px;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            }
            
            .product-suggestion:hover {
                background: #f8f9fa;
                border-color: #667eea;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            
            .product-name {
                font-weight: 600;
                color: #333;
                margin-bottom: 4px;
                font-size: 14px;
                line-height: 1.3;
            }
            
            .product-description {
                color: #666;
                font-size: 12px;
                line-height: 1.4;
                font-style: italic;
                margin: 0;
            }
            
            /* Product List - Styled List */
            .product-list {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            }
            
            .product-list-item {
                display: flex;
                align-items: center;
                padding: 16px 18px;
                border-bottom: 1px solid #f8f9fa;
                cursor: pointer;
                transition: all 0.3s ease;
                gap: 15px;
            }
            
            .product-list-item:last-child {
                border-bottom: none;
            }
            
            .product-list-item:hover {
                background: #f8f9fa;
                transform: translateX(5px);
            }
            
            .product-list-number {
                background: linear-gradient(135deg, #667eea 0%, #5a6fd8 100%);
                color: white;
                width: 28px;
                height: 28px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 12px;
                flex-shrink: 0;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
            }
            
            .product-list-content {
                flex: 1;
                min-width: 0;
            }
            
            .product-list-name {
                font-weight: 700;
                color: #333;
                margin-bottom: 4px;
                font-size: 14px;
                line-height: 1.3;
            }
            
            .product-list-description {
                color: #666;
                font-size: 12px;
                line-height: 1.4;
                font-style: italic;
                margin: 0;
            }
            
            .product-list-arrow {
                color: #667eea;
                font-size: 14px;
                opacity: 0.7;
                transition: all 0.3s ease;
                flex-shrink: 0;
            }
            
            .product-list-item:hover .product-list-arrow {
                opacity: 1;
                transform: translateX(3px);
            }
            
            /* Search Actions & Options - Enhanced Cards */
            .search-actions,
            .search-options {
                background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
                border: 2px solid #e9ecef;
                border-radius: 20px;
                padding: 25px;
                margin-top: 15px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                border-left: 5px solid #28a745;
                position: relative;
                overflow: hidden;
            }
            
            .search-actions-title,
            .search-options-title {
                font-weight: 800;
                color: #2c3e50;
                margin-bottom: 20px;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 12px 15px;
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            }
            
            .search-actions-buttons,
            .search-options-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 15px;
            }
            
            .search-action-btn,
            .search-option-btn {
                background: linear-gradient(135deg, #667eea 0%, #5a6fd8 100%);
                color: white;
                border: none;
                padding: 10px 16px;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                font-size: 12px;
                font-weight: 600;
                letter-spacing: 0.3px;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
            }
            
            .search-action-btn:hover,
            .search-option-btn:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #4a5fc8 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }
            
            .search-action-btn:active,
            .search-option-btn:active {
                transform: translateY(0);
            }
            
            .search-actions-info,
            .search-options-info {
                color: #666;
                font-size: 12px;
                font-style: italic;
                padding: 8px 12px;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 3px solid #ffc107;
            }
            
            /* Help Menu - Simple Design */
            .help-menu {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 12px;
                padding: 20px;
                margin-top: 15px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            
            .help-menu-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 16px;
                font-size: 15px;
            }
            
            .help-menu-content {
                font-size: 13px;
                line-height: 1.6;
            }
            
            .help-section {
                margin-bottom: 12px;
                padding: 12px;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 3px solid #667eea;
            }
            
            .help-section:last-child {
                margin-bottom: 0;
            }
            
            .help-section strong {
                color: #333;
                font-weight: 600;
            }
            
            /* Input Area - Refined Design */
            .chatbot-input {
                padding: 22px 24px;
                background: white;
                border-top: 1px solid #e9ecef;
                display: flex;
                gap: 12px;
                align-items: center;
            }
            
            .chatbot-input input {
                flex: 1;
                padding: 14px 18px;
                border: 2px solid #e9ecef;
                border-radius: 25px;
                outline: none;
                font-size: 14px;
                transition: all 0.3s ease;
                background: #f8f9fa;
                color: #333;
                font-weight: 400;
            }
            
            .chatbot-input input:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
                background: white;
            }
            
            .chatbot-input input::placeholder {
                color: #999;
                font-weight: 400;
            }
            
            .chatbot-input button {
                background: linear-gradient(135deg, #667eea 0%, #5a6fd8 100%);
                color: white;
                border: none;
                padding: 14px 18px;
                border-radius: 50%;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                justify-content: center;
                width: 48px;
                height: 48px;
                box-shadow: 0 3px 12px rgba(102, 126, 234, 0.2);
            }
            
            .chatbot-input button:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #4a5fc8 100%);
                transform: scale(1.05);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }
            
            .chatbot-input button:active {
                transform: scale(0.95);
            }
            
            .chatbot-input button:disabled {
                background: #ccc;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }
            
            .chatbot-input button i {
                font-size: 16px;
                filter: drop-shadow(0 1px 2px rgba(0,0,0,0.1));
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .chatbot-window {
                    width: 340px;
                    height: 480px;
                    right: -15px;
                    bottom: 80px;
                }
                
                .chatbot-toggle-text {
                    display: none;
                }
                
                .chatbot-toggle {
                    padding: 16px;
                    border-radius: 50%;
                    min-width: 56px;
                    justify-content: center;
                }
                
                .chatbot-messages {
                    padding: 20px;
                }
                
                .chatbot-input {
                    padding: 18px 20px;
                }
                
                .message-content {
                    max-width: 90%;
                    padding: 12px 16px;
                }
                
                /* Mobile product suggestions */
                .product-suggestion {
                    padding: 14px 16px;
                }
                
                .product-name {
                    font-size: 13px;
                }
                
                .product-description {
                    font-size: 11px;
                }
                
                /* Mobile product list */
                .product-list-item {
                    padding: 14px 16px;
                    gap: 12px;
                }
                
                .product-list-number {
                    width: 24px;
                    height: 24px;
                    font-size: 11px;
                }
                
                .product-list-name {
                    font-size: 13px;
                }
                
                .product-list-description {
                    font-size: 11px;
                }
            }
            
            @media (max-width: 480px) {
                .chatbot-window {
                    width: 320px;
                    height: 450px;
                    right: -20px;
                }
                
                .chatbot-toggle {
                    bottom: 15px;
                    right: 15px;
                }
                
                /* Small mobile product suggestions */
                .product-suggestion {
                    padding: 12px 14px;
                }
                
                .product-name {
                    font-size: 13px;
                }
                
                .product-description {
                    font-size: 11px;
                }
                
                /* Small mobile product list */
                .product-list-item {
                    padding: 12px 14px;
                    gap: 10px;
                }
                
                .product-list-number {
                    width: 22px;
                    height: 22px;
                    font-size: 10px;
                }
                
                .product-list-name {
                    font-size: 12px;
                }
                
                .product-list-description {
                    font-size: 10px;
                }
            }
        </style>

        <!-- Search Form JavaScript -->
        <script>
            // Search form functionality
            document.addEventListener('DOMContentLoaded', function() {
                const searchForm = document.getElementById('searchForm');
                const categorySelect = document.querySelector('select[name="category"]');
                const searchInput = document.querySelector('input[name="q"]');
                const clearSearchBtn = document.getElementById('clearSearchBtn');
                
                // Auto-submit when category changes
                if (categorySelect) {
                    categorySelect.addEventListener('change', function() {
                        // Update search input with category value if empty
                        if (!searchInput.value.trim()) {
                            searchInput.value = this.value;
                        }
                        searchForm.submit();
                    });
                }
                
                // Submit on Enter key in search input
                if (searchInput) {
                    searchInput.addEventListener('keypress', function(e) {
                        if (e.key === 'Enter') {
                            e.preventDefault();
                            searchForm.submit();
                        }
                    });
                }
                
                // Clear search functionality
                if (clearSearchBtn) {
                    clearSearchBtn.addEventListener('click', function() {
                        searchInput.value = '';
                        categorySelect.value = '';
                        searchForm.submit();
                    });
                }
            });
        </script>

        <!-- Chatbot JavaScript -->
        <script>
            // Simple Chatbot Implementation
            document.addEventListener('DOMContentLoaded', function() {
                // Get chatbot elements
                var toggle = document.getElementById('chatbotToggle');
                var chatWindow = document.getElementById('chatbotWindow');
                var closeBtn = document.getElementById('chatbotClose');
                var input = document.getElementById('chatbotInput');
                var sendBtn = document.getElementById('chatbotSend');
                var messages = document.getElementById('chatbotMessages');
                
                if (!toggle || !chatWindow || !closeBtn || !input || !sendBtn || !messages) {
                    console.error(' Some chatbot elements are missing!');
                    return;
                }
                
                var isOpen = false;
                var products = [];
                
                // Load products from page
                function loadProducts() {
                    if (window.allProducts && window.allProducts.length > 0) {
                        products = window.allProducts;
                    } else {
                        // Fallback: collect from DOM
                        var carItems = document.querySelectorAll('.car-item');
                        products = [];
                        
                        carItems.forEach(function(item, index) {
                            var nameElement = item.querySelector('.car-name');
                            var imageElement = item.querySelector('.car-image');
                            var linkElement = item.querySelector('a[href*="action=detail"]');
                            
                            if (nameElement && linkElement) {
                                var href = linkElement.getAttribute('href');
                                var productId = href.match(/id=(\d+)/)?.[1] || index;
                                
                                var category = 'Porsche';
                                if (item.closest('[id="718-section"]')) category = '718 Series';
                                else if (item.closest('[id="911-section"]')) category = '911 Series';
                                else if (item.closest('[id="taycan-section"]')) category = 'Taycan Series';
                                else if (item.closest('[id="panamera-section"]')) category = 'Panamera Series';
                                else if (item.closest('[id="macan-section"]')) category = 'Macan Series';
                                else if (item.closest('[id="cayenne-section"]')) category = 'Cayenne Series';
                                
                                var product = {
                                id: productId,
                                name: nameElement.textContent.trim(),
                                category: category,
                                image: imageElement ? imageElement.src : '',
                                    imageSideUrl: imageElement ? imageElement.src : '',
                                detailUrl: 'home?action=detail&id=' + productId
                                };
                                
                                products.push(product);
                            }
                        });
                    }
                    
                    // Verify products are loaded
                    if (products.length === 0) {
                        addMessage('️ Không thể tải danh sách sản phẩm. Vui lòng tải lại trang.', 'bot');
                    }
                }
                
                // Toggle chat window
                function toggleChat() {
                    isOpen = !isOpen;
                    chatWindow.style.display = isOpen ? 'flex' : 'none';
                    
                    if (isOpen) {
                        input.focus();
                    }
                }
                
                // Close chat
                function closeChat() {
                    isOpen = false;
                    chatWindow.style.display = 'none';
                }
                
                // Add message to chat
                function addMessage(text, sender) {
                    var messageDiv = document.createElement('div');
                    messageDiv.className = 'message ' + sender + '-message';
                    
                    var contentClass = sender === 'user' ? 'user-message' : 'bot-message';
                    
                    messageDiv.innerHTML = '<div class="message-content ' + contentClass + '">' +
                        '<div class="message-text">' + text + '</div>' +
                        '</div>';
                    
                    messages.appendChild(messageDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                
                // Process user message
                function processMessage(message) {
                    var lowerMessage = message.toLowerCase();
                    
                    // Check for exact commands first
                    if (lowerMessage === 'tìm kiếm' || lowerMessage === 'search' || lowerMessage === 'tìm') {
                        showSearchOptions();
                    } else if (lowerMessage === 'giúp' || lowerMessage === 'help' || lowerMessage === 'hướng dẫn') {
                        showHelpMenu();
                    } else if (lowerMessage === 'xóa' || lowerMessage === 'clear' || lowerMessage === 'reset') {
                        clearSearchResults();
                        addMessage('Đã xóa kết quả tìm kiếm. Bạn có thể tìm kiếm mới.', 'bot');
                    } else if (lowerMessage === 'chào' || lowerMessage === 'hello' || lowerMessage === 'hi' || lowerMessage === 'xin chào') {
                        showWelcomeMessage();
                    } else if (lowerMessage === 'giới thiệu' || lowerMessage === 'about' || lowerMessage === 'thông tin') {
                        showAboutMessage();
                    } else if (lowerMessage === 'liên hệ' || lowerMessage === 'contact' || lowerMessage === 'hotline') {
                        showContactMessage();
                    } else if (lowerMessage === 'showroom' || lowerMessage === 'địa chỉ' || lowerMessage === 'address') {
                        showShowroomMessage();
                    } else if (lowerMessage.includes('tìm ') && lowerMessage.length > 4) {
                        // Only process search if it's "tìm + something"
                        handleAdvancedSearch(message);
                    } else if (lowerMessage.includes('718') || lowerMessage.includes('911') || lowerMessage.includes('taycan') || 
                               lowerMessage.includes('panamera') || lowerMessage.includes('macan') || lowerMessage.includes('cayenne')) {
                        handleCategorySearch(message);
                    } else if (lowerMessage.includes('rẻ') || lowerMessage.includes('cheap') || lowerMessage.includes('giá thấp')) {
                        handlePriceSearch('low');
                    } else if (lowerMessage.includes('đắt') || lowerMessage.includes('expensive') || lowerMessage.includes('giá cao')) {
                        handlePriceSearch('high');
                    } else if (lowerMessage.includes('nhanh') || lowerMessage.includes('fast') || lowerMessage.includes('tốc độ')) {
                        handleSpeedSearch();
                    } else if (lowerMessage.includes('điện') || lowerMessage.includes('electric') || lowerMessage.includes('ev')) {
                        handleElectricSearch();
                    } else if (lowerMessage.includes('giá') || lowerMessage.includes('price')) {
                        addMessage('Để biết thông tin chi tiết về giá cả, vui lòng liên hệ trực tiếp với chúng tôi hoặc xem thông tin chi tiết sản phẩm.', 'bot');
                    } else if (lowerMessage.includes('mua') || lowerMessage.includes('buy')) {
                        addMessage('Để mua sản phẩm, bạn có thể:\n1. Xem chi tiết sản phẩm\n2. Liên hệ với chúng tôi qua hotline\n3. Đến showroom để được tư vấn trực tiếp', 'bot');
                    } else {
                        addMessage('Tôi hiểu bạn đang hỏi về "' + message + '". Bạn có thể cho tôi biết cụ thể hơn về sản phẩm bạn quan tâm không?', 'bot');
                    }
                }
                
                // Handle advanced search (like products.jsp admin)
                function handleAdvancedSearch(message) {
                    var searchTerm = message.replace(/^tìm\s+/i, '').trim();
                    
                    if (!searchTerm) {
                        showSearchOptions();
                        return;
                    }
                    

                    
                    // Check if it's a category search
                    var category = '';
                    var searchType = 'general';
                    
                    if (searchTerm.toLowerCase().includes('718')) {
                        category = '718 Series';
                        searchType = 'category';
                    } else if (searchTerm.toLowerCase().includes('911')) {
                        category = '911 Series';
                        searchType = 'category';
                    } else if (searchTerm.toLowerCase().includes('taycan')) {
                        category = 'Taycan Series';
                        searchType = 'category';
                    } else if (searchTerm.toLowerCase().includes('panamera')) {
                        category = 'Panamera Series';
                        searchType = 'category';
                    } else if (searchTerm.toLowerCase().includes('macan')) {
                        category = 'Macan Series';
                        searchType = 'category';
                    } else if (searchTerm.toLowerCase().includes('cayenne')) {
                        category = 'Cayenne Series';
                        searchType = 'category';
                    }
                    
                    // Perform search
                    var results = [];
                    if (searchType === 'category') {
                        results = products.filter(function(product) {
                            return product.category === category;
                        });
                        // Category search
                    } else {
                        results = products.filter(function(product) {
                            var nameMatch = product.name && product.name.toLowerCase().includes(searchTerm.toLowerCase());
                            var categoryMatch = product.category && product.category.toLowerCase().includes(searchTerm.toLowerCase());
                            var descriptionMatch = product.description && product.description.toLowerCase().includes(searchTerm.toLowerCase());
                            
                            return nameMatch || categoryMatch || descriptionMatch;
                        });
                    }
                    
                    // Display search results directly
                    if (results.length > 0) {
                        // Add products with proper styling directly
                        addProductList(results);
                        
                        // Không hiển thị search actions sau khi tìm kiếm
                    } else {
                        addMessage('Không tìm thấy sản phẩm nào phù hợp với "' + searchTerm + '".\n\n**Gợi ý:**\n• Thử từ khóa khác\n• Tìm theo danh mục (718, 911, Taycan, Panamera, Macan, Cayenne)\n• Gõ "giúp" để xem hướng dẫn', 'bot');
                    }
                }
                
                // Handle category search
                function handleCategorySearch(message) {
                    var category = '';
                    if (message.toLowerCase().includes('718')) category = '718 Series';
                    else if (message.toLowerCase().includes('911')) category = '911 Series';
                    else if (message.toLowerCase().includes('taycan')) category = 'Taycan Series';
                    else if (message.toLowerCase().includes('panamera')) category = 'Panamera Series';
                    else if (message.toLowerCase().includes('macan')) category = 'Macan Series';
                    else if (message.toLowerCase().includes('cayenne')) category = 'Cayenne Series';
                    
                    if (category) {
                        var results = products.filter(function(p) {
                            return p.category === category;
                        });
                        if (results.length > 0) {
                            // Add products with proper styling directly
                            addProductList(results);
                        } else {
                            addMessage('Không tìm thấy sản phẩm nào trong ' + category + '.', 'bot');
                        }
                    }
                }
                
                // Handle price-based search (rẻ/đắt)
                function handlePriceSearch(priceType) {
                    if (priceType === 'low') {
                        // Tìm 5 sản phẩm rẻ nhất (dựa trên danh mục)
                        var priceRanking = [
                            '718 Series', 'Macan', 'Cayenne', 'Panamera', '911 Series', 'Taycan Series'
                        ];
                        
                        var sortedProducts = [];
                        priceRanking.forEach(function(category) {
                            var found = products.filter(function(p) {
                                return p.category === category;
                            });
                            sortedProducts = sortedProducts.concat(found);
                        });
                        
                        var top5Cheapest = sortedProducts.slice(0, 5);
                        addProductList(top5Cheapest);
                    } else if (priceType === 'high') {
                        // Tìm 5 sản phẩm đắt nhất
                        var priceRanking = [
                            'Taycan Series', '911 Series', 'Panamera', 'Cayenne', 'Macan', '718 Series'
                        ];
                        
                        var sortedProducts = [];
                        priceRanking.forEach(function(category) {
                            var found = products.filter(function(p) {
                                return p.category === category;
                            });
                            sortedProducts = sortedProducts.concat(found);
                        });
                        
                        var top5Expensive = sortedProducts.slice(0, 5);
                        addProductList(top5Expensive);
                    }
                }
                
                // Handle speed-based search (nhanh nhất)
                function handleSpeedSearch() {
                    // Tìm 5 sản phẩm nhanh nhất dựa trên thông tin hiệu suất
                    var speedRanking = [
                        'Taycan', '911', '718', 'Panamera', 'Macan', 'Cayenne'
                    ];
                    
                    var sortedProducts = [];
                    speedRanking.forEach(function(model) {
                        var found = products.filter(function(p) {
                            return p.name.toLowerCase().includes(model.toLowerCase());
                        });
                        sortedProducts = sortedProducts.concat(found);
                    });
                    
                    var top5Fastest = sortedProducts.slice(0, 5);
                    addProductList(top5Fastest);
                }
                
                // Handle electric vehicle search
                function handleElectricSearch() {
                    // Tìm các xe có động cơ điện
                    var electricCars = products.filter(function(p) {
                        return p.name.toLowerCase().includes('taycan') || 
                               p.description && p.description.toLowerCase().includes('điện');
                    });
                    
                    if (electricCars.length > 0) {
                        addMessage('**Các sản phẩm có động cơ điện:**', 'bot');
                        addProductList(electricCars);
                    } else {
                        addMessage('Hiện tại chưa có sản phẩm động cơ điện nào.', 'bot');
                    }
                }
                
                // Show welcome message
                function showWelcomeMessage() {
                    addMessage('Xin chào! Tôi là trợ lý ảo của AutoShowVN. Tôi có thể giúp bạn:\n\n• Tìm kiếm sản phẩm Porsche\n• Xem thông tin chi tiết xe\n• Hỗ trợ mua hàng\n• Cung cấp thông tin liên hệ\n\nBạn cần gì? Gõ "giúp" để xem hướng dẫn đầy đủ.', 'bot');
                }
                
                // Show about message
                function showAboutMessage() {
                    addMessage('**AutoShowVN** - Đại lý chính thức Porsche tại Việt Nam\n\n• Chuyên cung cấp các dòng xe Porsche cao cấp\n• Dịch vụ bảo hành, bảo dưỡng chính hãng\n• Đội ngũ tư vấn chuyên nghiệp\n• Showroom hiện đại, tiêu chuẩn quốc tế\n\nChúng tôi cam kết mang đến trải nghiệm Porsche hoàn hảo nhất!', 'bot');
                }
                
                // Show contact message
                function showContactMessage() {
                    addMessage('**Thông tin liên hệ AutoShowVN:**\n\n📞 **Hotline:** 1900-xxxx\n📧 **Email:** info@autoshowvn.com\n🌐 **Website:** www.autoshowvn.com\n⏰ **Giờ làm việc:** 8:00 - 20:00 (Thứ 2 - Chủ nhật)\n\nHãy liên hệ với chúng tôi để được tư vấn chi tiết!', 'bot');
                }
                
                // Show showroom message
                function showShowroomMessage() {
                    addMessage('**Showroom AutoShowVN:**\n\n📍 **Địa chỉ:** 123 Đường ABC, Quận XYZ, TP.HCM\n🚗 **Diện tích:** 2,000m²\n✨ **Tiêu chuẩn:** Porsche Center quốc tế\n\n**Dịch vụ tại showroom:**\n• Trưng bày xe mẫu\n• Tư vấn mua hàng\n• Dịch vụ bảo hành\n• Bảo dưỡng định kỳ\n\nHãy đến thăm showroom để trải nghiệm trực tiếp!', 'bot');
                }
                
                // Add product suggestion - very simple
                function addProductSuggestion(product) {
                    var suggestionDiv = document.createElement('div');
                    suggestionDiv.className = 'message bot-message';
                    
                    suggestionDiv.innerHTML = '<div class="message-content">' +
                        '<div class="product-suggestion" onclick="window.location.href=\'' + product.detailUrl + '\'">' +
                        '<div class="product-name">' + product.name + '</div>' +
                        '<div class="product-description">' + getProductDescription(product.name) + '</div>' +
                        '</div>' +
                        '</div>';
                    
                    messages.appendChild(suggestionDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                
                // Add product list with proper styling
                function addProductList(products) {
                    var productListDiv = document.createElement('div');
                    productListDiv.className = 'message bot-message';
                    
                    var productListHtml = '<div class="message-content">' +
                        '<div class="product-list">';
                    
                    products.forEach(function(product, index) {
                        productListHtml += '<div class="product-list-item" onclick="window.location.href=\'' + product.detailUrl + '\'">' +
                            '<div class="product-list-number">' + (index + 1) + '</div>' +
                            '<div class="product-list-content">' +
                            '<div class="product-list-name">' + product.name + '</div>' +
                            '<div class="product-list-description">' + getProductDescription(product.name) + '</div>' +
                            '</div>' +
                            '<div class="product-list-arrow">' +
                            '<i class="fas fa-chevron-right"></i>' +
                            '</div>' +
                            '</div>';
                    });
                    
                    productListHtml += '</div></div>';
                    
                    productListDiv.innerHTML = productListHtml;
                    messages.appendChild(productListDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                

                
                // Get product description based on name
                function getProductDescription(name) {
                    var descriptions = {
                        '718': 'Thể thao thuần túy, hiệu suất tối ưu',
                        '911': 'Huyền thoại thể thao, biểu tượng hoàn hảo',
                        'Taycan': 'Tương lai điện, hiệu suất vượt trội',
                        'Panamera': 'Sedan thể thao, sang trọng đẳng cấp',
                        'Macan': 'SUV nhỏ gọn, thể thao đích thực',
                        'Cayenne': 'SUV thể thao, sức mạnh vượt trội'
                    };
                    
                    for (var key in descriptions) {
                        if (name.toLowerCase().includes(key.toLowerCase())) {
                            return descriptions[key];
                        }
                    }
                    return 'Xe thể thao cao cấp, thiết kế tinh tế';
                }
                
                // Get engine information
                function getEngineInfo(name) {
                    if (name.toLowerCase().includes('taycan')) {
                        return 'Động cơ điện';
                    } else if (name.toLowerCase().includes('718') || name.toLowerCase().includes('911')) {
                        return 'Boxer Engine';
                    } else {
                        return 'Turbo Engine';
                    }
                }
                
                // Get performance information
                function getPerformanceInfo(name) {
                    if (name.toLowerCase().includes('taycan')) {
                        return '0-100km/h: 2.8s';
                    } else if (name.toLowerCase().includes('911')) {
                        return '0-100km/h: 3.4s';
                    } else if (name.toLowerCase().includes('718')) {
                        return '0-100km/h: 4.1s';
                    } else {
                        return 'Hiệu suất cao';
                    }
                }
                
                // Add search actions (like products.jsp admin)
                function addSearchActions(searchTerm, searchType, resultCount) {
                    var actionsDiv = document.createElement('div');
                    actionsDiv.className = 'message bot-message';
                    
                    var actionsHtml = '<div class="message-content">' +
                        '<div class="search-actions">' +
                        '<div class="search-actions-buttons">';
                    
                    // Add action buttons
                    if (searchType === 'category') {
                        actionsHtml += '<button onclick="testSearch(\'tìm ' + searchTerm + '\')" class="search-action-btn">Tìm thêm</button>';
                    } else {
                        actionsHtml += '<button onclick="testSearch(\'tìm ' + searchTerm + '\')" class="search-action-btn">Tìm lại</button>';
                    }
                    
                    actionsHtml += '<button onclick="testSearch(\'tìm 718\')" class="search-action-btn">718 Series</button>' +
                        '<button onclick="testSearch(\'tìm 911\')" class="search-action-btn">911 Series</button>' +
                        '<button onclick="testSearch(\'tìm taycan\')" class="search-action-btn">Taycan</button>' +
                        '<button onclick="testSearch(\'tìm panamera\')" class="search-action-btn">Panamera</button>' +
                        '<button onclick="testSearch(\'tìm macan\')" class="search-action-btn">Macan</button>' +
                        '<button onclick="testSearch(\'tìm cayenne\')" class="search-action-btn">Cayenne</button>' +
                        '</div>' +
                        '<div class="search-actions-info">' +
                        '<small>Tip: Bạn có thể gõ "xóa" để xóa kết quả tìm kiếm</small>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    
                    actionsDiv.innerHTML = actionsHtml;
                    messages.appendChild(actionsDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                
                // Show search options
                function showSearchOptions() {
                    var optionsDiv = document.createElement('div');
                    optionsDiv.className = 'message bot-message';
                    
                    optionsDiv.innerHTML = '<div class="message-content">' +
                        '<div class="search-options">' +
                        '<div class="search-options-title">**Chọn cách tìm kiếm:**</div>' +
                        '<div class="search-options-buttons">' +
                        '<button onclick="testSearch(\'tìm 718\')" class="search-option-btn">718 Series</button>' +
                        '<button onclick="testSearch(\'tìm 911\')" class="search-option-btn">911 Series</button>' +
                        '<button onclick="testSearch(\'tìm taycan\')" class="search-option-btn">Taycan</button>' +
                        '<button onclick="testSearch(\'tìm panamera\')" class="search-option-btn">Panamera</button>' +
                        '<button onclick="testSearch(\'tìm macan\')" class="search-option-btn">Macan</button>' +
                        '<button onclick="testSearch(\'tìm cayenne\')" class="search-option-btn">Cayenne</button>' +
                        '</div>' +
                        '<div class="search-options-info">' +
                        '<small>Hoặc gõ tên sản phẩm cụ thể để tìm kiếm</small>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    
                    messages.appendChild(optionsDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                
                // Show help menu
                function showHelpMenu() {
                    var helpDiv = document.createElement('div');
                    helpDiv.className = 'message bot-message';
                    
                    helpDiv.innerHTML = '<div class="message-content">' +
                        '<div class="help-menu">' +
                        '<div class="help-menu-content">' +
                        '<div class="help-section">' +
                        '<strong>Tìm kiếm sản phẩm:</strong><br>' +
                        '• "tìm 911" - Tìm theo danh mục<br>' +
                        '• "tìm macan" - Tìm theo tên<br>' +
                        '• "tìm kiếm" - Xem tùy chọn tìm kiếm<br>' +
                        '</div>' +
                        '<div class="help-section">' +
                        '<strong>Tìm theo danh mục:</strong><br>' +
                        '• 718 Series, 911 Series<br>' +
                        '• Taycan, Panamera<br>' +
                        '• Macan, Cayenne<br>' +
                        '</div>' +
                        '<div class="help-section">' +
                        '<strong>Tìm kiếm thông minh:</strong><br>' +
                        '• "rẻ" - 5 sản phẩm giá tốt nhất<br>' +
                        '• "đắt" - 5 sản phẩm cao cấp nhất<br>' +
                        '• "nhanh" - 5 sản phẩm hiệu suất cao nhất<br>' +
                        '• "điện" - Các xe động cơ điện<br>' +
                        '</div>' +
                        '<div class="help-section">' +
                        '<strong>Lệnh nhanh:</strong><br>' +
                        '• "xóa" - Xóa kết quả tìm kiếm<br>' +
                        '• "giúp" - Hiển thị hướng dẫn này<br>' +
                        '</div>' +
                        '<div class="help-section">' +
                        '<strong>Thông tin cơ bản:</strong><br>' +
                        '• "chào" - Lời chào mừng<br>' +
                        '• "giới thiệu" - Thông tin về AutoShowVN<br>' +
                        '• "liên hệ" - Thông tin liên hệ<br>' +
                        '• "showroom" - Địa chỉ và dịch vụ<br>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    
                    messages.appendChild(helpDiv);
                    messages.scrollTop = messages.scrollHeight;
                }
                
                // Clear search results
                function clearSearchResults() {
                    // Remove all search-related messages
                    var searchMessages = messages.querySelectorAll('.message');
                    searchMessages.forEach(function(message, index) {
                        // Keep the first 2 messages (welcome and test buttons)
                        if (index > 1) {
                            message.remove();
                        }
                    });
                }
                
                // Send message
                function sendMessage() {
                    var message = input.value.trim();
                    if (!message) return;
                    
                    addMessage(message, 'user');
                    input.value = '';
                    
                    // Process message after a short delay to show typing effect
                    setTimeout(function() {
                        processMessage(message);
                    }, 500);
                }
                
                // Bind events
                toggle.addEventListener('click', toggleChat);
                closeBtn.addEventListener('click', closeChat);
                input.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') sendMessage();
                });
                sendBtn.addEventListener('click', sendMessage);
                
                // Load products
                loadProducts();
                
                // Test function for debugging
                window.testSearch = function(query) {
                    addMessage(query, 'user');
                    setTimeout(function() {
                        processMessage(query);
                    }, 500);
                };
            });
        </script>
    </body>
</html>
