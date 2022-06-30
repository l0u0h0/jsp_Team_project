<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        String userid = (String)session.getAttribute("userid");
        String username = (String)session.getAttribute("username");
    %>
    <meta charset="UTF-8">
    <title>그루, GROW</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
    <link rel="stylesheet" href="../css/apply_check.css">
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
        <div id="commu_text3" style="cursor: pointer;"onclick="location.href='../apply/apply_check.jsp';"> &nbsp;- &nbsp;신청 내역 </div>
        <div id="commu_text4" style="cursor: pointer;"onclick="location.href='../apply/apply.jsp';"> &nbsp;- &nbsp;내 신청서 </div> </b>
        <br><br><br>
    </div>


        <h3 class="write"> 신청 내역 </h3>
        <% request.setCharacterEncoding("utf-8"); %>
		<%
        String jo_ti = "";
        String jo_con = "";
        Boolean check = false;
		Connection con = null;
	    PreparedStatement pstmt = null;
	    String driverName = "org.gjt.mm.mysql.Driver";
	    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
	    String sql = "select * from join_";
        int rowCount = 0;
		try {

			
	    	ResultSet result = null;

			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "kbc0924");
			pstmt = con.prepareStatement(sql);
			result =  pstmt.executeQuery();
	    
		%>

		<div class="board_list_wrap">
            <form>
            <table class="board_list">
                <caption>게시판 목록</caption>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
					<%
						while(result.next()) {
                            jo_con = result.getString("JO_CON");
                            String[] us_id = jo_con.split("/");
                            check = false;
                            jo_ti = "신청";
                            for (int i = 0; i < us_id.length; i++){
                                if (userid.equals(us_id[i])){
                                    check = true;
                                    rowCount++;
                                    if (result.getString("JO_SD").equals(jo_ti)){
                                        jo_ti = "[신청]" + result.getString("JO_TI");
                                    }
                                    else {
                                        jo_ti = result.getString("JO_TI");
                                    }
                                    break;
                                }
                            }
                            if (check){
					%>
					<tr>
                        <td><%=result.getInt("JO_NUM") %></td>
                        <td class="tit">
                            <a href="group_view.jsp?JO_NUM=<%= result.getString("JO_NUM")%>"> <%=jo_ti %> </a>
                        </td>
                        <td> <%=result.getString("US_ID")%> </td>
                        <td><%=result.getDate("JO_DA")%></td>
                    </tr>
					<% 
                            }
						}
                        if (rowCount == 0) {
                            %>
                            <tr>
                                <td colspan="4"> 신청/매칭 그룹 내역이 존재하지 않습니다..</td> 
                            </tr>
                            <%
                        }
						result.close();   
						}
						catch(Exception e) {
					    	out.println("문제가 있습니다. <hr>");
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
            <br>
           

            <div class="paging">
                <a href="#" class="bt">첫 페이지</a>
                <a href="#" class="bt">이전 페이지</a>
                <a href="#" class="num on">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="bt">다음 페이지</a>
                <a href="#" class="bt">마지막 페이지</a>
            </div>
        </div>
 </form>
</body>
</html>