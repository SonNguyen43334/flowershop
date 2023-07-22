<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FRAGRANCE SHOP</title>
        <style>
            /* CSS cho phần navbar */
            .navbar {
                background-color: #f5f5f5;
                padding: 10px;
                background-color: #000;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .navbar a {
                margin-right: 10px;
                text-decoration: none;
                color: darkgray;
            }

            .search-bar {
                margin: 20px 0;
            }

            .search-bar input[type="text"] {
                width: 200px;
                padding: 5px;
            }

            .search-bar button {
                padding: 5px 10px;
                background-color: #4caf50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .search-bar button:hover {
                background-color: #45a049;
            }

            /* CSS cho phần sản phẩm */
            .container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .product {
                width: calc(100% / 3);
                padding: 20px;
                text-align: center;
            }

            .product img {
                width: 200px;
                height: 200px;
                object-fit: cover;
                margin-bottom: 10px;
            }

            .product h3 {
                margin-bottom: 10px;
            }

            .product p {
                margin-bottom: 10px;
            }

            .product button {
                padding: 10px 20px;
                background-color: #4caf50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .product button:hover {
                background-color: #45a049;
            }
            .center-text{
                text-align: center;
            }
            .search-input {
                background-color: lightgray;
                color: black;
            }

            .search-button {
                background-color: gray;
                color: white;
            }
        </style>
    </head>

    <body>
        <div class="navbar">
            <div>
                <a href="HomepageController">Homepage</a>
                <a href="cart.jsp">Cart</a>
                <c:if test="${empty sessionScope.LOGIN_USER}">
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp">Register</a>
                </c:if>
                <c:if test="${not empty sessionScope.LOGIN_USER}">
                    <a href="MainController?action=Logout">Logout</a>
                </c:if>
                <!-- Chỉ hiển thị liên kết CRUD nếu người dùng có vai trò admin -->
                <!--      <a href="crud.jsp">CRUD</a>-->
            </div>
            <form action="MainController" method="post">
                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="Search" name="search">
                    <button type="submit" class="search-button" name="action" value="Search">Search</button>
                </div>
            </form>
        </div>

        <h1 class="center-text">FRAGRANCE SHOP</h1>

        <div class="container">
            <c:forEach var="item" items="${products}">
                <div class="product">
                    <img src="${item.image}">
                    <h3>${item.name}</h3>
                    <input type="hidden" name="name" value="${item.name}">
                    <p>Giá: ${item.price}$</p>
                    <form action="MainController" method="post">
                        <input type="hidden" name="id" value="${item.id}">
                        <input type="hidden" name="name" value="${item.name}">
                        <input type="hidden" name="image" value="${item.image}">
                        <input type="hidden" name="price" value="${item.price}">
                        <input type="hidden" name="quantity" value="1" />
                        <button type="submit" name="action" value="AddToCart">Thêm vào giỏ hàng</button>
                    </form>
                </div>
            </c:forEach>


        </div>

        <script>
            function addToCart(name, price) {
                // Lưu thông tin sản phẩm vào Local Storage hoặc gửi dữ liệu qua AJAX

                alert('Đã thêm sản phẩm "' + name + '" vào giỏ hàng');
            }
        </script>
    </body>

</html>