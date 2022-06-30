<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="content-Type" content="text/html; charset= UTF-8">
		<title>그루, GROW 모집게시판</title>
		<link rel="stylesheet" href="../css/gathering.css">
		<link rel="stylesheet" type="text/css" href=".../css/main.css">
		<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
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

		<div style="text-align: center; padding-top: 30px;">
		<form action="gathering_search.jsp" method="post">
			<span class='green_window'>
				<input type='text' class='input_text' name="search" placeholder="검색어를 입력하세요." />
			</span>
			<button type='submit' class='sch_smit'>검색</button><br><br>
		</form>
		</div>
		<% request.setCharacterEncoding("utf-8"); %>
		<%

		Connection con = null;
	    	PreparedStatement pstmt = null;
	    	String driverName = "org.gjt.mm.mysql.Driver";
	    	String dbURL = "jdbc:mysql://localhost:3306/mysql29";
	    	String sql = "select * from join_ where JO_FI is null";

		try {

			
	    	ResultSet result = null;

			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "kbc0924");
			pstmt = con.prepareStatement(sql);
			result =  pstmt.executeQuery();
	    
		%>

		<div class="container">

			<table class="table table-hover" style="font-size: 17px;"><br><br>
				<thead>
					
						<tr>
							<th > 번호</th>
							<th > 제목 </th>
							<th > 작성자 </th>
							<th > 날짜</th>
							<th > 조회수 </th>
						</tr>
					
				</thead>
				<tbody>
					<%
						while(result.next()) {

					%>
					<tr>
						<td ><%= result.getInt("JO_NUM")%></td>
						<td class="tit">
						<a href="View.jsp?JO_NUM=<%= result.getString("JO_NUM")%>">
                            [<%=result.getString("JO_FD")%>]<%= result.getString("JO_TI") %>
						</a>
                        </td>
						<td > <%= result.getString("US_ID") %> </td>
						<td > <%= result.getString("JO_DA") %> </td>
						<td > <%= result.getInt("JO_VI")%> </td>
					</tr>
					<% 
						}
						result.close();   
						}
						catch(Exception e) {
					    	out.println("MySql 데이터베이스 조회에 문제가 있습니다. <hr>");
					        out.println(e.toString());
					        e.printStackTrace();
					    }
					    finally {
					        if(pstmt != null) pstmt.close();
					        if(con != null) con.close();
			    		}
					%>
						
			    </tbody>
			</table>
			<hr/>
			<!--<a class="btn btn-default pull-right">글쓰기</a>-->
			<section style="padding-top: 40px; text-align: right;">
				
					<a href="../user/write.html"><button class="next"> 글쓰기 </button></a>
			</section>
			
			<div class="text-center">
				<ul class="pagination">
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li><br><br><br><br><br>
				</ul>
			</div>
		</div><br><br><br>


		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
    </body>
    <footer>
    	Made by 
    </footer>
</html>

