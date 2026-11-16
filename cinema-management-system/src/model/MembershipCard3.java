package model;

import java.io.Serializable;
import java.util.Date;

/**
 * Lớp thực thể Thẻ thành viên (MembershipCard3)
 * Lưu trữ thông tin ngày cấp và điểm tích lũy của khách hàng rạp chiếu phim.
 */
public class MembershipCard3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date issueDate;
    private int points;

    public MembershipCard3() {
    }

    public MembershipCard3(int id, Date issueDate, int points) {
        this.id = id;
        this.issueDate = issueDate;
        this.points = points;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    @Override
    public String toString() {
        return "MembershipCard3 [id=" + id + ", issueDate=" + issueDate + ", points=" + points + "]";
    }
}
