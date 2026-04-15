-- 1. Tạo cơ sở dữ liệu (Nếu chưa có) và thiết lập sử dụng UTF-8 để hỗ trợ Tiếng Việt
CREATE DATABASE IF NOT EXISTS quanly_thuchi 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE quanly_thuchi;

-- ==========================================
-- 2. TẠO CÁC BẢNG (TABLES)
-- ==========================================

-- Bảng Người dùng (users)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER'
);

-- Bảng Danh mục Thu/Chi (categories)
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('INCOME', 'EXPENSE') NOT NULL
);

-- Bảng Giao dịch (transactions)
CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount DOUBLE NOT NULL,
    transaction_date DATE NOT NULL,
    note TEXT,
    category_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ==========================================
-- 3. CHÈN DỮ LIỆU MẪU (INSERT DATA)
-- ==========================================

-- Thêm tài khoản đăng nhập (Mật khẩu mặc định: 123456)
INSERT INTO users (username, password, role) VALUES 
('admin', '123456', 'ADMIN'),
('nhanvien', '123456', 'USER');

-- Thêm dữ liệu Danh mục mẫu cho Cửa hàng điện thoại
INSERT INTO categories (name, type) VALUES 
('Bán điện thoại', 'INCOME'),
('Sửa chữa dịch vụ', 'INCOME'),
('Bán phụ kiện', 'INCOME'),
('Nhập hàng linh kiện', 'EXPENSE'),
('Trả lương nhân viên', 'EXPENSE'),
('Tiền mặt bằng & Điện nước', 'EXPENSE'),
('Chi phí Marketing', 'EXPENSE');

-- Thêm một vài Giao dịch mẫu (Giả sử admin có id=1)
-- Lưu ý: Các ID category phải khớp với dữ liệu vừa insert ở trên
INSERT INTO transactions (amount, transaction_date, note, category_id, user_id) VALUES 
(24000000, '2024-05-01', 'Bán iPhone 15 Pro Max 256GB', 1, 1),
(500000, '2024-05-02', 'Thay pin iPhone X cho khách', 2, 1),
(150000, '2024-05-02', 'Bán ốp lưng cường lực', 3, 1),
(12000000, '2024-05-03', 'Nhập lô hàng màn hình và pin', 4, 1),
(8000000, '2024-05-05', 'Trả lương tháng 4 cho nv kĩ thuật', 5, 1),
(15000000, '2024-05-06', 'Đóng tiền mặt bằng tháng 5', 6, 1),
(8500000, '2024-05-07', 'Bán Samsung Galaxy S23 cũ', 1, 1);