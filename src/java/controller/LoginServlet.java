/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.UserDao;
import data.dao.FavoriteDao;
import data.impl.UserImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

/**
 * LoginServlet handles user authentication
 * @author Duy Khánh
 */
public class LoginServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserImpl();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the login form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Test database connection

        ((UserImpl) userDao).testDatabase();
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect to home
            response.sendRedirect("home");
            return;
        }
        
        // Kiểm tra nếu đây là logout
        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            // Thêm cache control headers để tránh browser cache
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            
            // Set attribute để JSP biết đây là logout
            request.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");
    
        }
        
        // Forward to login.jsp
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes login form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Authenticate user
            User user = userDao.authenticate(email.trim(), password);
            
            if (user != null) {
                // Login successful
        
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("userName", user.getFullName());
                
                // Get and set favorite count for the user
                try {
                    data.dao.FavoriteDao favoriteDao = data.dao.Database.getFavoriteDao();
                    int favoriteCount = favoriteDao.countByUserId(user.getId());
                    session.setAttribute("favoriteCount", favoriteCount);
            
                } catch (Exception e) {
                    System.err.println("Error getting favorite count: " + e.getMessage());
                    session.setAttribute("favoriteCount", 0);
                }
                
                // Redirect based on role
                if ("admin".equalsIgnoreCase(user.getRole()) || "A".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("admin?action=dashboard");
                } else {
                    response.sendRedirect("home");
                }
            } else {
                // Login failed
                request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Handle any errors
            System.err.println(" Exception during login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại sau!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet for user authentication";
    }
}
