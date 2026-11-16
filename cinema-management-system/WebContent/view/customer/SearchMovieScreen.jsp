<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MovieDAO3" %>
<%@ page import="model.Movie3" %>
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("keyword");
    boolean hasSearched = (keyword != null);
    ArrayList<Movie3> movieList = null;

    if (hasSearched) {
        MovieDAO3 movieDAO = new MovieDAO3();
        movieList = movieDAO.getMovies(keyword);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Movie - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <style>
        .search-bar {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-bar input[type="text"] {
            flex: 1;
            padding: 10px 14px;
            font-size: 15px;
            border: 1px solid #000;
            background-color: #ffffff;
        }
    </style>
</head>
<body>

    <div class="screen-container">
        <div style="font-size: 13px; color: #555; margin-bottom: 10px;">
            <% if (!hasSearched) { %>
                (2) Before searching
            <% } else { %>
                (2) Search Results
            <% } %>
        </div>

        <div class="screen-title">Search Movie</div>

        <!-- Search Bar -->
        <form action="SearchMovieScreen.jsp" method="get" class="search-bar">
            <input type="text" name="keyword" 
                   placeholder="(Insert name of movie here)" 
                   value="<%= (keyword != null) ? keyword : "" %>">
            <button type="submit" class="btn-blue">Search</button>
        </form>

        <% if (hasSearched) { %>
            <div class="section-label">Results:</div>

            <% if (movieList != null && !movieList.isEmpty()) { %>
                <!-- Scrollable container when list exceeds 10 rows -->
                <div class="table-scroll-movie">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th class="th-orange" style="width: 15%;">No.</th>
                                <th class="th-orange" style="width: 65%;">Title</th>
                                <th class="th-orange" style="width: 20%;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int stt = 1;
                                for (Movie3 m : movieList) {
                            %>
                            <tr>
                                <td class="text-center"><%= stt++ %></td>
                                <td><%= (m.getTitle() != null) ? m.getTitle() : "" %></td>
                                <td class="text-center">
                                    <a href="MovieDetailScreen.jsp?id=<%= m.getId() %>" class="link-view">View</a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div style="background-color: #fff; padding: 15px; border: 1px solid #000; text-align: center; margin-bottom: 15px;">
                    No movies found matching keyword "<%= keyword %>".
                </div>
            <% } %>
        <% } %>

        <!-- Bottom bar with Back button -->
        <div class="bottom-bar">
            <a href="CustomerScreen.jsp" class="btn-white">Back</a>
        </div>
    </div>

</body>
</html>
