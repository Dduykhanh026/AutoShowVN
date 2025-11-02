package model;

/**
 * Favorite model class representing the wishlist table
 * Lưu trữ thông tin sản phẩm yêu thích của người dùng
 */
public class Favorite {
    private int userId;
    private int productId;
    private String note;
    
    // Thêm thông tin sản phẩm để hiển thị (không lưu trong database)
    private Product product;
    private User user;
    
    // Default constructor
    public Favorite() {
    }
    
    // Constructor với các trường cơ bản
    public Favorite(int userId, int productId) {
        this.userId = userId;
        this.productId = productId;
    }
    
    // Constructor đầy đủ
    public Favorite(int userId, int productId, String note) {
        this.userId = userId;
        this.productId = productId;
        this.note = note;
    }
    
    // Constructor với thông tin sản phẩm
    public Favorite(int userId, int productId, String note, Product product) {
        this.userId = userId;
        this.productId = productId;
        this.note = note;
        this.product = product;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    // toString method
    @Override
    public String toString() {
        return "Favorite{" +
                "userId=" + userId +
                ", productId=" + productId +
                ", note='" + note + '\'' +
                ", product=" + (product != null ? product.getName() : "null") +
                '}';
    }
    
    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Favorite favorite = (Favorite) o;
        
        if (userId != favorite.userId) return false;
        return productId == favorite.productId;
    }
    
    @Override
    public int hashCode() {
        int result = userId;
        result = 31 * result + productId;
        return result;
    }
    
    // Method tiện ích để kiểm tra xem sản phẩm có phải là yêu thích không
    public boolean isFavoriteForUser(int userId, int productId) {
        return this.userId == userId && this.productId == productId;
    }
}
