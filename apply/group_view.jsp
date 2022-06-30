<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
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
		String userid = (String)session.getAttribute("userid");
		String username = (String)session.getAttribute("username");
		// 회원 관련 객체 
        String us_pn    = "";
        String us_id    = "";
		String us_Id    = "";
		String jo_ti    = "";
		String jo_con   = "";
		String image    = "";
		String jo_mt    = "";
		String jo_fd    = ""; 
        String jo_sd    = "";
		String jo_da    = ""; 
		String jo_num   = "";
        String jo_fi    = "";
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
        	
			String sql = "select * from join_ where JO_NUM = " + num;
        	
			// 사용자 회원정보 추출  
			
            
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			//pstmt.setString(1, userId);
			// 등록된 게시물인 경우
			if (rs.next()) {
				us_Id     = rs.getString("US_ID");
				jo_ti     = rs.getString("JO_TI");
				jo_con    = rs.getString("JO_CON");
				image     = rs.getString("JO_IR");
				jo_mt     = rs.getString("JO_MT");
				jo_fd     = rs.getString("JO_FD");
                jo_sd     = rs.getString("JO_SD");
				jo_da     = rs.getString("JO_DA");
                jo_fi     = rs.getString("JO_FI");
				String[] post = jo_con.split("/");
                if (jo_sd == null){
            %>
            <div>
                <div id="title">
                    <span>
                        <b> [<%= jo_fd%>]<%= jo_ti %> </b>
                    </span> 
                    <span id="info">
                        닉네임: <%= us_Id %>
                        |
                        대면/비대면: <%= jo_mt %>
                        |
                        날짜: <%= jo_da %>
                    </span>
                </div>
            </div>
            <br>
            <div id="container">
            	   <img src="../uploaded/post_image/<%= image %>">
                <div id="content" style="margin-top: 20px;">
            	   <br><br>
				   신청 내역이 없습니다..
                </div>
                <br><br>
            </div>
            <%
                }
                else if (jo_sd.equals("신청")){
				%>
            <div>
                <div id="title">
                    <span>
                        <b> [<%= jo_fd%>]<%= jo_ti %> </b>
                    </span> 
                    <span id="info">
                        닉네임: <%= us_Id %>
                        |
                        대면/비대면: <%= jo_mt %>
                        |
                        날짜: <%= jo_da %>
                    </span>
                </div>
            </div>
            <br>
            <div id="container" style="height: 500px;">
            	   <img src="../uploaded/post_image/<%= image %>">
                <div id="content" style="margin-top: 20px;">
            	   <br><br>
                   <%=post[0]%>
                   <%
                   if (us_Id.equals(userid)){
                    %>
                   <br><br>
                   신청 회원 명단: 
                   <%
                   }
                   for (int i = 1; i < post.length; i++){
                    
                        // 명단을 열람한 유저가 작성자일 경우 신청 회원들의 전화번호 공개
                        if (us_Id.equals(userid)){
                            %>
                                &nbsp;<%=post[i] %>
                            <%
                            sql = "select * from user";
                            pstmt = con.prepareStatement(sql);
                            rs2 = pstmt.executeQuery();
                            while (rs2.next()){
                                us_id = rs2.getString("US_ID");
                                us_pn = rs2.getString("US_PN");
                                if (us_id.equals(post[i])){
                            
                                    %>
                                    (<%=us_pn %>),&nbsp;
                                    <%
                                }
                            }
                        }
                        else{
                            %>
                            &nbsp;
                            <%
                        }
                   } %>
                </div>
                <br><br>
            
            </div> 
			    <%	 
                }
                else if (jo_sd.equals("매칭")){
                    sql = "select * from user";
                    pstmt = con.prepareStatement(sql);
                    rs2 = pstmt.executeQuery();
                    
                    %>
            <div>
                <div id="title">
                    <span>
                        <b> <%= jo_ti %> </b>
                    </span> 
                    <span id="info">
                        분류: <%= jo_fi %>
                        |
                        대면/비대면: <%= jo_mt %>
                        |
                        날짜: <%= jo_da %>
                    </span>
                </div>
            </div>
            <br>
            <div id="container" style="height: 200px;">
                <div id="content" style="margin-top: 20px;">
                   <br><br>
                   매칭 회원 명단: 
				   <%
                        for (int i = 0; i < post.length; i++){
                    %>
                       &nbsp;<%=post[i] %>(
                       <%
                            while (rs2.next()){
                                us_id = rs2.getString("US_ID");
                                us_pn = rs2.getString("US_PN");
                                if (us_id.equals(post[i])){
                            %>
                                    <%=us_pn %>
                            <%
                                }
                            }
                        }
                 %>
                ),&nbsp;&nbsp;
                </div>
                <br><br>
            
            </div> 
			    <%	 
                }
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
            <input type="button" value="목록" class="btn1" style="cursor: pointer;" onclick="location.href='apply_check.jsp';">
            
</body>
</html>
