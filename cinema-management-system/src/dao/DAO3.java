package dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Lớp cơ sở DAO3 (Data Access Object) quản lý kết nối CSDL MySQL 8.0.
 * Tuân thủ quy chuẩn giáo trình Chương 5.2 (Hình 5.1 và trang 116).
 * Cung cấp biến kết nối `public static Connection con` phục vụ kết nối dùng chung
 * và hỗ trợ Transaction Rollback cho các bài kiểm thử tự động JUnit 4.
 *
 * Toàn bộ thông số kết nối (đặc biệt là mật khẩu) được nạp động từ file .env
 * hoặc biến môi trường hệ thống, tuyệt đối không hard-code trong mã nguồn.
 */
public class DAO3 {
    public static Connection con;

    public DAO3() {
        if (con == null) {
            openConnection();
        } else {
            try {
                if (con.isClosed()) {
                    openConnection();
                }
            } catch (SQLException e) {
                openConnection();
            }
        }
    }

    /**
     * Khởi tạo kết nối tới CSDL MySQL dựa trên cấu hình nạp từ .env / Environment
     * Tích hợp cơ chế retry tự động để đảm bảo kết nối ổn định khi CSDL đang khởi động trong Docker.
     */
    public synchronized static Connection openConnection() {
        if (con != null) {
            try {
                if (!con.isClosed()) {
                    return con;
                }
            } catch (SQLException ignored) {
            }
        }

        Properties env = loadEnv();
        String host = env.getProperty("DB_HOST", "localhost");
        String port = env.getProperty("DB_PORT", "3306");
        String dbName = env.getProperty("DB_NAME", "cinema_db3");
        String user = env.getProperty("DB_USER", "root");
        String password = env.getProperty("DB_PASSWORD", "root");

        String dbUrl = "jdbc:mysql://" + host + ":" + port + "/" + dbName
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8&autoReconnect=true";
        String dbClass = "com.mysql.cj.jdbc.Driver";

        // Thử kết nối với cơ chế retry (tối đa 5 lần, mỗi lần cách nhau 1.5s)
        int maxAttempts = 5;
        for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, user, password);
                if (con != null && !con.isClosed()) {
                    return con;
                }
            } catch (Exception e) {
                if (attempt == maxAttempts) {
                    System.err.println("Lỗi khởi tạo kết nối CSDL trong DAO3: " + e.getMessage());
                } else {
                    try {
                        Thread.sleep(1500);
                    } catch (InterruptedException ignored) {
                    }
                }
            }
        }
        return con;
    }

    /**
     * Đóng kết nối CSDL nếu đang mở
     */
    public static void closeConnection() {
        if (con != null) {
            try {
                if (!con.isClosed()) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                con = null;
            }
        }
    }

    /**
     * Nạp cấu hình từ biến môi trường hệ thống hoặc file .env (Zero-dependency parser)
     */
    public static Properties loadEnv() {
        Properties props = new Properties();

        // 1. Giá trị mặc định
        props.setProperty("DB_HOST", "localhost");
        props.setProperty("DB_PORT", "3306");
        props.setProperty("DB_NAME", "cinema_db3");
        props.setProperty("DB_USER", "root");
        props.setProperty("DB_PASSWORD", "root");

        // 2. Tìm file .env theo các đường dẫn tương đối và tuyệt đối tiềm năng
        String userDir = System.getProperty("user.dir", ".");
        String[] candidatePaths = {
            ".env",
            "cinema-management-system/.env",
            "../.env",
            userDir + "/.env",
            userDir + "/cinema-management-system/.env"
        };

        File envFile = null;
        for (String path : candidatePaths) {
            File f = new File(path);
            if (f.exists() && f.isFile()) {
                envFile = f;
                break;
            }
        }

        if (envFile != null) {
            try (InputStream is = new FileInputStream(envFile);
                 BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    line = line.trim();
                    if (line.isEmpty() || line.startsWith("#")) {
                        continue;
                    }
                    int eqIdx = line.indexOf('=');
                    if (eqIdx > 0) {
                        String key = line.substring(0, eqIdx).trim();
                        String value = line.substring(eqIdx + 1).trim();
                        if ((value.startsWith("\"") && value.endsWith("\"")) ||
                            (value.startsWith("'") && value.endsWith("'"))) {
                            if (value.length() >= 2) {
                                value = value.substring(1, value.length() - 1);
                            }
                        }
                        props.setProperty(key, value);
                    }
                }
            } catch (Exception e) {
                System.err.println("Không thể đọc file .env tại: " + envFile.getAbsolutePath() + " - " + e.getMessage());
            }
        }

        // 3. Biến môi trường hệ thống (System.getenv) và JVM Properties (System.getProperty) có độ ưu tiên cao nhất
        String[] keys = {"DB_HOST", "DB_PORT", "DB_NAME", "DB_USER", "DB_PASSWORD"};
        for (String k : keys) {
            String sysVal = System.getenv(k);
            if (sysVal != null && !sysVal.trim().isEmpty()) {
                props.setProperty(k, sysVal.trim());
            }
            String propVal = System.getProperty(k);
            if (propVal != null && !propVal.trim().isEmpty()) {
                props.setProperty(k, propVal.trim());
            }
        }

        return props;
    }
}
