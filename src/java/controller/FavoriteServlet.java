package controller;

import data.dao.Database;
import data.dao.FavoriteDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Favorite;
import model.Product;
import model.User;
import model.Images;

/**
 * FavoriteServlet - Xử lý các thao tác với sản phẩm yêu thích
 * @author Duy Khánh
 */
public class FavoriteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("favorite?action=list");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listUserFavorites(request, response);
                    break;
                case "add":
                    addToFavorites(request, response);
                    break;
                case "remove":
                    removeFromFavorites(request, response);
                    break;
                case "check":
                    checkFavoriteStatus(request, response);
                    break;
                case "count":
                    getFavoriteCount(request, response);
                    break;
                default:
                    listUserFavorites(request, response);
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addToFavorites(request, response);
                    break;
                case "remove":
                    removeFromFavorites(request, response);
                    break;
                case "updateNote":
                    updateFavoriteNote(request, response);
                    break;
                default:
                    response.sendRedirect("favorite?action=list");
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FavoriteServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách sản phẩm yêu thích của người dùng
     */
    private void listUserFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            List<Favorite> userFavorites = favoriteDao.findByUserId(user.getId());
            
            // Lấy danh sách ảnh để hiển thị ảnh side view
            List<Images> listImage = Database.getImagesDao().findAll();
            
            
            
            // Cập nhật số lượng yêu thích trong session
            int favoriteCount = favoriteDao.countByUserId(user.getId());
            session.setAttribute("favoriteCount", favoriteCount);
            
            request.setAttribute("userFavorites", userFavorites);
            request.setAttribute("listImage", listImage);
            request.setAttribute("user", user);
            
            
            
            request.getRequestDispatcher("./views/favorites.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(FavoriteServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Error in listUserFavorites: " + ex.getMessage());
            ex.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách yêu thích: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Thêm sản phẩm vào danh sách yêu thích
     */
    private void addToFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        String note = request.getParameter("note");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            
            // Kiểm tra xem sản phẩm đã có trong yêu thích chưa
            if (favoriteDao.exists(user.getId(), productId)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Sản phẩm đã có trong danh sách yêu thích\"}");
                return;
            }
            
            // Thêm vào yêu thích
            Favorite favorite = new Favorite(user.getId(), productId, note);
            boolean success = favoriteDao.insert(favorite);
            
            if (success) {
                // Cập nhật số lượng yêu thích trong session
                int favoriteCount = favoriteDao.countByUserId(user.getId());
                session.setAttribute("favoriteCount", favoriteCount);
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã thêm vào yêu thích\", \"count\": " + favoriteCount + "}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể thêm vào yêu thích\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
        }
    }

    /**
     * Xóa sản phẩm khỏi danh sách yêu thích
     */
    private void removeFromFavorites(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            
            // Xóa khỏi yêu thích
            boolean success = favoriteDao.delete(user.getId(), productId);
            
            if (success) {
                // Cập nhật số lượng yêu thích trong session
                int favoriteCount = favoriteDao.countByUserId(user.getId());
                session.setAttribute("favoriteCount", favoriteCount);
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã xóa khỏi yêu thích\", \"count\": " + favoriteCount + "}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa khỏi yêu thích\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
        }
    }

    /**
     * Kiểm tra trạng thái yêu thích của sản phẩm
     */
    private void checkFavoriteStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": false, \"message\": \"Chưa đăng nhập\"}");
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            
            boolean isFavorite = favoriteDao.exists(user.getId(), productId);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": " + isFavorite + "}");
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
        }
    }

        /**
     * Cập nhật ghi chú cho sản phẩm yêu thích
     */
    private void updateFavoriteNote(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        String note = request.getParameter("note");
        
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            
            // Cập nhật ghi chú
            boolean success = favoriteDao.updateNote(user.getId(), productId, note);
            
            if (success) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã cập nhật ghi chú\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể cập nhật ghi chú\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID sản phẩm không hợp lệ\"}");
        }
    }

    /**
     * Lấy số lượng sản phẩm yêu thích của người dùng
     */
    private void getFavoriteCount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Chưa đăng nhập\"}");
            return;
        }
        
        try {
            FavoriteDao favoriteDao = Database.getFavoriteDao();
            int favoriteCount = favoriteDao.countByUserId(user.getId());
            
            // Cập nhật số lượng yêu thích trong session
            session.setAttribute("favoriteCount", favoriteCount);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"count\": " + favoriteCount + "}");
            
        } catch (Exception ex) {
            Logger.getLogger(FavoriteServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi lấy số lượng yêu thích\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "FavoriteServlet - Quản lý sản phẩm yêu thích";
    }
}
