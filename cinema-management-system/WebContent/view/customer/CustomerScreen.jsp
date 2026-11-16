<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Home - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <style>
        .home-box {
            text-align: center;
            padding: 40px 20px;
        }
        .btn-search-movie {
            background-color: #d0e1f9;
            color: #000000;
            border: 1px solid #000000;
            padding: 14px 45px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.15s ease-in-out;
        }
        .btn-search-movie:hover {
            background-color: #b8d4f0;
        }
    </style>
</head>
<body>

    <div class="screen-container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
            <span style="font-size: 13px; color: #555;">(1) Customer Home</span>
            <a href="../../LoginScreen.jsp" style="font-size: 13px; color: #333; text-decoration: none;">[Logout]</a>
        </div>

        <div class="screen-title">Home</div>

        <div class="home-box">
            <a href="SearchMovieScreen.jsp" class="btn-search-movie">Search Movie</a>
        </div>
    </div>

</body>
</html>
