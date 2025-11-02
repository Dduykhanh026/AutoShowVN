package controller;

import data.dao.Database;
import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.impl.OrderImpl;
import data.impl.OrderItemImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;

/**
 * OrderServlet - Xử lý các thao tác với đơn hàng và thanh toán
 * @author Duy Khánh
 */
public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("order?action=list");
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
                    listUserOrders(request, response);
                    break;
                case "detail":
                    showOrderDetail(request, response);
                    break;
                case "checkout":
                    showCheckoutPage(request, response);
                    break;
                case "payment":
                    processPayment(request, response);
                    break;
                case "cancel":
                    cancelOrder(request, response);
                    break;
                case "test":
                    showTestPage(request, response);
                    break;
                default:
                    listUserOrders(request, response);
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                case "create":
                    createOrder(request, response);
                    break;
                case "update":
                    updateOrder(request, response);
                    break;
                case "payment":
                    processPayment(request, response);
                    break;
                default:
                    response.sendRedirect("order?action=list");
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách đơn hàng của người dùng
     */
    private void listUserOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            OrderDao orderDao = new OrderImpl();
            List<Order> userOrders = orderDao.findByUserId(user.getId());
            
            request.setAttribute("userOrders", userOrders);
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/views/orders.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            
            // Kiểm tra xem response đã được commit chưa
            if (!response.isCommitted()) {
                request.setAttribute("error", "Không thể tải danh sách đơn hàng: " + ex.getMessage());
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            } else {
                // Nếu response đã commit, redirect với error parameter
                response.sendRedirect(request.getContextPath() + "/order?action=list&error=" + 
                    java.net.URLEncoder.encode("Không thể tải danh sách đơn hàng", "UTF-8"));
            }
        }
    }

    /**
     * Hiển thị chi tiết đơn hàng
     */
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect("order?action=list");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDao orderDao = new OrderImpl();
            OrderItemDao orderItemDao = new OrderItemImpl();
            
            Order order = orderDao.findById(orderId);
            if (order == null || order.getUserId() != user.getId()) {
                request.setAttribute("error", "Không tìm thấy đơn hàng");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            List<OrderItem> orderItems = orderItemDao.findByOrderId(orderId);
            order.setOrderItems(orderItems);
            
            request.setAttribute("order", order);
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/views/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            if (!response.isCommitted()) {
                request.setAttribute("error", "ID đơn hàng không hợp lệ");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/order?action=list&error=" + 
                    java.net.URLEncoder.encode("ID đơn hàng không hợp lệ", "UTF-8"));
            }
        }
    }

    /**
     * Hiển thị trang thanh toán
     */
    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productIdStr == null || quantityStr == null) {
            response.sendRedirect("home");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Lấy thông tin sản phẩm
            Product product = Database.getProductDao().find(productId);
            if (product == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
                return;
            }
            
            BigDecimal totalAmount = product.getPrice().multiply(BigDecimal.valueOf(quantity));
            
            request.setAttribute("product", product);
            request.setAttribute("quantity", quantity);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            if (!response.isCommitted()) {
                request.setAttribute("error", "Thông tin không hợp lệ");
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home?error=" + 
                    java.net.URLEncoder.encode("Thông tin không hợp lệ", "UTF-8"));
            }
        }
    }

    /**
     * Tạo đơn hàng mới
     */
    private void createOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Kiểm tra xem có phải AJAX request không
            String xRequestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(xRequestedWith)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            } else {
                response.sendRedirect("login");
            }
            return;
        }
        
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        String note = request.getParameter("note");
        
        if (productIdStr == null || quantityStr == null) {
            // Kiểm tra xem có phải AJAX request không
            String xRequestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(xRequestedWith)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Thông tin không hợp lệ\"}");
            } else {
                request.setAttribute("error", "Thông tin không hợp lệ");
                response.sendRedirect("home");
            }
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Lấy thông tin sản phẩm
            Product product = Database.getProductDao().find(productId);
            if (product == null) {
                // Kiểm tra xem có phải AJAX request không
                String xRequestedWith = request.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equals(xRequestedWith)) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy sản phẩm\"}");
                } else {
                    request.setAttribute("error", "Không tìm thấy sản phẩm");
                    response.sendRedirect("home");
                }
                return;
            }
            
            BigDecimal totalAmount = product.getPrice().multiply(BigDecimal.valueOf(quantity));
            
            // Tạo đơn hàng
            Order order = new Order(user.getId(), totalAmount, note);
            OrderDao orderDao = new OrderImpl();
            
            if (orderDao.insert(order)) {
                // Tạo order item
                OrderItem orderItem = new OrderItem(order.getId(), productId, quantity, product.getPrice());
                OrderItemDao orderItemDao = new OrderItemImpl();
                
                if (orderItemDao.insert(orderItem)) {
                    // Kiểm tra xem có phải AJAX request không
                    String xRequestedWith = request.getHeader("X-Requested-With");
                    if ("XMLHttpRequest".equals(xRequestedWith)) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": true, \"message\": \"Đặt hàng thành công\", \"orderId\": " + order.getId() + "}");
                    } else {
                        // Redirect đến trang orders với thông báo thành công
                        session.setAttribute("successMessage", "Đặt hàng thành công! Đơn hàng #" + order.getId() + " đã được tạo.");
                        response.sendRedirect("order?action=list");
                    }
                } else {
                    // Xóa đơn hàng nếu không thể tạo order item
                    orderDao.delete(order.getId());
                    // Kiểm tra xem có phải AJAX request không
                    String xRequestedWith = request.getHeader("X-Requested-With");
                    if ("XMLHttpRequest".equals(xRequestedWith)) {
                        response.setContentType("application/json");
                        response.getWriter().write("{\"success\": false, \"message\": \"Không thể tạo đơn hàng\"}");
                    } else {
                        request.setAttribute("error", "Không thể tạo đơn hàng");
                        response.sendRedirect("home");
                    }
                }
            } else {
                // Kiểm tra xem có phải AJAX request không
                String xRequestedWith = request.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equals(xRequestedWith)) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": false, \"message\": \"Không thể tạo đơn hàng\"}");
                } else {
                    request.setAttribute("error", "Không thể tạo đơn hàng");
                    response.sendRedirect("home");
                }
            }
            
        } catch (NumberFormatException e) {
            // Kiểm tra xem có phải AJAX request không
            String xRequestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(xRequestedWith)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Thông tin không hợp lệ\"}");
            } else {
                request.setAttribute("error", "Thông tin không hợp lệ");
                response.sendRedirect("home");
            }
        }
    }

    /**
     * Xử lý thanh toán
     */
    private void processPayment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (orderIdStr == null || paymentMethod == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Thông tin không hợp lệ\"}");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDao orderDao = new OrderImpl();
            
            Order order = orderDao.findById(orderId);
            if (order == null || order.getUserId() != user.getId()) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy đơn hàng\"}");
                return;
            }
            
            if (!"unconfirmed".equals(order.getStatus())) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Đơn hàng không thể thanh toán\"}");
                return;
            }
            
            // Cập nhật trạng thái thành "confirmed" thay vì "paid"
            if (orderDao.updateStatus(orderId, "confirmed")) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Thanh toán thành công\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xử lý thanh toán\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID đơn hàng không hợp lệ\"}");
        }
    }

    /**
     * Hủy đơn hàng
     */
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            return;
        }
        
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID đơn hàng không hợp lệ\"}");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderDao orderDao = new OrderImpl();
            
            Order order = orderDao.findById(orderId);
            if (order == null || order.getUserId() != user.getId()) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy đơn hàng\"}");
                return;
            }
            
            if (!"unconfirmed".equals(order.getStatus())) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể hủy đơn hàng này\"}");
                return;
            }
            
            // Cập nhật trạng thái thành "cancelled"
            if (orderDao.updateStatus(orderId, "cancelled")) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Đã hủy đơn hàng\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể hủy đơn hàng\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"ID đơn hàng không hợp lệ\"}");
        }
    }


    private void showTestPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            OrderDao orderDao = new OrderImpl();
            List<Order> userOrders = orderDao.findByUserId(user.getId());
            
            request.setAttribute("userOrders", userOrders);
            request.setAttribute("user", user);
            
            request.getRequestDispatcher("/views/test-orders.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Không thể tải trang test: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    /**
     * Cập nhật đơn hàng
     */
    private void updateOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Implementation cho việc cập nhật đơn hàng
        response.sendRedirect("order?action=list");
    }

    @Override
    public String getServletInfo() {
        return "OrderServlet - Quản lý đơn hàng và thanh toán";
    }
}
