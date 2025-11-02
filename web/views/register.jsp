<%-- 
    Document   : register
    Created on : Aug 17, 2025, 9:14:16 PM
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
        <title>Đăng ký - K - Auto</title>
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
            
            .register-container {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 30px;
                padding: 35px 40px;
                box-shadow: 
                    20px 20px 60px rgba(180, 180, 180, 0.6),
                    -20px -20px 60px rgba(255, 255, 255, 0.9);
                width: 100%;
                max-width: 500px;
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
            
            .checkbox-container {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 25px;
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
            
            .signup-button {
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
            
            .signup-button:active {
                transform: translateY(0px);
                box-shadow: 
                    inset 4px 4px 8px rgba(160, 160, 160, 0.7),
                    inset -4px -4px 8px rgba(255, 255, 255, 0.9);
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
            
            .login-section {
                text-align: center;
                color: #718096;
                font-size: 14px;
            }
            
            .login-link {
                color: #4a5568;
                text-decoration: none;
                font-weight: 600;
                margin-left: 5px;
            }
            
            .login-link:hover {
                color: #2d3748;
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
                 flex-direction: column;
                 align-items: flex-start;
                 gap: 10px;
             }
             
             .redirect-countdown {
                 font-size: 12px;
                 color: #38a169;
                 font-weight: 500;
                 margin-top: 5px;
             }
            
            @media (max-width: 480px) {
                .register-container {
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
        <div class="register-container">
            <!-- Header Section -->
            <div class="header-section">
                <div class="profile-icon">
                    <a href="home">
                        <img src="assets/icons/logok.png" alt="Profile Icon">
                    </a>
                </div>
                <h1 class="welcome-text">Tạo tài khoản mới</h1>
                <p class="subtitle">Vui lòng điền thông tin để đăng ký</p>
            </div>
            
                         <!-- Success Message -->
             <c:if test="${not empty successMessage}">
                 <div class="success-message" id="successMessage">
                     <i class="fas fa-check-circle"></i>
                     ${successMessage}
                                           <div class="redirect-countdown">Chuyển hướng đến trang đăng nhập sau <span id="countdown">3</span> giây...</div>
                 </div>
             </c:if>
            
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    ${error}
                </div>
            </c:if>
            
            <!-- Register Form -->
            <form action="register" method="POST" id="registerForm">
                <div class="form-group">
                    <div class="input-field">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" 
                               name="fullName" 
                               value="${not empty error ? fullName : ''}" 
                               placeholder="Họ và tên"
                               required>
                    </div>
                </div>
                
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
                         <i class="fas fa-phone input-icon"></i>
                         <input type="tel" 
                                name="phone" 
                                value="${not empty error ? phone : ''}" 
                                placeholder="Số điện thoại"
                                required>
                     </div>
                 </div>
                 
                 <div class="form-group">
                     <div class="input-field">
                         <i class="fas fa-lock input-icon"></i>
                         <input type="password" 
                                name="password" 
                                id="password"
                                placeholder="Mật khẩu"
                                required>
                         <button type="button" class="password-toggle" onclick="togglePassword('password')">
                             <i class="fas fa-eye" id="eye-icon-password"></i>
                         </button>
                     </div>
                 </div>
                
                <div class="form-group">
                    <div class="input-field">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" 
                               name="confirmPassword" 
                               id="confirmPassword"
                               placeholder="Xác nhận mật khẩu"
                               required>
                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                            <i class="fas fa-eye" id="eye-icon-confirm"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Terms Checkbox -->
                <div class="checkbox-container">
                    <div class="neumorphic-checkbox" onclick="toggleCheckbox(this)"></div>
                    <label class="checkbox-label">Tôi đồng ý với <a href="#" style="color: #4a5568; text-decoration: underline;">Điều khoản sử dụng</a> và <a href="#" style="color: #4a5568; text-decoration: underline;">Chính sách bảo mật</a></label>
                </div>
                
                <!-- Sign Up Button -->
                <button type="submit" class="signup-button" id="signupBtn" disabled>
                    Đăng ký
                </button>
            </form>
            
            <!-- Divider -->
            <div class="divider">
                <span class="divider-text">HOẶC TIẾP TỤC VỚI</span>
            </div>
            
            <!-- Social Login Buttons -->
            <div class="social-buttons">
                <button class="social-button" onclick="socialRegister('google')">
                    <i class="fab fa-google"></i>
                </button>
                <button class="social-button" onclick="socialRegister('github')">
                    <i class="fab fa-github"></i>
                </button>
                <button class="social-button" onclick="socialRegister('twitter')">
                    <i class="fab fa-twitter"></i>
                </button>
            </div>
            
            <!-- Login Section -->
            <div class="login-section">
                Đã có tài khoản?<a href="login" class="login-link">Đăng nhập</a>
            </div>
        </div>
        
        <script>
                         // Luôn reset form khi vào trang register
             document.addEventListener('DOMContentLoaded', function() {
                 const form = document.querySelector('form');
                 if (form) {
                     form.reset();
             
                     
                     const inputs = form.querySelectorAll('input');
                     inputs.forEach(input => {
                         input.value = '';
                     });
                 }
                 
                 // Kiểm tra checkbox để enable/disable button
                 checkTermsCheckbox();
                 
                 // Xử lý countdown và redirect nếu có success message
                 handleSuccessRedirect();
             });
             
             // Function xử lý countdown và redirect
             function handleSuccessRedirect() {
                 const successMessage = document.getElementById('successMessage');
                 if (successMessage) {
                     let countdown = 3;
                     const countdownElement = document.getElementById('countdown');
                     
                     const timer = setInterval(() => {
                         countdown--;
                         if (countdownElement) {
                             countdownElement.textContent = countdown;
                         }
                         
                         if (countdown <= 0) {
                             clearInterval(timer);
                             window.location.href = 'login';
                         }
                     }, 1000);
                 }
             }
            
            function togglePassword(fieldId) {
                const passwordInput = document.getElementById(fieldId);
                const eyeIcon = document.getElementById(fieldId === 'password' ? 'eye-icon-password' : 'eye-icon-confirm');
                
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
                checkTermsCheckbox();
            }
            
            function checkTermsCheckbox() {
                const checkbox = document.querySelector('.neumorphic-checkbox');
                const signupBtn = document.getElementById('signupBtn');
                
                if (checkbox.classList.contains('checked')) {
                    signupBtn.disabled = false;
                    signupBtn.style.opacity = '1';
                    signupBtn.style.cursor = 'pointer';
                } else {
                    signupBtn.disabled = true;
                    signupBtn.style.opacity = '0.6';
                    signupBtn.style.cursor = 'not-allowed';
                }
            }
            
            function socialRegister(provider) {
        
                alert('Tính năng đăng ký ' + provider + ' sẽ được phát triển sau!');
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
            
                         // Form validation
             document.getElementById('registerForm').addEventListener('submit', function(e) {
                 const password = document.getElementById('password').value;
                 const confirmPassword = document.getElementById('confirmPassword').value;
                 const phone = document.querySelector('input[name="phone"]').value;
                 const checkbox = document.querySelector('.neumorphic-checkbox');
                 
                 if (!checkbox.classList.contains('checked')) {
                     e.preventDefault();
                     alert('Vui lòng đồng ý với điều khoản sử dụng!');
                     return false;
                 }
                 
                 if (password !== confirmPassword) {
                     e.preventDefault();
                     alert('Mật khẩu xác nhận không khớp!');
                     return false;
                 }
                 
                 if (password.length < 6) {
                     e.preventDefault();
                     alert('Mật khẩu phải có ít nhất 6 ký tự!');
                     return false;
                 }
                 
                 if (!phone || phone.trim().length < 10) {
                     e.preventDefault();
                     alert('Số điện thoại phải có ít nhất 10 số!');
                     return false;
                 }
             });
             

        </script>
    </body>
</html>
