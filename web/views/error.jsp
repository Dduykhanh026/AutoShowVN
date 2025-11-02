<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi - AutoShowVN</title>
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
                margin-top: 10px;
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
            
            .error-section {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
            }
            .error-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                border: none;
            }
            .error-icon {
                font-size: 5rem;
                color: #dc3545;
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
                <div class="d-flex align-items-center">
                    <a class="navbar-brand me-4" href="home">
                        <img src="assets/icons/logok.png" alt="AutoShowVN Logo" style="height: 50px; width: 50px; object-fit: cover; border-radius: 8px;">
                    </a>
                    
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
                </div>
            </div>
        </nav>

        <section class="error-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="card error-card text-center p-5">
                            <div class="card-body">
                                <i class="fas fa-exclamation-triangle error-icon mb-4"></i>
                                <h2 class="text-danger mb-3">Đã xảy ra lỗi!</h2>
                                
                                <c:if test="${not empty error}">
                                    <p class="lead text-muted mb-4">${error}</p>
                                </c:if>
                                
                                <c:if test="${empty error}">
                                    <p class="lead text-muted mb-4">Đã xảy ra lỗi không mong muốn. Vui lòng thử lại sau.</p>
                                </c:if>
                                
                                <div class="d-grid gap-2 d-md-block">
                                    <a href="home" class="btn btn-primary btn-lg me-md-2">
                                        <i class="fas fa-home"></i> Về trang chủ
                                    </a>
                                    <button onclick="history.back()" class="btn btn-secondary btn-lg">
                                        <i class="fas fa-arrow-left"></i> Quay lại
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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
            });
            
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
