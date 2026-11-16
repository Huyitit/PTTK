package test.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.DAO3;
import dao.InvoiceDAO3;
import model.Invoice3;
import model.Ticket3;

/**
 * Lớp kiểm thử đơn vị cho InvoiceDAO3 (Module 2: Xem chi tiết hóa đơn & vé của khách hàng).
 * Đạt độ phủ nhánh cấp 2 (Branch Coverage Level 2), đối chiếu dữ liệu khớp chính xác 100% với
 * Wireframe UI Customer-transaction_screen.png và kịch bản Mục 2.1.2.
 */
public class TestInvoiceDAO3 {

    private static InvoiceDAO3 invDAO;
    private static SimpleDateFormat sdf;

    @BeforeClass
    public static void setUp() {
        invDAO = new InvoiceDAO3();
        sdf = new SimpleDateFormat("yyyy-MM-dd");
    }

    @AfterClass
    public static void tearDown() {
        DAO3.closeConnection();
    }

    /**
     * getInvoicesOfCustomer_testChuan1: Khách hàng KH001 (customerId = 1) trong kỳ Tháng 1/2026.
     * Kiểm tra đúng 3 hóa đơn, tổng tiền 1,500,000 VNĐ, và kiểm tra chi tiết các vé xem phim con thuộc từng hóa đơn.
     */
    @Test
    public void getInvoicesOfCustomer_testChuan1() {
        try {
            int customerId = 1;
            Date startDate = sdf.parse("2026-01-01");
            Date endDate = sdf.parse("2026-01-31");

            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);

            Assert.assertNotNull("Danh sách hóa đơn không được null", list);
            Assert.assertEquals("KH001 phải có chính xác 3 hóa đơn trong tháng 1/2026", 3, list.size());

            float totalAmount = 0;
            int totalTickets = 0;

            for (Invoice3 inv : list) {
                Assert.assertTrue("Mã hóa đơn phải > 0", inv.getId() > 0);
                Assert.assertNotNull("Ngày tạo hóa đơn không được null", inv.getCreatedDate());
                Assert.assertNotNull("Phương thức thanh toán không được null", inv.getPaymentMethod());
                Assert.assertTrue("Tổng tiền hóa đơn phải > 0", inv.getTotalAmount() > 0);

                totalAmount += inv.getTotalAmount();

                // Kiểm tra nạp danh sách vé con từ Stored Procedure sp_getTicketsOfInvoice
                Assert.assertNotNull("Danh sách vé của hóa đơn không được null", inv.getTickets());
                Assert.assertTrue("Hóa đơn phải có ít nhất 1 vé", inv.getTickets().size() >= 1);

                for (Ticket3 t : inv.getTickets()) {
                    totalTickets++;
                    Assert.assertTrue("Mã vé phải > 0", t.getId() > 0);
                    Assert.assertTrue("Giá vé phải > 0", t.getPrice() > 0);
                    Assert.assertNotNull("Suất chiếu của vé không được null", t.getShowtime());
                    Assert.assertNotNull("Phim trong suất chiếu không được null", t.getShowtime().getMovie());
                    Assert.assertNotNull("Tên phim không được rỗng", t.getShowtime().getMovie().getTitle());
                    Assert.assertNotNull("Phòng chiếu không được null", t.getShowtime().getRoom());
                    Assert.assertNotNull("Vị trí ghế không được null", t.getSeat());
                    Assert.assertNotNull("Hàng ghế không được null", t.getSeat().getRow());
                }
            }

            // Kiểm tra tổng cộng khớp với bảng hiển thị wireframe UI: 6 vé, 1,500,000 VNĐ
            Assert.assertEquals("Tổng tiền 3 hóa đơn của KH001 phải là 1,500,000 VNĐ", 1500000.0f, totalAmount, 0.01f);
            Assert.assertEquals("Tổng số vé trong 3 hóa đơn của KH001 phải là 6 vé", 6, totalTickets);

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getInvoicesOfCustomer_testChuan2: Khách hàng KH008 (customerId = 8) có 4 hóa đơn, tổng 1,200,000 VNĐ.
     */
    @Test
    public void getInvoicesOfCustomer_testChuan2() {
        try {
            int customerId = 8;
            Date startDate = sdf.parse("2026-01-01");
            Date endDate = sdf.parse("2026-01-31");

            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);

            Assert.assertNotNull("Danh sách hóa đơn không được null", list);
            Assert.assertEquals("KH008 phải có 4 hóa đơn trong kỳ", 4, list.size());

            float totalAmount = 0;
            for (Invoice3 inv : list) {
                totalAmount += inv.getTotalAmount();
            }
            Assert.assertEquals("Tổng doanh thu của KH008 phải là 1,200,000 VNĐ", 1200000.0f, totalAmount, 0.01f);

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getInvoicesOfCustomer_testNgoaile1: Khách hàng KH099 (customerId = 99) hợp lệ nhưng không có giao dịch.
     */
    @Test
    public void getInvoicesOfCustomer_testNgoaile1() {
        try {
            int customerId = 99;
            Date startDate = sdf.parse("2026-01-01");
            Date endDate = sdf.parse("2026-01-31");

            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);

            Assert.assertNotNull("Danh sách không được null", list);
            Assert.assertEquals("Không được có hóa đơn nào", 0, list.size());

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getInvoicesOfCustomer_testNgoaile2: ID khách hàng không tồn tại trong hệ thống (customerId = 99999).
     */
    @Test
    public void getInvoicesOfCustomer_testNgoaile2() {
        try {
            int customerId = 99999;
            Date startDate = sdf.parse("2026-01-01");
            Date endDate = sdf.parse("2026-01-31");

            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);

            Assert.assertNotNull("Danh sách không được null", list);
            Assert.assertEquals("Phải trả về danh sách rỗng", 0, list.size());

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getInvoicesOfCustomer_testNgoaile3: Khoảng ngày bất hợp lệ (startDate > endDate).
     */
    @Test
    public void getInvoicesOfCustomer_testNgoaile3() {
        try {
            int customerId = 1;
            Date startDate = sdf.parse("2026-12-31");
            Date endDate = sdf.parse("2026-01-01");

            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);

            Assert.assertNotNull("Danh sách không được null", list);
            Assert.assertEquals("Phải trả về danh sách rỗng khi ngày bắt đầu sau ngày kết thúc", 0, list.size());

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getInvoicesOfCustomer_testNgoaile4: Tham số customerId <= 0 hoặc tham số ngày null.
     */
    @Test
    public void getInvoicesOfCustomer_testNgoaile4() {
        ArrayList<Invoice3> listInvalidId = invDAO.getInvoicesOfCustomer(-1, new Date(), new Date());
        Assert.assertNotNull(listInvalidId);
        Assert.assertEquals(0, listInvalidId.size());

        ArrayList<Invoice3> listNullDate = invDAO.getInvoicesOfCustomer(1, null, null);
        Assert.assertNotNull(listNullDate);
        Assert.assertEquals(0, listNullDate.size());
    }

    /**
     * Minh họa kiểm thử với Transaction Rollback theo chuẩn Mục 5.3.2 giáo trình.
     */
    @Test
    public void getInvoicesOfCustomer_testWithRollback() {
        try {
            if (DAO3.con != null && !DAO3.con.isClosed()) {
                DAO3.con.setAutoCommit(false);
            }

            Date s = sdf.parse("2026-01-01");
            Date e = sdf.parse("2026-01-31");
            ArrayList<Invoice3> list = invDAO.getInvoicesOfCustomer(1, s, e);
            Assert.assertNotNull(list);

        } catch (Exception ex) {
            ex.printStackTrace();
            Assert.fail("Exception: " + ex.getMessage());
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
