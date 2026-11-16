# ====================================================================
# Dockerfile cho Cinema Management System (Subject No. 17)
# Kiến trúc: Eclipse Dynamic Web Project thuần (Java 17 + Tomcat 9)
# Multi-stage build: Tự động biên dịch mã nguồn và đóng gói vào Tomcat
# ====================================================================

# --------------------------------------------------------------------
# STAGE 1: Biên dịch mã nguồn Model và DAO
# --------------------------------------------------------------------
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Copy mã nguồn và thư viện
COPY src ./src
COPY WebContent ./WebContent

# Biên dịch toàn bộ các lớp Model và DAO
RUN mkdir -p build/classes && \
    javac -encoding UTF-8 \
    -cp "WebContent/WEB-INF/lib/*" \
    -d build/classes \
    src/model/*.java src/dao/*.java

# --------------------------------------------------------------------
# STAGE 2: Khởi chạy trên Apache Tomcat 9 (Servlet 4.0 / Java 17)
# --------------------------------------------------------------------
FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat

# Dọn dẹp ứng dụng mặc định của Tomcat
RUN rm -rf webapps/*

# Triển khai ứng dụng vào webapps/ROOT (truy cập tại http://localhost:8080/)
COPY --from=builder /app/WebContent webapps/ROOT
COPY --from=builder /app/build/classes webapps/ROOT/WEB-INF/classes

# Tạo thêm bản sao tại webapps/cinema-management-system (truy cập cả 2 đường dẫn)
RUN cp -r webapps/ROOT webapps/cinema-management-system

# Cổng dịch vụ web
EXPOSE 8080

# Chạy Tomcat ở chế độ foreground
CMD ["catalina.sh", "run"]
