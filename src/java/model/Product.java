package model;

import java.math.BigDecimal;
import model.Categories;

public class Product {
    private int id;
    private Categories category;
    private String name;
    private BigDecimal price;
    private int year;
    private String engine;
    private int horsepower;
    private int torque;
    private int topSpeed;
    private String image;
    private String description;

    // Constructor rỗng
    public Product() {
    }

    // Constructor đầy đủ
    public Product(int id, Categories category, String name, BigDecimal price, int year,
                   String engine, int horsepower, int torque, int topSpeed,
                   String image, String description) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.price = price;
        this.year = year;
        this.engine = engine;
        this.horsepower = horsepower;
        this.torque = torque;
        this.topSpeed = topSpeed;
        this.image = image;
        this.description = description;
    }

    // Constructor với categoryId (để tương thích ngược)
    public Product(int id, int categoryId, String name, BigDecimal price, int year,
                   String engine, int horsepower, int torque, int topSpeed,
                   String image, String description) {
        this.id = id;
        this.category = new Categories(categoryId, "", "");
        this.name = name;
        this.price = price;
        this.year = year;
        this.engine = engine;
        this.horsepower = horsepower;
        this.torque = torque;
        this.topSpeed = topSpeed;
        this.image = image;
        this.description = description;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public Categories getCategory() {
        return category;
    }
    
    public void setCategory(Categories category) {
        this.category = category;
    }
    
    public int getCategoryId() {
        return category != null ? category.getId() : 0;
    }
    
    public void setCategoryId(int categoryId) {
        if (this.category == null) {
            this.category = new Categories();
        }
        this.category.setId(categoryId);
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getYear() {
        return year;
    }
    public void setYear(int year) {
        this.year = year;
    }

    public String getEngine() {
        return engine;
    }
    public void setEngine(String engine) {
        this.engine = engine;
    }

    public int getHorsepower() {
        return horsepower;
    }
    public void setHorsepower(int horsepower) {
        this.horsepower = horsepower;
    }

    public int getTorque() {
        return torque;
    }
    public void setTorque(int torque) {
        this.torque = torque;
    }

    public int getTopSpeed() {
        return topSpeed;
    }
    public void setTopSpeed(int topSpeed) {
        this.topSpeed = topSpeed;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", category=" + (category != null ? category.getName() : "null") +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", year=" + year +
                ", engine='" + engine + '\'' +
                ", horsepower=" + horsepower +
                ", torque=" + torque +
                ", topSpeed=" + topSpeed +
                ", image='" + image + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}