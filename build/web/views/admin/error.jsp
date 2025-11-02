<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi - Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            .error-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .error-card {
                background: white;
                border-radius: 16px;
                padding: 3rem;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                border: 1px solid #f0f0f0;
                text-align: center;
                max-width: 500px;
                width: 100%;
            }
            
            .error-icon {
                font-size: 4rem;
                color: #dc3545;
                margin-bottom: 1.5rem;
            }
            
            .error-title {
                color: #dc3545;
                font-size: 2rem;
                font-weight: 600;
                margin-bottom: 1rem;
            }
            
            .error-message {
                color: #6c757d;
                font-size: 1.1rem;
                margin-bottom: 2rem;
                line-height: 1.6;
            }
            
            .btn-back {
                background: #333;
                color: white;
                border: none;
                padding: 0.75rem 2rem;
                border-radius: 8px;
                font-weight: 500;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.3s ease;
            }
            
            .btn-back:hover {
                background: #555;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                color: white;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="error-card">
                <div class="error-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                
                <h1 class="error-title">Đã xảy ra lỗi!</h1>
                
                <div class="error-message">
                    <c:choose>
                        <c:when test="${not empty error}">
                            ${error}
                        </c:when>
                        <c:otherwise>
                            Có lỗi không xác định đã xảy ra. Vui lòng thử lại sau.
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <a href="admin?action=dashboard" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Quay về Dashboard
                </a>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
