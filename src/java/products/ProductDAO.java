/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import users.UserDTO;
import utils.DBContext;

/**
 *
 * @author Thinh Tran
 */
public class ProductDAO {

    private static final String GET_ALL = "select * from Products";
    private static final String SEARCH = "select * from Products where ProductName like ?";
    private static final String INSERT = "INSERT INTO Products (ProductID, ProductName, ProductImage, Price, Quantity) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE = "UPDATE Products SET ProductName = ?, ProductImage = ?, Price = ?, Quantity = ? WHERE ProductID = ?";
    private static final String DELETE = "DELETE FROM Products WHERE ProductID = ?";
    private static final String GET_PRODUCT_BY_ID = "SELECT * FROM Products WHERE ProductID = ?";

    public List<ProductDTO> getAll() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        List<ProductDTO> products = new ArrayList<>();
        try {
//            Xu ly o day
            conn = DBContext.getConnection();
            if (conn != null) {

                ptm = conn.prepareStatement(GET_ALL);

                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("ProductID");
                    String name = rs.getString("ProductName");
                    String image = rs.getString("ProductImage");
                    double price = rs.getDouble("Price");
                    int quantity = rs.getInt("Quantity");
                    products.add(new ProductDTO(id, name, image, price, quantity));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return products;
    }

    public List<ProductDTO> SearchProducts(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        List<ProductDTO> products = new ArrayList<>();
        try {
//            Xu ly o day
            conn = DBContext.getConnection();
            if (conn != null) {

                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");

                rs = ptm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("ProductID");
                    String name = rs.getString("ProductName");
                    String image = rs.getString("ProductImage");
                    double price = rs.getDouble("Price");
                    int quantity = rs.getInt("Quantity");
                    products.add(new ProductDTO(id, name, image, price, quantity));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return products;
    }

    public ProductDTO searchProductById(int productId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT_BY_ID);
                ptm.setInt(1, productId);

                rs = ptm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("ProductID");
                    String name = rs.getString("ProductName");
                    String image = rs.getString("ProductImage");
                    double price = rs.getDouble("Price");
                    int quantity = rs.getInt("Quantity");

                    return new ProductDTO(id, name, image, price, quantity);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public boolean insertProduct(ProductDTO product) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setInt(1, product.getId());
                ptm.setString(2, product.getName());
                ptm.setString(3, product.getImage());
                ptm.setDouble(4, product.getPrice());
                ptm.setInt(5, product.getQuantity());

                int rowsInserted = ptm.executeUpdate();
                return rowsInserted > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    public boolean updateProduct(ProductDTO product) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, product.getName());
                ptm.setString(2, product.getImage());
                ptm.setDouble(3, product.getPrice());
                ptm.setInt(4, product.getQuantity());
                ptm.setInt(5, product.getId());

                int rowsUpdated = ptm.executeUpdate();
                return rowsUpdated > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    public boolean deleteProduct(int productId) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setInt(1, productId);

                int rowsDeleted = ptm.executeUpdate();
                return rowsDeleted > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        ProductDAO dao = new ProductDAO();
        boolean product = dao.deleteProduct(11);
        System.out.println(product);
    }
}
