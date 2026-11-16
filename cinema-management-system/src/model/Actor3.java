package model;

import java.io.Serializable;

/**
 * Lớp thực thể Diễn viên (Actor3)
 */
public class Actor3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;

    public Actor3() {
    }

    public Actor3(int id, String name) {
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
        return "Actor3 [id=" + id + ", name=" + name + "]";
    }
}
