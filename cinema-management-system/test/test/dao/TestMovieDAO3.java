package test.dao;

import java.util.ArrayList;

import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.DAO3;
import dao.MovieDAO3;
import model.Movie3;

/**
 * Lớp kiểm thử đơn vị cho MovieDAO3 (Module 1: Tìm kiếm thông tin phim).
 * Đạt độ phủ nhánh cấp 2 (Branch Coverage Level 2), bao phủ toàn bộ các trường hợp chuẩn và ngoại lệ.
 * Tuân thủ quy chuẩn đặt tên theo giáo trình: <tenPhuongThuc>_testChuan<k>() và <tenPhuongThuc>_testNgoaile<k>().
 */
public class TestMovieDAO3 {

    private static MovieDAO3 movieDAO;

    @BeforeClass
    public static void setUp() {
        movieDAO = new MovieDAO3();
    }

    @AfterClass
    public static void tearDown() {
        DAO3.closeConnection();
    }

    // ====================================================================
    // TEST CASES CHO PHƯƠNG THỨC getMovies(String name)
    // ====================================================================

    /**
     * getMovies_testChuan1: Từ khóa khớp chính xác 1 bộ phim duy nhất trong CSDL.
     */
    @Test
    public void getMovies_testChuan1() {
        String keyword = "Avatar: The Way of Water";
        ArrayList<Movie3> list = movieDAO.getMovies(keyword);

        Assert.assertNotNull("Danh sách kết quả không được null", list);
        Assert.assertEquals("Phải tìm thấy đúng 1 bộ phim", 1, list.size());
        Assert.assertEquals("Avatar: The Way of Water", list.get(0).getTitle());
        Assert.assertEquals("Thời lượng phim phải là 192 phút", 192, list.get(0).getDuration());
    }

    /**
     * getMovies_testChuan2: Từ khóa khớp nhiều bộ phim trong CSDL (kiểm tra vòng lặp while).
     */
    @Test
    public void getMovies_testChuan2() {
        String keyword = "Avatar";
        ArrayList<Movie3> list = movieDAO.getMovies(keyword);

        Assert.assertNotNull("Danh sách kết quả không được null", list);
        Assert.assertTrue("Phải tìm thấy ít nhất 2 bộ phim chứa từ khóa Avatar", list.size() >= 2);
        for (Movie3 m : list) {
            Assert.assertTrue("Tên phim phải chứa từ khóa tìm kiếm", m.getTitle().toLowerCase().contains("avatar"));
        }
    }

    /**
     * getMovies_testChuan3: Từ khóa rỗng - hệ thống trả về toàn bộ danh sách phim hiện có.
     */
    @Test
    public void getMovies_testChuan3() {
        String keyword = "";
        ArrayList<Movie3> list = movieDAO.getMovies(keyword);

        Assert.assertNotNull("Danh sách kết quả không được null", list);
        Assert.assertTrue("Phải trả về toàn bộ phim trong CSDL (>= 25 phim)", list.size() >= 25);
    }

    /**
     * getMovies_testNgoaile1: Từ khóa không tồn tại trong CSDL.
     */
    @Test
    public void getMovies_testNgoaile1() {
        String keyword = "PhimKhongCoThuc999XYZ";
        ArrayList<Movie3> list = movieDAO.getMovies(keyword);

        Assert.assertNotNull("Danh sách kết quả không được null", list);
        Assert.assertEquals("Không được trả về bản ghi nào", 0, list.size());
    }

    /**
     * getMovies_testNgoaile2: Từ khóa truyền vào là null (kiểm tra khả năng bắt lỗi an toàn).
     */
    @Test
    public void getMovies_testNgoaile2() {
        String keyword = null;
        ArrayList<Movie3> list = movieDAO.getMovies(keyword);

        Assert.assertNotNull("Hàm phải xử lý an toàn, không được quăng NullPointerException", list);
    }

    // ====================================================================
    // TEST CASES CHO PHƯƠNG THỨC getMovieDetail(Movie3 movie)
    // ====================================================================

    /**
     * getMovieDetail_testChuan1: Phim hợp lệ tồn tại đầy đủ thể loại và diễn viên liên kết.
     */
    @Test
    public void getMovieDetail_testChuan1() {
        Movie3 m = new Movie3();
        m.setId(1); // Avatar 2

        Movie3 detail = movieDAO.getMovieDetail(m);

        Assert.assertNotNull("Thông tin chi tiết phim không được null", detail);
        Assert.assertEquals("ID phim phải khớp", 1, detail.getId());
        Assert.assertEquals("Avatar: The Way of Water", detail.getTitle());
        Assert.assertNotNull("Đạo diễn không được null", detail.getDirector());
        Assert.assertNotNull("Danh sách thể loại không được null", detail.getGenres());
        Assert.assertTrue("Phim phải có ít nhất 1 thể loại", detail.getGenres().size() >= 1);
        Assert.assertNotNull("Danh sách diễn viên không được null", detail.getActors());
        Assert.assertTrue("Phim phải có ít nhất 1 diễn viên", detail.getActors().size() >= 1);
    }

    /**
     * getMovieDetail_testChuan2: Phim hợp lệ khác trong CSDL (Avatar 1).
     */
    @Test
    public void getMovieDetail_testChuan2() {
        Movie3 m = new Movie3();
        m.setId(2); // Avatar 1

        Movie3 detail = movieDAO.getMovieDetail(m);

        Assert.assertNotNull("Thông tin chi tiết phim không được null", detail);
        Assert.assertEquals("Avatar: The First Journey", detail.getTitle());
        Assert.assertEquals("Thời lượng phải là 162 phút", 162, detail.getDuration());
        Assert.assertNotNull("Ngày phát hành không được null", detail.getReleaseDate());
    }

    /**
     * getMovieDetail_testNgoaile1: ID phim không tồn tại trong CSDL.
     */
    @Test
    public void getMovieDetail_testNgoaile1() {
        Movie3 m = new Movie3();
        m.setId(99999);

        Movie3 detail = movieDAO.getMovieDetail(m);

        Assert.assertNull("Phải trả về null khi không tìm thấy phim", detail);
    }

    /**
     * getMovieDetail_testNgoaile2: Đối tượng phim truyền vào là null hoặc có ID không hợp lệ.
     */
    @Test
    public void getMovieDetail_testNgoaile2() {
        Movie3 detailNull = movieDAO.getMovieDetail(null);
        Assert.assertNull("Phải trả về null khi tham số truyền vào là null", detailNull);

        Movie3 mInvalid = new Movie3();
        mInvalid.setId(-1);
        Movie3 detailInvalid = movieDAO.getMovieDetail(mInvalid);
        Assert.assertNull("Phải trả về null khi ID <= 0", detailInvalid);
    }

    /**
     * Minh họa kiểm thử với Transaction Rollback theo chuẩn Mục 5.3.2 giáo trình.
     */
    @Test
    public void getMovies_testWithRollback() {
        try {
            if (DAO3.con != null && !DAO3.con.isClosed()) {
                DAO3.con.setAutoCommit(false);
            }

            ArrayList<Movie3> list = movieDAO.getMovies("Avatar");
            Assert.assertNotNull(list);

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Exception xảy ra trong quá trình test: " + e.getMessage());
        } finally {
            try {
                if (DAO3.con != null && !DAO3.con.isClosed()) {
                    DAO3.con.rollback();
                    DAO3.con.setAutoCommit(true);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
