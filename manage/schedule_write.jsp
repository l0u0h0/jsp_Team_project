<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> 그루, GROW 스케줄 등록</title>
<link rel="stylesheet" href="../css/gather.css">
</head>
<body>

<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String userid = (String)session.getAttribute("userid");
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into schedule(US_ID, PS_NUM, SC_CT, SC_DA) "); 
    SQL.append("values (?, ?, ?, ?)");
    String jo_no = request.getParameter("jo_no");
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    String jo_ti = "";
    String sc_ct = request.getParameter("SC_CON") + "/" + request.getParameter("time") + " ~ " + request.getParameter("time1");

    try {
	    Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        String sql = "select * from join_ where JO_NUM = '" + jo_no + "'";
        pstmt = con.prepareStatement(sql);
        ResultSet jo_check = pstmt.executeQuery();
        int count = 0;
        while (jo_check.next()){
            jo_ti = jo_check.getString("JO_TI");
        }
        
        pstmt = con.prepareStatement(SQL.toString());
        
        pstmt.setString(1, userid);
        pstmt.setString(2, jo_no);
        pstmt.setString(3, sc_ct);
        pstmt.setString(4, request.getParameter("date"));
        
        int result = pstmt.executeUpdate();

        if (result == 1) {
        %>
            <script>alert("등록에 성공하셨습니다.");</script>
        <%
                
        }else if (result != 1) {
        %>
            <script>alert("등록에 문제가 있습니다.");</script>
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
	out.println("<meta http-equiv='Refresh' content='1;URL=manageschedule.jsp'>");
%>

</body>
</html>