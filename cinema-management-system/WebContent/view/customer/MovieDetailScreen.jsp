<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MovieDAO3" %>
<%@ page import="model.Movie3" %>
<%@ page import="model.MovieActor3" %>
<%@ page import="model.Actor3" %>
<%@ page import="model.MovieGenre3" %>
<%@ page import="model.Genre3" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("id");
    Movie3 movie = null;
    StringBuilder actorsSb = new StringBuilder();
    StringBuilder genresSb = new StringBuilder();
    String releaseDateStr = "N/A";

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            int movieId = Integer.parseInt(idStr.trim());
            MovieDAO3 movieDAO = new MovieDAO3();
            Movie3 param = new Movie3();
            param.setId(movieId);
            movie = movieDAO.getMovieDetail(param);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    if (movie != null) {
        if (movie.getReleaseDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            releaseDateStr = sdf.format(movie.getReleaseDate());
        }

        if (movie.getActors() != null && !movie.getActors().isEmpty()) {
            for (int i = 0; i < movie.getActors().size(); i++) {
                MovieActor3 ma = movie.getActors().get(i);
                if (ma.getActor() != null && ma.getActor().getName() != null) {
                    actorsSb.append(ma.getActor().getName());
                }
                if (i < movie.getActors().size() - 1) {
                    actorsSb.append(", ");
                }
            }
        }

        if (movie.getGenres() != null && !movie.getGenres().isEmpty()) {
            for (int i = 0; i < movie.getGenres().size(); i++) {
                MovieGenre3 mg = movie.getGenres().get(i);
                if (mg.getGenre() != null && mg.getGenre().getName() != null) {
                    genresSb.append(mg.getGenre().getName());
                }
                if (i < movie.getGenres().size() - 1) {
                    genresSb.append(", ");
                }
            }
        }
    }

    String ageStr = "P - General Audiences (All ages admitted)";
    if (movie != null) {
        int age = movie.getAgeRestriction();
        if (age == 13) ageStr = "PG-13 - Parents strongly cautioned (Under 13 requires guidance)";
        else if (age == 16) ageStr = "R-16 - Restricted to viewers aged 16 and older";
        else if (age == 18) ageStr = "R-18 - Restricted to adults aged 18 and older";
        else if (age > 0) ageStr = "Rated " + age + "+";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Detail - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
</head>
<body>

    <div class="screen-container">
        <div style="font-size: 13px; color: #555; margin-bottom: 10px;">(3) Movie Detail</div>

        <div class="screen-title">Movie Detail</div>

        <% if (movie != null) { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th class="th-orange" style="width: 30%;">Information</th>
                        <th class="th-orange" style="width: 70%;">Detail</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="td-info">Code</td>
                        <td class="td-detail">MOV<%= String.format("%03d", movie.getId()) %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Title</td>
                        <td class="td-detail"><strong><%= movie.getTitle() %></strong></td>
                    </tr>
                    <tr>
                        <td class="td-info">Director</td>
                        <td class="td-detail"><%= (movie.getDirector() != null) ? movie.getDirector() : "N/A" %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Main actors</td>
                        <td class="td-detail"><%= (actorsSb.length() > 0) ? actorsSb.toString() : "N/A" %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Genres</td>
                        <td class="td-detail"><%= (genresSb.length() > 0) ? genresSb.toString() : "N/A" %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Duration</td>
                        <td class="td-detail"><%= movie.getDuration() %> minutes</td>
                    </tr>
                    <tr>
                        <td class="td-info">Release Date</td>
                        <td class="td-detail"><%= releaseDateStr %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Age Restriction</td>
                        <td class="td-detail"><%= ageStr %></td>
                    </tr>
                    <tr>
                        <td class="td-info">Description</td>
                        <td class="td-detail"><%= (movie.getDescription() != null) ? movie.getDescription() : "" %></td>
                    </tr>
                </tbody>
            </table>
        <% } else { %>
            <div style="background-color: #fff; padding: 20px; border: 1px solid #000; text-align: center;">
                Movie details not found.
            </div>
        <% } %>

        <!-- Close button -->
        <div class="bottom-bar">
            <a href="SearchMovieScreen.jsp" class="btn-white">Close</a>
        </div>
    </div>

</body>
</html>
