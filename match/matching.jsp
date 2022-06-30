<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
    <title> 그루, GROW </title>
    <link rel="stylesheet" href="../css/gather.css">
    <%
    String type = request.getParameter("type");
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
    
    if (userid == null && username == null){
        %>
        <script>
            alert("로그인 후 이용해주시기 바랍니다.");
            document.location.href='../main/main.jsp';
        </script>
        <%
    }
    %>
    <% request.setCharacterEncoding("utf-8"); %>
    <!--
        성향 번호 별 의미
        1. 열정적인
        2. 성실한
        3. 리더적인
        4. 시간약속 잘 지키는
        5. 잘 따르는
        6. 응답이 빠른
    -->
</head>
<body>
    <%
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("update user set US_AG = ?, US_CL = ?, US_MT = ?, US_TM = ? , US_WN = ? where US_ID = ? "); 
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    String wanttime = request.getParameter("selected");
    String wanttime2 = request.getParameter("selected1");
    String [] my_ten = request.getParameterValues("my_tendency");
    String [] ot_ten = request.getParameterValues("other_tendency");
    // 성향에 대한 체크박스 값을 배열로 받아오기
    String result = "";
    String result2 = "";
    // 받아온 체크박스 배열 값을 하나의 String으로 사용하기 위한 변수
    String [] tmp = {"!", "@", "#", "$", "%", "^"};
    // 배열로 받아온 값에 구분자를 넣기 위한 배열, 정확한 구분을 위해 각자 다른 기호로 구분
    for (int i = 0; i < my_ten.length; i++){
        result += my_ten[i] + tmp[i];
    }
    for (int i = 0; i < ot_ten.length; i++){
        result2 += ot_ten[i] + tmp[i];
    }
    // 하나의 String에 배열 값을 구분자 포함하여 저장
    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(SQL.toString());
        pstmt.setString(1, request.getParameter("age"));
        pstmt.setString(2, request.getParameter("type") + "/" + request.getParameter("us_cl"));
        pstmt.setString(3, request.getParameter("meeting"));
        pstmt.setString(4, wanttime + "&" + wanttime2);
        int num = Integer.parseInt(request.getParameter("num"));
		pstmt.setInt(5, num);
        pstmt.setString(6, userid);
        
        int check = pstmt.executeUpdate();

        if (check == 1) {
        
            StringBuffer SQL2 = new StringBuffer("update user_tendency set US_MY = ?, US_OT = ? where US_ID = ?");
            pstmt = con.prepareStatement(SQL2.toString());
            
            pstmt.setString(1, result);
            pstmt.setString(2, result2);
            pstmt.setString(3, userid);

            int check2 = pstmt.executeUpdate();
            if (check2 == 1){
            %>
            <script>alert("작성에 성공하셨습니다.");</script>
            <%
            }else if (check2 != 1){
            %>
            <script>alert("작성2에 문제가 있습니다.");</script>
            <%
            }
        
        }else if (check != 1) {
        %>
        <script>alert("작성에 문제가 있습니다.");</script>
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
    %>
    <%out.println("<meta http-equiv='Refresh' content='1;URL=match_process.jsp'>");%>
</body>
</html>
