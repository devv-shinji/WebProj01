<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%
/* 페이지 진입 전 회원가입 이용약관 동의여부 체크 */
if(request.getParameterValues("agreement1") == null) {
%>
	<script>
		alert("회원 이용약관에 동의해주세요");
		location.href="join01.jsp";
	</script>
<% } %>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/****** DAUM 주소 api ******/
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                console.log(extraAddr);
	            } 
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample6_postcode').value = data.zonecode;
	            document.getElementById("sample6_address").value = addr + extraAddr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("sample6_detailAddress").focus();
	        }
	    }).open();
	}

	/****** submit 시 폼값 유효성 체크 함수 ******/
	function isValidate(frm) {
		console.log("네 이놈 함수 실행되느냐");
		
		if (frm.name.value=="") {
			alert('이름을 입력하세요.');
            frm.name.focus();
            return false;
		}
		if (frm.id.value=="") {
			alert('아이디를 입력하세요.');
            frm.id.focus();
            return false;
		}
		if (!frm.pass1.value || !frm.pass2.value) {
			alert('비밀번호를 입력하세요.');
            frm.pass1.focus();
            return false;
		}
		if (frm.pass1.value != frm.pass2.value) {
			alert('일치하지 않는 비밀번호입니다.');
			frm.pass2.value = "";
            frm.pass2.focus();
            return false;
		}
		if (frm.mobile1.value=="" || frm.mobile2.value=="" || frm.mobile3.value=="") {
			alert('핸드폰번호를 입력하세요.');
            return false;
		}
		if (!frm.email_1.value || !frm.email_2.value) {
			alert('이메일을 입력하세요.');
            return false;
		}
		/* if (frm.open_email.checked == false) {
			alert('이메일 수신에 동의해주세요.');
            return false;
		} */
		if (!frm.zip1.value || !frm.addr1.value || !frm.addr2.value) {
			alert('주소를 입력하세요.');
            return false;
		}
	}
	
	/****** 아이디 & 비밀번호 유효 패턴 체크 ******/
	function idpwPattern(obj) {
		
		var pattern = /^[A-Za-z0-9+]{4,12}$/; //영 대소문자, 숫자조합의 4~12자리의 정규식 표현

		//틀린 형식으로 입력한 경우
		if(!pattern.test(obj.value)) {
			if(obj.type=="text") { //아이디 입력 시
				obj.value = obj.value.replace(" ",""); //중간공백 지움처리
				$('#idmsg').text('4~12자 이내의 영 대소문자와 숫자조합으로 입력하세요.').css('color', 'red');
				return;
			}
			if(obj.type=="password") { //비밀번호 입력 시
				obj.value = obj.value.replace(" ","");
				$('#pwmsg').text('4~12자 이내의 영 대소문자와 숫자조합으로 입력하세요.').css('color', 'red');
				return;
			}
		}
		//올바르게 입력한 경우
		else {
			if(obj.type=="text") { //아이디 입력 시
				$('#idmsg').text('');
			}
			if(obj.type=="password") { //비밀번호 입력 시
				$('#pwmsg').text('');
			}
		}
	}
	
	
	/*********** 이메일 선택 시 인풋 값 자동입력 ***********/
	function email_input(obj) {
		var obj2 = document.getElementById("email_2");
			
		if(obj.value == "1") {
			obj2.value = "";
			obj2.focus();
			$(obj2).removeAttr("readonly");
		}
		else {
			obj2.value = obj.value;
		}
	}
	
	/*********** 아이디 중복확인 버튼(Modal 창 활용) ***********/
	$(function () {
		$("#duplCheck").click(function () {
			
			//입력된 아이디가 없을 경우
			if($("#id").val()=="") {
				alert("아이디를 입력해주세요.");
				$("#id").focus();
			}
			//입력값 있을 경우 -> 아이디 중복여부 확인
			else {
				$.ajax({
					url : "JoinIdCheck.jsp",
					dataType : "html",
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					data : {
						user_id : $("#id").val()
					},
					success : sucFunc,
					error : errFunc
				});
			}
		});
		
		/* 모달창 내의 동적 태그로 생성된 엘리먼트의 이벤트 발생 시 */
		// '중복확인' 버튼 클릭 시
		$('#modal-here').on('click', '#idCheck', function() {
			
			if($("#idInput").val()=="") {
				alert("아이디를 입력해주세요.");
				$("#idInput").focus();
			}
			// 아이디 중복여부 확인
			else {
				$.ajax({
					url : "JoinIdCheck.jsp",
					dataType : "html",
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					data : {
						user_id : $("#idInput").val()
					},
					success : sucReFunc,
					error : errFunc
				});
			}
		});
		// '아이디 사용하기' 버튼 클릭 시
		$('#modal-here').on('click', '#idUse', function() {
			
			if($("#idInput").val()=="") {
				alert("아이디를 입력해주세요.");
				$("#idInput").focus();
			}
			else {
				$("#id").val($("#idInput").val());
				$("#myModal").modal('hide');
			}
		});
	});
	
	function sucFunc(resData) {
		$("#modal-here").html(resData);
		$("#myModal").modal('show');
	}
	function sucReFunc(resData) {
		$("#modal-here").html(resData);
	}
	function errFunc() {
		alert("에러가 발생했습니다.");
	}
	
	
</script>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/member/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">
					<%@ include file="../include/member_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입
						<p>
					</div>

					<p class="join_title">
						<img src="../images/join_tit03.gif" alt="회원정보입력" />
					</p>
					
					<!-------------- 정보입력 폼 --------------->
					<form name="regiForm" action="JoinProc.jsp" onsubmit="return isValidate(this);">
					<table cellpadding="0" cellspacing="0" border="0" class="join_box">
						<colgroup>
							<col width="80px;" />
							<col width="*" />
						</colgroup>
						<tr>
							<!-- 이름 입력 -->
							<th><img src="../images/join_tit001.gif" /></th>
							<td><input type="text" name="name" value="" class="join_input"  /></td>
						</tr>
						<tr>
							<!-- 아이디 입력 -->
							<th><img src="../images/join_tit002.gif" /></th>
							<td><input type="text" id="id" name="id" class="join_input" onkeyup="idpwPattern(this);">&nbsp;
  							<!-- 아이디 중복확인 -->
							<!-- <a onclick="id_check_person();" style="cursor: hand;"> -->
							<img src="../images/btn_idcheck.gif" alt="중복확인" id="duplCheck" style="cursor: hand;"/>
							<!-- </a> -->
							&nbsp;&nbsp;
							<span id="idmsg">* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
						</tr>
						<tr>
							<!-- 비밀번호 입력 -->
							<th><img src="../images/join_tit003.gif" /></th>
							<td><input type="password" name="pass1" value="" class="join_input" onkeyup="idpwPattern(this);"/>&nbsp;&nbsp;
							<span id="pwmsg">* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
						</tr>
						<tr>
							<!-- 비밀번호 확인 -->
							<th><img src="../images/join_tit04.gif" /></th>
							<td><input type="password" name="pass2" value="" class="join_input" /></td>
						</tr>


						<tr>
							<th><img src="../images/join_tit06.gif" /></th>
							<td><input type="text" name="tel1" value="" maxlength="3"
								class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
								type="text" name="tel2" value="" maxlength="4"
								class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
								type="text" name="tel3" value="" maxlength="4"
								class="join_input" style="width: 50px;" /></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit07.gif" /></th>
							<td><input type="text" name="mobile1" value="" maxlength="3"
								class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
								type="text" name="mobile2" value="" maxlength="4"
								class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
								type="text" name="mobile3" value="" maxlength="4"
								class="join_input" style="width: 50px;" /></td>
						</tr>
						<tr>
						
						
							<th><img src="../images/join_tit08.gif" /></th>
							<td><input type="text" name="email_1"
								style="width: 100px; height: 20px; border: solid 1px #dadada;"
								value="" /> @ <input type="text" id="email_2" name="email_2"
								style="width: 150px; height: 20px; border: solid 1px #dadada;"
								value="" readonly /> <select name="last_email_check2"
								onChange="email_input(this);" class="pass"
								id="last_email_check2">
									<option selected="" value="">선택해주세요</option>
									<option value="1">직접입력</option>
									<option value="dreamwiz.com">dreamwiz.com</option>
									<option value="empal.com">empal.com</option>
									<option value="empas.com">empas.com</option>
									<option value="freechal.com">freechal.com</option>
									<option value="hanafos.com">hanafos.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="intizen.com">intizen.com</option>
									<option value="korea.com">korea.com</option>
									<option value="kornet.net">kornet.net</option>
									<option value="msn.co.kr">msn.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="naver.com">naver.com</option>
									<option value="netian.com">netian.com</option>
									<option value="orgio.co.kr">orgio.co.kr</option>
									<option value="paran.com">paran.com</option>
									<option value="sayclub.com">sayclub.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="yahoo.com">yahoo.com</option>
							</select> <label><input type="checkbox" name="open_email" value="1"> <span>이메일 수신동의</span></label></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit09.gif" /></th>
							<td>
							<input type="text" id="sample6_postcode" name="zip1" value="" class="join_input" style="width: 100px;" placeholder="우편번호" />
							<a href="javascript:sample6_execDaumPostcode();" title="새 창으로 열림">[우편번호검색]</a> <br />
							<input type="text" id=sample6_address name="addr1" value="" class="join_input" style="width: 550px; margin-top: 5px;" placeholder="도로명주소" />
							<br>
							<input type="text" id="sample6_detailAddress" name="addr2" value="" class="join_input" style="width: 550px; margin-top: 5px;" placeholder="상세주소"/>
							</td>
						</tr>
						<input type="hidden" name="uflag" value="member"/>
						
						<!-- <input type="hidden" id="sample6_extraAddress" value=""/> -->
					</table>

					<p style="text-align: center; margin-bottom: 20px">
						<!-- 확인버튼 -->
						<input type="image" src="../images/btn01.gif" />
						
						&nbsp;&nbsp; 
						<a href="javascript:history.go(-1);"><img src="../images/btn02.gif" /></a>
						<!-- 취소버튼 -->
					</p>
					</form>
					<!----------------- 정보입력 폼 끝 -------------------->

				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>
		<%@ include file="../include/footer.jsp"%>
		
		
		<!------------------ Bootstrap 모달창 영역 START ------------------->
		<!-- The Modal -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
		    	<div class="modal-content">
		    
			      	<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">아이디 중복확인</h4>
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
