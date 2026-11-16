package model;

/**
 * Lớp thực thể Nhân viên (Staff3)
 * Kế thừa từ User3, bổ sung vai trò của nhân viên trong rạp chiếu phim.
 */
public class Staff3 extends User3 {
    private static final long serialVersionUID = 1L;

    private String role;

    public Staff3() {
        super();
    }

    public Staff3(int id, String username, String password, String fullName, String email, String phone, String role) {
        super(id, username, password, fullName, email, phone);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Staff3 [" + super.toString() + ", role=" + role + "]";
    }
}
