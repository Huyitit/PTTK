package model;

/**
 * Lớp thực thể Khách hàng (Customer3)
 * Kế thừa từ User3, bổ sung mã định danh khách hàng và thông tin thẻ thành viên.
 */
public class Customer3 extends User3 {
    private static final long serialVersionUID = 1L;

    private String code;
    private MembershipCard3 card;

    public Customer3() {
        super();
    }

    public Customer3(int id, String username, String password, String fullName, String email, String phone, String code) {
        super(id, username, password, fullName, email, phone);
        this.code = code;
    }

    public Customer3(int id, String username, String password, String fullName, String email, String phone, String code, MembershipCard3 card) {
        super(id, username, password, fullName, email, phone);
        this.code = code;
        this.card = card;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public MembershipCard3 getCard() {
        return card;
    }

    public void setCard(MembershipCard3 card) {
        this.card = card;
    }

    @Override
    public String toString() {
        return "Customer3 [" + super.toString() + ", code=" + code + ", card=" + card + "]";
    }
}
