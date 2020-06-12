<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
String save_id = request.getParameter("save_id");

String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");

MemberDAO dao = new MemberDAO(drv, url);

/* Map 컬렉션에 회원정보 저장 후 반환받기 */
Map<String, String> memberInfo = dao.getMemberMap(id, pw);
//Map의 id키값에 저장된 값이 있는지 확인
if(memberInfo.get("id")!=null) {
	//저장된 값이 있다면... 세션영역의 아이디, 패스워드, 이름을 속성으로 저장한다.
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_PW", memberInfo.get("pass"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	session.setAttribute("USER_UFLAG", memberInfo.get("uflag"));
	
	/* 아이디 저장에 체크 시 쿠키에  ID 값을 저장 */
	if(save_id == null) { 
		// 아이디저장 안할경우 쿠키를 삭제하기 위해 빈 쿠키를 생성
		Cookie ck = new Cookie("USER_ID", "");
		ck.setPath(request.getContextPath());
		ck.setMaxAge(0); //유효시간이 0이므로 사용할 수 없는 쿠키가 됨
		response.addCookie(ck);
	}
	else {
		// 아이디저장을 원할 경우
		Cookie ck = new Cookie("USER_ID", id);
		ck.setPath(request.getContextPath());
		ck.setMaxAge(60*60*24*100); //100일 동안 유효
		response.addCookie(ck);
	}
	response.sendRedirect("../main/main.jsp");
}
else {
	/* //저장된 값이 없다면... 리퀘스트 영역에 오류메세지를 저장하고 포워드
	request.setAttribute("ERROR_MSG", "회원이 아니시군요");
	request.getRequestDispatcher("../main/main.jsp").forward(request, response); */

%>

	<script>
		alert("로그인에 실패하였습니다.");
		history.go(-1);
	</script>
	
<% } %>