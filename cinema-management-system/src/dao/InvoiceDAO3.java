package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import model.Invoice3;
import model.Movie3;
import model.ScreeningRoom3;
import model.Seat3;
import model.Showtime3;
import model.Ticket3;

/**
 * Lớp DAO truy cập dữ liệu Hóa đơn và Vé giao dịch (InvoiceDAO3).
 * Phục vụ Phân hệ 2: Xem chi tiết lịch sử hóa đơn và vé của một khách hàng cụ thể.
 * Hiện thực các phương thức gọi Stored Procedures `sp_getInvoicesOfCustomer` và `sp_getTicketsOfInvoice`.
 */
public class InvoiceDAO3 extends DAO3 {

    public InvoiceDAO3() {
        super();
    }

    /**
     * Lấy danh sách hóa đơn kèm chi tiết các vé xem phim của khách hàng trong khoảng thời gian [startDate, endDate].
     * Gọi Stored Procedure `sp_getInvoicesOfCustomer(cId, sDate, eDate)` và `sp_getTicketsOfInvoice(invId)`.
     *
     * @param customerId ID người dùng của khách hàng
     * @param startDate  Ngày bắt đầu khoảng thời gian tra cứu
     * @param endDate    Ngày kết thúc khoảng thời gian tra cứu
     * @return Danh sách Invoice3 chứa đầy đủ chi tiết vé
     */
    public ArrayList<Invoice3> getInvoicesOfCustomer(int customerId, Date startDate, Date endDate) {
        ArrayList<Invoice3> list = new ArrayList<>();

        if (customerId <= 0 || startDate == null || endDate == null || startDate.after(endDate)) {
            return list;
        }

        String sqlInvoices = "{call sp_getInvoicesOfCustomer(?, ?, ?)}";
        CallableStatement csInv = null;
        ResultSet rsInv = null;

        try {
            if (con == null || con.isClosed()) {
                openConnection();
            }

            // 1. Lấy danh sách hóa đơn cơ bản
            csInv = con.prepareCall(sqlInvoices);
            csInv.setInt(1, customerId);
            csInv.setDate(2, new java.sql.Date(startDate.getTime()));
            csInv.setDate(3, new java.sql.Date(endDate.getTime()));
            rsInv = csInv.executeQuery();

            while (rsInv.next()) {
                Invoice3 inv = new Invoice3();
                inv.setId(rsInv.getInt("id"));
                inv.setCreatedDate(rsInv.getTimestamp("createdDate"));
                inv.setTotalAmount(rsInv.getFloat("totalAmount"));
                inv.setPaymentMethod(rsInv.getString("paymentMethod"));
                list.add(inv);
            }

            // Đóng ResultSet và Statement danh sách hóa đơn trước khi truy vấn chi tiết vé
            if (rsInv != null) {
                rsInv.close();
                rsInv = null;
            }
            if (csInv != null) {
                csInv.close();
                csInv = null;
            }

            // 2. Với mỗi hóa đơn, lấy danh sách các vé thuộc hóa đơn đó
            String sqlTickets = "{call sp_getTicketsOfInvoice(?)}";
            for (Invoice3 inv : list) {
                CallableStatement csTicket = null;
                ResultSet rsTicket = null;
                try {
                    csTicket = con.prepareCall(sqlTickets);
                    csTicket.setInt(1, inv.getId());
                    rsTicket = csTicket.executeQuery();

                    ArrayList<Ticket3> tickets = new ArrayList<>();
                    while (rsTicket.next()) {
                        Ticket3 t = new Ticket3();
                        t.setId(rsTicket.getInt("ticketId"));
                        t.setPrice(rsTicket.getFloat("price"));
                        t.setIssueTime(rsTicket.getTimestamp("issueTime"));
                        t.setStatus(rsTicket.getString("status"));
                        t.setType(rsTicket.getString("ticketType"));

                        // Suất chiếu
                        Showtime3 st = new Showtime3();
                        st.setId(rsTicket.getInt("showtimeId"));
                        st.setShowDate(rsTicket.getDate("showDate"));
                        st.setStartTime(rsTicket.getString("startTime"));
                        st.setEndTime(rsTicket.getString("endTime"));

                        // Phim trong suất chiếu
                        Movie3 m = new Movie3();
                        m.setTitle(rsTicket.getString("movieTitle"));
                        st.setMovie(m);

                        // Phòng chiếu trong suất chiếu
                        ScreeningRoom3 room = new ScreeningRoom3();
                        room.setName(rsTicket.getString("roomName"));
                        st.setRoom(room);

                        t.setShowtime(st);

                        // Vị trí ghế
                        Seat3 seat = new Seat3();
                        seat.setRow(rsTicket.getString("seatRow"));
                        seat.setNumber(rsTicket.getInt("seatNumber"));
                        seat.setType(rsTicket.getString("seatType"));

                        t.setSeat(seat);

                        tickets.add(t);
                    }
                    inv.setTickets(tickets);
                } finally {
                    if (rsTicket != null) {
                        try { rsTicket.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                    if (csTicket != null) {
                        try { csTicket.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rsInv != null) {
                try { rsInv.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (csInv != null) {
                try { csInv.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        return list;
    }
}
