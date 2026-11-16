package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Actor3;
import model.Genre3;
import model.Movie3;
import model.MovieActor3;
import model.MovieGenre3;

/**
 * Lớp DAO truy cập dữ liệu Phim (MovieDAO3).
 * Phục vụ Phân hệ 1: Khách hàng tìm kiếm thông tin phim (Module 1).
 * Hiện thực các phương thức gọi Stored Procedure tương ứng trong CSDL cinema_db3.
 */
public class MovieDAO3 extends DAO3 {

    public MovieDAO3() {
        super();
    }

    /**
     * Tìm kiếm danh sách phim theo từ khóa tên phim.
     * Gọi Stored Procedure `sp_searchMovies(kw)`.
     *
     * @param name Từ khóa tên phim tìm kiếm (nếu null hoặc rỗng sẽ trả về toàn bộ phim)
     * @return Danh sách Movie3 phù hợp
     */
    public ArrayList<Movie3> getMovies(String name) {
        ArrayList<Movie3> list = new ArrayList<>();
        String sql = "{call sp_searchMovies(?)}";
        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            if (con == null || con.isClosed()) {
                openConnection();
            }
            cs = con.prepareCall(sql);
            cs.setString(1, (name != null) ? name.trim() : "");
            rs = cs.executeQuery();

            while (rs.next()) {
                Movie3 m = new Movie3();
                m.setId(rs.getInt("id"));
                m.setTitle(rs.getString("title"));
                m.setDirector(rs.getString("director"));
                m.setDuration(rs.getInt("duration"));
                m.setReleaseDate(rs.getDate("releaseDate"));
                m.setAgeRestriction(rs.getInt("ageRestriction"));
                m.setDescription(rs.getString("description"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (cs != null) {
                try {
                    cs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    /**
     * Lấy thông tin chi tiết đầy đủ của một bộ phim (thông tin cơ bản, danh sách thể loại, danh sách diễn viên).
     * Gọi các Stored Procedures: `sp_getMovieDetail(mId)`, `sp_getMovieGenres(mId)`, `sp_getMovieActors(mId)`.
     *
     * @param movie Đối tượng Movie3 chứa id phim cần xem
     * @return Đối tượng Movie3 hoàn chỉnh thông tin hoặc null nếu không tồn tại
     */
    public Movie3 getMovieDetail(Movie3 movie) {
        if (movie == null || movie.getId() <= 0) {
            return null;
        }

        CallableStatement csDetail = null;
        CallableStatement csGenres = null;
        CallableStatement csActors = null;
        ResultSet rsDetail = null;
        ResultSet rsGenres = null;
        ResultSet rsActors = null;

        try {
            if (con == null || con.isClosed()) {
                openConnection();
            }

            // 1. Lấy thông tin cơ bản bộ phim
            csDetail = con.prepareCall("{call sp_getMovieDetail(?)}");
            csDetail.setInt(1, movie.getId());
            rsDetail = csDetail.executeQuery();

            if (rsDetail.next()) {
                movie.setTitle(rsDetail.getString("title"));
                movie.setDirector(rsDetail.getString("director"));
                movie.setDuration(rsDetail.getInt("duration"));
                movie.setReleaseDate(rsDetail.getDate("releaseDate"));
                movie.setAgeRestriction(rsDetail.getInt("ageRestriction"));
                movie.setDescription(rsDetail.getString("description"));
            } else {
                return null; // Không tìm thấy bản ghi phim trong CSDL
            }

            // 2. Lấy danh sách thể loại liên kết
            csGenres = con.prepareCall("{call sp_getMovieGenres(?)}");
            csGenres.setInt(1, movie.getId());
            rsGenres = csGenres.executeQuery();
            ArrayList<MovieGenre3> genres = new ArrayList<>();
            while (rsGenres.next()) {
                Genre3 g = new Genre3(rsGenres.getInt("genreId"), rsGenres.getString("genreName"));
                MovieGenre3 mg = new MovieGenre3(rsGenres.getInt("movieGenreId"), rsGenres.getFloat("rate"), g);
                genres.add(mg);
            }
            movie.setGenres(genres);

            // 3. Lấy danh sách diễn viên tham gia
            csActors = con.prepareCall("{call sp_getMovieActors(?)}");
            csActors.setInt(1, movie.getId());
            rsActors = csActors.executeQuery();
            ArrayList<MovieActor3> actors = new ArrayList<>();
            while (rsActors.next()) {
                Actor3 a = new Actor3(rsActors.getInt("actorId"), rsActors.getString("actorName"));
                MovieActor3 ma = new MovieActor3(rsActors.getInt("movieActorId"), rsActors.getString("characterName"), a);
                actors.add(ma);
            }
            movie.setActors(actors);

            return movie;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rsDetail != null) {
                try { rsDetail.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (csDetail != null) {
                try { csDetail.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (rsGenres != null) {
                try { rsGenres.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (csGenres != null) {
                try { csGenres.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (rsActors != null) {
                try { rsActors.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (csActors != null) {
                try { csActors.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return movie;
    }
}
