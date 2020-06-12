package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;


public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public MemberDAO(String driver, String url) {
		try {
			Class.forName(driver);
			//로컬정보
			/*String id = "suamil_user";
			String pw = "1234";*/
			
			//Cafe24 웹서버정보
			String id = "devvshinji";
			String pw = "devvshinji!!db1";
			con = DriverManager.getConnection(url,id,pw);
			System.out.println("DB연결성공");
		}
		catch (Exception e) {
			System.out.println("DBCP 연결실패");
			e.printStackTrace();
		}
	}
	
	public MemberDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			//로컬정보
			/*String id = "suamil_user";
			String pw = "1234";*/
			
			//Cafe24 웹서버정보
			String id = "devvshinji";
			String pw = "devvshinji!!db1";
			con = DriverManager.getConnection(ctx.getInitParameter("MariaConnectURL"),id,pw);
			System.out.println("DB연결성공");
		}
		catch (Exception e) {
			System.out.println("DBCP 연결실패");
			e.printStackTrace();
		}
	}
	
	public Map<String, String> getMemberMap(String id, String pass) {
		Map<String, String> maps = new HashMap<String, String>();
		String query = "SELECT id, pass, name FROM membership WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
				maps.put("name", rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch (Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		return maps;
	}
	
	//회원가입 처리 메소드
	public int insertMember(MemberDTO dto) {
		//쿼리 업데이트 성공여부 저장 변수 (입력된 행)
		int affected = 0;
		
		try {
			String query = "INSERT INTO membership (id, NAME, PASS, phone_number, cell_number, email, subs, address, uflag) "
					+ "VALUES (?,?,?,?,?,?,?,?,?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPass());
			psmt.setString(4, dto.getPhone_number());
			psmt.setString(5, dto.getCell_number());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getSubs());
			psmt.setString(8, dto.getAddress());
			psmt.setString(9, dto.getUflag());
			
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원가입 멤버 insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	//방법1: 회원의 존재유무만 판단한다.
	public boolean isMember(String id) {
		String sql = "SELECT COUNT(*) FROM membership WHERE id=?";
		int isMember = 0;
		boolean isFlag = false;
		
		try {
			//prepare객체로 쿼리문 전송
			psmt = con.prepareStatement(sql);
			//인파라미터 설정
			psmt.setString(1, id);
			//쿼리실행
			rs = psmt.executeQuery();
			//실행결과를 가져오기 위해 next() 호출
			rs.next();
			
			isMember = rs.getInt(1);
			System.out.println("affected:"+ isMember);
			if(isMember==0) {
				isFlag = false;
			}
			else {
				isFlag = true;
			}
		}
		catch (Exception e) {
			isFlag = false;
			e.printStackTrace();
		}
		return isFlag;
	}
	
	//회원 ID, PW 확인
	//회원의 이름과 이메일을 전달받아 레코드를 조회 후 ID or PW를 반환한다.
	public String findUserIDPW(String id, String name, String email) {
		
		String query = "";
		String resStr = "";
		
		try {
			//ID 찾기일 경우
			if(id.equals("1")) {
				System.out.println(id);
				query = "SELECT id FROM membership WHERE name=? AND email=? ";
			}
			//PW 찾기일 경우
			else {
				query = "SELECT pass FROM membership WHERE name=? AND email=? ";
			}
			psmt = con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			rs.next();
			resStr = rs.getString(1);
			
		}
		catch (Exception e) {
			System.out.println("findUserIDPW오류");
			e.printStackTrace();
		}
		return resStr;
	}
	
	
	
	
	
	
	
	
	
}
