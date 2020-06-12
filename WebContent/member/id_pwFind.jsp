<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 아이디/비번 찾기 인풋값 파라미터 전송 받기
String id = request.getParameter("user_id");
String name = request.getParameter("user_name");
String email = request.getParameter("user_email");

System.out.println(id+name+email);

//DAO객체 생성 시 application 내장객체를 인자로 전달하여 DB연결
MemberDAO dao = new MemberDAO(application);
String resStr = "";


//비밀번호 찾기
if (id.equals("1")) {
	String userId = dao.findUserIDPW(id, name, email);
	resStr = "<h3>회원님의 아이디는 "+ userId +"입니다.</h3>";
	out.println(resStr);
}
else {
	String userPw = dao.findUserIDPW(id, name, email);
	resStr = "<h3>회원님의 비밀번호는 "+ userPw +"입니다.</h3>";
	out.println(resStr);
} 
%>