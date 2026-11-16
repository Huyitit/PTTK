package model;

import java.io.Serializable;
import java.util.Date;

/**
 * Lớp thực thể Vé xem phim (Ticket3)
 * Gắn với một suất chiếu cụ thể và một vị trí ghế ngồi cụ thể.
 */
public class Ticket3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private float price;
    private Date issueTime;
    private String status;
    private String type;
    private Showtime3 showtime;
    private Seat3 seat;

    public Ticket3() {
    }

    public Ticket3(int id, float price, Date issueTime, String status, String type) {
        this.id = id;
        this.price = price;
        this.issueTime = issueTime;
        this.status = status;
        this.type = type;
    }

    public Ticket3(int id, float price, Date issueTime, String status, String type, Showtime3 showtime, Seat3 seat) {
        this.id = id;
        this.price = price;
        this.issueTime = issueTime;
        this.status = status;
        this.type = type;
        this.showtime = showtime;
        this.seat = seat;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Date getIssueTime() {
        return issueTime;
    }

    public void setIssueTime(Date issueTime) {
        this.issueTime = issueTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Showtime3 getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime3 showtime) {
        this.showtime = showtime;
    }

    public Seat3 getSeat() {
        return seat;
    }

    public void setSeat(Seat3 seat) {
        this.seat = seat;
    }

    @Override
    public String toString() {
        return "Ticket3 [id=" + id + ", price=" + price + ", issueTime=" + issueTime + ", status=" + status
                + ", type=" + type + ", seat=" + (seat != null ? seat.getRow() + seat.getNumber() : null) + "]";
    }
}
