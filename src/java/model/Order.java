package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import model.User;

/**
 * Model Order - Đại diện cho đơn hàng
 * @author Duy Khánh
 */
public class Order {
    private int id;
    private int userId;
    private LocalDateTime orderDate;
    private String status;
    private BigDecimal totalAmount;
    private String note;
    private List<OrderItem> orderItems;
    private User user;
    
    // Constructors
    public Order() {
        this.orderDate = LocalDateTime.now();
        this.status = "unconfirmed";
    }
    
    public Order(int userId, BigDecimal totalAmount, String note) {
        this();
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.note = note;
    }
    
    public Order(int id, int userId, LocalDateTime orderDate, String status, BigDecimal totalAmount, String note) {
        this.id = id;
        this.userId = userId;
        this.orderDate = orderDate;
        this.status = status;
        this.totalAmount = totalAmount;
        this.note = note;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public LocalDateTime getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    // Helper methods
    public String getStatusDisplay() {
        switch (this.status) {
            case "unconfirmed": return "Chờ xác nhận";
            case "confirmed": return "Đã xác nhận";
            case "in delivery": return "Đang giao";
            case "delivered": return "Đã giao";
            case "cancelled": return "Đã hủy";
            default: return this.status;
        }
    }
    
    public String getStatusColor() {
        switch (status) {
            case "unconfirmed": return "warning";
            case "confirmed": return "info";
            case "shipped": return "primary";
            case "delivered": return "success";
            case "cancelled": return "danger";
            default: return "secondary";
        }
    }

    // Thêm phương thức helper để format date cho JSP
    public String getFormattedOrderDate() {
        if (orderDate != null) {
            return orderDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return "";
    }
    
    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", userId=" + userId + ", orderDate=" + orderDate + 
               ", status=" + status + ", totalAmount=" + totalAmount + ", note=" + note + '}';
    }
}
