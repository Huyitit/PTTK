package test.dao;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

/**
 * Test Suite gom toàn bộ các lớp kiểm thử DAO của Hệ thống quản lý rạp chiếu phim (cinema_db3).
 * Phục vụ việc chạy toàn bộ các ca kiểm thử đạt độ phủ nhánh cấp 2 (Branch Coverage Level 2)
 * của cả 2 module theo đúng chuẩn Chương 5.3 giáo trình.
 */
@RunWith(Suite.class)
@SuiteClasses({
    TestMovieDAO3.class,
    TestCustomerStatDAO3.class,
    TestInvoiceDAO3.class
})
public class AllDAOTests3 {
}
