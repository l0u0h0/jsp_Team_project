<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
    %>
    <% request.setCharacterEncoding("utf-8"); %>
    <meta charset="UTF-8">
    <title>그루, GROW 스케줄 관리</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
    <link rel="stylesheet" href="../css/apply_check.css">
    <link rel="stylesheet" href="../css/schedule.css">
    <style>
    .next {
	    display: inline-block;
	    width: 120px;
	    height: 35px;
	    border: none;
	    background-color: #77A180;
	    border-radius: 3px;
	    color: #fff; 
	    font-size: 17px;
	    font-weight: bold;
	    position: relative; 
	    font-family: ff; 
    }
    </style>
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
    String jo_no = request.getParameter("JO_NUM");
    String[] sc_con = new String[2];
    String[] sc_da = new String[3];
    int sc_cd = 0;
    Connection con = null;
	PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/mysql29";
	String sql = "select JO_TI from join_ where JO_NUM = '" + jo_no + "'";
    String sql1 = "select * from schedule where PS_NUM = '" + jo_no + "'";

    Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, "root", "kbc0924");
    pstmt = con.prepareStatement(sql);
    ResultSet title = pstmt.executeQuery();
    String group_title = "";
    while (title.next()){
        group_title = title.getString("JO_TI");
    }
    title.close();

    

%>
<%
    java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
    int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
    int currentMonth=cal.get(java.util.Calendar.MONTH);
    int currentDate=cal.get(java.util.Calendar.DATE);
    java.util.Calendar todayCheck_cal = java.util.Calendar.getInstance();
    String Year=request.getParameter("year"); //나타내고자 하는 날짜
    String Month=request.getParameter("month");
    int year, month;
    if(Year == null && Month == null){ //처음 호출했을 때
        year=currentYear;
        month=currentMonth;
    }
    else { //나타내고자 하는 날짜를 숫자로 변환
        year=Integer.parseInt(Year);
        month=Integer.parseInt(Month);
        if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
        if(month>11) { month=0; year=year+1; }
    }
%>

    <h3 class="write" style="font-size: 24pt; align: center;"> [<%=group_title %>] 그룹 스케줄 캘린더</h3><br>
    <input type="button" value="스케줄 등록" class="next" style="cursor: pointer;" onclick="location.href='schedule_write.html?JO_NUM=<%=jo_no%>';">
<!-- 달력 부분 --> 
  <div id="calendar-wrap">
            <header>
                 <h1> <b> <a href="schedule_view.jsp?JO_NUM=<%=jo_no %>&year=<%out.print(year);%>&month=<%out.print(month - 1);%>"><</a> </b> &nbsp;&nbsp;&nbsp;&nbsp;  <% out.print(year); %>, <% out.print(month+1); %>월 &nbsp;&nbsp;&nbsp;&nbsp; <b> <a href="schedule_view.jsp?JO_NUM=<%=jo_no %>&year=<%out.print(year);%>&month=<%out.print(month + 1);%>">> </a></b> </h1>
                 <h4 style="text-align: right; margin-right: 50px;"><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></h4><br>
                 
            </header> 
            
            <br><br>
            <div id="calendar">
                <ul class="weekdays">
                    <li>Sunday</li>
                    <li>Monday</li>
                    <li>Tuesday</li>
                    <li>Wednesday</li>
                    <li>Thursday</li>
                    <li>Friday</li>
                    <li>Saturday</li>
                </ul>
                <!-- Days from previous month -->
<%
    cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
    int startDay = cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
    int end = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
    int weekSize = cal.getActualMaximum(java.util.Calendar.WEEK_OF_MONTH);
    int day = cal.get(java.util.Calendar.DATE);
    int check = 1;
    int end_check = 1;
    int last = 0;
    for (int i = 0; i < weekSize; i++){
        out.println("<ul class='days'>");
        for (int j = 1; j < 8; j++){
            if (startDay > check){
                out.println("<li class='day other-month'>");
                check++;
            }
            else if (end >= day){
                out.println("<li class='day'>");
                out.println("<div class='date'>"+day+"</div>");
                pstmt1 = con.prepareStatement(sql1);
                ResultSet schedule = pstmt1.executeQuery();
                while (schedule.next()){
                    sc_con = schedule.getString("SC_CT").split("/");
                    sc_da = schedule.getString("SC_DA").split("-");
                    sc_cd = schedule.getInt("SC_CD");
                    if (year == Integer.parseInt(sc_da[0]) && (month + 1) == Integer.parseInt(sc_da[1]) && day == Integer.parseInt(sc_da[2])){
                        out.println("<div class='event'>");
                        out.println("<div class='event-desc'>" + sc_con[0] + "</div>");
                        out.println("<div class='event-time'>" + sc_con[1] + "</div>");
                        out.println("</div>");
                    }
                }
                if (todayCheck_cal.equals(cal)){
                    out.println("<center><b>today</b></center>");
                }
                cal.set(java.util.Calendar.DATE, ++day);
                
                end_check++;
            }
            else if (end < end_check){
                out.println("<li class='day other-month'>");
                check++;
            }
            out.println("</li>");
        }
        out.println("</ui>");
        
    }
%>
                
            </div><!-- /. calendar -->
        </div><!-- /. wrap -->
 </body>
</html>
</body>
</html>

