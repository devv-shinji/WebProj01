<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
	$(function() {
		$('#idFindBtn1').click(function () {
			/* 이름과 이메일란이 빈값이면 */
			if($('#idFindName').val()=="" || $('#idFindEmail').val()==""){
				alert('이름과 이메일을 모두 입력해주세요.');
			}
			else {
				$.ajax({
					url : "id_pwFind.jsp",
					dataType : "html",
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					data : {
						user_id : "1",
						user_name : $("#idFindName").val(),
						user_email : $("#idFindEmail").val()
					},
					success : sucFunc,
					error : errFunc
				});
			}
		});
	});
	
	function sucFunc(resData) {
		$("#modal-here").html(resData);
		$("#myModal").modal('show');
	}
	function errFunc() {
		System.out.println("에러발생");
	}

</script>

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
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				
				<div class="idpw_box">
					<!-- 아이디 찾기 -->
					<div class="id_box">
						<ul>
							<li><input type="text" id="idFindName" name="" value="" class="login_input01" /></li> <!-- 이름 -->
							<li><input type="text" id="idFindEmail" name="" value="" class="login_input01" /></li> <!-- 이메일 -->
						</ul>
						<a href="" id="idFindBtn1"><img src="../images/member/id_btn01.gif" class="id_btn" /></a> <!-- 확인버튼 -->
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a> <!-- 회원가입 -->
					</div>
					<!-- 비밀번호 찾기 -->
					<div class="pw_box">
						<ul>
							<li><input type="text" name="" value="" class="login_input01" /></li> <!-- 아이디 -->
							<li><input type="text" name="" value="" class="login_input01" /></li> <!-- 이름 -->
							<li><input type="text" name="" value="" class="login_input01" /></li> <!-- 이메일 -->
						</ul>
						<a href="" id="idFindBtn2"><img src="../images/member/id_btn01.gif" class="pw_btn" /></a> <!-- 확인버튼 -->
					</div>
				</div>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<!------------------ Bootstrap 모달창 영역 START ------------------->
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
	    	<div class="modal-content">
	    
		      	<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">아이디/비밀번호 찾기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<div id="modal-here">
					
					</div>
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
				  <button type="button" class="btn btn-danger" data-dismiss="modal">닫 기</button>
				</div>
		  
			</div>
		</div>
	</div>
		
	</center>
 </body>
</html>
