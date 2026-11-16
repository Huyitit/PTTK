package model;

import java.util.Date;

/**
 * Lớp thực thể Thống kê khách hàng theo doanh thu (CustomerStats3)
 * Kế thừa từ Customer3, bổ sung các thuộc tính thống kê: khoảng thời gian, tổng số giao dịch, tổng doanh thu.
 */
public class CustomerStats3 extends Customer3 {
    private static final long serialVersionUID = 1L;

    private Date startDate;
    private Date endDate;
    private int totalTransactions;
    private float totalRevenue;

    public CustomerStats3() {
        super();
    }

    public CustomerStats3(int id, String username, String password, String fullName, String email, String phone, String code,
                          Date startDate, Date endDate, int totalTransactions, float totalRevenue) {
        super(id, username, password, fullName, email, phone, code);
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalTransactions = totalTransactions;
        this.totalRevenue = totalRevenue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getTotalTransactions() {
        return totalTransactions;
    }

    public void setTotalTransactions(int totalTransactions) {
        this.totalTransactions = totalTransactions;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "CustomerStats3 [" + super.toString() + ", startDate=" + startDate + ", endDate=" + endDate
                + ", totalTransactions=" + totalTransactions + ", totalRevenue=" + totalRevenue + "]";
    }
}
