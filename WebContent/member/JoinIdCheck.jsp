<%@page import="model.MemberDAO"%>
<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한글깨짐 방지 처리
request.setCharacterEncoding("UTF-8");

//중복 체크 할 아이디 값 전송받기
String id = request.getParameter("user_id");
System.out.println(id);

//DAO객체 생성 시 application 내장객체를 인자로 전달하여 DB연결
MemberDAO dao = new MemberDAO(application);

boolean affected = dao.isMember(id);
String resStr = "";

//동일한 아이디가 존재하지 않을 경우
if(affected==false) {
	resStr = "<br><h3>사용할 수 있는 아이디입니다.</h3>";
	resStr += "<input type='text' id='idInput' style='border:1px solid #d2d2d2;' value='"+id+"'></input>";
	resStr += "<button id='idCheck'>중복 확인</button>";
	resStr += "<br><br>";
	resStr += "<button id='idUse'>아이디 사용 하기</button>";
	out.println(resStr);

} 
//동일한 아이디가 존재할 경우
else {
	resStr = "<br><h3>중복되는 아이디가 존재합니다.</h3>";
	resStr += "<p>새로운 아이디를 입력해주세요.</p>";
	resStr += "<input type='text' id='idInput' style='border:1px solid #d2d2d2;'></input>";
	resStr += "<button id='idCheck'>중복 확인</button>";
	out.println(resStr);
}
%>




