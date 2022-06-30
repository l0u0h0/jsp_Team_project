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
    // 세션에 담긴 유저 아이디
    int writenum = 0;
    // 신청서 번호 합계를 위한 변수
    String type = null;
    // 저장될 신청서 번호를 위한 변수
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into user_request(US_ID, US_RF, US_FP, US_SP, UR_DA) ");
    SQL.append("values (?, ?, ?, ?, CURDATE())");
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";

    try {
	    Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        String sql = "select US_RF from user_request where US_ID = '" + userid + "'";
        //세션에 담긴 유저 아이디 정보로 DB에서 회원의 신청서 번호 조회
        pstmt = con.prepareStatement(sql);
        ResultSet typecheck = pstmt.executeQuery();
        while (typecheck.next()){
            writenum += typecheck.getInt(1);
            // 조회한 번호를 모두 더해서 회원이 갖고있는 신청서의 번호 합계를 구함.
        }
        // 합계가 0인 경우, 작성한 신청서가 없는 경우
        if (writenum == 0){
            // 1번 신청서로 DB에 저장
            pstmt = con.prepareStatement(SQL.toString());
            type = "1";
            pstmt.setString(1, userid);
            pstmt.setString(2, type);
            pstmt.setString(3, request.getParameter("title"));
            pstmt.setString(4, request.getParameter("content"));
        
            int result = pstmt.executeUpdate();

            if (result == 1) {
                %>
                    <script>alert("작성에 성공하셨습니다.");</script>
                <%
            }
        }
        // 합계가 1인 경우, 작성한 신청서가 1번 신청서 하나인 경우
        else if (writenum == 1){
            // 2번 신청서로 DB에 저장
            pstmt = con.prepareStatement(SQL.toString());
            type = "2";
            pstmt.setString(1, userid);
            pstmt.setString(2, type);
            pstmt.setString(3, request.getParameter("title"));
            pstmt.setString(4, request.getParameter("content"));
        
            int result = pstmt.executeUpdate();

            if (result == 1) {
                %>
                    <script>alert("작성에 성공하셨습니다.");</script>
                <%
            }else if (result != 1) {
                %>
                    <script>alert("작성에 문제가 있습니다.");</script>
                <%
            }
        }
        // 합계가 2인 경우, 작성한 신청서가 2번 신청서 하나인 경우
        else if (writenum == 2){
            // 1번 신청서로 DB에 저장
            pstmt = con.prepareStatement(SQL.toString());
            type = "1";
            pstmt.setString(1, userid);
            pstmt.setString(2, type);
            pstmt.setString(3, request.getParameter("title"));
            pstmt.setString(4, request.getParameter("content"));
        
            int result = pstmt.executeUpdate();

            if (result == 1) {
                %>
                    <script>alert("작성에 성공하셨습니다.");</script>
                <%
            }else if (result != 1) {
                %>
                    <script>alert("작성에 문제가 있습니다.");</script>
                <%
            }
        }
        // 합계가 3이상인 경우, 작성한 신청서가 1번, 2번 모두인 경우
        else if (writenum >= 3){
            // 경고팝업 출력 후 신청서 페이지로 되돌아가기
            %>
                <script>
                    alert("작성가능한 신청서의 개수를 초과했습니다.");
                    document.location.href='apply.jsp'
                </script>
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
	out.println("<meta http-equiv='Refresh' content='1;URL=apply.jsp'>");
%>

</body>
</html>