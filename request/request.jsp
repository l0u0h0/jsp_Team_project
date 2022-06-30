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
    <title>그루, GROW</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
    <link rel="stylesheet" href="../css/apply.css">
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
        <h3 class="write"> 내 신청서 목록 </h3>
        <div class="board_list_wrap">
            <form>
            <table class="board_list">
                <caption>게시판 목록</caption>
                <%
                String jo_num = request.getParameter("JO_NUM");
                Connection con = null;
                PreparedStatement pstmt = null;
                String driverName = "org.gjt.mm.mysql.Driver";
                String dbURL = "jdbc:mysql://localhost:3306/mysql29";
                String sql = "select * from user_request where US_ID = '" + userid + "'";
                int count = 0;

                try {
                    Class.forName(driverName);
                    con = DriverManager.getConnection(dbURL, "root", "kbc0924");
                    pstmt = con.prepareStatement(sql);
                    ResultSet result = pstmt.executeQuery();
                %>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>제출</th>
                    </tr>
                </thead>
                <tbody>
                <%
                while (result.next()) {
                %>
                    <tr>
                        <td><%=result.getInt(2)%></td>
                        <td class="tit">
                            <a href="../apply/apply_detail.jsp?no=<%= result.getInt(2)%>"> <%=result.getString(3)%> </a>
                        </td>
                        <td><%=result.getDate(5)%></td>
                        <td><input type="button" value="제출 하기"  style="display: inline;" onclick="location.href='request_submit.jsp?no=<%= result.getInt(2)%>&JO_NUM=<%= jo_num%>';"></td>
                    </tr>
                <%
                    count++;
                }
                if (count == 0){
                %>
                    <tr>
                        <td colspan="4">작성된 신청서 내역이 존재하지 않습니다..</td> 
                    </tr>
                <%
                }
                result.close();        
                }
                catch(Exception e) {
    	            out.println("데이터베이스 조회에 문제가 있습니다. <hr>");
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
        </div>
 </form>
</body>
</html>