/*
-- Xóa bảng OrderDetails
DROP TABLE OrderDetails;
GO

-- Xóa bảng Orders
DROP TABLE Orders;
GO

-- Xóa bảng Products
DROP TABLE Products;
GO

-- Xóa bảng Users
DROP TABLE tblUsers;
GO
*/
-- Tạo cơ sở dữ liệu
CREATE DATABASE FragranceShop;
GO

-- Sử dụng cơ sở dữ liệu
USE FragranceShop;
GO

-- Tạo bảng User
CREATE TABLE tblUsers(
	[userID] [nvarchar](50) NOT NULL primary key,
	[fullName] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[email] [nvarchar](100) NULL,
	[address] [nvarchar](100) NULL,
	[phoneNumber] [varchar](11) NULL,
 )
GO

-- Tạo bảng Product
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
	ProductImage NVARCHAR(1000),
    Price DECIMAL(10, 2),
    Quantity INT
);
GO
-- Tạo bảng Order
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    [userID] [nvarchar](50),
    OrderDate DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (userID) REFERENCES tblUsers(userID)
);
GO

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Price DECIMAL(10, 2),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'admin', N'Toi la admin', N'1', N'AD', 1,'admin309@gmail.com','hcm','0128313498')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'Hoadnt', N'Hoa Doan', N'1', N'US', 1,'HoaDoan309@gmail.com','hcm','0129381843')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE130363', N'Ngo Ha Tri Bao', N'1', N'AD', 1,'NgoHaTriBao309@gmail.com','hcm','0847197823')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE140103', N'Phuoc Ha', N'1', N'US', 1,'PhuocHa309@gmail.com','hcm','0893719273')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE140119', N'Trai Nguyen', N'1', N'AD', 1,'TraiNguyen309@gmail.com','hcm','0837197122')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE140130', N'Tam Tran', N'1', N'AD', 1,'TamTran309@gmail.com','hcm','0937184822')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE140201', N'PHAM HOANG TU', N'1', N'AD', 1,'PHAMHOANGTU309@gmail.com','hcm','0974816322')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE140969', N'Nguyen Gia Tin', N'123', N'US', 1,'NguyenGiaTin309@gmail.com','hcm','0938718742')
INSERT tblUsers ([userID], [fullName], [password], [roleID], [status], [email], [address],[phoneNumber]) VALUES (N'SE150443', N'LE MINH KHOA', N'1', N'US', 1,'LEMINHKHOA309@gmail.com','hcm','0938179273')





	-- Thêm 10 loại hoa Products
INSERT INTO Products (ProductID, ProductName, ProductImage, Price, Quantity)
VALUES 
    (1, 'Rose', 'https://salisburygreenhouse.com/wp-content/uploads/square.png', 10.99, 50),
    (2, 'Tulip', 'https://assets.florista.ph/uploads/product-pics/1674799696_2065.png', 8.99, 40),
    (3, 'Lily', 'https://www.prestigeflowers.co.uk/images/products/2786e09de66b931e65f5b93b794bbb0c.jpg', 12.99, 30),
    (4, 'Sunflower', 'https://images.unsplash.com/photo-1580046154419-2ab638e3be8e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80',7.99, 60),
    (5, 'Carnation', 'https://cdn.britannica.com/04/204204-050-13AFD426/red-carnation-flowers.jpg',6.99, 70),
    (6, 'Orchid', 'https://www.southernliving.com/thmb/gYMDrpPeIZ6a4k5UNcbGglOjCKo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/gettyimages-859455640-1-3958af52944e41d6bea36341c85cf383.jpg',15.99, 20),
    (7, 'Daisy', 'https://hgtvhome.sndimg.com/content/dam/images/grdn/fullset/2013/4/15/0/CI_ci-shasta-daisy-white-flower-farm.jpg.rend.hgtvcom.406.406.suffix/1452753540053.jpeg',5.99, 80),
    (8, 'Hydrangea', 'https://img.crocdn.co.uk/images/products2/pl/20/00/03/76/pl2000037670_card3_lg.jpg',9.99, 35),
    (9, 'Peony', 'https://www.gardendesign.com/pictures/images/900x705Max/site_3/pink-peony-paeonia-lactiflora-123rf_12230.jpg',11.99, 25),
    (10, 'Gerbera', 'https://www.blumenshop.com/media/catalog/product/cache/2a71f149df63c21acaeaca054470e23d/4/2/4260625430071_bunte_gerbera_int2.jpg',8.99, 45);