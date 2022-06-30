<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
        <%
            String userid = (String)session.getAttribute("userid");
            String username = (String)session.getAttribute("username");
        %>
		<meta charset="UTF-8">
		<title>그루, GROW</title>
    <link rel="shortcut icon" type="image/x-icon" href="../image/tree.png">  
		<link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/main2.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	</head>

	<body>
		<header>
			<a href="main.jsp"><img src="../image/logo.png"></a>
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
    if (userid == null){
        %>
		 <div id="loginback">
		 	 <div id="login" style="cursor: pointer;"onclick="location.href='../user/login.html';">
		 		<b> 그루 LOGIN </b>
		 		<br>
         	 </div>
         	  <div class="find">
         	  	<ul>
         	  		<li style="cursor: pointer;"onclick="location.href='../user/find_id.html';"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 아이디 </li> &nbsp;·&nbsp;
         	  		<li style="cursor: pointer;"onclick="location.href='../user/find_pw.html';"> 비밀번호찾기 </li>
         	  		<li style="cursor: pointer;"onclick="location.href='../user/gather.html';"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 회원가입 </li>
         	  	</ul>
         	  </div>
         </div>
    <%
    }else{
        %>
      <div id="loginback">  
    		<p> <b> &nbsp;&nbsp;&nbsp;&nbsp;<%=username %> 님, 반갑습니다.
    		<br> 오늘도 꿈에 한 발자국 더 다가가세요. </b> </p> 
    		<br>
    		<div class="logout">
    			<ul>
    				<li style="cursor: pointer;"onclick="location.href='../user/info_edit.jsp';"> 회원 정보 수정 </li>&nbsp;·&nbsp;
    				<li style="cursor: pointer;"onclick="location.href='../user/logout.jsp';"> 로그아웃 </li>
    			</ul>


    		</div>
    	</div>
        <%
    }
    %>
         <div class="page-wrapper" style="position: relative; background-color: black;">
          <div class="post-slider">
            <i class="fas fa-chevron-left prev"></i>  
            <i class="fas fa-chevron-right next"></i>   
            <div class="post-wrapper">
              <div class="post">
                  <img src="../image/toeic.png" class="slider-image" style="cursor: pointer;"onclick="location.href='https://www.toeic.co.kr/';">
                  <div class="post-info">
                    <h4 class="post-subject"> TOEIC </h4> <br>
                    <p class="far fa-user" style="height:10%;"> <b>제437회</b> <br><br> 시험일자: 2021.06.27(일) <br> 성적 발표: 2021.07.07.(수) 
                    </p>
                  </div>
                </div>

              <div class="post">
                  <img src="../image/engineer.png" class="slider-image" style="cursor: pointer;"onclick="location.href='http://www.q-net.or.kr/crf005.do?id=crf00505&gSite=Q&gId=&jmCd=1320&examInstiCd=1';">
                  <div class="post-info">
                    <h4 class="post-subject"> 정보처리기사 </h4> <br>
                    <p class="far fa-user" style="height:5%; top: 10px;"> <b> 2021 정기 기사 2회 </b> <br><br> 실기시험: 2021.07.10.(토) ~ 2021.07.24.(토) <br> 합격자 발표: 2021.08.06.(금) ~ 2021.10.06.(수)</p>
                  </div>
                </div>

                <div class="post" style="cursor: pointer;"onclick="location.href='http://www.historyexam.go.kr/main/mainPage.do?netfunnel_key=956E81429C3A560943C3FFEFD1F0FA15253D2CE63F77D922D4732F625B9071B984CE77310B197E2B0A17D79AE22538BA00B41DA6F63FE51DE48F15A7F9F0A10063E1F450C27EDC58A383109D2FD214595040FF6CCA34DB8A028CF47044B6F18A41B952CC05EFAC3838CBB62ABD326F25302C30';">
                  <img src="../image/history.png" class="slider-image">
                  <div class="post-info">
                    <h4 class="post-subject"> 한국사능력검정 시험 </h4><br>
                    <p class="far fa-user" style="height:10%;"> <b> 한국사능력검정시험 54회 </b> <br><br> 접수: 2021.07.12.(월) ~ 2021.07.16.(금)<br> 시험일자: 2021.08.07.(토) </p>
                  </div>
                </div>

                 <div class="post" class="post" style="cursor: pointer;"onclick="location.href='https://www.opic.or.kr/opics/jsp/senior/index.jsp';">
                  <img src="../image/opic.png" class="slider-image">
                  <div class="post-info">
                    <h4 class="post-subject"> OPIc </h4> <br>
                    <p class="far fa-user" style="height:10%;"> <b> 정기 고사 </b> <br><br>시험일자: 2021.06.17(목) <br> 성적 발표: 2021.06.24(목) </p>
                  </div>
                </div>

              </div>
            </div>
            </div>
          <script src="../js/main.js"></script>



        <footer>
            Made by <b> TEAM E </b>
        </footer>
     </body>
      
</html>

