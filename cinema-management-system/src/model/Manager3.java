package model;

/**
 * Lớp thực thể Quản lý (Manager3)
 * Kế thừa từ Staff3, đại diện cho nhân viên quản lý rạp chiếu phim.
 */
public class Manager3 extends Staff3 {
    private static final long serialVersionUID = 1L;

    public Manager3() {
        super();
    }

    public Manager3(int id, String username, String password, String fullName, String email, String phone, String role) {
        super(id, username, password, fullName, email, phone, role);
    }

    @Override
    public String toString() {
        return "Manager3 [" + super.toString() + "]";
    }
}
