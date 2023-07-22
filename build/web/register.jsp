<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Đăng ký</title>
        <style>
            /* CSS styles */

            body {
                font-family: Arial, sans-serif;
                background-color: #f1f1f1;
            }

            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
            }

            form {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="email"],
            input[type="tel"],
            input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .error-message {
                color: red;
                margin-bottom: 10px;
            }

            p {
                text-align: center;
            }

            .login-link {
                color: #007bff;
                text-decoration: none;
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
            <a href="homepage.jsp">Homepage</a>
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
        <div class="container">
            <h1>Đăng ký</h1>

            <form action="MainController" method="post" onsubmit="return validateForm()">
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" required>
                
                <label for="name">Họ và tên:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="phone">Số điện thoại:</label>
                <input type="tel" id="phone" name="phone" required>

                <label for="address">Địa chỉ: </label>
                <input type="text" id="address" name="address" required>

                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>

                <button type="submit" name="action" value="Register">Đăng ký</button>

                <p id="error-message" class="error-message"></p>
            </form>

            <p>Bạn đã có tài khoản? <a class="login-link" href="login.jsp">Đăng nhập</a></p>
        </div>

        <script>
            // JavaScript validation
            function validateForm() {
                var name = document.getElementById("name").value;
                var email = document.getElementById("email").value;
                var phone = document.getElementById("phone").value;
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                var errorMessage = document.getElementById("error-message");

                if (name === "" || email === "" || phone === "" || username === "" || password === "") {
                    errorMessage.textContent = "Vui lòng nhập đủ thông tin.";
                    return false;
                }

                return true;
            }
        </script>
    </body>

</html>