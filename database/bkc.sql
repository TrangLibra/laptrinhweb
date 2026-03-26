-- Tạo database
CREATE DATABASE IF NOT EXISTS bkc;
USE bkc;

-- Xóa bảng nếu đã tồn tại (tránh lỗi khi import lại)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- Tạo bảng users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);

-- Tạo bảng products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DOUBLE NOT NULL,
    product_description TEXT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);

-- Tạo bảng order_details
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME
);

-- Thêm khóa ngoại (bonus điểm)
ALTER TABLE orders 
ADD CONSTRAINT fk_orders_users 
FOREIGN KEY (user_id) REFERENCES users(user_id);

ALTER TABLE order_details 
ADD CONSTRAINT fk_od_orders 
FOREIGN KEY (order_id) REFERENCES orders(order_id),
ADD CONSTRAINT fk_od_products 
FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Dữ liệu mẫu users
INSERT INTO users (user_name, user_email, user_pass, created_at) VALUES
('minh', 'minh@gmail.com', '123', NOW()),
('anh', 'anh@gmail.com', '123', NOW()),
('lan', 'lan@yahoo.com', '123', NOW()),
('mai', 'mai@gmail.com', '123', NOW()),
('tuan', 'tuan@gmail.com', '123', NOW()),
('linh', 'linh@gmail.com', '123', NOW()),
('hieu', 'hieu@gmail.com', '123', NOW()),
('trang', 'trang@gmail.com', '123', NOW()),
('khanh', 'khanh@gmail.com', '123', NOW()),
('binh', 'binh@yahoo.com', '123', NOW());

-- Dữ liệu mẫu products
INSERT INTO products (product_name, product_price, product_description, created_at) VALUES
('Samsung S23', 20000000, 'Điện thoại Samsung', NOW()),
('Samsung A50', 8000000, 'Samsung giá rẻ', NOW()),
('iPhone 15', 25000000, 'Điện thoại Apple', NOW()),
('iPhone 13', 18000000, 'Apple đời cũ', NOW()),
('Laptop Dell', 15000000, 'Laptop văn phòng', NOW()),
('Macbook Pro', 30000000, 'Laptop Apple', NOW()),
('AirPods', 5000000, 'Tai nghe Apple', NOW());

-- Dữ liệu mẫu orders
INSERT INTO orders (user_id, created_at) VALUES
(1, NOW()),
(2, NOW()),
(3, NOW()),
(1, NOW()),
(4, NOW()),
(5, NOW()),
(1, NOW()),
(6, NOW());

-- Dữ liệu mẫu order_details
INSERT INTO order_details (order_id, product_id, created_at) VALUES
(1, 1, NOW()),
(1, 3, NOW()),
(2, 2, NOW()),
(3, 4, NOW()),
(4, 1, NOW()),
(4, 5, NOW()),
(5, 6, NOW()),
(6, 2, NOW()),
(7, 7, NOW()),
(8, 3, NOW());