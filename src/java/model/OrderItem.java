package model;

import java.math.BigDecimal;

/**
 * Model OrderItem - Đại diện cho từng sản phẩm trong đơn hàng
 * @author Duy Khánh
 */
public class OrderItem {
    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;
    private Product product; // Để lấy thông tin sản phẩm
    
    // Constructors
    public OrderItem() {
    }
    
    public OrderItem(int orderId, int productId, int quantity, BigDecimal price) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }
    
    public OrderItem(int id, int orderId, int productId, int quantity, BigDecimal price) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    // Helper methods
    public BigDecimal getSubtotal() {
        if (price != null && quantity > 0) {
            return price.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
    
    @Override
    public String toString() {
        return "OrderItem{" + "id=" + id + ", orderId=" + orderId + ", productId=" + productId + 
               ", quantity=" + quantity + ", price=" + price + '}';
    }
}
