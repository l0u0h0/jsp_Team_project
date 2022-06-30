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
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
	StringBuffer SQL = new StringBuffer("delete from user_tendency where US_ID = ?");

    try{
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
		String sql = "select * from join_";
		pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		String jo_con = "";
		while (rs.next()){
			jo_con = rs.getString("JO_CON");
			String[] de_us = jo_con.split("/");
			for (int i = 1; i < de_us.length; i++){
				if (de_us[i] == null){
					break;
				}
				if(de_us[i].equals(userid)){
					de_us[i] == "";
				}
			}
		}
		rs.close();

        pstmt = con.prepareStatement(SQL.toString());

        pstmt.setString(1, userid);


        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1){
			StringBuffer SQL2 = new StringBuffer("delete from join_ where US_ID = ?");
			pstmt = con.prepareStatement(SQL2.toString());
			pstmt.setString(1, userid);
			int rowCount2 = pstmt.executeUpdate();
			if (rowCount2 == 1){
				StringBuffer SQL1 = new StringBuffer("delete from user where US_ID = ?");
				pstmt = con.prepareStatement(SQL1.toString());
				pstmt.setString(1, userid);

				int rowCount1 = pstmt.executeUpdate();
				if (rowCount1 == 1){
					%>

        			<script> alert("회원 탈퇴: 다음에 다시 만나요!");</script>

        			<%
					session.removeAttribute("userid");
        			session.removeAttribute("username");
					out.println("<meta http-equiv='Refresh' content='1;URL=../main/main.jsp'>");
				} else {
					%>
       	 			<script> alert("회원 탈퇴에 문제가 있습니다.");</script>
       	 			<%
				}
			} else {
				%>
       	 		<script> alert("회원 탈퇴에 문제가 있습니다.");</script>
       	 		<%
			}
			
       	 } else {

       	 	%>
       	 		<script> alert("회원 탈퇴에 문제가 있습니다.");</script>
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

			%>
		</body>
	</html>
