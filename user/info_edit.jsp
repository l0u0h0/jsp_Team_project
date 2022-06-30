<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>그루, GROW</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
    <link rel="stylesheet" href="../css/info_edit.css">
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
</head>
<body>
    <%@ page import="java.sql.*" %>
    <% request.setCharacterEncoding("utf-8"); %>

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
     <b> <div id="commu_text1"> &nbsp; 마이 페이지 </div> <br>
        <div id="commu_text2" style="cursor: pointer;"onclick="location.href='../user/info_edit.jsp';"> &nbsp;- &nbsp;회원 정보 </div>
        <div id="commu_text3" style="cursor: pointer;"onclick="location.href='../apply/apply_check.jsp';"> &nbsp;- &nbsp;신청 내역 </div>
        <div id="commu_text4" style="cursor: pointer;"onclick="location.href='../apply/apply.jsp';"> &nbsp;- &nbsp;내 신청서 </div> </b>
        <br><br><br>
    </div>

        <div class="container">
        <div class="form-wrap">
            <div class="head">
                <h2> <b> 회원 정보 </b> </h2>
            </div>
            <span> ✓ ID를 제외한 모든 항목을 변경할 수 있습니다. </span> <br><br>


    <% 
        Connection con = null;
        PreparedStatement pstmt = null;
        String driverName = "org.gjt.mm.mysql.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/mysql29";
        String sql = "select * from user where US_ID = '" + userid + "'";
        int rowcount = 0; 

        try {

        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();

        while(result.next()) {
    %>

            <form method="post" action="editOk.jsp">
                 <div class="form-group">
                    <label for="last-name">아이디</label><br>
                    <p> <%=userid %> </p>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label><br>
                    <input type="password" name="password" id="password" value=<%= result.getString("US_PW") %>>
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label><br>
                    <input type="text" name="phone" id="phone" value=<%= result.getString("US_PN") %>>
                </div>
                <div class="form-group">
                    <label for="email">이메일</label><br>
                    <input type="email" name="email" id="email" value=<%= result.getString("US_EM") %>>
                </div>
                <div class="form-group">
                    <label for="name">이름</label><br>
                    <input type="text" name="name" id="name" value=<%= result.getString("US_NA") %>>
                </div>
                <div class="form">
                    <label for="sex">성별</label><br>
                    <%= result.getString("US_GE") %>
                </div> 
                <br><br>
                 <button type="submit" class="btn" onclick="location.href='editOk.jsp'">수정하기</button>
                 <button type="button" class="btn" onclick="location.href='delete.jsp'">탈퇴하기</button>
                 <br><br><br><br><br><br>
            </form>
    </div>
</div>

<%
    rowcount++;
    }
    result.close();
    }
        catch(Exception e) {
        out.println("데이터베이스 회원정보 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
%>
</body>
