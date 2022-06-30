<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<%
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
    <meta charset="UTF-8">
    <title>그루, GROW</title>
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
	<%
		// 회원 관련 객체 
		String us_Id   = "";
		String us_id    = "";
		String co_con   = "";
		String co_da    = "";
		String jo_ti    = "";
		String jo_con   = "";
		String image    = "";
		String jo_mt    = "";
		String jo_fd    = ""; 
		String jo_da    = ""; 
		String jo_num   = "";
		int jo_vi       =  0;
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
        	int num = Integer.parseInt(request.getParameter("JO_NUM"));
        	int rowCount = 0;
			String sql = "select * from join_ where JO_NUM = " + num;
        	
			// 사용자 회원정보 추출  
			
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			//pstmt.setString(1, userId);
			// 등록된 게시물인 경우
			if (rs.next()) {
				us_Id        = rs.getString("US_ID");
				jo_ti      = rs.getString("JO_TI");
				jo_con    = rs.getString("JO_CON");
				image       = rs.getString("JO_IR");
				jo_mt     = rs.getString("JO_MT");
				jo_fd     = rs.getString("JO_FD");
				jo_da     = rs.getString("JO_DA");
				jo_vi     = rs.getInt("JO_VI");
				jo_vi     = jo_vi + 1;
				String[] post = jo_con.split("/");
				%>
            <div>
                <div id="title">
                    <span>
                        <b> [<%= jo_fd%>]<%= jo_ti %> </b>
                    </span> 
                    <span id="info">
                        닉네임: <%= us_Id %>
                        |
                        조회수: <%= jo_vi %>
                        |
                        날짜: <%= jo_da %>
                    </span>
                </div>
            </div>
            <br>
            <div id="container">
            	   <img src="../uploaded/post_image/<%= image %>">
                <div id="content" style="margin-top: 20px; height: auto;">
            	   <br><br>
				   <%= post[0] %>
                </div>
                <br><br>
            <div>
                <input type="button" value="신청하기" class="btn" style="cursor: pointer; margin-top: 30px;" onclick="location.href='../request/request.jsp?JO_NUM=<%= rs.getString("JO_NUM")%>';">
            </div>
            <div>
                <input type="button" value="신청 목록 확인하기" class="btn" style="cursor: pointer; margin-top: 10px;" onclick="location.href='../apply/group_view.jsp?JO_NUM=<%= rs.getString("JO_NUM")%>';">
            </div>
			<br><br>
			<div >
                    <div>
                        <b style="font-size: 14pt;"> 댓글 </b><hr style="width: 1000px;">
                    </div>
					<%
					sql = "select * from comment where PS_NUM = " + num;
					pstmt = con.prepareStatement(sql);
					rs2 = pstmt.executeQuery();
					while (rs2.next()){
						us_id = rs2.getString("US_ID");
						co_con = rs2.getString("CM_PS");
						co_da = rs2.getString("CM_DA");
					%>
					<br>
					<div style="font-size: 12pt;">
                        닉네임: <%= us_id %>
                        |
                         <%= co_con %>
                        |
                        날짜: <%= co_da %>
                    </div>
					<%
					rowCount++;
					}
					if (rowCount == 0){
					%>
					<div style="font-size: 0.8em;">
                        아직 댓글이 달리지 않았습니다..
                    </div>
					<%
					}
					%>
					<p>
					<br>
					<div>
						<form method="POST" action="comment.jsp?JO_NUM=<%= num%>">
							<input type='text' value='댓글을 작성해주세요..' name='comment' style="width: 450px; height: 30px;">
							<input type='submit' value='작성하기' class="btn" style="cursor: pointer; margin-left: 460px; margin-top: -33px; width: 100px; height: 30px; padding: 0px">
						</form>
					</div>
                </div>
            </div> 
			<%	 
			}
			StringBuffer SQL = new StringBuffer("update join_ set JO_VI = ? where JO_NUM = ?"); 
            pstmt = con.prepareStatement(SQL.toString());
			pstmt.setInt(1, jo_vi);
            pstmt.setString(2, request.getParameter("JO_NUM"));
            
            pstmt.executeUpdate();
			
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
            <input type="button" value="목록" class="btn1" style="cursor: pointer;" onclick="location.href='../user/gathering.jsp';">
            <input type="button" value="글쓰기" class="btn2" style="cursor: pointer;" onclick="location.href='../user/write.html';">
			
</body>
</html>
