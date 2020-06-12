<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<style>
.login_box01{height:185px;}
</style>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				
				<form action="../session/LoginProcess.jsp" method="post" name="loginFrm"
							onsubmit="return loginValidate(this);">
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<!-- 아이디 입력 -->
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" />
						<input type="text" name="user_id" value="" class="login_input01" /></li>
						<!-- 비밀번호 입력 -->
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" />
						<input type="password" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					<input type="image" src="../images/login_btn.gif" class="login_btn01" />
					<!-- <a href=""><img src="../images/login_btn.gif" class="login_btn01" /></a> -->
				</div>
				</form>
				
				<!-- 로그인 시 빈값 체크 -->
				<script>
					function loginValidate(fn) {
						if (!fn.user_id.value) {
							alert("아이디를 입력하세요");
							fn.user_id.focus();
							return false;
						}
						if (fn.user_pw.value == "") {
							alert("패스워드를 입력하세요");
							fn.user_pw.focus();
							return false;
						}
					}
				</script>
				
				<p style="text-align:center; margin-bottom:50px;"><a href="./id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;
				<a href="./join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
