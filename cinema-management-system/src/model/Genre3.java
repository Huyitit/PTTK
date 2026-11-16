package model;

import java.io.Serializable;

/**
 * Lớp thực thể Thể loại phim (Genre3)
 */
public class Genre3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;

    public Genre3() {
    }

    public Genre3(int id, String name) {
        this.id = id;
        this.name = name;
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

    @Override
    public String toString() {
        return "Genre3 [id=" + id + ", name=" + name + "]";
    }
}
