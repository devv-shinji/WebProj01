<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한글깨짐 방지 처리
request.setCharacterEncoding("UTF-8");

//회원가입 폼값 전송받기
String id = request.getParameter("id");
String name = request.getParameter("name");
String pass = request.getParameter("pass1");
String phone_number = request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
	//전화번호 입력 안 했을 시 빈값으로 변경 처리 
	if(phone_number.equals("--")) {
		phone_number = "";
	}
String cell_number = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
String email = request.getParameter("email_1")+"@"+request.getParameter("email_2");
String subs; 
	//이메일 수신 동의 안할 시 N, 동의에 체크 시 Y
	if(request.getParameterValues("open_email") == null) subs = "N";
	else subs = "Y";
String address = 
	request.getParameter("zip1")+" "+request.getParameter("addr1")+" "+request.getParameter("addr2");
String uflag = request.getParameter("uflag");


//폼값을 DTO객체에 저장
MemberDTO dto = new MemberDTO();

dto.setId(id);
dto.setName(name);
dto.setPass(pass);
dto.setPhone_number(phone_number);
dto.setCell_number(cell_number);
dto.setEmail(email);
dto.setSubs(subs);
dto.setAddress(address);
dto.setUflag(uflag);

//DAO객체 생성 시 application 내장객체를 인자로 전달하여 DB연결
MemberDAO dao = new MemberDAO(application);
int affected = dao.insertMember(dto);


//회원가입에 성공했을 때
if(affected==1) {
	// Map 컬렉션에 회원정보 저장 후 반환받기
	Map<String, String> memberInfo = dao.getMemberMap(id, pass);
	//저장된 값이 있다면... 세션영역의 아이디, 패스워드, 이름, 회원권한 플래그를 속성으로 저장한다.
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_PW", memberInfo.get("pass"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	session.setAttribute("USER_UFLAG", memberInfo.get("uflag"));
	
	//회원가입 후 자동로그인 처리 후 메인페이지로 이동
	response.sendRedirect("../main/main.jsp");

} else {
%>
	<script>
		alert("회원가입에 실패하였습니다.");
		history.go(-1);
	</script>
<% } %>




