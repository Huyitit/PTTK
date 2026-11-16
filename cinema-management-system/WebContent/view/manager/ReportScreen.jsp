<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerStatDAO3" %>
<%@ page import="model.CustomerStats3" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String reportType = request.getParameter("reportType");
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    boolean hasSubmitted = (reportType != null && startDateStr != null && endDateStr != null);
    ArrayList<CustomerStats3> statList = null;

    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");

    Date startDate = null;
    Date endDate = null;
    String displayFrom = "";
    String displayTo = "";

    if (hasSubmitted) {
        try {
            startDate = sdfInput.parse(startDateStr.trim());
        } catch (Exception e) {
            try { startDate = sdfDisplay.parse(startDateStr.trim()); } catch (Exception ignored) {}
        }

        try {
            endDate = sdfInput.parse(endDateStr.trim());
        } catch (Exception e) {
            try { endDate = sdfDisplay.parse(endDateStr.trim()); } catch (Exception ignored) {}
        }

        if (startDate != null && endDate != null) {
            displayFrom = sdfDisplay.format(startDate);
            displayTo = sdfDisplay.format(endDate);
            CustomerStatDAO3 statDAO = new CustomerStatDAO3();
            statList = statDAO.getCustomerStat(startDate, endDate);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reports - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <style>
        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }
        .form-row label {
            width: 110px;
            font-weight: bold;
            font-size: 15px;
        }
        .form-row input, .form-row select {
            flex: 1;
            max-width: 420px;
        }
        .action-cell {
            background-color: #c8e6c9;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="screen-container">
        <div style="font-size: 13px; color: #555; margin-bottom: 10px;">
            <% if (!hasSubmitted) { %>
                (2) Before selecting report type and date range
            <% } else { %>
                (2) Customer Revenue Statistics
            <% } %>
        </div>

        <div class="screen-title">View Reports</div>

        <% if (!hasSubmitted) { %>
            <!-- State 1: Before selecting report -->
            <div class="section-label" style="margin-top: 0;">Select report</div>

            <form action="ReportScreen.jsp" method="get" style="margin-top: 15px;">
                <div class="form-row">
                    <label for="reportType">Type:</label>
                    <select id="reportType" name="reportType" class="input-select" required>
                        <option value="">Select report</option>
                        <option value="Customer - Revenue" selected>Customer - Revenue</option>
                    </select>
                </div>

                <hr style="border: 0; border-top: 1px dashed #666; margin: 18px 0;">

                <div class="form-row">
                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate" class="input-text" value="2026-01-01" required>
                </div>

                <div class="form-row">
                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate" class="input-text" value="2026-01-31" required>
                </div>

                <div style="display: flex; justify-content: flex-end; margin-top: 20px;">
                    <button type="submit" class="btn-blue">View report</button>
                </div>
            </form>

            <div class="bottom-bar">
                <a href="ManagerScreen.jsp" class="btn-white">Back</a>
            </div>

        <% } else { %>
            <!-- State 2: After submitting report filter -->
            <table class="summary-table">
                <tr>
                    <td class="label-cell">Type</td>
                    <td style="font-weight: bold;"><%= reportType %></td>
                </tr>
                <tr>
                    <td class="label-cell">From</td>
                    <td><%= displayFrom %></td>
                </tr>
                <tr>
                    <td class="label-cell">To</td>
                    <td><%= displayTo %></td>
                </tr>
            </table>

            <div class="section-label">Result:</div>

            <% if (statList != null && !statList.isEmpty()) { %>
                <!-- Scrollable container when list exceeds 15 rows -->
                <div class="table-scroll-stat">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th class="th-blue" style="width: 8%;">No.</th>
                                <th class="th-blue" style="width: 18%;">Customer code</th>
                                <th class="th-blue" style="width: 28%;">Customer name</th>
                                <th class="th-blue" style="width: 18%;">Total transactions</th>
                                <th class="th-blue" style="width: 20%;">Total revenue (VNĐ)</th>
                                <th class="th-blue" style="width: 8%;">&#9660;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int stt = 1;
                                for (CustomerStats3 cs : statList) {
                            %>
                            <tr>
                                <td class="text-center"><%= stt++ %></td>
                                <td class="text-center"><%= (cs.getCode() != null) ? cs.getCode() : "" %></td>
                                <td><%= (cs.getFullName() != null) ? cs.getFullName() : "" %></td>
                                <td class="text-center"><%= cs.getTotalTransactions() %></td>
                                <td class="text-right"><%= df.format(cs.getTotalRevenue()) %></td>
                                <td class="action-cell">
                                    <a href="CustomerTransactionScreen.jsp?customerId=<%= cs.getId() %>&startDate=<%= startDateStr %>&endDate=<%= endDateStr %>&customerCode=<%= cs.getCode() %>&customerName=<%= java.net.URLEncoder.encode(cs.getFullName(), "UTF-8") %>" class="link-view">View</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div style="background-color: #fff; padding: 20px; border: 1px solid #000; text-align: center; margin-bottom: 15px;">
                    No transaction data found for the selected period from <%= displayFrom %> to <%= displayTo %>.
                </div>
            <% } %>

            <!-- Bottom bar with Back button -->
            <div class="bottom-bar">
                <a href="ReportScreen.jsp" class="btn-white">Back</a>
            </div>
        <% } %>

    </div>

</body>
</html>
