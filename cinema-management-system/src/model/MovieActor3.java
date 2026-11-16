package model;

import java.io.Serializable;

/**
 * Lớp thực thể Liên kết Phim - Diễn viên (MovieActor3)
 * Lưu trữ tên nhân vật trong phim và tham chiếu tới Actor3.
 */
public class MovieActor3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String characterName;
    private Actor3 actor;

    public MovieActor3() {
    }

    public MovieActor3(int id, String characterName, Actor3 actor) {
        this.id = id;
        this.characterName = characterName;
        this.actor = actor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String characterName) {
        this.characterName = characterName;
    }

    public Actor3 getActor() {
        return actor;
    }

    public void setActor(Actor3 actor) {
        this.actor = actor;
    }

    @Override
    public String toString() {
        return "MovieActor3 [id=" + id + ", characterName=" + characterName + ", actor=" + actor + "]";
    }
}
