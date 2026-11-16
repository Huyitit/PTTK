package test.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.CustomerStatDAO3;
import dao.DAO3;
import model.CustomerStats3;

/**
 * Lớp kiểm thử đơn vị cho CustomerStatDAO3 (Module 2: Thống kê khách hàng theo doanh thu).
 * Đạt độ phủ nhánh cấp 2 (Branch Coverage Level 2), đối chiếu dữ liệu chính xác 100% với kịch bản Mục 2.1.2
 * và Wireframe UI reportScreen-after-select-report.png.
 */
public class TestCustomerStatDAO3 {

    private static CustomerStatDAO3 statDAO;
    private static SimpleDateFormat sdf;

    @BeforeClass
    public static void setUp() {
        statDAO = new CustomerStatDAO3();
        sdf = new SimpleDateFormat("yyyy-MM-dd");
    }

    @AfterClass
    public static void tearDown() {
        DAO3.closeConnection();
    }

    /**
     * getCustomerStat_testChuan1: Kỳ báo cáo chuẩn (Tháng 1/2026) có nhiều khách hàng phát sinh doanh thu.
     * Kiểm tra đúng số lượng, đúng dữ liệu xếp hạng top đầu và kiểm tra thứ tự sắp xếp giảm dần theo doanh thu.
     */
    @Test
    public void getCustomerStat_testChuan1() {
        try {
            Date startDate = sdf.parse("2026-01-01");
            Date endDate = sdf.parse("2026-01-31");

            ArrayList<CustomerStats3> list = statDAO.getCustomerStat(startDate, endDate);

            Assert.assertNotNull("Danh sách thống kê không được null", list);
            Assert.assertTrue("Phải có ít nhất 4 khách hàng có doanh thu", list.size() >= 4);

            // Kiểm tra khách hàng đứng đầu: KH001 (John Doe) - 3 giao dịch, tổng 1,500,000 VNĐ
            CustomerStats3 top1 = list.get(0);
            Assert.assertEquals("KH001", top1.getCode());
            Assert.assertEquals("John Doe", top1.getFullName());
            Assert.assertEquals("0912345678", top1.getPhone());
            Assert.assertEquals(3, top1.getTotalTransactions());
            Assert.assertEquals(1500000.0f, top1.getTotalRevenue(), 0.01f);

            // Kiểm tra khách hàng thứ hai: KH008 (Jane Smith) - 4 giao dịch, tổng 1,200,000 VNĐ
            CustomerStats3 top2 = list.get(1);
            Assert.assertEquals("KH008", top2.getCode());
            Assert.assertEquals("Jane Smith", top2.getFullName());
            Assert.assertEquals(1200000.0f, top2.getTotalRevenue(), 0.01f);

            // Kiểm tra tính chất sắp xếp giảm dần theo tổng doanh thu (totalRevenue DESC)
            for (int i = 0; i < list.size() - 1; i++) {
                Assert.assertTrue("Doanh thu phải sắp xếp giảm dần từ cao xuống thấp",
                        list.get(i).getTotalRevenue() >= list.get(i + 1).getTotalRevenue());
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getCustomerStat_testChuan2: Khoảng ngày hẹp đúng 1 ngày (2026-01-05) chỉ có duy nhất 1 hóa đơn phát sinh.
     */
    @Test
    public void getCustomerStat_testChuan2() {
        try {
            Date startDate = sdf.parse("2026-01-05");
            Date endDate = sdf.parse("2026-01-05");

            ArrayList<CustomerStats3> list = statDAO.getCustomerStat(startDate, endDate);

            Assert.assertNotNull("Danh sách thống kê không được null", list);
            Assert.assertEquals("Chỉ có duy nhất 1 khách hàng giao dịch trong ngày 05/01/2026", 1, list.size());
            Assert.assertEquals("KH001", list.get(0).getCode());
            Assert.assertEquals(500000.0f, list.get(0).getTotalRevenue(), 0.01f);

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getCustomerStat_testNgoaile1: Khoảng ngày trong quá khứ không có giao dịch nào phát sinh.
     */
    @Test
    public void getCustomerStat_testNgoaile1() {
        try {
            Date startDate = sdf.parse("2020-01-01");
            Date endDate = sdf.parse("2020-01-31");

            ArrayList<CustomerStats3> list = statDAO.getCustomerStat(startDate, endDate);

            Assert.assertNotNull("Danh sách không được null", list);
            Assert.assertEquals("Không được có bản ghi nào", 0, list.size());

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getCustomerStat_testNgoaile2: Ngày bắt đầu lớn hơn ngày kết thúc (startDate > endDate).
     */
    @Test
    public void getCustomerStat_testNgoaile2() {
        try {
            Date startDate = sdf.parse("2026-12-31");
            Date endDate = sdf.parse("2026-01-01");

            ArrayList<CustomerStats3> list = statDAO.getCustomerStat(startDate, endDate);

            Assert.assertNotNull("Danh sách không được null", list);
            Assert.assertEquals("Phải trả về danh sách rỗng khi khoảng ngày không hợp lệ", 0, list.size());

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Xảy ra ngoại lệ: " + e.getMessage());
        }
    }

    /**
     * getCustomerStat_testNgoaile3: Tham số ngày truyền vào là null.
     */
    @Test
    public void getCustomerStat_testNgoaile3() {
        ArrayList<CustomerStats3> list = statDAO.getCustomerStat(null, null);

        Assert.assertNotNull("Danh sách không được null", list);
        Assert.assertEquals("Phải xử lý an toàn trả về danh sách rỗng", 0, list.size());
    }

    /**
     * Minh họa kiểm thử với Transaction Rollback theo chuẩn giáo trình.
     */
    @Test
    public void getCustomerStat_testWithRollback() {
        try {
            if (DAO3.con != null && !DAO3.con.isClosed()) {
                DAO3.con.setAutoCommit(false);
            }

            Date s = sdf.parse("2026-01-01");
            Date e = sdf.parse("2026-01-31");
            ArrayList<CustomerStats3> list = statDAO.getCustomerStat(s, e);
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
