# 📱 Website Quản lý Thu Chi - Cửa hàng điện thoại

Dự án cuối kỳ môn Công cụ Phát triển Phần mềm. Ứng dụng giúp chủ cửa hàng điện thoại quản lý dòng tiền (Thu/Chi) một cách trực quan, khoa học thông qua các biểu đồ và báo cáo.

## 🚀 Tính năng chính
* **Quản lý Truy cập:** Đăng nhập hệ thống, bảo mật Session, Đăng xuất an toàn.
* **Dashboard (Bảng điều khiển):** Hiển thị Tổng thu, Tổng chi, Số dư và 10 giao dịch gần đây nhất.
* **Nghiệp vụ Thu Chi:** Thêm mới giao dịch (bán máy, sửa chữa, nhập hàng, tiền lương...), xem danh sách và xóa giao dịch.
* **Thống kê chuyên sâu:** Biểu đồ hình tròn (Pie Chart) và vành khăn (Doughnut) phân tích tỷ trọng các khoản thu/chi bằng thư viện **Chart.js**.

## 🛠 Công nghệ sử dụng
* **Backend:** Java Servlet (Jakarta EE), JDBC.
* **Frontend:** HTML5, CSS3 (Modern Light Theme), JavaScript, JSP.
* **Cơ sở dữ liệu:** MySQL 8.0.
* **Quản lý dự án:** Jira (Agile/Scrum), Maven.
* **Kiểm soát mã nguồn:** Git & GitHub.
* **Triển khai:** Docker & Docker Compose.

## 🐳 Hướng dẫn cài đặt nhanh bằng Docker

Đây là cách nhanh nhất để chạy dự án mà không cần cài đặt Java hay MySQL thủ công.

### 1. Yêu cầu hệ thống
* Đã cài đặt [Docker Desktop](https://www.docker.com/products/docker-desktop/).

### 2. Các bước thực hiện
1. **Clone dự án từ GitHub:**
   ```bash
   git clone https://github.com/tuaanshuuysv/quan-ly-thu-chi
   cd quan-ly-thu-chi
2.Khởi chạy Docker:
docker-compose up --build -d
3. Kết nối tới MySQL tại localhost:3307 (Mật khẩu: huy2406) và chạy script SQL trong tệp script.sql để tạo bảng và dữ liệu mẫu.
4.Truy cập:
Mở trình duyệt và truy cập: http://localhost:8083/

📂 Cấu trúc thư mục (MVC)
src/main/java/com/store/model: Chứa các Entity (User, Transaction, Category).

src/main/java/com/store/dao: Xử lý truy vấn CSDL (JDBC).

src/main/java/com/store/controller: Các Servlet điều hướng và xử lý logic.

src/main/java/com/store/utils: Lớp kết nối DBConnection.

src/main/webapp/views: Giao diện JSP cho ứng dụng.