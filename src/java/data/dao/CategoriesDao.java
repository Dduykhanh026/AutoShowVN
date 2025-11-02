package data.dao;

import java.util.List;
import model.Categories;

public interface CategoriesDao {
    
    /**
     * Lấy tất cả categories
     */
    List<Categories> getAllCategories();
    
    /**
     * Lấy category theo ID
     */
    Categories getCategoryById(int id);
    
    /**
     * Lấy category theo tên
     */
    Categories getCategoryByName(String name);
    
    /**
     * Thêm category mới
     */
    boolean addCategory(Categories category);
    
    /**
     * Cập nhật category
     */
    boolean updateCategory(Categories category);
    
    /**
     * Xóa category theo ID
     */
    boolean deleteCategory(int id);
    
    /**
     * Kiểm tra category có tồn tại không
     */
    boolean categoryExists(int id);
    
    /**
     * Kiểm tra tên category có tồn tại không
     */
    boolean categoryNameExists(String name);
}
