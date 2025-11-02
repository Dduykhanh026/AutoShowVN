
package data.dao;

import data.impl.FavoriteImpl;
import data.impl.ImagesImpl;
import data.impl.ProductImpl;
import data.impl.UserImpl;
import data.impl.CategoriesImpl;
import data.impl.OrderImpl;
import data.impl.OrderItemImpl;
import data.dao.OrderDao;
import data.dao.OrderItemDao;
import java.sql.SQLException;


public class Database {


    public static ProductDao getProductDao() throws SQLException {
        return new ProductImpl();
    }
    public static ImagesDao getImagesDao() throws SQLException {
        return new ImagesImpl();
    }
    public static FavoriteDao getFavoriteDao() throws SQLException {
        return new  FavoriteImpl();
    }
    public static UserDao getUserDao() throws SQLException {
        return new UserImpl();
    }
    public static CategoriesDao getCategoriesDao() throws SQLException {
        return new CategoriesImpl();
    }
    
    public static OrderDao getOrderDao() throws SQLException {
        return new OrderImpl();
    }
    
    public static OrderItemDao getOrderItemDao() throws SQLException {
        return new OrderItemImpl();
    }
}
