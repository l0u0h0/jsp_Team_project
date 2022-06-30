<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="content-Type" content="text/html; charset= UTF-8">
		<title>그루, GROW 자료 관리</title>
		<link rel="stylesheet" href="../css/gathering.css">
		<link rel="stylesheet" href="../css/apply_check.css">
		<link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
		<!--<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> -->
		
	</head>

	<body>
    <header>
			<a href="main.jsp"><img src="../image/logo.png"></a>
		</header>
        <%
            String userid = (String)session.getAttribute("userid");
            String username = (String)session.getAttribute("username");
        %>

        <%
            if (userid == null && username == null){
        %>
        <script>
            alert("로그인 후 이용해주시기 바랍니다.");
            document.location.href='../main/main.jsp';
        </script>
        <%
            }
        %>

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
	<h3 class="write"> 그룹 내역 </h3>
		<% request.setCharacterEncoding("utf-8"); %>
		<%
        String jo_con = "";
        int jo_no = 0;
		Connection con = null;
	    PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
	    String driverName = "org.gjt.mm.mysql.Driver";
	    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
	    String sql = "select * from join_";
        String sql1 = "select * from data where PS_NUM = " + jo_no;

		try {

			int check = 0;
	    	ResultSet result = null;
            ResultSet result1 = null;

			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "kbc0924");
			pstmt = con.prepareStatement(sql);
			result =  pstmt.executeQuery();
            while (result.next()){
                jo_con = result.getString("JO_CON");
                String [] list = jo_con.split("/");
                for (int i = 0; i < list.length; i++){
                    if (userid.equals(list[i])){
                        jo_no = result.getInt("JO_NUM");
                        pstmt1 = con.prepareStatement(sql1);
                        result1 = pstmt1.executeQuery();
                        while (result1.next()){
                            check++;
%>
            <div class="board_list_wrap">
			    <table class="board_list" style="font-size: 17px;"><br><br>
				    <thead>
						<tr>
							<th > 그룹번호</th>
							<th > 제목 </th>
							<th > 작성자 </th>
						</tr>
					
				</thead>
				<tbody>
					<tr>
						<td ><%= result1.getInt("PS_NUM")%></td>
						<td class="tit">
						<a href="data_view.jsp?DA_NUM=<%= result1.getInt("DA_CD")%>">
                            <%= result.getString("DA_TI") %>
						</a>
                        </td>
						<td > <%= result.getString("US_ID") %> </td>
					</tr>
					<% 
                        }
                    }
                }
            }
            if (check == 0){
%>
            <div class="board_list_wrap">
			    <table class="board_list" style="font-size: 17px;"><br><br>
				    <thead>
						<tr>
							<th > 그룹번호</th>
							<th > 제목 </th>
							<th > 작성자 </th>
						</tr>
					
				</thead>
				<tbody>
					<tr>
                        <td colspan="3"> 업로드 된 파일 내역이 존재하지 않습니다..</td> 
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
			<section style="padding-top: 40px; text-align: right;">
				
					<a href="../manage/uploadfile.html"><button class="next"> 업로드 </button></a>
			</section>
			
		</div><br><br><br>


		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
    </body>
    <footer>
    	Made by 
    </footer>
</html>

