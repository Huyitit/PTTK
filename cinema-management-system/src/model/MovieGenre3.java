package model;

import java.io.Serializable;

/**
 * Lớp thực thể Liên kết Phim - Thể loại (MovieGenre3)
 * Lưu trữ tỷ lệ / trọng số thể loại trong phim và tham chiếu tới Genre3.
 */
public class MovieGenre3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private float rate;
    private Genre3 genre;

    public MovieGenre3() {
    }

    public MovieGenre3(int id, float rate, Genre3 genre) {
        this.id = id;
        this.rate = rate;
        this.genre = genre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public Genre3 getGenre() {
        return genre;
    }

    public void setGenre(Genre3 genre) {
        this.genre = genre;
    }

    @Override
    public String toString() {
        return "MovieGenre3 [id=" + id + ", rate=" + rate + ", genre=" + genre + "]";
    }
}
