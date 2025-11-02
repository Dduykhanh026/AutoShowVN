package controller;

import data.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 * ProfileServlet handles user profile operations
 */
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // User not logged in, redirect to login
            response.sendRedirect("login");
            return;
        }
        
        try {
            // Get fresh user data from database
            User freshUser = Database.getUserDao().find(user.getId());
            if (freshUser != null) {
                request.setAttribute("user", freshUser);
                // Update session with fresh data
                session.setAttribute("user", freshUser);
                session.setAttribute("userName", freshUser.getFullName());
            }
            
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("./views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "update":
                    updateProfile(request, response, user);
                    break;
                case "changePassword":
                    changePassword(request, response, user);
                    break;
                default:
                    response.sendRedirect("profile");
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("./views/error.jsp").forward(request, response);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists for another user
        User existingUser = Database.getUserDao().findByEmail(email);
        if (existingUser != null && existingUser.getId() != user.getId()) {
            request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản khác");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Update user information
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        
        boolean success = Database.getUserDao().update(user);
        
        if (success) {
            // Update session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getFullName());
            
            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại sau.");
        }
        
        request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin mật khẩu");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Check if new password matches confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Check if new password is different from current
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("error", "Mật khẩu mới phải khác mật khẩu hiện tại");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Validate current password (you might want to hash this)
        if (!currentPassword.equals(user.getPasswordHash())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng");
            request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
            return;
        }
        
        // Update password
        user.setPasswordHash(newPassword);
        boolean success = Database.getUserDao().update(user);
        
        if (success) {
            // Update session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại sau.");
        }
        
        request.getRequestDispatcher("./views/profile.jsp").forward(request, response);
    }
}
