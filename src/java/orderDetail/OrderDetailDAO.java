/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package orderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import products.ProductDTO;
import utils.DBContext;

/**
 *
 * @author Thinh Tran
 */
public class OrderDetailDAO {

    private static final String ADD_ORDER_DETAIL = "INSERT INTO [OrderDetails] (orderID, orderDetailID, productID, price, quantity) VALUES (?, ?, ?, ?, ?)";

    public int addOrderDetail(int orderID, ProductDTO product) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int orderDetailID = -1;

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(ADD_ORDER_DETAIL, Statement.RETURN_GENERATED_KEYS);

            // Sử dụng một giá trị ngẫu nhiên cho orderDetailID
            Random rand = new Random();
            orderDetailID = rand.nextInt(1000000);

            stmt.setInt(1, orderID);
            stmt.setInt(2, orderDetailID);
            stmt.setInt(3, product.getId());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getQuantity());

            stmt.executeUpdate();

            // Không cần lấy giá trị orderDetailID được tạo tự động
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return orderDetailID;
    }

    public static void main(String[] args) {
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

        try {
            int orderID = 6; // Giả sử đã có orderID từ bước trước
            ProductDTO product = new ProductDTO(1, "Product 1", "image1.jpg", 10.99, 2); // Tạo đối tượng product

            int orderDetailID = orderDetailDAO.addOrderDetail(orderID, product);
            System.out.println("OrderDetailID: " + orderDetailID);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
