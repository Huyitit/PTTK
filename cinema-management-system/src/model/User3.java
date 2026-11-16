package model;

import java.io.Serializable;

/**
 * Lớp thực thể Người dùng cơ sở (User3)
 * Đại diện cho thông tin tài khoản người dùng dùng chung trong hệ thống rạp chiếu phim.
 */
public class User3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;

    public User3() {
    }

    public User3(int id, String username, String password, String fullName, String email, String phone) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "User3 [id=" + id + ", username=" + username + ", fullName=" + fullName + ", phone=" + phone + "]";
    }
}
