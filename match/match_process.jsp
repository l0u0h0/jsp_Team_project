<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.ResultSet" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
    <title> 그루, GROW </title>
    <link rel="stylesheet" href="../css/gather.css">
    <!--
        성향 번호 별 의미
        1. 열정적인
        2. 성실한
        3. 리더적인
        4. 시간약속 잘 지키는
        5. 잘 따르는
        6. 응답이 빠른
    -->
</head>
<body>
<%
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
%>
<%
    String age = "";
    String us_cl = "";
    String meeting = "";
    String gender = "";
    String time = "";
    int num = 0;
    String my_ten = "";
    String other_ten = "";
    // 현재 로그인 중인 사용자의 매칭 정보
    String agelist = "";
    String genderlist = "";
    String timelist = "";
    int numlist = 0;
    String my_tenlist = "";
    String other_tenlist = "";
    // DB에 담긴 사용자들의 매칭 정보
    Connection con = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt3 = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql29";
    String sql = "select user.US_AG, user.US_CL, user.US_MT, user.US_GE, user.US_TM, user.US_WN, user_tendency.US_MY, user_tendency.US_OT from user left join user_tendency on user.US_ID = user_tendency.US_ID where user.US_ID = '" + userid + "'";
    int rowCount = 0;
    String[] list = new String[10];
    int i = 0;
    try {
        // 현재 정보 받아오기 시작
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();
        while (result.next()) {
            age = result.getString(1);
            us_cl = result.getString(2);
            meeting = result.getString(3);
            gender = result.getString(4);
            time = result.getString(5);
            num = result.getInt(6);
            my_ten = result.getString(7);
            other_ten = result.getString(8);
        }
        result.close();
        // 여기까지 현재 사용자의 매칭 정보 받아오기

        // DB에서 매칭 정보에 대해 조회 시작
        String sql1 = "select user.US_ID, user.US_AG, user.US_GE, user.US_TM, user.US_WN, user_tendency.US_MY, user_tendency.US_OT from user left join user_tendency on user.US_ID = user_tendency.US_ID where user.US_CL = '" + us_cl + "' AND user.US_MT = '" + meeting + "'";
        pstmt1 = con.prepareStatement(sql1);
        ResultSet result1 = pstmt1.executeQuery();

        while (result1.next()){
            agelist = result1.getString(2);
            genderlist = result1.getString(3);
            timelist = result1.getString(4);
            numlist = result1.getInt(5);
            my_tenlist = result1.getString(6);
            other_tenlist = result1.getString(7);
            // DB내에 존재하는 회원들의 정보를 보관할 변수

            // 3가지 이상의 항목 일치 검사를 위한 if문
            if (agelist.equals(age)){
                if (genderlist.equals(gender)){
                    if (timelist.equals(time)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (numlist == num){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
                else if (timelist.equals(time)){
                    if (numlist == num){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
                else if (numlist == num){
                    if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
            }
            else if (genderlist.equals(gender)){
                if (timelist.equals(time)){
                    if (numlist == num){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
                else if (numlist == num){
                    if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
                else if (my_tenlist.equals(other_ten)){
                    if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
            }
            else if (timelist.equals(time)){
                if (numlist == num){
                    if (my_tenlist.equals(other_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                    else if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
                else if (my_tenlist.equals(other_ten)){
                    if (other_tenlist.equals(my_ten)){
                        list[i] = result1.getString(1);
                        i++;
                        rowCount++;
                    }
                }
            }
            else if (numlist == num){
                if (my_tenlist.equals(other_ten)){
                    if (other_tenlist.equals(my_ten)){
                    list[i] = result1.getString(1);
                    i++;
                    rowCount++;
                    }
                }
            }
            
            // rowCount가 원하는 인원 수보다 하나 더 크면 탐색 종료
            // 부합하는 모든 데이터 조회가 끝나도 탐색 종료
            if (rowCount == (num + 1)){
                break;
            }
        }
        result1.close();
        // 여기까지 DB에 담긴 매칭된 사용자 id 배열에 담기


        // 조회된 정보로 매칭 결성하기 시작
        if (rowCount > 1 && (rowCount == (num + 1) || (rowCount == num - 1) || (rowCount == num))){
            // 원하는 인원 수와 오차범위 1 내에 인원 수가 조회 되면 매칭 결성 시작
            // 이 때 rowCount는 2 이상의 수여야 함.
            PreparedStatement pstmt2 = null;
            StringBuffer SQL = new StringBuffer("insert into join_(JO_TI, JO_MT, JO_CON, JO_DA, JO_FD, JO_FI, JO_SD, US_ID) "); 
            SQL.append("values(?, ?, ?, CURDATE(), ?, ?, ?, ?)");
            pstmt2 = con.prepareStatement(SQL.toString());
            // 제목 지정
            String matchtitle = "[매칭] " + username + "님의 그룹";
            // 대면/비대면 타입 지정
            if (meeting.equals("1")){
                meeting = "대면";
            }
            else if (meeting.equals("2")){
                meeting = "비대면";
            }
            // 매칭 결성된 회원들 아이디 저장
            String jo_con = "";
            for (int k = 0; k < rowCount; k++){
                jo_con += list[k] + "/";
                
            }
            // US_CL에서 /구분자를 사용해 받았던 스터디/튜터링 과 분류에 대한 정보 나누기
            String[] fd = us_cl.split("/");
            // 스터디 튜터링 구분
            String jo_fd = "";
            if (fd[0].equals("s")){
                jo_fd = "스터디";
            }
            else if (fd[0].equals("t")){
                jo_fd = "튜터링";
            }
            // 분류 구분
            String jo_fi = "";
            if (fd[1].equals("toeic")){
                jo_fi = "토익";
            }
            else if (fd[1].equals("info_pro")){
                jo_fi = "정보처리기사";
            }
            else if (fd[1].equals("ko_his")){
                jo_fi = "한국사능력검정";
            }
            else if (fd[1].equals("opic")){
                jo_fi = "오픽";
            }
            else if (fd[1].equals("in_view")){
                jo_fi = "면접";
            }
            else if (fd[1].equals("com_1")){
                jo_fi = "컴활1급";
            }
            // 결성된 그룹에 대한 (매칭/신청) 구분
            String info = "매칭";
            pstmt2.setString(1, matchtitle);
            pstmt2.setString(2, meeting);
            pstmt2.setString(3, jo_con);
            pstmt2.setString(4, jo_fd);
            pstmt2.setString(5, jo_fi);
            pstmt2.setString(6, info);
            pstmt2.setString(7, userid);
        
            int result2 = pstmt2.executeUpdate();
            if (result2 == 1){
            %>
                <script>alert("매칭에 성공하셨습니다.");</script>
            <%
            // 매칭이 완료된 사용자들에게 새 매칭이 있다는 정보 업데이트
                for (int m = 0; m < list.length; m++){
                    if (list[m] == null){
                        break;
                    }
                    StringBuffer SQL1 = new StringBuffer("update user set US_NT = ? where US_ID = '" + list[m] + "'");
                    pstmt3 = con.prepareStatement(SQL1.toString());
                    int notice = 1;
                    int no_notice = 0;
                    // 로그인 된 사용자와 같다면 0 입력
                    if (list[m].equals(userid)){
                        pstmt3.setInt(1, no_notice);
                        pstmt3.executeUpdate();
                    }
                    // 로그인 된 사용자가 아니라면 1 입력
                    else {
                        pstmt3.setInt(1, notice);
                        pstmt3.executeUpdate();
                    }
                }

            }else if (result2 != 1) {
            %>
                <script>alert("매칭에 문제가 있습니다.");</script>
            <%
            }
        }
        // 매칭 결성에 대한 부분 종료
        else{
            %>
                <script>alert("매칭에 실패하였습니다.");</script>
            <%
        }
        // 오차범위 내에 인원이 조회되지 않았을 경우 매칭 실패
    }
    catch(Exception e) {
    	    out.println("조회에 문제가 있습니다. <hr>");
            out.println(e.toString());
            e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    out.println("<meta http-equiv='Refresh' content='1;URL=../main/main.jsp'>");
    %>
</body>
</html>
