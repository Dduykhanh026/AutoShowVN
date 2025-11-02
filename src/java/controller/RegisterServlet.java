package controller;

import data.dao.UserDao;
import data.impl.UserImpl;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="RegisterServlet", urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet {
    
    private UserDao userDao;
    
    @Override
    public void init() throws ServletException {
        userDao = new UserImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang đăng ký
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
                 // Lấy thông tin từ form
         String fullName = request.getParameter("fullName");
         String email = request.getParameter("email");
         String phone = request.getParameter("phone");
         String password = request.getParameter("password");
         String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation cơ bản
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập họ và tên!");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
                 if (email == null || email.trim().isEmpty()) {
             request.setAttribute("error", "Vui lòng nhập email!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
         
         if (phone == null || phone.trim().isEmpty()) {
             request.setAttribute("error", "Vui lòng nhập số điện thoại!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
        
                 if (password == null || password.trim().isEmpty()) {
             request.setAttribute("error", "Vui lòng nhập mật khẩu!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
         
         if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
             request.setAttribute("error", "Vui lòng xác nhận mật khẩu!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
         
         if (!password.equals(confirmPassword)) {
             request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
         
         if (password.length() < 6) {
             request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             return;
         }
        
        try {
            // Kiểm tra email đã tồn tại chưa
            boolean emailExists = userDao.emailExists(email);
                         if (emailExists) {
                 request.setAttribute("error", "Email này đã được sử dụng! Vui lòng chọn email khác.");
                 request.setAttribute("fullName", fullName);
                 request.setAttribute("email", email);
                 request.setAttribute("phone", phone);
                 request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                 return;
             }
            
                         // Tạo user mới
             User newUser = new User();
             newUser.setFullName(fullName.trim());
             newUser.setEmail(email.trim().toLowerCase());
             newUser.setPhone(phone.trim()); // Lưu số điện thoại từ form
             newUser.setPasswordHash(password); // Trong thực tế nên hash password
             newUser.setRole("customer"); // Sử dụng "customer" cho user thường
            
            // Lưu user vào database
            boolean success = userDao.insert(newUser);
            
            if (success) {
                // Đăng ký thành công
                request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/views/register.jsp").forward(request, response);
                         } else {
                 // Lỗi khi tạo user
                 request.setAttribute("error", "Có lỗi xảy ra khi đăng ký! Vui lòng thử lại.");
                 request.setAttribute("fullName", fullName);
                 request.setAttribute("email", email);
                 request.setAttribute("phone", phone);
                 request.getRequestDispatcher("/views/register.jsp").forward(request, response);
             }
            
        } catch (Exception e) {
            // Log lỗi
            e.printStackTrace();
            
                         request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại sau.");
             request.setAttribute("fullName", fullName);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
