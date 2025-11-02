package data.utils;

/**
 * Utility class để quản lý các trạng thái đơn hàng
 * @author Duy Khánh
 */
public class OrderStatus {
    
    // Các giá trị status hợp lệ
    public static final String UNCONFIRMED = "unconfirmed";
    public static final String CONFIRMED = "confirmed";
    public static final String IN_DELIVERY = "in delivery";
    public static final String DELIVERED = "delivered";
    public static final String CANCELLED = "cancelled";
    
    // Mảng tất cả status hợp lệ
    public static final String[] VALID_STATUSES = {
        UNCONFIRMED, CONFIRMED, IN_DELIVERY, DELIVERED, CANCELLED
    };
    
    // Độ dài tối đa cho status
    public static final int MAX_STATUS_LENGTH = 50;
    
    /**
     * Kiểm tra xem status có hợp lệ không
     * @param status status cần kiểm tra
     * @return true nếu hợp lệ, false nếu không
     */
    public static boolean isValidStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return false;
        }
        
        if (status.length() > MAX_STATUS_LENGTH) {
            return false;
        }
        
        for (String validStatus : VALID_STATUSES) {
            if (validStatus.equals(status)) {
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Lấy tên hiển thị của status
     * @param status status cần chuyển đổi
     * @return tên hiển thị tiếng Việt
     */
    public static String getDisplayName(String status) {
        switch (status) {
            case UNCONFIRMED:
                return "Chờ xác nhận";
            case CONFIRMED:
                return "Đã xác nhận";
            case IN_DELIVERY:
                return "Đang giao";
            case DELIVERED:
                return "Đã giao";
            case CANCELLED:
                return "Đã hủy";
            default:
                return status;
        }
    }
    
    /**
     * Lấy màu Bootstrap cho status
     * @param status status cần lấy màu
     * @return tên class màu Bootstrap
     */
    public static String getBootstrapColor(String status) {
        switch (status) {
            case UNCONFIRMED:
                return "warning";
            case CONFIRMED:
                return "info";
            case IN_DELIVERY:
                return "primary";
            case DELIVERED:
                return "success";
            case CANCELLED:
                return "danger";
            default:
                return "secondary";
        }
    }
    
    /**
     * Validate và trả về status mặc định nếu không hợp lệ
     * @param status status cần validate
     * @return status hợp lệ hoặc status mặc định
     */
    public static String validateAndGetDefault(String status) {
        if (isValidStatus(status)) {
            return status;
        }
        return UNCONFIRMED; // Trả về status mặc định
    }
    
    /**
     * Lấy danh sách tất cả status hợp lệ
     * @return mảng các status hợp lệ
     */
    public static String[] getAllValidStatuses() {
        return VALID_STATUSES.clone();
    }
    
    /**
     * Kiểm tra xem status có thể chuyển đổi sang status khác không
     * @param currentStatus status hiện tại
     * @param newStatus status mới
     * @return true nếu có thể chuyển đổi
     */
    public static boolean canTransitionTo(String currentStatus, String newStatus) {
        if (!isValidStatus(currentStatus) || !isValidStatus(newStatus)) {
            return false;
        }
        
        // Logic chuyển đổi status
        switch (currentStatus) {
            case UNCONFIRMED:
                // Unconfirmed có thể chuyển thành confirmed hoặc cancelled
                return CONFIRMED.equals(newStatus) || CANCELLED.equals(newStatus);
            case CONFIRMED:
                // Confirmed có thể chuyển thành in delivery
                return IN_DELIVERY.equals(newStatus);
            case IN_DELIVERY:
                // In delivery có thể chuyển thành delivered
                return DELIVERED.equals(newStatus);
            case DELIVERED:
            case CANCELLED:
                // Delivered và cancelled không thể chuyển đổi
                return false;
            default:
                return false;
        }
    }
}
