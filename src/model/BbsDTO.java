package model;

public class BbsDTO {
	/*
	DTO객체를 만들 때 테이블 컬럼의 타입과는 상관없이 대부분의 멤버변수는 String형으로 정의하면 된다. 
	JSP에서 산술연산이 꼭 필요한 경우에만 int, double과 같이 숫자형으로 정의한다.
	간단한 연산은 오라클이 할 일이다~ ex) visitcount+1
	 */
	
	//멤버변수
	private String idx;		//게시판의 일련번호
	private String id;	//제목
	private String title;	//내용
	private String content;		//작성자 아이디(member테이블 참조)
	private java.sql.Date post_date; //작성일
	private String o_file; //조회수
	private String s_file; //조회수
	private String downcount; //조회수
	private String visitcount; //조회수
	private String bflag; //조회수
	//멤버변수 추가: board와 member테이블의 join을 위해 name컬럼 추가
	private String name;
	
	
	//getter/setter
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getPost_date() {
		return post_date;
	}
	public void setPost_date(java.sql.Date post_date) {
		this.post_date = post_date;
	}
	public String getO_file() {
		return o_file;
	}
	public void setO_file(String o_file) {
		this.o_file = o_file;
	}
	public String getS_file() {
		return s_file;
	}
	public void setS_file(String s_file) {
		this.s_file = s_file;
	}
	public String getDowncount() {
		return downcount;
	}
	public void setDowncount(String downcount) {
		this.downcount = downcount;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getBflag() {
		return bflag;
	}
	public void setBflag(String bflag) {
		this.bflag = bflag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
