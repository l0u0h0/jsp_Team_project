<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> 그루, GROW </title>
<link rel="stylesheet" href="../css/gather.css">
</head>
<body>

<%@ page import="java.sql.*" %>

<%
    String userid = "";
    String userpw = "";
    Connection con = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    Boolean check = false;

    if (request.getParameter("userid") == ""){
        // 아이디가 입력되지 않았음.
        // 다시 메인 화면으로 돌아가거나 경고 팝업 띄움
        %><script>
	        alert("ID를 잘못 입력했습니다.");
	        document.location.href='../main/main.jsp'
	    </script>
        <%
    }
    else if (request.getParameter("userpw") == ""){
        // 비밀번호가 입력되지 않았음.
        // 다시 메인 화면으로 돌아가거나 경고 팝업 띄움
        %><script>
	        alert("PW를 잘못 입력했습니다.");
	        document.location.href='../main/main.jsp'
	    </script>
        <%
    }
    else { // 아이디와 비밀번호 둘 다 공백이 아닐 경우

        userid = request.getParameter("userid");
        userpw = request.getParameter("userpw");

        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        Statement pstmt = con.createStatement();
        PreparedStatement pstmt1 = null;
        // 테스트를 위해 student 테이블로 진행. 추후 user테이블로 변경해야함
        //ResultSet result = pstmt.executeQuery("select tid, tpw, tname from student where tid = '" + userid + "' AND tpw = '" + userpw + "'");
        ResultSet result = pstmt.executeQuery("select US_ID, US_PW, US_NA, US_NT from user where US_ID = '" + userid + "' AND US_PW = '" + userpw + "'");
        int notice = 0;
        while (result.next()){
            String id = result.getString("US_ID");
            String name = result.getString("US_NA");
            notice = result.getInt("US_NT");
            //String id = result.getString("tid");
            //String name = result.getString("tname");
            // 로그인 성공한 아이디를 세션에 저장
            session.setAttribute("userid", id);
            session.setAttribute("username", name);
        %>
        <script>
            // 로그인 성공한 아이디를 js로 세션에 저장
            sessionStorage.setItem("userid", "<%=id %>");
            sessionStorage.setItem("username", "<%=name %>");
        </script>
        <%
            check = true;
        }

        if (check){
            // 로그인 성공
            if (notice == 0){
%>          
            <script>
            alert("환영합니다.");
            document.location.href='../main/main.jsp'
            </script><%
            }
            else if (notice == 1){
                %>          
            <script>
            alert("환영합니다.");
            alert("새로운 매칭이 있습니다.");
            document.location.href='../main/main.jsp'
            </script><%
            }
            StringBuffer SQL = new StringBuffer("update user set US_NT = ? where US_ID = '" + session.getAttribute("userid") + "'");
            pstmt1 = con.prepareStatement(SQL.toString());
            int no_notice = 0;
            pstmt1.setInt(1, no_notice);
            pstmt1.executeUpdate();
            result.close();
            con.close();
        }else{
            // 로그인 실패
            %><script>
	        alert("ID 또는 PW를 잘못 입력했습니다.");
	        document.location.href='../main/main.jsp'
	        </script>
            <%
        }
    }
    %>
    