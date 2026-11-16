package model;

import java.io.Serializable;
import java.util.Date;

/**
 * Lớp thực thể Suất chiếu phim (Showtime3)
 * Gắn với một phòng chiếu và một bộ phim cụ thể.
 */
public class Showtime3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date showDate;
    private String startTime;
    private String endTime;
    private String format;
    private float basePrice;
    private ScreeningRoom3 room;
    private Movie3 movie;

    public Showtime3() {
    }

    public Showtime3(int id, Date showDate, String startTime, String endTime, String format, float basePrice) {
        this.id = id;
        this.showDate = showDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.format = format;
        this.basePrice = basePrice;
    }

    public Showtime3(int id, Date showDate, String startTime, String endTime, String format, float basePrice,
                     ScreeningRoom3 room, Movie3 movie) {
        this.id = id;
        this.showDate = showDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.format = format;
        this.basePrice = basePrice;
        this.room = room;
        this.movie = movie;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getShowDate() {
        return showDate;
    }

    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public float getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(float basePrice) {
        this.basePrice = basePrice;
    }

    public ScreeningRoom3 getRoom() {
        return room;
    }

    public void setRoom(ScreeningRoom3 room) {
        this.room = room;
    }

    public Movie3 getMovie() {
        return movie;
    }

    public void setMovie(Movie3 movie) {
        this.movie = movie;
    }

    @Override
    public String toString() {
        return "Showtime3 [id=" + id + ", showDate=" + showDate + ", startTime=" + startTime + ", endTime=" + endTime
                + ", format=" + format + ", basePrice=" + basePrice + ", room=" + (room != null ? room.getName() : null) + "]";
    }
}
