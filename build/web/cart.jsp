<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Giỏ hàng</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
            }

            .cart-wrapper {
                display: grid;
                grid-template-columns: 1fr 1fr;
                grid-gap: 20px;
            }

            .cart-item {
                display: flex;
                align-items: center;
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            .cart-item img {
                width: 100px;
                margin-right: 10px;
            }

            .cart-item-info {
                flex-grow: 1;
            }

            .cart-item-quantity {
                width: 100px;
                text-align: center;
            }

            .cart-item-price {
                margin-right: 10px;
            }

            .cart-item-remove {
                margin-left: 10px;
                cursor: pointer;
            }

            .checkout-info {
                padding: 10px;
                border: 1px solid #ddd;
            }

            .checkout-info label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .checkout-info input[type="text"],
            .checkout-info textarea {
                width: 100%;
                padding: 5px;
            }

            .checkout-btns {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .checkout-btn {
                padding: 10px 20px;
                background-color: #4caf50;
                color: #fff;
                text-decoration: none;
                border: none;
                cursor: pointer;
                margin-left: 50px;
                margin-right: 50px;
                margin-bottom: 50px;
                border-radius: 20px;
            }

            .back-btn {
                background-color: #bbb;
            }

            .checkout-btn:hover,
            .back-btn:hover {
                background-color: #45a049;
            }

            .cart-total {
                font-weight: bold;
                text-align: right;
            }

            .container-1 {
                width: 90%;
                background-color: beige;
                border-radius: 20px;
                margin: 5%;
            }

            /* CSS cho phần navbar */
            .navbar {
                background-color: #f5f5f5;
                padding: 10px;
                background-color: #000;
            }

            .navbar a {
                margin-right: 10px;
                text-decoration: none;
                color: darkgray;
            }
        </style>
    </head>

    <body>
        <div class="navbar">
            <a href="HomepageController">Homepage</a>
            <a href="cart.jsp">Cart</a>
            <!--    <a href="crud.jsp">CRUD</a>-->
            <c:if test="${empty sessionScope.LOGIN_USER}">
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </c:if>
            <c:if test="${not empty sessionScope.LOGIN_USER}">
                <a href="MainController?action=Logout">Logout</a>
            </c:if>
        </div>
        <div class="container-1">
            <h1>Giỏ hàng</h1>
            <div class="cart-wrapper">
                <div>
                    <form action="MainController" method="post">
                        <c:forEach var="product" items="${sessionScope.CART.cart}">
                            <div class="cart-item">
                                <img src="${product.value.image}" >
                                <div class="cart-item-info">
                                    <div class="cart-item-name">${product.value.name}</div>
                                    <input type="hidden" name="id" value="${product.value.id}">
                                    <input type="number" class="cart-item-quantity" min="1" value="${product.value.quantity}">
                                </div>
                                <div class="cart-item-price">$${product.value.price}</div>
                                <input type="submit" name="action" value="Remove Cart"/>
                            </div>
                        </c:forEach>
                    </form>

                </div>
            </div>
            <div class="cart-total">
                Tổng tiền: <span id="total-price">$0.00</span>
            </div>
            <div class="checkout-btns">
                <a href="MainController?action=" class="checkout-btn back-btn">Quay lại</a>
                <a href="MainController?action=Checkout" class="checkout-btn">Thanh toán</a>
            </div>
        </div>

        <script>
            var mess = "<c:out value='${requestScope.mess}' />";
            if (mess) {
                alert(mess);
            }
        </script>
        <script>
            // Lấy danh sách tất cả các phần tử giá sản phẩm
            const priceElements = document.querySelectorAll('.cart-item-price');

// Lấy danh sách tất cả các phần tử số lượng sản phẩm
            const quantityElements = document.querySelectorAll('.cart-item-quantity');

// Thẻ tổng tiền
            const totalPriceElement = document.getElementById('total-price');

// Tính toán và cập nhật tổng tiền
            function updateTotalPrice() {
                let totalPrice = 0;

                // Duyệt qua tất cả các sản phẩm
                for (let i = 0; i < priceElements.length; i++) {
                    const price = parseFloat(priceElements[i].textContent.replace('$', ''));
                    const quantity = parseInt(quantityElements[i].value);

                    // Tính tiền của sản phẩm = giá * số lượng
                    const productTotal = price * quantity;

                    totalPrice += productTotal;
                }

                // Hiển thị tổng tiền
                totalPriceElement.textContent = '$' + totalPrice.toFixed(2);
            }

// Gắn sự kiện thay đổi số lượng sản phẩm để cập nhật tổng tiền
            quantityElements.forEach(element => {
                element.addEventListener('change', updateTotalPrice);
            });

// Xóa sản phẩm khỏi giỏ hàng
            function removeCartItem(element) {
                const cartItem = element.parentNode;
                cartItem.remove();

                updateTotalPrice();
            }

// Cập nhật tổng tiền lần đầu khi tải trang
            updateTotalPrice();
        </script>
    </body>

</html>