<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
    <title> 그루, GROW </title>
    <link rel="stylesheet" href="../css/gather.css">
    <script>
        sessionStorage.clear();
        alert("로그아웃이 완료됐습니다.");
    </script>
    <%
        session.removeAttribute("userid");
        session.removeAttribute("username");
    %>
</head>
<body>
    <script>
        document.location.href='../main/main.jsp'
    </script>
</body>
</html>
