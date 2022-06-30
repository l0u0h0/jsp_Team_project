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
    StringBuffer SQL = new StringBuffer("insert into user(US_ID, US_PW, US_PN, US_EM, US_NA, US_GE, US_NT) "); 
    SQL.append("values (?, ?, ?, ?, ?, ?, ?)");
    String userid = request.getParameter("id");
    Boolean check = false;
    String pw1 = request.getParameter("password");
    String pw2 = request.getParameter("password2");
    int notice = 0;
    if (pw1.equals(pw2)) {
        check = true;
    }
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    
    // 정보 입력이 없이 넘어왔을 경우 되돌아
    if (request.getParameter("id") == "" || request.getParameter("password") == "") {
        %>
        <script>
        alert("빠짐없이 입력해주시길 바랍니다.");
        document.location.href='gather.html'
        </script>
        <%
    }
    else if (check) {
        try {
		    Class.forName(driverName);
            con = DriverManager.getConnection(dbURL, "root", "kbc0924");
            String sql = "select US_ID from user where US_ID = '" + userid + "'";
            pstmt = con.prepareStatement(sql);
            ResultSet idcheck = pstmt.executeQuery();
            int count = 0;
            while (idcheck.next()){
                count++;
            }
            if (count > 0){
                %>
                <script>
                    alert("아이디가 중복되었습니다.");
                    document.location.href='gather.html'
                </script>
                <%
            }else{
                pstmt = con.prepareStatement(SQL.toString());
                // user테이블에 입력될 회원정보
                // 아이디, 패스워드, 전화번호, 이메일, 이름, 성별
                pstmt.setString(1, request.getParameter("id"));
                pstmt.setString(2, request.getParameter("password"));
                pstmt.setString(3, request.getParameter("phone"));
                pstmt.setString(4, request.getParameter("email"));
                pstmt.setString(5, request.getParameter("name"));
                pstmt.setString(6, request.getParameter("sex"));
                pstmt.setInt(7, notice);
        
                int result = pstmt.executeUpdate();

                if (result == 1) {
                %>
                    <script>alert("회원가입에 성공하셨습니다.");</script>
                <%
                    StringBuffer SQL1 = new StringBuffer("insert into user_tendency(US_ID, US_MY, US_OT) "); 
                    SQL1.append("values (?, ?, ?)");
                    pstmt = con.prepareStatement(SQL1.toString());
                    pstmt.setString(1, request.getParameter("id"));
                    pstmt.setString(2, "null");
                    pstmt.setString(3, "null");
                    pstmt.executeUpdate();
                }else if (result != 1) {
                %>
                    <script>alert("회원가입에 문제가 있습니다.");</script>
                <%
                }
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
    } 
    else {
        %>
        <script>
        alert("비밀번호가 일치하지 않습니다.");
        document.location.href='gather.html'
        </script>
        <%
    }
%>

</body>
</html>