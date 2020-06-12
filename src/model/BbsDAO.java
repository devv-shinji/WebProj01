package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

public class BbsDAO {
	//멤버변수(클래스 전체 멤버메소드에서 접근 가능)
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	
	//인자생성자2 : DB연결
	/*
	JSP파일에서 application내장객체를 파라미터로 전달하고
	생성자에서 web.xml에 직접 접근한다.
	application내장객체는 javax.servlet.ServletContext타입으로 정의되었으므로
	메소드에서 사용시에는 해당 타입으로 받아야 한다.
	※ 각 내장객체의 타입은 JSP교안 "04.내장객체" 참조할 것.
	*/
		public BbsDAO(ServletContext ctx) {
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
				System.out.println("DB 연결실패");
				e.printStackTrace();
			}
		}
	
	//DB자원해제
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
		} 
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	/*
	게시판 리스트에서 게시물의 갯수를 count()함수를 통해 구해서 반환함.
	가상번호, 페이지번호 처리를 위해 사용됨.
	 */
	public int getTotalRecordCount(Map<String, Object> map) {
		//게시물의 수는 0으로 초기화
		int totalCount = 0;
		
		//기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM multi_board";
		
		//JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가됨.
		if(map.get("Word")!=null) {
			query += " WHERE "+ map.get("Column")+ " "+ " LIKE '%"+ map.get("Word") +"%'";
		}
		//단순 로그 확인용 출력문
		System.out.println("query="+ query);
		
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			//반환한 결과값(레코드수)을 저장
			//레코드가 없어도  0을 반환하므로 무조건 반환값이 있다.
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {}
		return totalCount;
	}
	
	/*
	게시판 리스트에서 조건에 맞는 레코드를 select하여 ResultSet(결과셋)을
	List컬렉션에 저장 후 반환하는 메소드
	 */
	public List<BbsDTO> selectList(Map<String, Object> map) {
		List<BbsDTO> bbs = new Vector<BbsDTO>();

		//기본 쿼리문
		String query = "SELECT * FROM multi_board ";
		
		//검색어가 있는 경우 조건절 동적 추가
		if(map.get("Word")!=null) {
			query += " WHERE "+ map.get("Column")+ " "+ " LIKE '%"+ map.get("Word") +"%'";
		}
		
		//최근 게시물이 항상 위로 노출되야 하므로 작성된 순서의 역순으로 정렬한다.
		//order by는 where조건절에 상관없이 항상 쿼리문에 추가되어야 함.
		query += " ORDER BY idx DESC";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			
			//오라클이 반환해준 ResultSet의 갯수만큼 반복한다.
			while(rs.next()) {
				//하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
				BbsDTO dto = new BbsDTO();
				
				//setter()메소드를 사용하여 DTO객체에 데이터 저장
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPost_date(rs.getDate(5));
				dto.setO_file(rs.getString(6));
				dto.setS_file(rs.getString(7));
				dto.setDowncount(rs.getString(8));
				dto.setVisitcount(rs.getString(9));
				dto.setBflag(rs.getString(10));
				
				//저장된 DTO객체를 List컬렉션에 추가
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	/*
	게시판 리스트 페이지 처리
	 */
	public List<BbsDTO> selectListPage(Map<String, Object> map) {
		List<BbsDTO> bbs = new Vector<BbsDTO>();

		String query = "SELECT * FROM multi_board ";
		
		if(map.get("Word")!=null) {
			query += " WHERE "+ map.get("Column") +" "+" LIKE '%"+ map.get("Word") +"%' ";
		}
		query += "ORDER BY idx DESC LIMIT 0, 2";
		System.out.println("쿼리문:"+ query);
		
		try {
			psmt = con.prepareStatement(query);
			
			//JSP에서 계산한 페이지 범위값을 이용해 인파라미터를 설정함
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			
			rs = psmt.executeQuery();
			
			//오라클이 반환해준 ResultSet의 갯수만큼 반복한다.
			while(rs.next()) {
				//하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
				BbsDTO dto = new BbsDTO();
				
				//setter()메소드를 사용하여 DTO객체에 데이터 저장
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPost_date(rs.getDate("post_date"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//저장된 DTO객체를 List컬렉션에 추가
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	
	//글쓰기 처리 메소드
	public int insertWrite(BbsDTO dto) {
		//실제 입력된 행의 갯수를 저장하기 위한 변수
		int affected = 0;
		try {
			String query = "INSERT INTO multi_board ( "
					+ " title, content, id, visitcount) "
					+ " VALUES ( ?, ?, ?, 0)";
						
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			//입력된 행의 갯수 반환
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	//조회수 증가
	//일련번호 num에 해당하는 게시물의 조회수 증가
	public void updateVisitCount(String idx) {
		
		String query = "UPDATE multi_board SET visitcount=visitcount+1 WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("조회수 증가시 예외발생");
			e.printStackTrace();
		}
	}
	
	//게시물 가져오기
	//일련번호에 해당하는 게시물을 가져와서 DTO객체에 저장후 반환
	public BbsDTO selectView(String idx) {
		BbsDTO dto = new BbsDTO();
		
		//기존쿼리문: member테이블과 join없을 때..
		/*String query = "SELECT * FROM multi_board WHERE num=?";*/
		
		//변경된 쿼리문: member테이블과 join하여 사용자이름 가져옴.
		String query = "SELECT B.*, M.name "
				+ "FROM membership M INNER JOIN multi_board B "
				+ "ON M.id=B.id "
				+ "WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPost_date(rs.getDate("post_date"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				//테이블join으로 컬럼추가
				dto.setName(rs.getString("name"));
			}
		}
		catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	//게시물 수정하기
	public int updateEdit(BbsDTO dto) {
		int affected = 0;
		
		try {
			String query = "UPDATE multi_board SET title=?, content=? WHERE Idx=?";
		
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getIdx());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}
		System.out.println(affected);
		return affected;
	}
	
	//게시물 삭제 처리
	public int delete(BbsDTO dto) {
		int affected = 0;
		try {
			String query = "DELETE FROM multi_board WHERE Idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	
	
	
	
	
	
	
}

