<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<head>
    <link rel="stylesheet" href="../css/login.css">
    <title>그루, GROW</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
</head>
<body>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<hr><center>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    String userid = request.getParameter("userid");
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    String sql = "select * from user where US_ID = '" + userid + "'";
    int rowCount = 0;

    try {
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();
%>
<body>
    <div class="login">
            <div class="login-screen">
                <div class="app-title">
                    <h3>PW 정보</h3>
                </div>
                <div class="loginform">
                    <div class="control">
                    <center>
                        <table style="font-size: 17px;">
                            <tr>
                                <th width=80>아이디</th>
                                <th width=80>비밀번호</th>
                            </tr>
    <%
        while (result.next()) {
    %>
                            <tr>
                                <td align=center><%= result.getString(1) %></td>
                                <td align=center><%= result.getString(2) %></td>
                            </tr>
    <%
	    rowCount++;
        }
        result.close();        
    }
    catch(Exception e) {
    	out.println("비밀번호 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    
                    

%>
                        </table>
                    </center>
                    <br>
                    <br>
                    <input type='button' value='돌아가기' class='btn' onclick="location.href='../main/main.jsp';">
                </div>
            </div>
 
    </div>
</body>
</html>

<%
	if (rowCount == 0) 
		out.println("조회된 결과가 없습니다.");
	else 
		out.println("조회된 결과가 " + rowCount + "건 입니다.");    
%>

</body>
</html>