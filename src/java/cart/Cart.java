/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import products.ProductDTO;

/**
 *
 * @author Thinh Tran
 */
public class Cart {

    private Map<Integer, ProductDTO> cart;

    public Cart() {
        cart = new HashMap<>();
    }

    public Cart(Map<Integer, ProductDTO> cart) {
        this.cart = cart;
    }

    public Map<Integer, ProductDTO> getCart() {
        return cart;
    }

    public void setCart(Map<Integer, ProductDTO> cart) {
        this.cart = cart;
    }

    public boolean add(ProductDTO product) {
        boolean check = false;
        if (this.cart.containsKey(product.getId())) {
            ProductDTO existingProduct = this.cart.get(product.getId());
            existingProduct.setQuantity(existingProduct.getQuantity() + product.getQuantity());
        } else {
            this.cart.put(product.getId(), product);
        }
        check = true;
        return check;
    }

    public boolean update(int id, ProductDTO product) {
        boolean checkUpdate = false;
        if (this.cart.containsKey(id)) {
            this.cart.put(id, product);
            checkUpdate = true;
        }
        return checkUpdate;
    }

    public boolean remove(int id) {
        boolean checkRemove = false;
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
            checkRemove = true;
        }
        return checkRemove;
    }

    public double getTotal() {
        double total = 0.0;
        for (ProductDTO product : cart.values()) {
            total += product.getPrice() * product.getQuantity();
        }
        return total;
    }
}
