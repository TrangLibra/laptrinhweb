-- 1. Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT u.user_id, u.user_name, o.order_id 
FROM  users u 
JOIN orders o ON u.user_id=o.user_id;

-- 2. Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users u 
JOIN orders o ON u.user_id=o.user_id
GROUP BY u.user_id, u.user_name;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS 'So san pham'
FROM orders o 
JOIN order_details od ON o.order_id=od.order_id
GROUP BY o.order_id;
-- 4. Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản phẩm. Lưu ý: gôm nhóm theo đơn hàng, tránh hiển thị xen kẻ các đơn hàng với nhau
SELECT u.user_id, u.user_name, o.order_id, p.product_name 
FROM products p
JOIN order_details od ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
JOIN users u ON u.user_id = o.user_id
ORDER BY o.order_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất, thông tin hiển thị gồm: mã user, tên user, số lượng đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_don_hang
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY so_don_hang DESC
LIMIT 7;


-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản phẩm, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT DISTINCT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' 
   OR p.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS tong_tien
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

-- 8. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. 
-- Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất. 
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id, 
           SUM(p.product_price) AS tong_tien
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE tong_tien = (
    SELECT MAX(t2.tong_tien)
    FROM (
        SELECT o2.order_id, o2.user_id, SUM(p2.product_price) AS tong_tien
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        GROUP BY o2.order_id, o2.user_id
    ) t2
    WHERE t.user_id = t2.user_id
);

-- 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. 
-- Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất. 
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id, 
           SUM(p.product_price) AS tong_tien,
           COUNT(p.product_id) AS so_san_pham
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE tong_tien = (
    SELECT MIN(t2.tong_tien)
    FROM (
        SELECT o2.order_id, o2.user_id, SUM(p2.product_price) AS tong_tien
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        GROUP BY o2.order_id, o2.user_id
    ) t2
    WHERE t.user_id = t2.user_id
);

-- 10. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. 
-- Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất.
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id, 
           SUM(p.product_price) AS tong_tien,
           COUNT(p.product_id) AS so_san_pham
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE so_san_pham = (
    SELECT MAX(t2.so_san_pham)
    FROM (
        SELECT o2.order_id, o2.user_id, COUNT(p2.product_id) AS so_san_pham
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        GROUP BY o2.order_id, o2.user_id
    ) t2
    WHERE t.user_id = t2.user_id
);