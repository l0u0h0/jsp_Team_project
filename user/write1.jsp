<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
	<title>그루, GROW 모집게시판 글쓰기</title>
	<!-- 화면 최적화 -->
	<meta name="viewport" content="width-device-width", initial-scale="1">
	<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>

<% request.setCharacterEncoding("utf-8"); %>
<%
    

%>
<%
    String savePath = request.getServletContext().getRealPath("proj/uploaded/post_image");
    // 저장될 경로
    int sizeLimit = 1024*1024*10;
    // 최대 이미지 크기 (10MB)
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
    MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", policy);
    String fileName = multi.getOriginalFileName("JO_IR");
    String filePath = savePath + "/" + fileName;
    String userid = (String)session.getAttribute("userid");
    String jo_con = multi.getParameter("JO_CON") + "/";
    if (userid == null){
        %>
        <script>
        alert("로그인 후 이용해주세요.");
        document.location.href='write.html'
        </script>
        <%
    }
    if (multi.getParameter("JO_TI") == null || multi.getParameter("JO_CON") == null){
        %>
        <script>
        alert("빠짐없이 입력해주시길 바랍니다.");
        document.location.href='write.html'
        </script>
        <%
    }
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into join_(JO_TI, JO_MT, JO_CON, JO_IR, JO_DA, JO_FD, US_ID) "); 
    SQL.append("values (?, ?, ?, ?, CURDATE(), ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    
    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(SQL.toString());

        pstmt.setString(1, multi.getParameter("JO_TI"));
        pstmt.setString(2, multi.getParameter("JO_MT"));
        pstmt.setString(3, jo_con);
        pstmt.setString(4, fileName);
        pstmt.setString(5, multi.getParameter("JO_FD"));
        pstmt.setString(6, userid);
        
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
	out.println("<meta http-equiv='Refresh' content='1;URL=gathering.jsp'>");
%>

</body>
</html>