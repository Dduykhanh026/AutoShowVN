
package data.dao;

import java.util.List;
import model.Product;


public interface ProductDao {
    public List <Product> findAll();
    public boolean insert(Product car);
    public boolean delete(String maxe);
    public boolean delete(int id);
    public boolean update(String maxe);
    public boolean update(Product product);
    public Product find(String maxe);
    public Product find(int id);
    public List<Product> search(String keyword);
}
