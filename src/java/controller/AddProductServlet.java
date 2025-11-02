package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.UUID;
import java.math.BigDecimal;
import data.dao.Database;
import model.Product;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/add-product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10,  // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kiểm tra quyền admin
        if (session.getAttribute("userRole") == null || 
            (!"admin".equals(session.getAttribute("userRole")) && !"A".equals(session.getAttribute("userRole")))) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "showForm";
        }
        
        try {
            switch (action) {
                case "showForm":
                    showAddProductForm(request, response);
                    break;
                case "add":
                    addProduct(request, response);
                    break;
                default:
                    showAddProductForm(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    private void showAddProductForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/add-product.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Lấy thông tin sản phẩm từ form
            String name = request.getParameter("name");
            String categoryStr = request.getParameter("category");
            String priceStr = request.getParameter("price");
            String yearStr = request.getParameter("year");
            String engine = request.getParameter("engine");
            String horsepowerStr = request.getParameter("horsepower");
            String torqueStr = request.getParameter("torque");
            String topSpeedStr = request.getParameter("topSpeed");
            String description = request.getParameter("description");
            
            // Validate required fields
            if (name == null || name.trim().isEmpty() || 
                categoryStr == null || categoryStr.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc!");
                request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
                return;
            }
            
            // Parse numeric values with validation
            int categoryId, year = 0, horsepower = 0, torque = 0, topSpeed = 0;
            BigDecimal price;
            
            try {
                // Map category names to IDs
                categoryId = mapCategoryNameToId(categoryStr);
                price = new BigDecimal(priceStr);
                
                if (yearStr != null && !yearStr.trim().isEmpty()) {
                    year = Integer.parseInt(yearStr);
                }
                if (horsepowerStr != null && !horsepowerStr.trim().isEmpty()) {
                    horsepower = Integer.parseInt(horsepowerStr);
                }
                if (torqueStr != null && !torqueStr.trim().isEmpty()) {
                    torque = Integer.parseInt(torqueStr);
                }
                if (topSpeedStr != null && !topSpeedStr.trim().isEmpty()) {
                    topSpeed = Integer.parseInt(topSpeedStr);
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Dữ liệu số không hợp lệ: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
                return;
            }
            
            // Xử lý upload hình ảnh
            String imagePath = "";
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                String fileExtension = getFileExtension(fileName);
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Lưu file vào thư mục assets/images
                String uploadPath = getServletContext().getRealPath("/assets/images/");
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                filePart.write(uploadPath + uniqueFileName);
                imagePath = "/assets/images/" + uniqueFileName;
            }
            
            // Tạo Product object
            Product newProduct = new Product();
            newProduct.setCategoryId(categoryId);
            newProduct.setName(name.trim());
            newProduct.setPrice(price);
            newProduct.setYear(year);
            newProduct.setEngine(engine != null ? engine.trim() : "");
            newProduct.setHorsepower(horsepower);
            newProduct.setTorque(torque);
            newProduct.setTopSpeed(topSpeed);
            newProduct.setImage(imagePath);
            newProduct.setDescription(description != null ? description.trim() : "");
            
            // Lưu vào database
            boolean success = Database.getProductDao().insert(newProduct);
            
            if (success) {
        
                // Redirect về trang quản lý sản phẩm
                response.sendRedirect("admin?action=products&success=added");
            } else {
                request.setAttribute("error", "Không thể thêm sản phẩm. Vui lòng thử lại!");
                request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thêm sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/add-product.jsp").forward(request, response);
        }
    }
    
    private int mapCategoryNameToId(String categoryName) {
        switch (categoryName.toLowerCase()) {
            case "718": return 1;
            case "911": return 2;
            case "cayenne": return 3;
            case "macan": return 4;
            case "panamera": return 5;
            case "taycan": return 6;
            default: return 1; // Default to 718
        }
    }



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

    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1) {
            return "";
        }
        return fileName.substring(lastDotIndex);
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
        return "AddProduct Servlet for adding new products";
    }
}
