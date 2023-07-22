/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package orders;

import java.sql.Date;

/**
 *
 * @author Thinh Tran
 */
public class OrderDTO {
    private int id;
    private int userID;
    private Date orderDate;
    private double total;

    public OrderDTO(int id, int userID, Date orderDate, double total) {
        this.id = id;
        this.userID = userID;
        this.orderDate = orderDate;
        this.total = total;
    }

    public OrderDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "OrderDTO{" + "id=" + id + ", userID=" + userID + ", orderDate=" + orderDate + ", total=" + total + '}';
    }
    
    
}
