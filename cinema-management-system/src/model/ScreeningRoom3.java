package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Lớp thực thể Phòng chiếu (ScreeningRoom3)
 * Sở hữu danh sách các ghế ngồi và thuộc về một rạp chiếu phim cụ thể.
 */
public class ScreeningRoom3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private int capacity;
    private String type;
    private ArrayList<Seat3> seats;

    public ScreeningRoom3() {
        this.seats = new ArrayList<>();
    }

    public ScreeningRoom3(int id, String name, int capacity, String type) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.type = type;
        this.seats = new ArrayList<>();
    }

    public ScreeningRoom3(int id, String name, int capacity, String type, ArrayList<Seat3> seats) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.type = type;
        this.seats = (seats != null) ? seats : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList<Seat3> getSeats() {
        return seats;
    }

    public void setSeats(ArrayList<Seat3> seats) {
        this.seats = seats;
    }

    public Seat3[] getSeatsArray() {
        if (seats == null) return new Seat3[0];
        return seats.toArray(new Seat3[0]);
    }

    public void setSeatsArray(Seat3[] seatsArray) {
        this.seats = new ArrayList<>();
        if (seatsArray != null) {
            for (Seat3 s : seatsArray) {
                this.seats.add(s);
            }
        }
    }

    @Override
    public String toString() {
        return "ScreeningRoom3 [id=" + id + ", name=" + name + ", capacity=" + capacity + ", type=" + type + "]";
    }
}
