package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;
import model.Product;
import model.Images;
import model.Categories;
import model.Order;
import model.OrderItem;
import data.dao.UserDao;
import data.dao.ProductDao;
import data.dao.ImagesDao;
import data.dao.CategoriesDao;
import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.impl.UserImpl;
import data.impl.ProductImpl;
import data.impl.ImagesImpl;
import data.impl.CategoriesImpl;
import data.impl.OrderImpl;
import data.impl.OrderItemImpl;
import data.driver.MySQLDriver;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AdminServlet extends HttpServlet {

    private UserDao userDao;
    private ProductDao productDao;
    private ImagesDao imagesDao;
    private CategoriesDao categoriesDao;
    private OrderDao orderDao;
    private OrderItemDao orderItemDao;

    @Override
    public void init() throws ServletException {
        try {
            userDao = new UserImpl();
            productDao = new ProductImpl();
            imagesDao = new ImagesImpl();
            categoriesDao = new CategoriesImpl();
            orderDao = new OrderImpl();
            orderItemDao = new OrderItemImpl();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kiểm tra quyền admin với validation tốt hơn
        if (!isValidAdminSession(session)) {
            response.sendRedirect("login?error=unauthorized&redirect=admin");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }
        
        try {
            switch (action) {
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "users":
                    showUsers(request, response);
                    break;
                case "products":
                    showProducts(request, response);
                    break;
                case "orders":
            
                    showOrders(request, response);
                    break;
                case "viewOrder":
                    viewOrder(request, response);
                    break;
                case "editOrder":
                    showEditOrder(request, response);
                    break;
                case "updateOrder":
                    updateOrder(request, response);
                    break;
                case "deleteOrder":
                    deleteOrder(request, response);
                    break;
                case "updateOrderStatus":
                    updateOrderStatus(request, response);
                    break;
                case "testDatabase":
                    testDatabaseConnection(request, response);
                    break;
                case "reports":
                    showReports(request, response);
                    break;
                case "settings":
                    showSettings(request, response);
                    break;
                case "addUser":
                    if ("POST".equals(request.getMethod())) {
                        addUser(request, response);
                    } else {
                        showAddUser(request, response);
                    }
                    break;
                case "editUser":
                    showEditUser(request, response);
                    break;
                case "updateUser":
                    updateUser(request, response);
                    break;
                case "deleteUser":
                    deleteUser(request, response);
                    break;
                case "addProduct":
                    showAddProduct(request, response);
                    break;
                case "editProduct":
                    showEditProduct(request, response);
                    break;
                case "viewProduct":
                    showViewProduct(request, response);
                    break;
                case "updateProduct":
                    updateProduct(request, response);
                    break;
                case "deleteProduct":
                    deleteProduct(request, response);
                    break;
                case "viewOrders":
                    showViewOrders(request, response);
                    break;
                case "generateReport":
                    generateReport(request, response);
                    break;
                case "logout":
                    logout(request, response);
                    break;
                case "searchUsers":
                    searchUsers(request, response);
                    break;
                case "searchProducts":
                    searchProducts(request, response);
                    break;
                case "getUserStats":
                    getUserStats(request, response);
                    break;
                case "getProductStats":
                    getProductStats(request, response);
                    break;
                case "testDatabaseUpdate":
                    testDatabaseUpdate(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            
            // Kiểm tra xem response đã được commit chưa
            if (!response.isCommitted()) {
                request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
                try {
                    request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
                } catch (Exception forwardException) {
                    // Nếu không thể forward, ghi error trực tiếp
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().write("<html><body><h1>Lỗi</h1><p>Có lỗi xảy ra: " + e.getMessage() + "</p></body></html>");
                }
            } else {
                // Response đã được commit, ghi error trực tiếp
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().write("<html><body><h1>Lỗi</h1><p>Có lỗi xảy ra: " + e.getMessage() + "</p></body></html>");
                } catch (Exception writeException) {
                    // Không thể ghi gì cả, chỉ log
                    System.err.println("Không thể ghi error response: " + writeException.getMessage());
                }
            }
        }
    }

    // Kiểm tra session admin hợp lệ
    private boolean isValidAdminSession(HttpSession session) {
        if (session == null) return false;
        
        String userRole = (String) session.getAttribute("userRole");
        Object userIdObj = session.getAttribute("userId");
        
        // Xử lý userId có thể là Integer hoặc String
        if (userIdObj == null) return false;
        
        String userId;
        if (userIdObj instanceof Integer) {
            userId = String.valueOf(userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        } else {
            return false;
        }
        
        return userRole != null && !userId.isEmpty() && 
               ("admin".equals(userRole) || "A".equals(userRole));
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        // Lấy thống kê tổng quan từ database
        int totalUsers = getTotalUsers();
        int totalProducts = getTotalProducts();
        int totalOrders = getTotalOrders();
        double totalRevenue = getTotalRevenue();
        
        // Thêm thống kê mới
        int activeUsers = getActiveUsers();
        int newUsers = getNewUsers();
        int adminUsers = getAdminUsers();
        int totalCategories = getTotalCategories();
        int lowStockProducts = getLowStockProducts();
        double totalProductValue = getTotalProductValue();
        
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("newUsers", newUsers);
        request.setAttribute("adminUsers", adminUsers);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("totalProductValue", totalProductValue);
        
        // Thêm thông tin user hiện tại
        request.setAttribute("currentUser", getCurrentUserFromSession(request));
        
        request.getRequestDispatcher("views/admin/dashboard.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        // Lấy thống kê users từ database
        int totalUsers = getTotalUsers();
        int activeUsers = getActiveUsers();
        int newUsers = getNewUsers();
        int adminUsers = getAdminUsers();
        
        // Lấy các tham số lọc từ request
        String searchTerm = request.getParameter("search");
        String roleFilter = request.getParameter("role");
        String statusFilter = request.getParameter("status");
        
        List<User> users;
        
        // Áp dụng các bộ lọc
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            users = searchUsersByTerm(searchTerm);
        } else {
            users = getAllUsers();
        }
        
        // Lọc theo role
        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
            users = filterUsersByRole(users, roleFilter);
        }
        
        // Lọc theo status (có thể mở rộng sau)
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            users = filterUsersByStatus(users, statusFilter);
        }
        
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("newUsers", newUsers);
        request.setAttribute("adminUsers", adminUsers);
        request.setAttribute("users", users);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("roleFilter", roleFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("currentUser", getCurrentUserFromSession(request));
        
        request.getRequestDispatcher("views/admin/users.jsp").forward(request, response);
    }

    private void showProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        // Lấy các tham số lọc từ request
        String searchTerm = request.getParameter("search");
        String categoryFilter = request.getParameter("category");
        String statusFilter = request.getParameter("status");
        
        List<Product> products;
        
        // Áp dụng các bộ lọc
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            products = searchProductsByTerm(searchTerm);
        } else {
            products = productDao.findAll();
        }
        
        // Lọc theo category
        if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
            products = filterProductsByCategory(products, categoryFilter);
        }
        
        // Lọc theo status (có thể mở rộng sau)
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            products = filterProductsByStatus(products, statusFilter);
        }
        
        List<Images> allImages = imagesDao.findAll();
        
        // Lấy thống kê sản phẩm
        int totalProducts = products.size();
        int totalCategories = getTotalCategories();
        int lowStockProducts = getLowStockProducts();
        double totalProductValue = getTotalProductValue();
        
        request.setAttribute("products", products);
        request.setAttribute("allImages", allImages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("totalProductValue", totalProductValue);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("categoryFilter", categoryFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("currentUser", getCurrentUserFromSession(request));
        
        request.getRequestDispatcher("views/admin/products.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("🚀 ADMIN SERVLET - showOrders() method called!");
        try {
            // Lấy các tham số lọc
            String status = request.getParameter("status");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            String search = request.getParameter("search");
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            int pageSize = 10;
            int offset = (page - 1) * pageSize;
            
            // Debug logging
            System.out.println("=== DEBUG SHOW ORDERS ===");
            System.out.println("Status: " + status);
            System.out.println("DateFrom: " + dateFrom);
            System.out.println("DateTo: " + dateTo);
            System.out.println("Search: " + search);
            System.out.println("Page: " + page);
            System.out.println("PageSize: " + pageSize);
            System.out.println("Offset: " + offset);
            
            // Kiểm tra orderDao có null không
            if (orderDao == null) {
                System.err.println(" ERROR: orderDao is NULL!");
                request.setAttribute("error", "Lỗi hệ thống: OrderDao không được khởi tạo");
                request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
                return;
            }
            
            System.out.println(" orderDao is not null, calling findWithFilters...");
            
            // Lấy danh sách orders với filter và pagination
            List<Order> orders = getOrdersWithFilters(status, dateFrom, dateTo, search, pageSize, offset);
            
            int totalOrders = getTotalOrdersWithFilters(status, dateFrom, dateTo, search);
            
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            
            // Lấy thống kê
            int pendingOrders = getOrderCountByStatus("unconfirmed");
            int shippedOrders = getOrderCountByStatus("in delivery");
            int deliveredOrders = getOrderCountByStatus("delivered");
            
            // Set attributes
            request.setAttribute("orders", orders);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("shippedOrders", shippedOrders);
            request.setAttribute("deliveredOrders", deliveredOrders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            

            request.getRequestDispatcher("views/admin/orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
        }
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement reports
        request.getRequestDispatcher("views/admin/reports.jsp").forward(request, response);
    }

    private void showSettings(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement settings
        request.getRequestDispatcher("views/admin/settings.jsp").forward(request, response);
    }

    private void showAddUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("views/admin/add-user.jsp").forward(request, response);
    }

    private void showEditUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String userId = request.getParameter("id");
        if (userId != null) {
            User user = getUserById(Integer.parseInt(userId));
            request.setAttribute("user", user);
        }
        request.getRequestDispatcher("views/admin/edit-user.jsp").forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            // Lấy thông tin user từ form
            int userId = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            String newPassword = request.getParameter("newPassword");
            
            // Lấy user hiện tại từ database
            User currentUser = getUserById(userId);
            if (currentUser == null) {
                request.setAttribute("error", "Không tìm thấy user với ID: " + userId);
                response.sendRedirect("admin?action=users");
                return;
            }
            
            // Kiểm tra email có bị trùng với user khác không
            if (!email.equals(currentUser.getEmail())) {
                if (userDao.emailExists(email)) {
                    request.setAttribute("error", "Email đã tồn tại trong hệ thống!");
                    request.setAttribute("user", currentUser);
                    request.getRequestDispatcher("views/admin/edit-user.jsp").forward(request, response);
                    return;
                }
            }
            
            // Cập nhật thông tin user
            User updatedUser = new User();
            updatedUser.setId(userId);
            updatedUser.setFullName(fullName);
            updatedUser.setEmail(email);
            updatedUser.setPhone(phone);
            updatedUser.setRole(role);
            
            // Xử lý mật khẩu mới nếu có
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                // Trong thực tế, nên hash password trước khi lưu
                updatedUser.setPasswordHash(newPassword);
            } else {
                // Giữ nguyên mật khẩu cũ
                updatedUser.setPasswordHash(currentUser.getPasswordHash());
            }
            
            // Cập nhật user vào database
            boolean updateSuccess = userDao.update(updatedUser);
            
            if (updateSuccess) {
                // Cập nhật thành công
                request.setAttribute("success", "Cập nhật user thành công!");
                
                // Lấy lại thông tin user đã cập nhật
                User refreshedUser = getUserById(userId);
                request.setAttribute("user", refreshedUser);
                
                // Forward về trang edit với thông báo thành công
                request.getRequestDispatcher("views/admin/edit-user.jsp").forward(request, response);
            } else {
                // Cập nhật thất bại
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật user. Vui lòng thử lại.");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("views/admin/edit-user.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            response.sendRedirect("admin?action=users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("admin?action=users");
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            // Lấy thông tin user từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            String password = request.getParameter("password");
            
            // Kiểm tra email đã tồn tại chưa
            if (userDao.emailExists(email)) {
                // Trả về response cho AJAX
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("error: Email đã tồn tại trong hệ thống!");
                return;
            }
            
            // Tạo user mới
            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setRole(role);
            // Trong thực tế, nên hash password trước khi lưu
            newUser.setPasswordHash(password);
            
            // Thêm user vào database
            boolean addSuccess = userDao.insert(newUser);
            
            if (addSuccess) {
                // Thêm thành công - trả về response cho AJAX
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("success: Thêm user mới thành công!");
            } else {
                // Thêm thất bại - trả về response cho AJAX
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("error: Có lỗi xảy ra khi thêm user. Vui lòng thử lại.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Có lỗi xảy ra - trả về response cho AJAX
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("error: Có lỗi xảy ra: " + e.getMessage());
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            String userId = request.getParameter("id");
            if (userId != null) {
                boolean success = deleteUserById(Integer.parseInt(userId));
                if (success) {
                    // Trả về JSON response với thông tin cập nhật
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    
                    // Lấy lại danh sách users sau khi xóa
                    List<User> updatedUsers = getAllUsers();
                    int totalUsers = updatedUsers.size();
                    int activeUsers = getActiveUsers();
                    int newUsers = getNewUsers();
                    int adminUsers = getAdminUsers();
                    
                    StringBuilder json = new StringBuilder();
                    json.append("{");
                    json.append("\"success\": true,");
                    json.append("\"message\": \"Xóa user thành công!\",");
                    json.append("\"totalUsers\": ").append(totalUsers).append(",");
                    json.append("\"activeUsers\": ").append(activeUsers).append(",");
                    json.append("\"newUsers\": ").append(newUsers).append(",");
                    json.append("\"adminUsers\": ").append(adminUsers).append(",");
                    json.append("\"users\": [");
                    
                    for (int i = 0; i < updatedUsers.size(); i++) {
                        User user = updatedUsers.get(i);
                        json.append("{");
                        json.append("\"id\":").append(user.getId()).append(",");
                        json.append("\"fullName\":\"").append(user.getFullName() != null ? user.getFullName() : "").append("\",");
                        json.append("\"email\":\"").append(user.getEmail() != null ? user.getEmail() : "").append("\",");
                        json.append("\"phone\":\"").append(user.getPhone() != null ? user.getPhone() : "").append("\",");
                        json.append("\"role\":\"").append(user.getRole() != null ? user.getRole() : "").append("\"");
                        json.append("}");
                        if (i < updatedUsers.size() - 1) json.append(",");
                    }
                    
                    json.append("]}");
                    response.getWriter().write(json.toString());
                } else {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra khi xóa user!\"}");
                }
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"ID user không hợp lệ!\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }

    private void showAddProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("views/admin/add-product.jsp").forward(request, response);
    }

    private void showEditProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String productId = request.getParameter("id");
        if (productId != null) {
            Product product = productDao.find(Integer.parseInt(productId));
            List<Images> productImages = imagesDao.findByProductId(Integer.parseInt(productId));
            request.setAttribute("product", product);
            request.setAttribute("productImages", productImages);
        }
        request.getRequestDispatcher("views/admin/edit-product.jsp").forward(request, response);
    }

    private void showViewProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String productId = request.getParameter("id");
        if (productId != null) {
            Product product = productDao.find(Integer.parseInt(productId));
            List<Images> productImages = imagesDao.findByProductId(Integer.parseInt(productId));
            request.setAttribute("product", product);
            request.setAttribute("productImages", productImages);
        }
        request.getRequestDispatcher("views/product-detail.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            // Lấy thông tin sản phẩm từ form
            int productId = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int categoryId = Integer.parseInt(request.getParameter("category"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            
            // Xử lý các trường có thể null
            int year = 0;
            try {
                year = Integer.parseInt(request.getParameter("year"));
            } catch (NumberFormatException e) {
                year = 0; // Giá trị mặc định
            }
            
            String engine = request.getParameter("engine");
            if (engine != null && engine.trim().isEmpty()) {
                engine = null;
            }
            
            int horsepower = 0;
            try {
                horsepower = Integer.parseInt(request.getParameter("horsepower"));
            } catch (NumberFormatException e) {
                horsepower = 0; // Giá trị mặc định
            }
            
            int torque = 0;
            try {
                torque = Integer.parseInt(request.getParameter("torque"));
            } catch (NumberFormatException e) {
                torque = 0; // Giá trị mặc định
            }
            
            int topSpeed = 0;
            try {
                topSpeed = Integer.parseInt(request.getParameter("topSpeed"));
            } catch (NumberFormatException e) {
                topSpeed = 0; // Giá trị mặc định
            }
            
            String description = request.getParameter("description");
            if (description != null && description.trim().isEmpty()) {
                description = null;
            }
            
            // Lấy sản phẩm hiện tại từ database
            Product currentProduct = productDao.find(productId);
            if (currentProduct == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm với ID: " + productId);
                response.sendRedirect("admin?action=products");
                return;
            }
            
            // Cập nhật thông tin sản phẩm
            Product updatedProduct = new Product();
            updatedProduct.setId(productId);
            updatedProduct.setCategoryId(categoryId);
            updatedProduct.setName(name);
            updatedProduct.setPrice(price);
            updatedProduct.setYear(year);
            updatedProduct.setEngine(engine);
            updatedProduct.setHorsepower(horsepower);
            updatedProduct.setTorque(torque);
            updatedProduct.setTopSpeed(topSpeed);
            updatedProduct.setDescription(description);
            
            // Xử lý hình ảnh nếu có upload mới
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                // Có file mới được upload
                String fileName = getSubmittedFileName(filePart);
                if (fileName != null && !fileName.trim().isEmpty()) {
                    // Lưu file mới và cập nhật đường dẫn
                    String newImagePath = saveUploadedFile(filePart, request);
                    if (newImagePath != null) {
                        updatedProduct.setImage(newImagePath);
                    } else {
                        // Nếu lưu file thất bại, giữ nguyên hình cũ
                        updatedProduct.setImage(currentProduct.getImage());
                    }
                } else {
                    // Không có file mới, giữ nguyên hình cũ
                    updatedProduct.setImage(currentProduct.getImage());
                }
            } else {
                // Không có file mới, giữ nguyên hình cũ
                updatedProduct.setImage(currentProduct.getImage());
            }
            
            // Cập nhật sản phẩm vào database
            boolean updateSuccess = productDao.update(updatedProduct);
            
            if (updateSuccess) {
                // Cập nhật thành công
                request.setAttribute("success", "Cập nhật sản phẩm thành công!");
                
                // Lấy lại thông tin sản phẩm đã cập nhật
                Product refreshedProduct = productDao.find(productId);
                request.setAttribute("product", refreshedProduct);
                
                // Forward về trang edit với thông báo thành công
                request.getRequestDispatcher("views/admin/edit-product.jsp").forward(request, response);
            } else {
                // Cập nhật thất bại
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm. Vui lòng thử lại.");
                request.setAttribute("product", currentProduct);
                request.getRequestDispatcher("views/admin/edit-product.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            response.sendRedirect("admin?action=products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("admin?action=products");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            String productId = request.getParameter("id");
            if (productId != null && !productId.trim().isEmpty()) {
                int id = Integer.parseInt(productId);
                boolean success = productDao.delete(id);
                
                // Set content type và encoding
                response.setContentType("text/plain;charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("error: Invalid product ID");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("error: Invalid product ID format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error: " + e.getMessage());
        }
    }

    private void showViewOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement view orders
        request.getRequestDispatcher("views/admin/view-orders.jsp").forward(request, response);
    }

    private void generateReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // TODO: Implement report generation
        response.getWriter().write("Report generated successfully");
    }

    // Database methods using DAOs
    private int getTotalUsers() throws SQLException {
        try {
            List<User> allUsers = userDao.findAll();
            return allUsers != null ? allUsers.size() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getActiveUsers() throws SQLException {
        try {
            // Giả sử tất cả users đều active (cần thêm field status vào User model)
            List<User> allUsers = userDao.findAll();
            return allUsers != null ? allUsers.size() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getNewUsers() throws SQLException {
        try {
            // Giả sử 20% users mới
            List<User> allUsers = userDao.findAll();
            return allUsers != null ? (int)(allUsers.size() * 0.2) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getAdminUsers() throws SQLException {
        try {
            List<User> adminUsers = userDao.findByRole("admin");
            List<User> adminUsersA = userDao.findByRole("A");
            int totalAdminUsers = (adminUsers != null ? adminUsers.size() : 0) + 
                                 (adminUsersA != null ? adminUsersA.size() : 0);
            return totalAdminUsers;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getTotalProducts() throws SQLException {
        try {
            List<Product> allProducts = productDao.findAll();
            return allProducts != null ? allProducts.size() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getTotalCategories() throws SQLException {
        try {
            // Đếm số category khác nhau
            List<Product> allProducts = productDao.findAll();
            if (allProducts == null) return 0;
            
            java.util.Set<Integer> categories = new java.util.HashSet<>();
            for (Product product : allProducts) {
                categories.add(product.getCategoryId());
            }
            return categories.size();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getLowStockProducts() throws SQLException {
        // Giả sử sản phẩm có giá < 1000000 là low stock
        try {
            List<Product> allProducts = productDao.findAll();
            if (allProducts == null) return 0;
            
            int count = 0;
            for (Product product : allProducts) {
                if (product.getPrice() != null && product.getPrice().doubleValue() < 1000000) {
                    count++;
                }
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private double getTotalProductValue() throws SQLException {
        try {
            List<Product> allProducts = productDao.findAll();
            if (allProducts == null) return 0.0;
            
            double total = 0.0;
            for (Product product : allProducts) {
                if (product.getPrice() != null) {
                    total += product.getPrice().doubleValue();
                }
            }
            return total;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    private int getTotalOrders() throws SQLException {
        try {
            return orderDao.countAll();
        } catch (Exception e) {
            System.err.println(" Error getting total orders: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    private double getTotalRevenue() throws SQLException {
        try {
            // Lấy tổng doanh thu từ tất cả đơn hàng đã giao
            String sql = "SELECT COALESCE(SUM(total_amount), 0) as total_revenue FROM orders WHERE status IN ('delivered', 'confirmed')";
            
            try (Connection conn = MySQLDriver.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                if (rs.next()) {
                    double revenue = rs.getDouble("total_revenue");
                    System.out.println("💰 Total revenue from database: " + revenue);
                    return revenue;
                }
            }
            return 0.0;
        } catch (Exception e) {
            System.err.println(" Error getting total revenue: " + e.getMessage());
            e.printStackTrace();
            return 0.0;
        }
    }

    private List<User> getAllUsers() throws SQLException {
        try {
            return userDao.findAll();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private User getUserById(int userId) throws SQLException {
        try {
            return userDao.find(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private boolean deleteUserById(int userId) throws SQLException {
        try {
            return userDao.delete(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Lấy session hiện tại
            HttpSession session = request.getSession(false);
            if (session != null) {
                // Xóa tất cả attributes trong session
                session.removeAttribute("user");
                session.removeAttribute("userId");
                session.removeAttribute("userRole");
                session.removeAttribute("userName");
                session.removeAttribute("loginTime");
                
                // Invalidate session hoàn toàn
                session.invalidate();
                System.out.println(" Admin đã đăng xuất thành công - Session đã được xóa hoàn toàn");
            }
            
            // Thêm cache control headers để tránh browser cache
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            
            // Redirect về trang login với parameter để force refresh
            response.sendRedirect("login?logout=true&t=" + System.currentTimeMillis());
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, vẫn redirect về login
            response.sendRedirect("login?logout=true&error=1");
        }
    }

    // Thêm các method mới
    private void searchUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String searchTerm = request.getParameter("term");
        List<User> users = searchUsersByTerm(searchTerm);
        
        // Trả về JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            json.append("{");
            json.append("\"id\":").append(user.getId()).append(",");
            json.append("\"fullName\":\"").append(user.getFullName()).append("\",");
            json.append("\"email\":\"").append(user.getEmail()).append("\",");
            json.append("\"role\":\"").append(user.getRole()).append("\"");
            json.append("}");
            if (i < users.size() - 1) json.append(",");
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String searchTerm = request.getParameter("term");
        List<Product> products = searchProductsByTerm(searchTerm);
        
        // Trả về JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);
            json.append("{");
            json.append("\"id\":").append(product.getId()).append(",");
            json.append("\"name\":\"").append(product.getName()).append("\",");
            json.append("\"price\":").append(product.getPrice()).append(",");
            json.append("\"year\":").append(product.getYear());
            json.append("}");
            if (i < products.size() - 1) json.append(",");
        }
        json.append("]");
        
        response.getWriter().write(json.toString());
    }

    private void getUserStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Trả về thống kê user dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        int totalUsers = getTotalUsers();
        int activeUsers = getActiveUsers();
        int newUsers = getNewUsers();
        int adminUsers = getAdminUsers();
        
        String json = String.format(
            "{\"totalUsers\":%d,\"activeUsers\":%d,\"newUsers\":%d,\"adminUsers\":%d}",
            totalUsers, activeUsers, newUsers, adminUsers
        );
        
        response.getWriter().write(json);
    }

    private void getProductStats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Trả về thống kê product dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        int totalProducts = getTotalProducts();
        int totalCategories = getTotalCategories();
        int lowStockProducts = getLowStockProducts();
        double totalProductValue = getTotalProductValue();
        
        String json = String.format(
            "{\"totalProducts\":%d,\"totalCategories\":%d,\"lowStockProducts\":%d,\"totalProductValue\":%.2f}",
            totalProducts, totalCategories, lowStockProducts, totalProductValue
        );
        
        response.getWriter().write(json);
    }

    // Helper methods
    private List<User> searchUsersByTerm(String searchTerm) throws SQLException {
        try {
            List<User> allUsers = userDao.findAll();
            List<User> filteredUsers = new ArrayList<>();
            
            if (searchTerm == null || searchTerm.trim().isEmpty()) {
                return allUsers;
            }
            
            String term = searchTerm.toLowerCase().trim();
            for (User user : allUsers) {
                if (user.getFullName() != null && user.getFullName().toLowerCase().contains(term) ||
                    user.getEmail() != null && user.getEmail().toLowerCase().contains(term) ||
                    user.getPhone() != null && user.getPhone().contains(term)) {
                    filteredUsers.add(user);
                }
            }
            return filteredUsers;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private List<Product> searchProductsByTerm(String searchTerm) throws SQLException {
        try {
            List<Product> allProducts = productDao.findAll();
            List<Product> filteredProducts = new ArrayList<>();
            
            if (searchTerm == null || searchTerm.trim().isEmpty()) {
                return allProducts;
            }
            
            String term = searchTerm.toLowerCase().trim();
            for (Product product : allProducts) {
                if (product.getName() != null && product.getName().toLowerCase().contains(term) ||
                    product.getDescription() != null && product.getDescription().toLowerCase().contains(term) ||
                    product.getEngine() != null && product.getEngine().toLowerCase().contains(term)) {
                    filteredProducts.add(product);
                }
            }
            return filteredProducts;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private User getCurrentUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");
        
        if (userIdObj != null) {
            try {
                int userId;
                if (userIdObj instanceof Integer) {
                    userId = (Integer) userIdObj;
                } else if (userIdObj instanceof String) {
                    userId = Integer.parseInt((String) userIdObj);
                } else {
                    return null;
                }
                return userDao.find(userId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    
    private List<Product> filterProductsByCategory(List<Product> products, String categoryFilter) {
        List<Product> filteredProducts = new ArrayList<>();
        
        if (categoryFilter == null || categoryFilter.trim().isEmpty()) {
            return products;
        }
        
        String filter = categoryFilter.toLowerCase().trim();
        System.out.println("🔍 Filtering by category: '" + filter + "'");
        System.out.println("📊 Total products before filtering: " + products.size());
        
        for (Product product : products) {
            int categoryId = product.getCategoryId();
            String productName = product.getName();
            System.out.println("   Product: " + productName + " (ID: " + product.getId() + ", CategoryID: " + categoryId + ")");
            
            // Sửa lại mapping theo database thực tế:
            // id 4 = Panamera, id 6 = Cayenne
            if (filter.equals("718") && categoryId == 1) {
                System.out.println("    718 Series match found: " + productName);
                filteredProducts.add(product);
            } else if (filter.equals("911") && categoryId == 2) {
                System.out.println("    911 Series match found: " + productName);
                filteredProducts.add(product);
            } else if (filter.equals("taycan") && categoryId == 3) {
                System.out.println("    Taycan match found: " + productName);
                filteredProducts.add(product);
            } else if (filter.equals("panamera") && categoryId == 4) {
                System.out.println("    Panamera match found: " + productName);
                filteredProducts.add(product);
            } else if (filter.equals("macan") && categoryId == 5) {
                System.out.println("    Macan match found: " + productName);
                filteredProducts.add(product);
            } else if (filter.equals("cayenne") && categoryId == 6) {
                System.out.println("    Cayenne match found: " + productName);
                filteredProducts.add(product);
            } else {
                System.out.println("    No match for filter '" + filter + "' with categoryId " + categoryId);
            }
        }
        
        System.out.println("📊 Total products after filtering: " + filteredProducts.size());
        return filteredProducts;
    }
    
    private List<Product> filterProductsByStatus(List<Product> products, String statusFilter) {
        List<Product> filteredProducts = new ArrayList<>();
        
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            return products;
        }
        
        String filter = statusFilter.toLowerCase().trim();
        for (Product product : products) {
            // Mặc định tất cả products đều active
            if (filter.equals("active")) {
                filteredProducts.add(product);
            }
        }
        return filteredProducts;
    }
    
    private String getCategoryName(int categoryId) {
        try {
            Categories category = categoriesDao.getCategoryById(categoryId);
            if (category != null) {
                return category.getName();
            }
        } catch (Exception e) {
            System.err.println("Error getting category name for ID " + categoryId + ": " + e.getMessage());
        }
        
        // Fallback to hard-coded mapping for backward compatibility
        switch (categoryId) {
            case 1: return "718 Series";
            case 2: return "911 Series";    
            case 3: return "Taycan";
            case 4: return "Panamera";
            case 5: return "Macan";
            case 6: return "Cayenne";
            default: return "Category " + categoryId;
        }
    }
    
    private String getCategoryNameFromObject(Product product) {
        if (product.getCategory() != null) {
            return product.getCategory().getName();
        }
        return getCategoryName(product.getCategoryId());
    }
    
    private List<User> filterUsersByRole(List<User> users, String roleFilter) {
        List<User> filteredUsers = new ArrayList<>();
        
        if (roleFilter == null || roleFilter.trim().isEmpty()) {
            return users;
        }
        
        String filter = roleFilter.toLowerCase().trim();
        for (User user : users) {
            if (user.getRole() != null) {
                String userRole = user.getRole().toLowerCase().trim();
                // Xử lý các giá trị role khác nhau
                if ((filter.equals("admin") && (userRole.equals("admin") || userRole.equals("a"))) ||
                    (filter.equals("customer") && (userRole.equals("customer") || userRole.equals("c") || userRole.equals("user")))) {
                    filteredUsers.add(user);
                }
            }
        }
        return filteredUsers;
    }
    
    private List<User> filterUsersByStatus(List<User> users, String statusFilter) {
        List<User> filteredUsers = new ArrayList<>();
        
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            return users;
        }
        
        String filter = statusFilter.toLowerCase().trim();
        for (User user : users) {
            // Mặc định tất cả users đều active (có thể mở rộng sau khi có field status)
            if (filter.equals("active")) {
                filteredUsers.add(user);
            }
            // Có thể thêm logic cho inactive sau này
        }
        return filteredUsers;
    }
    
    // Helper method để lấy tên file từ Part
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
    
    // Helper method để lưu file upload
    private String saveUploadedFile(Part filePart, HttpServletRequest request) {
        try {
            String fileName = getSubmittedFileName(filePart);
            if (fileName == null || fileName.trim().isEmpty()) {
                return null;
            }
            
            // Tạo đường dẫn lưu file
            String uploadPath = request.getServletContext().getRealPath("/assets/images/");
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Tạo tên file duy nhất
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + java.io.File.separator + uniqueFileName;
            
            // Lưu file
            filePart.write(filePath);
            
            // Trả về đường dẫn tương đối để lưu vào database
            return "/assets/images/" + uniqueFileName;
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // ========== ORDER MANAGEMENT METHODS ==========
    
    private void viewOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            System.out.println(" ADMIN SERVLET - viewOrder() called for order ID: " + orderId);
            
            // Lấy thông tin đơn hàng
            Order order = orderDao.findById(orderId);
            
            if (order == null) {
                System.err.println(" Order not found with ID: " + orderId);
                request.setAttribute("error", "Không tìm thấy đơn hàng với ID: " + orderId);
                request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
                return;
            }
            
            System.out.println(" Order found: " + order.getId() + ", Status: " + order.getStatus());
            
            // Lấy thông tin user của đơn hàng
            try {
                UserDao userDao = new UserImpl();
                User user = userDao.find(order.getUserId());
                if (user != null) {
                    order.setUser(user);
                    System.out.println(" User loaded: " + user.getFullName() + " (" + user.getEmail() + ")");
                } else {
                    System.err.println("️ User not found for order, creating placeholder user");
                    // Tạo user placeholder nếu không tìm thấy
                    User placeholderUser = new User();
                    placeholderUser.setId(order.getUserId());
                    placeholderUser.setFullName("Khách hàng không xác định");
                    placeholderUser.setEmail("N/A");
                    placeholderUser.setPhone("N/A");
                    order.setUser(placeholderUser);
                }
            } catch (Exception e) {
                System.err.println(" Error loading user: " + e.getMessage());
                // Tạo user placeholder nếu có lỗi
                User placeholderUser = new User();
                placeholderUser.setId(order.getUserId());
                placeholderUser.setFullName("Khách hàng không xác định");
                placeholderUser.setEmail("N/A");
                placeholderUser.setPhone("N/A");
                order.setUser(placeholderUser);
            }
            
            // Kiểm tra và set ngày đặt hàng nếu null
            if (order.getOrderDate() == null) {
                System.out.println(" Order date is null, setting current date");
                order.setOrderDate(java.time.LocalDateTime.now());
            }
            
            // Lấy order items với thông tin sản phẩm
            try {
                List<OrderItem> orderItems = orderItemDao.findByOrderId(orderId);
                order.setOrderItems(orderItems);
                System.out.println("Order items loaded: " + (orderItems != null ? orderItems.size() : 0) + " items");
                
                // Debug: In ra thông tin từng item
                if (orderItems != null) {
                    for (OrderItem item : orderItems) {
                        System.out.println("   Item: " + item.getProductId() + 
                                         ", Product: " + (item.getProduct() != null ? item.getProduct().getName() : "NULL") +
                                         ", Quantity: " + item.getQuantity() + 
                                         ", Price: " + item.getPrice());
                    }
                }
            } catch (Exception e) {
                System.err.println("Error loading order items: " + e.getMessage());
                order.setOrderItems(new ArrayList<>());
            }
            
            // Set attributes và forward
            request.setAttribute("order", order);
            System.out.println("Forwarding to view-order.jsp with order: " + order.getId());
            request.getRequestDispatcher("views/admin/view-order.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println(" Invalid order ID format: " + e.getMessage());
            request.setAttribute("error", "ID đơn hàng không hợp lệ");
            request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in viewOrder: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi xem đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
        }
    }
    
    private void showEditOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDao.findById(orderId);
            
            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng với ID: " + orderId);
                request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
                return;
            }
            
            // Lấy order items
            List<OrderItem> orderItems = orderItemDao.findByOrderId(orderId);
            order.setOrderItems(orderItems);
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("views/admin/edit-order.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi sửa đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("views/admin/error.jsp").forward(request, response);
        }
    }
    
    private void updateOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String note = request.getParameter("note");
            
            Order order = orderDao.findById(orderId);
            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng với ID: " + orderId);
                response.sendRedirect("admin?action=orders");
                return;
            }
            
            order.setStatus(status);
            order.setNote(note);
            
            boolean updateSuccess = orderDao.update(order);
            
            if (updateSuccess) {
                response.sendRedirect("admin?action=orders&success=update");
            } else {
                response.sendRedirect("admin?action=orders&error=update");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=orders&error=update");
        }
    }
    
    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            
            // Xóa order items trước
            orderItemDao.deleteByOrderId(orderId);
            
            // Sau đó xóa order
            boolean deleteSuccess = orderDao.delete(orderId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (deleteSuccess) {
                response.getWriter().write("{\"success\": true, \"message\": \"Xóa đơn hàng thành công\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra khi xóa đơn hàng\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //  SỬA: Set response headers đúng
            response.setContentType("application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            // Log chi tiết request parameters
            System.out.println("=== DEBUG updateOrderStatus ===");
            System.out.println("ID Parameter: " + request.getParameter("id"));
            System.out.println("Status Parameter: " + request.getParameter("status"));
            
            // Validate parameters
            String orderIdStr = request.getParameter("id");
            String databaseStatus = request.getParameter("status");
            
            if (orderIdStr == null || databaseStatus == null || orderIdStr.trim().isEmpty() || databaseStatus.trim().isEmpty()) {
                System.out.println(" Validation failed - Missing parameters");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Thiếu tham số bắt buộc\"}");
                return;
            }
            
            int orderId;
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                System.out.println(" Validation failed - Invalid order ID: " + orderIdStr);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"ID đơn hàng không hợp lệ\"}");
                return;
            }
            
            //  SỬA: Mapping status từ frontend sang database
            // String databaseStatus = mapFrontendStatusToDatabase(frontendStatus); // Bỏ mapping trung gian
            System.out.println("Validation passed - Order ID: " + orderId + ", Status: " + databaseStatus + " -> DB: " + databaseStatus);
            
            // Call DAO to update status
            System.out.println("Calling orderDao.updateStatus...");
            boolean success = orderDao.updateStatus(orderId, databaseStatus);
            
            if (success) {
                System.out.println("Status updated successfully");
                response.getWriter().write("{\"success\":true,\"message\":\"Cập nhật trạng thái thành công\"}");
            } else {
                System.out.println("Failed to update status");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\":false,\"message\":\"Không thể cập nhật trạng thái\"}");
            }
            
        } catch (Exception e) {
            System.out.println("Error occurred: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"Lỗi server: " + e.getMessage() + "\"}");
        }
    }
    
    // Test method để kiểm tra database connection
    private void testDatabaseConnection(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            System.out.println("=== TEST DATABASE CONNECTION ===");
            response.setContentType("application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            try (Connection conn = MySQLDriver.getConnection()) {
                System.out.println(" Database connection successful");
                
                // Test basic query
                try (PreparedStatement ps = conn.prepareStatement("SELECT 1")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        System.out.println("Basic SELECT query successful");
                    }
                }
                
                // Test orders table count
                try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM orders")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        System.out.println(" Orders table count: " + count + " rows");
                    }
                }
                
                // Test orders table structure
                try (PreparedStatement ps = conn.prepareStatement("DESCRIBE orders")) {
                    ResultSet rs = ps.executeQuery();
                    System.out.println(" Orders table structure:");
                    while (rs.next()) {
                        String field = rs.getString("Field");
                        String type = rs.getString("Type");
                        String null_ = rs.getString("Null");
                        String key = rs.getString("Key");
                        String default_ = rs.getString("Default");
                        System.out.println("   " + field + " | " + type + " | " + null_ + " | " + key + " | " + default_);
                    }
                }
                
                // Test specific order query
                try (PreparedStatement ps = conn.prepareStatement("SELECT id, status FROM orders LIMIT 1")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        int id = rs.getInt("id");
                        String status = rs.getString("status");
                        System.out.println(" Sample order - ID: " + id + ", Status: " + status);
                    } else {
                        System.out.println("⚠️ No orders found in table");
                    }
                }
                
                // Test status update query (without executing)
                try (PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status = ? WHERE id = ?")) {
                    System.out.println(" Status update query prepared successfully");
                }
                
                // Check for database constraints or triggers
                try (PreparedStatement ps = conn.prepareStatement("SHOW CREATE TABLE orders")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String createTable = rs.getString(2);
                        System.out.println(" Orders table structure (CREATE TABLE):");
                        System.out.println(createTable);
                        
                        // Check for CHECK constraints on status
                        if (createTable.contains("CHECK") || createTable.contains("check")) {
                            System.out.println("⚠️ Found CHECK constraints - this might limit status values");
                        }
                        
                        // Check for triggers
                        if (createTable.contains("TRIGGER") || createTable.contains("trigger")) {
                            System.out.println("⚠️ Found TRIGGER - this might affect status updates");
                        }
                    }
                }
                
                // Check for any foreign key constraints
                try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'orders' AND REFERENCED_TABLE_NAME IS NOT NULL")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        System.out.println("⚠️ Found foreign key constraints on orders table");
                        do {
                            String column = rs.getString("COLUMN_NAME");
                            String referencedTable = rs.getString("REFERENCED_TABLE_NAME");
                            System.out.println("   Column: " + column + " → " + referencedTable);
                        } while (rs.next());
                    } else {
                        System.out.println(" No foreign key constraints found on orders table");
                    }
                }
                
                response.getWriter().write("{\"success\": true, \"message\": \"Database connection test successful - check server console for details\"}");
                
            } catch (SQLException e) {
                System.out.println(" SQL Error: " + e.getMessage());
                System.out.println(" SQL State: " + e.getSQLState());
                System.out.println(" Error Code: " + e.getErrorCode());
                e.printStackTrace();
                response.getWriter().write("{\"success\": false, \"message\": \"SQL Error: " + e.getMessage() + "\"}");
            }
            
        } catch (Exception e) {
            System.out.println(" General Error: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"General Error: " + e.getMessage() + "\"}");
        }
    }
    
    private List<Order> getOrdersWithFilters(String status, String dateFrom, String dateTo, String search, int pageSize, int offset) {
        try {
            System.out.println("=== DEBUG getOrdersWithFilters ===");
            System.out.println("Calling orderDao.findWithFilters...");
            
            List<Order> result = orderDao.findWithFilters(status, dateFrom, dateTo, search, pageSize, offset);
            
            System.out.println("Result from findWithFilters: " + (result != null ? result.size() : "NULL"));
            if (result != null && !result.isEmpty()) {
                System.out.println("First order ID: " + result.get(0).getId());
                System.out.println("First order status: " + result.get(0).getStatus());
            }
            System.out.println("=== END DEBUG getOrdersWithFilters ===");
            
            return result;
        } catch (Exception e) {
            System.err.println("ERROR in getOrdersWithFilters: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    private int getTotalOrdersWithFilters(String status, String dateFrom, String dateTo, String search) {
        try {
            System.out.println("=== DEBUG getTotalOrdersWithFilters ===");
            System.out.println("Calling orderDao.countWithFilters...");
            
            int result = orderDao.countWithFilters(status, dateFrom, dateTo, search);
            
            System.out.println("Result from countWithFilters: " + result);
            System.out.println("=== END DEBUG getTotalOrdersWithFilters ===");
            
            return result;
        } catch (Exception e) {
            System.err.println("ERROR in getTotalOrdersWithFilters: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
    
    private int getOrderCountByStatus(String status) {
        try {
            return orderDao.countByStatus(status);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Test method để kiểm tra database trực tiếp
    private void testDatabaseUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            System.out.println("=== TEST DATABASE UPDATE ===");
            
            // Lấy một đơn hàng để test
            List<Order> orders = orderDao.findAll();
            if (orders.isEmpty()) {
                response.getWriter().write("No orders found for testing");
                return;
            }
            
            Order testOrder = orders.get(0);
            int orderId = testOrder.getId();
            String oldStatus = testOrder.getStatus();
            
            System.out.println("Test Order ID: " + orderId);
            System.out.println("Old Status: " + oldStatus);
            
            // Test update sang 'confirmed'
            System.out.println("Testing update to 'confirmed'...");
            boolean updateSuccess = orderDao.updateStatus(orderId, "confirmed");
            System.out.println("Update result: " + updateSuccess);
            
            if (updateSuccess) {
                // Kiểm tra trạng thái mới
                String newStatus = orderDao.getOrderStatus(orderId);
                System.out.println("New status in database: " + newStatus);
                
                // Khôi phục trạng thái cũ
                System.out.println("Restoring old status...");
                orderDao.updateStatus(orderId, oldStatus);
                String restoredStatus = orderDao.getOrderStatus(orderId);
                System.out.println("Restored status: " + restoredStatus);
                
                String result = String.format(
                    "Test completed successfully!<br>" +
                    "Order ID: %d<br>" +
                    "Old Status: %s<br>" +
                    "Update to 'confirmed': %s<br>" +
                    "New Status: %s<br>" +
                    "Restore to old status: %s<br>" +
                    "Final Status: %s",
                    orderId, oldStatus, updateSuccess, newStatus, 
                    orderDao.updateStatus(orderId, oldStatus), restoredStatus
                );
                
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<html><body><h1>Database Test Result</h1>" + result + "</body></html>");
            } else {
                response.getWriter().write("Update failed!");
            }
            
            System.out.println("=== END TEST DATABASE UPDATE ===");
            
        } catch (Exception e) {
            System.err.println(" ERROR in testDatabaseUpdate: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Servlet for managing AutoShowVN system";
    }
}
