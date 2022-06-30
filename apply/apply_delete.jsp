<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
<title>그루, GROW</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%  
    String userid = (String)session.getAttribute("userid");
    String no = request.getParameter("no");
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    String SQL = "delete from user_request where US_ID = '" + userid + "' AND US_RF = '" + no + "'";

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";

    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(SQL);
        int result = pstmt.executeUpdate();

        if (result == 1) {
        %>
            <script>alert("삭제에 성공하셨습니다.");</script>
        <%
        }else if (result != 1) {
        %>
            <script>alert("삭제에 문제가 있습니다.");</script>
        <%
        }
    }
    catch(Exception e) {
    	out.println("데이터베이스 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
	out.println("<meta http-equiv='Refresh' content='1;URL=apply.jsp'>");
%>

<p><hr>

</body>
</html>