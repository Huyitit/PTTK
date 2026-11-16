package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Phim (Movie3)
 * Chứa thông tin bộ phim, danh sách thể loại liên kết, diễn viên tham gia và các suất chiếu.
 */
public class Movie3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String director;
    private int duration;
    private Date releaseDate;
    private int ageRestriction;
    private String description;
    private ArrayList<MovieGenre3> genres;
    private ArrayList<MovieActor3> actors;
    private ArrayList<Showtime3> showtimes;

    public Movie3() {
        this.genres = new ArrayList<>();
        this.actors = new ArrayList<>();
        this.showtimes = new ArrayList<>();
    }

    public Movie3(int id, String title, String director, int duration, Date releaseDate, int ageRestriction, String description) {
        this.id = id;
        this.title = title;
        this.director = director;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.ageRestriction = ageRestriction;
        this.description = description;
        this.genres = new ArrayList<>();
        this.actors = new ArrayList<>();
        this.showtimes = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public int getAgeRestriction() {
        return ageRestriction;
    }

    public void setAgeRestriction(int ageRestriction) {
        this.ageRestriction = ageRestriction;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<MovieGenre3> getGenres() {
        return genres;
    }

    public void setGenres(ArrayList<MovieGenre3> genres) {
        this.genres = genres;
    }

    public MovieGenre3[] getGenresArray() {
        if (genres == null) return new MovieGenre3[0];
        return genres.toArray(new MovieGenre3[0]);
    }

    public void setGenresArray(MovieGenre3[] genresArray) {
        this.genres = new ArrayList<>();
        if (genresArray != null) {
            for (MovieGenre3 g : genresArray) {
                this.genres.add(g);
            }
        }
    }

    public ArrayList<MovieActor3> getActors() {
        return actors;
    }

    public void setActors(ArrayList<MovieActor3> actors) {
        this.actors = actors;
    }

    public MovieActor3[] getActorsArray() {
        if (actors == null) return new MovieActor3[0];
        return actors.toArray(new MovieActor3[0]);
    }

    public void setActorsArray(MovieActor3[] actorsArray) {
        this.actors = new ArrayList<>();
        if (actorsArray != null) {
            for (MovieActor3 a : actorsArray) {
                this.actors.add(a);
            }
        }
    }

    public ArrayList<Showtime3> getShowtimes() {
        return showtimes;
    }

    public void setShowtimes(ArrayList<Showtime3> showtimes) {
        this.showtimes = showtimes;
    }

    public Showtime3[] getShowtimesArray() {
        if (showtimes == null) return new Showtime3[0];
        return showtimes.toArray(new Showtime3[0]);
    }

    public void setShowtimesArray(Showtime3[] showtimesArray) {
        this.showtimes = new ArrayList<>();
        if (showtimesArray != null) {
            for (Showtime3 s : showtimesArray) {
                this.showtimes.add(s);
            }
        }
    }

    @Override
    public String toString() {
        return "Movie3 [id=" + id + ", title=" + title + ", director=" + director + ", duration=" + duration
                + ", releaseDate=" + releaseDate + ", ageRestriction=" + ageRestriction + "]";
    }
}
