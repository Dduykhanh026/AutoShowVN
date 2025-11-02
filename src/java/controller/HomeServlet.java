
package controller;

import data.dao.Database;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.math.BigDecimal;
import model.Images;
import model.Product;
import data.impl.ProductImpl;

/**
 *
 * @author Duy Khánh
 */
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Process request logic handled by specific methods
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
                case "detail":
                    showProductDetail(request, response);
                    break;
                case "add":
                    showAddProductForm(request, response);
                    break;
                case "search":
                    searchProducts(request, response);
                    break;
                // AJAX search đã bị loại bỏ
                // case "ajaxSearch":
                //     ajaxSearchProducts(request, response);
                //     break;
                default:
                    listAllProducts(request, response);
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("./views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addNewProduct(request, response);
        } else {
            response.sendRedirect("home");
        }
    }

    private void showAddProductForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/add-product.jsp").forward(request, response);
    }

    private void addNewProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String categoryIdStr = request.getParameter("categoryId");
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String yearStr = request.getParameter("year");
            String engine = request.getParameter("engine");
            String horsepowerStr = request.getParameter("horsepower");
            String torqueStr = request.getParameter("torque");
            String topSpeedStr = request.getParameter("topSpeed");
            String image = request.getParameter("image");
            String description = request.getParameter("description");

            // Validation
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                yearStr == null || yearStr.trim().isEmpty() ||
                engine == null || engine.trim().isEmpty() ||
                horsepowerStr == null || horsepowerStr.trim().isEmpty() ||
                torqueStr == null || torqueStr.trim().isEmpty() ||
                topSpeedStr == null || topSpeedStr.trim().isEmpty() ||
                image == null || image.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                request.getRequestDispatcher("./views/add-product.jsp").forward(request, response);
                return;
            }

            // Parse và validate dữ liệu
            int categoryId, year, horsepower, torque, topSpeed;
            BigDecimal price;
            
            try {
                categoryId = Integer.parseInt(categoryIdStr);
                year = Integer.parseInt(yearStr);
                horsepower = Integer.parseInt(horsepowerStr);
                torque = Integer.parseInt(torqueStr);
                topSpeed = Integer.parseInt(topSpeedStr);
                price = new BigDecimal(priceStr);
                
                if (year < 1900 || year > 2030) {
                    throw new NumberFormatException("Năm sản xuất không hợp lệ");
                }
                if (horsepower <= 0 || torque <= 0 || topSpeed <= 0 || price.compareTo(BigDecimal.ZERO) <= 0) {
                    throw new NumberFormatException("Các giá trị số phải lớn hơn 0");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
                request.getRequestDispatcher("./views/add-product.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Product mới
            Product newProduct = new Product();
            newProduct.setCategoryId(categoryId);
            newProduct.setName(name.trim());
            newProduct.setPrice(price);
            newProduct.setYear(year);
            newProduct.setEngine(engine.trim());
            newProduct.setHorsepower(horsepower);
            newProduct.setTorque(torque);
            newProduct.setTopSpeed(topSpeed);
            
            // Xử lý đường dẫn hình ảnh - thêm dấu / nếu chưa có
            String imagePath = image.trim();
            if (!imagePath.startsWith("/")) {
                imagePath = "/" + imagePath;
            }
            newProduct.setImage(imagePath);
            
            newProduct.setDescription(description != null ? description.trim() : "");

            // Lưu vào database
            boolean success = Database.getProductDao().insert(newProduct);
            
            if (success) {
                // Thêm thông báo thành công vào session
                request.getSession().setAttribute("successMessage", "Thêm xe mới thành công!");
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Không thể thêm xe mới. Vui lòng thử lại sau.");
                request.getRequestDispatcher("./views/add-product.jsp").forward(request, response);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, "Error adding product", ex);
            request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
            request.getRequestDispatcher("./views/add-product.jsp").forward(request, response);
        }
    }

    private void listAllProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Product> listProduct = Database.getProductDao().findAll();
        List<Images> listImage = Database.getImagesDao().findAll();
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("listImage", listImage);
        request.getRequestDispatcher("./views/home.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Product product = Database.getProductDao().find(id);
                if (product != null) {
                    // Lấy ảnh theo productId cụ thể
                    List<Images> listImage = Database.getImagesDao().findByProductId(id);
                    
                    request.setAttribute("product", product);
                    request.setAttribute("listImage", listImage);
                    request.getRequestDispatcher("./views/product-detail.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy xe với ID: " + id);
                    request.getRequestDispatcher("./views/error.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID không hợp lệ");
                request.getRequestDispatcher("./views/error.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("home");
        }
    }
    
    private void searchProducts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("q");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu không có keyword, trả về tất cả sản phẩm
            listAllProducts(request, response);
            return;
        }
        
        try {
            List<Product> searchResults = new ArrayList<>();
            String searchType = "general";
            
            // Kiểm tra nếu là tìm kiếm theo category
            if (keyword.toLowerCase().contains("718") || keyword.toLowerCase().contains("911") || 
                keyword.toLowerCase().contains("taycan") || keyword.toLowerCase().contains("panamera") || 
                keyword.toLowerCase().contains("macan") || keyword.toLowerCase().contains("cayenne")) {
                
                // Tìm kiếm theo category
                searchResults = ((ProductImpl) Database.getProductDao()).searchByCategory(keyword.trim());
                searchType = "category";
        
            } else {
                // Tìm kiếm chung
                searchResults = Database.getProductDao().search(keyword.trim());
        
            }
            
            List<Images> listImage = Database.getImagesDao().findAll();
            
            // Thêm keyword vào request để hiển thị
            request.setAttribute("searchKeyword", keyword.trim());
            request.setAttribute("searchType", searchType);
            request.setAttribute("listProduct", searchResults);
            request.setAttribute("listImage", listImage);
            request.setAttribute("searchResultsCount", searchResults.size());
            
            // Forward đến home.jsp để hiển thị kết quả
            request.getRequestDispatcher("./views/home.jsp").forward(request, response);
            
        } catch (Exception ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, "Error searching products", ex);
            request.setAttribute("error", "Lỗi tìm kiếm: " + ex.getMessage());
            request.getRequestDispatcher("./views/error.jsp").forward(request, response);
        }
    }

    // AJAX search method đã bị loại bỏ
    // private void ajaxSearchProducts(HttpServletRequest request, HttpServletResponse response) 
    //         throws ServletException, IOException, SQLException {
    //     // Method này đã bị xóa
    // }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
