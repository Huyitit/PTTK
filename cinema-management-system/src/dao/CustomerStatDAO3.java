package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import model.CustomerStats3;

/**
 * Lớp DAO truy cập dữ liệu Thống kê khách hàng theo doanh thu (CustomerStatDAO3).
 * Phục vụ Phân hệ 2: Nhân viên quản lý xem thống kê khách hàng theo doanh thu (Module 2).
 * Hiện thực phương thức gọi Stored Procedure `sp_getCustomerRevenueStat(sDate, eDate)`.
 */
public class CustomerStatDAO3 extends DAO3 {

    public CustomerStatDAO3() {
        super();
    }

    /**
     * Thống kê danh sách khách hàng và tổng doanh thu trong khoảng thời gian [startDate, endDate].
     * Gọi Stored Procedure `sp_getCustomerRevenueStat(sDate, eDate)`.
     * Danh sách trả về được sắp xếp giảm dần theo doanh thu (totalRevenue DESC).
     *
     * @param startDate Ngày bắt đầu khoảng thời gian thống kê
     * @param endDate   Ngày kết thúc khoảng thời gian thống kê
     * @return Danh sách các đối tượng CustomerStats3
     */
    public ArrayList<CustomerStats3> getCustomerStat(Date startDate, Date endDate) {
        ArrayList<CustomerStats3> list = new ArrayList<>();

        // Kiểm tra tính hợp lệ của tham số đầu vào
        if (startDate == null || endDate == null || startDate.after(endDate)) {
            return list;
        }

        String sql = "{call sp_getCustomerRevenueStat(?, ?)}";
        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            if (con == null || con.isClosed()) {
                openConnection();
            }
            cs = con.prepareCall(sql);
            cs.setDate(1, new java.sql.Date(startDate.getTime()));
            cs.setDate(2, new java.sql.Date(endDate.getTime()));
            rs = cs.executeQuery();

            while (rs.next()) {
                CustomerStats3 stat = new CustomerStats3();
                stat.setId(rs.getInt("id"));
                stat.setCode(rs.getString("code"));
                stat.setFullName(rs.getString("fullName"));
                stat.setPhone(rs.getString("phone"));
                stat.setStartDate(startDate);
                stat.setEndDate(endDate);
                stat.setTotalTransactions(rs.getInt("totalTransactions"));
                stat.setTotalRevenue(rs.getFloat("totalRevenue"));
                list.add(stat);
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
}
