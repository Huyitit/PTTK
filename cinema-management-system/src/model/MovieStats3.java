package model;

import java.util.Date;

/**
 * Lớp thực thể Thống kê phim (MovieStats3)
 * Kế thừa từ Movie3, bổ sung các thuộc tính thống kê: khoảng thời gian, tổng số vé, tổng doanh thu.
 */
public class MovieStats3 extends Movie3 {
    private static final long serialVersionUID = 1L;

    private Date startDate;
    private Date endDate;
    private int totalTickets;
    private float totalRevenue;

    public MovieStats3() {
        super();
    }

    public MovieStats3(int id, String title, String director, int duration, Date releaseDate, int ageRestriction, String description,
                       Date startDate, Date endDate, int totalTickets, float totalRevenue) {
        super(id, title, director, duration, releaseDate, ageRestriction, description);
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalTickets = totalTickets;
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

    @Override
    public String toString() {
        return "MovieStats3 [" + super.toString() + ", startDate=" + startDate + ", endDate=" + endDate
                + ", totalTickets=" + totalTickets + ", totalRevenue=" + totalRevenue + "]";
    }
}
