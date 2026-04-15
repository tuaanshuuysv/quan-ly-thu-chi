# Sử dụng Tomcat 10 (chạy Jakarta EE) và Java 17
FROM tomcat:10.1-jdk17

# Xóa các ứng dụng rác mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file .war mà Maven vừa tạo vào thư mục webapps của Tomcat
# Đổi tên thành ROOT.war để website chạy thẳng ở đường dẫn chính localhost:8080/
COPY target/QuanLyThuChi.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Khởi chạy Tomcat
CMD ["catalina.sh", "run"]