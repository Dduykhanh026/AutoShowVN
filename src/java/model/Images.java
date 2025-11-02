package model;

/**
 * Model class representing the images table
 * Maps to the database table structure with columns: id, product_id, image_url, image_side_url, alt_text
 */
public class Images {
    
    private int id;
    private int productId;
    private String imageUrl;
    private String imageSideUrl;
    private String altText;
    
    // Default constructor
    public Images() {
    }
    
    // Constructor with all parameters
    public Images(int id, int productId, String imageUrl, String imageSideUrl, String altText) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.imageSideUrl = imageSideUrl;
        this.altText = altText;
    }
    
    // Constructor without id (for creating new records)
    public Images(int productId, String imageUrl, String imageSideUrl, String altText) {
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.imageSideUrl = imageSideUrl;
        this.altText = altText;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public String getImageSideUrl() {
        return imageSideUrl;
    }
    
    public void setImageSideUrl(String imageSideUrl) {
        this.imageSideUrl = imageSideUrl;
    }
    
    public String getAltText() {
        return altText;
    }
    
    public void setAltText(String altText) {
        this.altText = altText;
    }
    
    @Override
    public String toString() {
        return "Images{" +
                "id=" + id +
                ", productId=" + productId +
                ", imageUrl='" + imageUrl + '\'' +
                ", imageSideUrl='" + imageSideUrl + '\'' +
                ", altText='" + altText + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Images images = (Images) o;
        
        if (id != images.id) return false;
        if (productId != images.productId) return false;
        if (imageUrl != null ? !imageUrl.equals(images.imageUrl) : images.imageUrl != null) return false;
        if (imageSideUrl != null ? !imageSideUrl.equals(images.imageSideUrl) : images.imageSideUrl != null) return false;
        return altText != null ? altText.equals(images.altText) : images.altText == null;
    }
    
    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + productId;
        result = 31 * result + (imageUrl != null ? imageUrl.hashCode() : 0);
        result = 31 * result + (imageSideUrl != null ? imageSideUrl.hashCode() : 0);
        result = 31 * result + (altText != null ? altText.hashCode() : 0);
        return result;
    }
}
