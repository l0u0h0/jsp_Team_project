<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
    %>
    <meta charset="UTF-8">
    <title>그루, GROW 자료 관리</title>
	<% request.setCharacterEncoding("utf-8"); %>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
    <link rel="stylesheet" href="../css/view.css">
</head>
<body>
        <header>
            <a href="../main/main.jsp"><img src="../image/logo.png"></a>
        </header>

        <div class="menubar">
            <ul>
                <li><a href="../match/matching.html"> 매칭 </a></li> 
                <li><a href="../user/gathering.jsp"> 모집 </a></li> 
                <li><a> 관리 </a>
                    <ul>
                        <li><a href="../manage/manageschedule.jsp"> 스케줄 관리 </a></li>
                        <li><a href="../manage/managedata.jsp"> 자료 관리 </a></li>
                    </ul>
                </li>
                <li><a> 마이 페이지 </a>
          <ul>
            <li><a href="../user/info_edit.jsp"> 회원 정보 </a></li>
            <li><a href="../apply/apply_check.jsp"> 신청 내역 </a></li>
            <li><a href="../apply/apply.jsp"> 내 신청서 </a></li>
          </ul>
        </li> 
      </ul>
    </div>


    <div id="commu">
     <b> <a> <div id="commu_text1"> &nbsp; 관리 </div> </a> <br>
        <div id="commu_text2" style="cursor: pointer;"onclick="location.href='../manage/manageschedule.jsp';"> &nbsp;- &nbsp;스케줄 관리 </div>
        <div id="commu_text3" style="cursor: pointer;"onclick="location.href='../manage/managedata.jsp';"> &nbsp;- &nbsp;자료 관리 </div>
        <br><br><br>
    </div> </b>
    </div>
	<%
		// 회원 관련 객체 
		String us_id    = "";
		String da_con   = "";
		String da_ti    = "";
		String da_fi    = "";
		// DB 관련 객체 
		Connection        con  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		ResultSet         rs2   = null;
		
		String            rst   = "success";
		String            msg   = "";

    	String driverName = "org.gjt.mm.mysql.Driver";
    	String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    	
		%>
		<%
		try {
			
        	Class.forName(driverName);
        	con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        	int num = Integer.parseInt(request.getParameter("DA_NUM"));
        	int rowCount = 0;
			String sql = "select * from data where DA_CD = " + num;
        	
			// 사용자 회원정보 추출  
			
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			//pstmt.setString(1, userId);
			// 등록된 게시물인 경우
			while (rs.next()) {
				us_id        = rs.getString("US_ID");
				da_con       = rs.getString("DA_CT");
				da_ti        = rs.getString("DA_TI");
				da_fi        = rs.getString("DA_FI");
				%>
            <div>
                <div id="title">
                    <span>
                        <b> [<%=num%>번 그룹 자료]<%= da_ti %> </b>
                    </span> 
                    <span id="info">
                        작성자: <%= us_id %>
                    </span>
                </div>
            </div>
            <br>
            <div id="container">
            	   <a href="../uploaded/post_data/<%= da_fi %>"><%= da_fi %></a>
                <div id="content" style="margin-top: 20px; height: auto;">
            	   <br><br>
				   <%= da_con %>
                </div>
                <br><br>
            </div> 
			<%	 
			}
			
		} catch(SQLException e) {
			rst = "시스템에러";
			msg = e.getMessage();
		} finally {
			
			if(pstmt != null) 
				pstmt.close();
			if(con != null) 
				con.close();
		} 
		%>
            <input type="button" value="목록" class="btn1" style="cursor: pointer;" onclick="location.href='../manage/managedata.jsp';">
			
</body>
</html>
