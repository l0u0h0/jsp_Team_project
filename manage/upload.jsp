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
    <link rel="stylesheet" type="text/css" href="../css/main.css">
	<title>그루, GROW 자료관리 업로드</title>
	<!-- 화면 최적화 -->
	<meta name="viewport" content="width-device-width", initial-scale="1">
	<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
</head>
<body>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String savePath = request.getServletContext().getRealPath("proj/uploaded/post_data");
    // 저장될 경로
    int sizeLimit = 1024*1024*20;
    // 최대 파일 크기 (20MB)
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
    MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", policy);
    String fileName = multi.getOriginalFileName("DA_FI");
    String filePath = savePath + "/" + fileName;
    String userid = (String)session.getAttribute("userid");
    Connection con = null;
    PreparedStatement pstmt = null;
    StringBuffer SQL = new StringBuffer("insert into data(US_ID, PS_NUM , DA_TI , DA_CT, DA_FI) "); 
    SQL.append("values (?, ?, ?, ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    
    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(SQL.toString());

        pstmt.setString(1, userid);
        pstmt.setString(2, multi.getParameter("PS_NUM"));
        pstmt.setString(3, multi.getParameter("DA_TI"));
        pstmt.setString(4, multi.getParameter("DA_CT"));
        pstmt.setString(5, filePath);
        
        int result = pstmt.executeUpdate();

        if (result == 1) {
        %>
        <script>alert("업로드에 성공하셨습니다.");</script>
        <%
        }else if (result != 1) {
        %>
        <script>alert("업로드에 문제가 있습니다.");</script>
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
	out.println("<meta http-equiv='Refresh' content='1;URL=managedata.jsp'>");
%>

</body>
</html>