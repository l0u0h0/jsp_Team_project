<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title> 그루, GROW </title>
	<link rel="stylesheet" href="../css/info_edit.css">
        <%
            String userid = (String)session.getAttribute("userid");
            String username = (String)session.getAttribute("username");
        %>

</head>
<body>

	<%@ page import="java.sql.*" %>
	<% request.setCharacterEncoding("utf-8"); %>

	<%
	    Connection con = null;
    	PreparedStatement pstmt = null;
		Statement stmt = null;

		StringBuffer SQL = new StringBuffer("update user set US_PW = ?, US_PN = ?, US_EM = ?, US_NA = ? where US_ID = ?");


		String driverName = "org.gjt.mm.mysql.Driver";
    	String dbURL = "jdbc:mysql://localhost:3306/mysql29";

    	try{

    		Class.forName(driverName);
        	con = DriverManager.getConnection(dbURL, "root", "kbc0924");

        	pstmt = con.prepareStatement(SQL.toString());

        	pstmt.setString(1, request.getParameter("password"));
        	pstmt.setString(2, request.getParameter("phone"));
        	pstmt.setString(3, request.getParameter("email"));
        	pstmt.setString(4, request.getParameter("name"));
        	pstmt.setString(5, userid);

        	int rowCount = pstmt.executeUpdate();        
        	if (rowCount == 1) {

        	%>

        		<script> alert("정보가 수정되었습니다.");</script>

        	<%
        	out.println("<meta http-equiv='Refresh' content='1;URL=../user/info_edit.jsp'>");
       	} else {

       	 	%>
       	 		<script> alert("정보 수정에 문제가 있습니다.");</script>
       	 	<%

       	}

   	}

   	catch(Exception e) {
    	out.println("문제 발생! ");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }

out.println("<meta http-equiv='Refresh' content='1;URL=info_edit.jsp'>");
%>
</body>
</html>