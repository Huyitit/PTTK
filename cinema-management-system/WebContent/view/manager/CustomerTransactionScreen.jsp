<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.InvoiceDAO3" %>
<%@ page import="model.Invoice3" %>
<%@ page import="model.Ticket3" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String customerIdStr = request.getParameter("customerId");
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");
    String customerCode = request.getParameter("customerCode");
    String customerName = request.getParameter("customerName");

    if (customerName != null) {
        customerName = java.net.URLDecoder.decode(customerName, "UTF-8");
    }

    ArrayList<Invoice3> invoiceList = null;
    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfDateTime = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    DecimalFormat df = new DecimalFormat("#,###");

    Date startDate = null;
    Date endDate = null;

    if (customerIdStr != null && startDateStr != null && endDateStr != null) {
        try {
            int customerId = Integer.parseInt(customerIdStr.trim());
            try {
                startDate = sdfInput.parse(startDateStr.trim());
            } catch (Exception e) {
                startDate = sdfDisplay.parse(startDateStr.trim());
            }
            try {
                endDate = sdfInput.parse(endDateStr.trim());
            } catch (Exception e) {
                endDate = sdfDisplay.parse(endDateStr.trim());
            }

            InvoiceDAO3 invDAO = new InvoiceDAO3();
            invoiceList = invDAO.getInvoicesOfCustomer(customerId, startDate, endDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    int grandTotalTickets = 0;
    float grandTotalPrice = 0;
    if (invoiceList != null) {
        for (Invoice3 inv : invoiceList) {
            grandTotalTickets += (inv.getTickets() != null) ? inv.getTickets().size() : 0;
            grandTotalPrice += inv.getTotalAmount();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transactions of Customer - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <style>
        .cust-header {
            background-color: #ffffff;
            border: 1px solid #000;
            padding: 10px 15px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .ticket-detail-box {
            background-color: #f9f9f9;
            border: 1px dashed #666;
            margin: 6px 0;
            padding: 6px 12px;
            font-size: 13px;
        }
    </style>
</head>
<body>

    <div class="screen-container">
        <div style="font-size: 13px; color: #555; margin-bottom: 10px;">(3) Customer Transactions</div>

        <div class="screen-title">Transactions of Customer</div>

        <% if (customerCode != null || customerName != null) { %>
            <div class="cust-header">
                <strong>Customer:</strong> <%= (customerName != null) ? customerName : "" %> 
                (<%= (customerCode != null) ? customerCode : "" %>) | 
                <strong>Period:</strong> <%= (startDate != null) ? sdfDisplay.format(startDate) : "" %> - <%= (endDate != null) ? sdfDisplay.format(endDate) : "" %>
            </div>
        <% } %>

        <% if (invoiceList != null && !invoiceList.isEmpty()) { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th class="th-orange" style="width: 10%;">No.</th>
                        <th class="th-orange" style="width: 25%;">Invoice code</th>
                        <th class="th-orange" style="width: 25%;">Time</th>
                        <th class="th-orange" style="width: 20%;">Total tickets</th>
                        <th class="th-orange" style="width: 20%;">Total price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int stt = 1;
                        for (Invoice3 inv : invoiceList) {
                            String timeStr = (inv.getCreatedDate() != null) ? sdfDateTime.format(inv.getCreatedDate()) : "";
                            int ticketCount = (inv.getTickets() != null) ? inv.getTickets().size() : 0;
                            String codeStr = "HD" + String.format("%05d", inv.getId());
                    %>
                    <tr>
                        <td class="text-center"><%= stt++ %></td>
                        <td class="text-center font-bold"><strong><%= codeStr %></strong></td>
                        <td class="text-center"><%= timeStr %></td>
                        <td class="text-center"><%= ticketCount %></td>
                        <td class="text-right"><%= df.format(inv.getTotalAmount()) %></td>
                    </tr>
                    <!-- Detail of tickets in invoice -->
                    <% if (inv.getTickets() != null && !inv.getTickets().isEmpty()) { %>
                    <tr>
                        <td colspan="5" style="background-color: #f7f9fa; padding: 6px 14px;">
                            <div style="font-size: 12px; color: #444; margin-bottom: 4px; font-weight: bold;">
                                &bull; Ticket Details [Payment Method: <%= (inv.getPaymentMethod() != null) ? inv.getPaymentMethod() : "Cash" %>]:
                            </div>
                            <% for (Ticket3 t : inv.getTickets()) { %>
                                <div class="ticket-detail-box">
                                    <strong>Ticket #<%= t.getId() %>:</strong> 
                                    Movie: <em><%= (t.getShowtime() != null && t.getShowtime().getMovie() != null) ? t.getShowtime().getMovie().getTitle() : "N/A" %></em> | 
                                    Room: <%= (t.getShowtime() != null && t.getShowtime().getRoom() != null) ? t.getShowtime().getRoom().getName() : "N/A" %> | 
                                    Seat: <strong><%= (t.getSeat() != null) ? (t.getSeat().getRow() + t.getSeat().getNumber()) : "N/A" %></strong> (<%= (t.getSeat() != null) ? t.getSeat().getType() : "" %>) | 
                                    Price: <%= df.format(t.getPrice()) %> VNĐ
                                </div>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <% } %>

                    <!-- Total row matching wireframe Customer-transaction_screen.png -->
                    <tr class="tr-total">
                        <td class="text-center">Total</td>
                        <td class="text-center"><%= invoiceList.size() %> transactions</td>
                        <td class="text-center">-</td>
                        <td class="text-center"><%= grandTotalTickets %></td>
                        <td class="text-right"><%= df.format(grandTotalPrice) %> VNĐ</td>
                    </tr>
                </tbody>
            </table>
        <% } else { %>
            <div style="background-color: #fff; padding: 20px; border: 1px solid #000; text-align: center; margin-bottom: 15px;">
                No transactions found for this customer in the selected period.
            </div>
        <% } %>

        <!-- Bottom bar with Close button -->
        <div class="bottom-bar">
            <a href="ReportScreen.jsp?reportType=Customer+-+Revenue&startDate=<%= (startDateStr != null) ? startDateStr : "2026-01-01" %>&endDate=<%= (endDateStr != null) ? endDateStr : "2026-01-31" %>" class="btn-white">Close</a>
        </div>
    </div>

</body>
</html>
