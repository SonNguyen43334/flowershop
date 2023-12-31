/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.User;
import utils.DBContext;

/**
 *
 * @author Dell
 */
public class UserDAO {

    private static final String LOGIN = "SELECT * FROM tblUsers WHERE email = ? AND password = ?";
    private static final String LOGIN_VIA_GOOGLE = "select * from tblUsers where email = ?";
    private static final String SEARCH = "SELECT userID, fullName,roleID, status FROM tblUsers  WHERE fullName LIKE ?";
    private static final String DELETE = "DELETE FROM tblUsers  WHERE userID = ?";
    private static final String UPDATE = "UPDATE  tblUsers SET fullName = ?, roleID = ?  WHERE userID = ?";
    private static final String CHECK_DUPLICATE = "SELECT roleID FROM tblUsers  WHERE email = ?";
    private static final String INSERT = "INSERT INTO tblUsers (userID, fullName,password,roleID,status,email, address, phoneNumber) VALUES (?,?,?,?,?,?,?,?)";

    public UserDTO checkLogin(String email, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
//            Xu ly o day
            conn = DBContext.getConnection();
            ptm = conn.prepareStatement(LOGIN);
            ptm.setString(1, email);
            ptm.setString(2, password);
            rs = ptm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");
                String address = rs.getString("address");
                String phone = rs.getString("phoneNumber");
                user = new UserDTO(userID, fullName, password, roleID, status, email, address, phone);
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
        return user;
    }
     public UserDTO loginViaGoogle(String email) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
//            Xu ly o day
            conn = DBContext.getConnection();
            ptm = conn.prepareStatement(LOGIN_VIA_GOOGLE);
            ptm.setString(1, email);
            rs = ptm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");
                String address = rs.getString("address");
                String phone = rs.getString("phoneNumber");
                user = new UserDTO(userID, fullName, "1", roleID, status, email, address, phone);
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
        return user;
    }

//    public List<UserDTO> getListUser(String search) throws SQLException {
//        Connection conn = null;
//        PreparedStatement ptm = null;
//        ResultSet rs = null;
//
//        List<UserDTO> listUser = new ArrayList<>();
//        try {
////            Xu ly o day
//            conn = DBContext.getConnection();
//            if (conn != null) {
//
//                ptm = conn.prepareStatement(SEARCH);
//                ptm.setString(1, "%" + search + "%");
//
//                rs = ptm.executeQuery();
//                while (rs.next()) {
//                    String userID = rs.getString("userID");
//                    String fullName = rs.getString("fullName");
//                    String roleID = rs.getString("roleID");
//                    boolean status = rs.getBoolean("status");
//                    String password = "***";
//                    listUser.add(new UserDTO(userID, fullName, password, roleID, status));
//
//                }
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (ptm != null) {
//                ptm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return listUser;
//    }
    public boolean update(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, user.getFullName());
                ptm.setString(2, user.getRoleID());
                ptm.setString(3, user.getPassword());
                ptm.setString(4, user.getUserID());
                check = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteUser(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
//            Xu ly o day
            conn = DBContext.getConnection();

            if (conn != null) {

                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, userID);

                check = ptm.executeUpdate() > 0 ? true : false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return check;
    }

    public boolean checkDuplicate(String email) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            if (conn != null) {

                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, email);

                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
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
        return check;
    }

    public boolean insertUser(UserDTO user) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBContext.getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(INSERT);
                pstmt.setString(1, user.getUserID());
                pstmt.setString(2, user.getFullName());
                pstmt.setString(3, user.getPassword());
                pstmt.setString(4, "US");
                pstmt.setBoolean(5, true);
                pstmt.setString(6, user.getEmail());
                pstmt.setString(7, user.getAddress());
                pstmt.setString(8, user.getPhoneNumber());

                int rowsInserted = pstmt.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    public static void main(String[] args) throws SQLException {
        UserDAO dao = new UserDAO();
        UserDTO user = dao.checkLogin("thinh@gmail.com", "1");
        System.out.println(user);
    }
}
