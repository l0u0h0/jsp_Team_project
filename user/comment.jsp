<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> 그루, GROW </title>
<link rel="stylesheet" href="../css/gather.css">
</head>
<body>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into comment(US_ID, PS_NUM, CM_PS, CM_DA) "); 
    SQL.append("values (?, ?, ?, CURDATE())");
    String jo_no = request.getParameter("JO_NUM");
    String comment = request.getParameter("comment");
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    
    // 정보 입력이 없이 넘어왔을 경우 되돌아
    if (request.getParameter("comment") == "") {
        %>
        <script>
        alert("댓글이 입력되지 않았습니다.");
        history.go(-1);
        </script>
        <%
    }
    else {
    
    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        
        pstmt = con.prepareStatement(SQL.toString());
                
        pstmt.setString(1, userid);
        pstmt.setString(2, jo_no);
        pstmt.setString(3, comment);
        
        int result = pstmt.executeUpdate();

        if (result == 1) {
        %>
            <script>alert("댓글 작성에 성공하셨습니다.");</script>
        <%
        }else if (result != 1) {
        %>
            <script>alert("댓글 작성에 문제가 있습니다.");</script>
        <%
        }
    }
        // 예외처리
    catch(Exception e) {
    	%>
        <script>alert("문제가 있습니다.");</script>
        <%
        out.println(e.toString());
        e.printStackTrace();
        }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    }
%>
<script>
    history.go(-1);
</script>
</body>
</html>