package model;

import java.io.Serializable;

/**
 * Lớp thực thể Vị trí ghế ngồi (Seat3)
 * Thuộc về phòng chiếu trong rạp chiếu phim.
 */
public class Seat3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String row;
    private int number;
    private String type;

    public Seat3() {
    }

    public Seat3(int id, String row, int number, String type) {
        this.id = id;
        this.row = row;
        this.number = number;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRow() {
        return row;
    }

    public void setRow(String row) {
        this.row = row;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Seat3 [id=" + id + ", row=" + row + ", number=" + number + ", type=" + type + "]";
    }
}
