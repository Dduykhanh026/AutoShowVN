<%-- 
    Document   : login
    Created on : Aug 17, 2025, 9:14:16 PM
    Author     : Duy Khánh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <title>Đăng nhập - K - Auto</title>
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
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            
            .login-container {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 30px;
                padding: 35px 40px;
                box-shadow: 
                    20px 20px 60px rgba(180, 180, 180, 0.6),
                    -20px -20px 60px rgba(255, 255, 255, 0.9);
                width: 100%;
                max-width: 450px;
                position: relative;
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .header-section {
                text-align: center;
                margin-bottom: 30px;
            }
            
            .profile-icon {
                width: 120px;
                height: 120px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 15px;
                margin: 0 auto 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 
                    8px 8px 16px rgba(160, 160, 160, 0.7),
                    -8px -8px 16px rgba(255, 255, 255, 0.9);
                overflow: hidden;
                cursor: pointer;
                transition: all 0.2s ease;
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-2px);
            }
            
            .profile-icon:active {
                transform: translateY(0px);
                box-shadow: 
                    inset 4px 4px 8px rgba(160, 160, 160, 0.7),
                    inset -4px -4px 8px rgba(255, 255, 255, 0.9);
            }
            
            .profile-icon:hover {
                box-shadow: 
                    inset 3px 3px 6px #e0e0e0,
                    inset -3px -3px 6px #ffffff;
                transform: scale(0.98);
            }
            
            .profile-icon a {
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 100%;
            }
            
            .profile-icon img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 15px;
            }
            
            .welcome-text {
                font-size: 28px;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 10px;
            }
            
            .subtitle {
                font-size: 16px;
                color: #718096;
                font-weight: 400;
            }
            
            .form-group {
                margin-bottom: 20px;
            }
            
            .input-field {
                position: relative;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 20px;
                padding: 5px;
                box-shadow: 
                    6px 6px 12px rgba(160, 160, 160, 0.7),
                    -6px -6px 12px rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
                transition: all 0.2s ease;
            }
            
            .input-field:focus-within {
                transform: translateY(0px);
                box-shadow: 
                    inset 3px 3px 6px rgba(160, 160, 160, 0.7),
                    inset -3px -3px 6px rgba(255, 255, 255, 0.9);
            }
            
            .input-field input {
                width: 100%;
                border: none;
                background: transparent;
                padding: 20px 20px 20px 60px;
                font-size: 16px;
                color: #2d3748;
                outline: none;
            }
            
            .input-field input::placeholder {
                color: #a0aec0;
            }
            
            .input-field input {
                /* Đảm bảo không có giá trị mặc định */
                background: transparent !important;
                color: #2d3748 !important;
            }
            
            .input-field input:focus {
                background: transparent !important;
            }
            
            .input-icon {
                position: absolute;
                left: 20px;
                top: 50%;
                transform: translateY(-50%);
                color: #718096;
                font-size: 18px;
            }
            
            .password-toggle {
                position: absolute;
                right: 20px;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 50%;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 
                    4px 4px 8px rgba(160, 160, 160, 0.7),
                    -4px -4px 8px rgba(255, 255, 255, 0.9);
                color: #718096;
                transition: all 0.2s ease;
                backdrop-filter: blur(8px);
                -webkit-backdrop-filter: blur(8px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .password-toggle:active {
                transform: translateY(calc(-50% + 1px));
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.7),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9);
            }
            
            .password-toggle:hover {
                box-shadow: 
                    inset 2px 2px 4px #e0e0e0,
                    inset -2px -2px 4px #ffffff;
            }
            
            .options-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }
            
            .checkbox-container {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .neumorphic-checkbox {
                width: 20px;
                height: 20px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 6px;
                box-shadow: 
                    3px 3px 6px rgba(160, 160, 160, 0.7),
                    -3px -3px 6px rgba(255, 255, 255, 0.9);
                cursor: pointer;
                position: relative;
                backdrop-filter: blur(6px);
                -webkit-backdrop-filter: blur(6px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
                transition: all 0.2s ease;
            }
            
            .neumorphic-checkbox:active {
                transform: translateY(0px);
                box-shadow: 
                    inset 2px 2px 4px rgba(160, 160, 160, 0.7),
                    inset -2px -2px 4px rgba(255, 255, 255, 0.9);
            }
            
            .neumorphic-checkbox.checked::after {
                content: '✓';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: #4a5568;
                font-size: 14px;
                font-weight: bold;
            }
            
            .checkbox-label {
                color: #4a5568;
                font-size: 14px;
                cursor: pointer;
            }
            
            .forgot-link {
                color: #4a5568;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: color 0.2s ease;
            }
            
            .forgot-link:hover {
                color: #2d3748;
            }
            
            .signin-button {
                width: 100%;
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 20px;
                padding: 18px;
                font-size: 18px;
                font-weight: 600;
                color: #2d3748;
                cursor: pointer;
                box-shadow: 
                    8px 8px 16px rgba(160, 160, 160, 0.7),
                    -8px -8px 16px rgba(255, 255, 255, 0.9);
                transition: all 0.2s ease;
                margin-bottom: 25px;
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-2px);
            }
            
            .signin-button:active {
                transform: translateY(0px);
                box-shadow: 
                    inset 4px 4px 8px rgba(160, 160, 160, 0.7),
                    inset -4px -4px 8px rgba(255, 255, 255, 0.9);
            }
            
            .signin-button:hover {
                box-shadow: 
                    inset 3px 3px 6px #e0e0e0,
                    inset -3px -3px 6px #ffffff;
            }
            
            .signin-button:active {
                transform: translateY(2px);
            }
            
            .divider {
                text-align: center;
                margin: 25px 0;
                position: relative;
            }
            
            .divider::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 0;
                right: 0;
                height: 1px;
                background: #cbd5e0;
            }
            
            .divider-text {
                background: rgba(255, 255, 255, 0.9);
                padding: 0 20px;
                color: #718096;
                font-size: 14px;
                font-weight: 500;
                backdrop-filter: blur(8px);
                -webkit-backdrop-filter: blur(8px);
                border: 2px solid rgba(255, 255, 255, 0.4);
            }
            
            .social-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 25px;
            }
            
            .social-button {
                width: 50px;
                height: 50px;
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 
                    6px 6px 12px rgba(160, 160, 160, 0.7),
                    -6px -6px 12px rgba(255, 255, 255, 0.9);
                transition: all 0.2s ease;
                color: #4a5568;
                font-size: 18px;
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.4);
                transform: translateY(-1px);
            }
            
            .social-button:active {
                transform: translateY(0px);
                box-shadow: 
                    inset 3px 3px 6px rgba(160, 160, 160, 0.7),
                    inset -3px -3px 6px rgba(255, 255, 255, 0.9);
            }
            
            .social-button:hover {
                box-shadow: 
                    inset 3px 3px 6px #e0e0e0,
                    inset -3px -3px 6px #ffffff;
            }
            
            .signup-section {
                text-align: center;
                color: #718096;
                font-size: 14px;
            }
            
            .signup-link {
                color: #4a5568;
                text-decoration: none;
                font-weight: 600;
                margin-left: 5px;
            }
            
            .signup-link:hover {
                color: #667eea;
                text-decoration: underline;
            }
            
            .error-message {
                background: #fed7d7;
                color: #c53030;
                padding: 15px 20px;
                border-radius: 15px;
                margin-bottom: 25px;
                font-size: 14px;
                box-shadow: 
                    inset 3px 3px 6px #feb2b2,
                    inset -3px -3px 6px #ffffff;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .success-message {
                background: #c6f6d5;
                color: #22543d;
                padding: 15px 20px;
                border-radius: 15px;
                margin-bottom: 25px;
                font-size: 14px;
                box-shadow: 
                    inset 3px 3px 6px #9ae6b4,
                    inset -3px -3px 6px #ffffff;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            @media (max-width: 480px) {
                .login-container {
                    padding: 30px 20px;
                    margin: 10px;
                }
                
                .welcome-text {
                    font-size: 24px;
                }
                
                .social-buttons {
                    gap: 15px;
                }
            }


        </style>
    </head>
    <body>
        <div class="login-container">
            <!-- Header Section -->
            <div class="header-section">
                <div class="profile-icon">
                    <a href="home">
                        <img src="assets/icons/logok.png" alt="Profile Icon">
                    </a>
                </div>
                <h1 class="welcome-text">Chào mừng trở lại</h1>
                <p class="subtitle">Vui lòng đăng nhập để tiếp tục</p>
            </div>
            
            <!-- Logout Message -->
            <c:if test="${not empty logoutMessage}">
                <div class="success-message">
                    <i class="fas fa-check-circle"></i>
                    ${logoutMessage}
                </div>
            </c:if>
            
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    ${error}
                </div>
            </c:if>
            
            <!-- Login Form -->
            <form action="login" method="POST">
                <div class="form-group">
                    <div class="input-field">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" 
                               name="email" 
                               value="${not empty error ? email : ''}" 
                               placeholder="Email address"
                               required>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="input-field">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" 
                               name="password" 
                               id="password"
                               placeholder="Password"
                               required>
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="fas fa-eye" id="eye-icon"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Options Row -->
                <div class="options-row">
                    <div class="checkbox-container">
                        <div class="neumorphic-checkbox" onclick="toggleCheckbox(this)"></div>
                        <label class="checkbox-label">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="forgot-password" class="forgot-link">Quên mật khẩu?</a>
                </div>
                
                <!-- Sign In Button -->
                <button type="submit" class="signin-button">
                    Đăng nhập
                </button>
            </form>
            
            <!-- Divider -->
            <div class="divider">
                <span class="divider-text">HOẶC TIẾP TỤC VỚI</span>
            </div>
            
            <!-- Social Login Buttons -->
            <div class="social-buttons">
                <button class="social-button" onclick="socialLogin('google')">
                    <i class="fab fa-google"></i>
                </button>
                <button class="social-button" onclick="socialLogin('github')">
                    <i class="fab fa-github"></i>
                </button>
                <button class="social-button" onclick="socialLogin('twitter')">
                    <i class="fab fa-twitter"></i>
                </button>
            </div>
            
            <!-- Sign Up Section -->
            <div class="signup-section">
                Chưa có tài khoản?<a href="register" class="signup-link">Đăng ký</a>
            </div>
        </div>
        
        <script>
            // Luôn reset form khi vào trang login
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.querySelector('form');
                if (form) {
                    // Reset form để đảm bảo không có giá trị cũ
                    form.reset();
            
                    
                    // Xóa tất cả input values
                    const inputs = form.querySelectorAll('input');
                    inputs.forEach(input => {
                        input.value = '';
                    });
                }
                
                // Kiểm tra nếu đây là logout để hiển thị thông báo
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('logout') === 'true') {
            
                }
            });
            
            function togglePassword() {
                const passwordInput = document.getElementById('password');
                const eyeIcon = document.getElementById('eye-icon');
                
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.className = 'fas fa-eye-slash';
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.className = 'fas fa-eye';
                }
            }
            
            function toggleCheckbox(checkbox) {
                checkbox.classList.toggle('checked');
            }
            
            function socialLogin(provider) {
                // Placeholder for social login functionality
        
                alert('Tính năng đăng nhập ' + provider + ' sẽ được phát triển sau!');
            }
            
            // Function để force clear form
            function clearForm() {
                const form = document.querySelector('form');
                if (form) {
                    form.reset();
                    const inputs = form.querySelectorAll('input');
                    inputs.forEach(input => {
                        input.value = '';
                        input.defaultValue = '';
                    });
            
                }
            }
            
            // Clear form khi page load và khi focus vào input
            window.addEventListener('load', clearForm);
            document.addEventListener('focusin', function(e) {
                if (e.target.tagName === 'INPUT' && e.target.value === '') {
                    e.target.defaultValue = '';
                }
            });
            

        </script>
    </body>
</html>
