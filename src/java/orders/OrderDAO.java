/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package orders;

import cart.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import products.ProductDTO;
import users.UserDTO;
import utils.DBContext;

/**
 *
 * @author Thinh Tran
 */
public class OrderDAO {

    private static final String ADD_ORDER = "insert into [Orders] values (?,?,?)";

    public int addOrder(UserDTO user, Cart cart) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int orderID = -1;

        LocalDate currentDate = java.time.LocalDate.now();
        String date = currentDate.toString();

        try {
            conn = DBContext.getConnection();
            stmt = conn.prepareStatement(ADD_ORDER, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, user.getUserID());
            stmt.setDate(2, java.sql.Date.valueOf(date));
            stmt.setDouble(3, cart.getTotal());

            stmt.executeUpdate();

            // Lấy giá trị orderID được tạo tự động
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return orderID;
    }
    public static void main(String[] args) {
         try {
        // Tạo dữ liệu user và cart
        UserDTO user = new UserDTO();
        user.setUserID("Hoadnt");

        Cart cart = new Cart();
        ProductDTO product1 = new ProductDTO(1, "Product 1", "image1.jpg", 10.99, 2);
        ProductDTO product2 = new ProductDTO(2, "Product 2", "image2.jpg", 5.99, 3);
        cart.add(product1);
        cart.add(product2);

        // Tạo đối tượng OrderDAO
        OrderDAO orderDAO = new OrderDAO();

        // Gọi phương thức addOrder
        int orderID = orderDAO.addOrder(user, cart);

        if (orderID != -1) {
            System.out.println("Đã thêm đơn hàng thành công. OrderID: " + orderID);
        } else {
            System.out.println("Thêm đơn hàng thất bại.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    }
}
