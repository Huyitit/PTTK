package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Thống kê doanh thu (RevenueStats3)
 * Tổng hợp doanh thu toàn rạp trong khoảng thời gian [startDate, endDate] từ danh sách hóa đơn.
 */
public class RevenueStats3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date startDate;
    private Date endDate;
    private int totalTickets;
    private float totalRevenue;
    private ArrayList<Invoice3> invoices;

    public RevenueStats3() {
        this.invoices = new ArrayList<>();
    }

    public RevenueStats3(int id, Date startDate, Date endDate, int totalTickets, float totalRevenue) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalTickets = totalTickets;
        this.totalRevenue = totalRevenue;
        this.invoices = new ArrayList<>();
    }

    public RevenueStats3(int id, Date startDate, Date endDate, int totalTickets, float totalRevenue, ArrayList<Invoice3> invoices) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalTickets = totalTickets;
        this.totalRevenue = totalRevenue;
        this.invoices = (invoices != null) ? invoices : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getTotalTickets() {
        return totalTickets;
    }

    public void setTotalTickets(int totalTickets) {
        this.totalTickets = totalTickets;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public ArrayList<Invoice3> getInvoices() {
        return invoices;
    }

    public void setInvoices(ArrayList<Invoice3> invoices) {
        this.invoices = invoices;
    }

    public Invoice3[] getInvoicesArray() {
        if (invoices == null) return new Invoice3[0];
        return invoices.toArray(new Invoice3[0]);
    }

    public void setInvoicesArray(Invoice3[] invoicesArray) {
        this.invoices = new ArrayList<>();
        if (invoicesArray != null) {
            for (Invoice3 inv : invoicesArray) {
                this.invoices.add(inv);
            }
        }
    }

    @Override
    public String toString() {
        return "RevenueStats3 [id=" + id + ", startDate=" + startDate + ", endDate=" + endDate
                + ", totalTickets=" + totalTickets + ", totalRevenue=" + totalRevenue + "]";
    }
}
