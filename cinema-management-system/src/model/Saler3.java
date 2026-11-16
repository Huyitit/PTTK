package model;

/**
 * Lớp thực thể Nhân viên bán vé (Saler3)
 * Kế thừa từ Staff3, đại diện cho nhân viên bán vé tại quầy.
 */
public class Saler3 extends Staff3 {
    private static final long serialVersionUID = 1L;

    public Saler3() {
        super();
    }

    public Saler3(int id, String username, String password, String fullName, String email, String phone, String role) {
        super(id, username, password, fullName, email, phone, role);
    }

    @Override
    public String toString() {
        return "Saler3 [" + super.toString() + "]";
    }
}
