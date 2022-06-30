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
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into request(US_ID, PS_NUM, RE_PS, RE_DT) "); 
    SQL.append("values (?, ?, ?, CURDATE())");
    String userid = (String)session.getAttribute("userid");
    String re_no = request.getParameter("no");
    String jo_no = request.getParameter("JO_NUM");
    String us_fp = "";
    String us_sp = "";
    String ur_da = "";
    String jo_mt = "";
    String jo_fd = "";
    String re_post = "";
    String full_con = "";
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    
    try {
	    Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        String sql = "select * from user_request where US_ID = '" + userid + "' AND US_RF = '" + re_no + "'";
        pstmt = con.prepareStatement(sql);
        ResultSet recheck = pstmt.executeQuery();
        int count = 0;
        while (recheck.next()){
            us_fp = recheck.getString(3);
            us_sp = recheck.getString(4);
            ur_da = recheck.getString(5);
            count++;
        }
        String sql1 = "select JO_CON from join_ where JO_NUM = '" + jo_no + "'";
        pstmt = con.prepareStatement(sql1);
        ResultSet recheck1 = pstmt.executeQuery();
        count = 0;
        while (recheck1.next()){
            full_con = recheck1.getString("JO_CON");
            count++;
        }
        re_post = "title/" + us_fp + "/content/" + us_sp + "/date/" + ur_da;
        
        pstmt = con.prepareStatement(SQL.toString());
        
        pstmt.setString(1, userid);
        pstmt.setString(2, jo_no);
        pstmt.setString(3, re_post);
        
        int result = pstmt.executeUpdate();

        if (result == 1) {
        %>
            <script>alert("신청에 성공하셨습니다.");</script>
        <%
            PreparedStatement pstmt2 = null;
            StringBuffer SQL1 = new StringBuffer("update join_ set JO_CON = ?, JO_SD = ? where JO_NUM = ?");
            pstmt2 = con.prepareStatement(SQL1.toString());
            
            // 신청한 회원 아이디 저장
            full_con = full_con + userid + "/";
            
            // 결성된 그룹에 대한 (매칭/신청) 구분
            String info = "신청";
            pstmt2.setString(1, full_con);
            pstmt2.setString(2, info);
            pstmt2.setString(3, jo_no);
            
        
            int result2 = pstmt2.executeUpdate();
            if (result2 == 1){
            %>
                <script>alert("신청에 성공하셨습니다.");</script>
            <%
            }else if (result2 != 1) {
            %>
                <script>alert("신청에 문제가 있습니다.");</script>
            <%
            }
        }else if (result != 1) {
        %>
            <script>alert("조회에 문제가 있습니다.");</script>
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
	out.println("<meta http-equiv='Refresh' content='1;URL=../main/main.jsp'>");
%>

</body>
</html>