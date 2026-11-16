package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Lớp thực thể Cụm rạp chiếu phim (Cinema3)
 * Sở hữu danh sách các phòng chiếu.
 */
public class Cinema3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String address;
    private String phone;
    private ArrayList<ScreeningRoom3> rooms;

    public Cinema3() {
        this.rooms = new ArrayList<>();
    }

    public Cinema3(int id, String name, String address, String phone) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.rooms = new ArrayList<>();
    }

    public Cinema3(int id, String name, String address, String phone, ArrayList<ScreeningRoom3> rooms) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.rooms = (rooms != null) ? rooms : new ArrayList<>();
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public ArrayList<ScreeningRoom3> getRooms() {
        return rooms;
    }

    public void setRooms(ArrayList<ScreeningRoom3> rooms) {
        this.rooms = rooms;
    }

    public ScreeningRoom3[] getRoomsArray() {
        if (rooms == null) return new ScreeningRoom3[0];
        return rooms.toArray(new ScreeningRoom3[0]);
    }

    public void setRoomsArray(ScreeningRoom3[] roomsArray) {
        this.rooms = new ArrayList<>();
        if (roomsArray != null) {
            for (ScreeningRoom3 r : roomsArray) {
                this.rooms.add(r);
            }
        }
    }

    @Override
    public String toString() {
        return "Cinema3 [id=" + id + ", name=" + name + ", address=" + address + ", phone=" + phone + "]";
    }
}
