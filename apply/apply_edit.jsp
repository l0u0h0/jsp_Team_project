<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
	<head>
		<meta charset="UTF-8">
		<title>그루, GROW</title>
		<link rel="stylesheet" href="../css/apply_write.css">
		<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
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
     <b> <a> <div id="commu_text1"> &nbsp; 마이 페이지 </div> </a> <br>
        <div id="commu_text2" style="cursor: pointer;"onclick="location.href='../user/info_edit.jsp';"> &nbsp;- &nbsp;회원 정보 </div>
        <div id="commu_text3" style="cursor: pointer;"onclick="location.href='apply_check.jsp';"> &nbsp;- &nbsp;신청 내역 </div>
        <div id="commu_text4" style="cursor: pointer;"onclick="location.href='apply.jsp';"> &nbsp;- &nbsp;내 신청서 </div> </b>
        <br><br><br>
    </div>
    <%
    String no = request.getParameter("no");
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    String SQL = "update from user_request where US_ID = '" + userid + "' AND US_RF = '" + no + "'";
    String sql = "select * from user_request where US_ID = '" + userid + "' AND US_RF = '" + no + "'";
	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    pstmt = con.prepareStatement(sql);
    ResultSet result = pstmt.executeQuery();
    String us_ti = "";
    String us_co = "";
    while (result.next()){
        us_ti = result.getString("US_FP");
        us_co = result.getString("US_SP");
    }
    %>
    	<div  align = 'center'>
			<section class="box" align = 'left' style="height: 700px;">
				<form action="apply_editOk.jsp?no=<%=no%>" method="post">
					<h2> 신청서 수정 </h2> <br><br>
				<table width="1000px">
						<tr align="center">
							<td bgcolor="lightgrey" style="font-family:ff; text-align: center;" width="200px" height="60px">
								<b>제목</b> 
							</td>
							<td>
								<input type="text" name="title" size="70px" placeholder="<%=us_ti%>" style="font-size: 20px; font-family: ff; height: 60px; border: 0; background-color: #F0F0F0;" ><br>
							</td>								
						</tr>
						<tr align="center">
							<td bgcolor="lightgrey" style="font-family: ff;" width="200px" style="text-align: center;">
								<b>설명</b><br> &nbsp;&nbsp;&nbsp; 
							</td>
							<td>
								<textarea name="content" cols="70" rows="15" placeholder="<%=us_co%>" style="font-size: 20px; font-family: ff; border: 0; background-color: #F0F0F0;"></textarea>
							</td>								
						</tr>
				</table>


					<script type="text/javascript" src="write.js"></script>
					<input type="submit" value="수정" class="next" style="float: right; margin-left: 3px;">
				</section>
			</form>

	</section>
</div>


</body>
</html>