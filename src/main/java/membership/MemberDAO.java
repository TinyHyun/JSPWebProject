package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MemberDAO extends JDBConnect {

	//DB 연결을 위한 인수생성자 정의
	public MemberDAO(ServletContext app) {
		super(app);
	}
	
	//회원정보 입력을 위한 메서드 정의
	public int registInsert(MemberDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO member VALUES ( "
					+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		
		try {
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getMailing());
			psmt.setString(8, dto.getZipcode());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//아이디 중복 확인을 위한 메서드 정의
	public boolean idOverlap(String id) {
	
		//초기값은 true로 설정 => 중복된 아이디가 없는 경우
		boolean retValue = true;
		
		//중복된 아이디가 있는지 확인하기 위한 쿼리문
		String sql = "SELECT  COUNT(*) FROM member WHERE id=?";
		
		try {
			//prepared 객체 생성 및 인파라미터 설정
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			//select계열의 쿼리문이므로 반환값은 ResultSet
			rs = psmt.executeQuery();
			
			//count()함수를 사용하므로 결과는 무조건 0 혹은 1
			//따라서 if()문을 사용할 필요없이 next()를 호출한다.
			rs.next();
			
			int result = rs.getInt(1);
			
			//중복된 아이디가 있어 1이 반환되면 false를 반환한다.
			if (result == 1) {
				retValue = false;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		//중복된 아이디가 없다면 0이므로 true를 반환한다.
		return retValue;
	}
	
	//로그인 검증
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		//회원인증을 위한 쿼리문을 실행한 후 회원정보를 저장하기 위해 생성
		MemberDTO dto = new MemberDTO();
		
		//로그인 폼에서 입력한 아이디,비번을 통해 인파라미터를 설정할 수 있도록 쿼리문을 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			//쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리문을 실행한 후 ResultSet객체를 통해 결과 반환
			rs = psmt.executeQuery();
			
			//반환된 ResultSet객체에 정보가 있는지 확인한다.
			if (rs.next()) {
				//회원정보가 있다면 DTO객체에 저장한다.
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//아이디 찾기
	public String idsearch(String name, String email) {
		
		String id = null;
		
		String query = "SELECT * FROM member WHERE name=? AND email=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, name);
			psmt.setString(2, email);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				id = rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return id;
	}
	
	
	//비밀번호 찾기
	public String pwsearch(String id, String name, String email) {
		
		String pass = null;
		
		String query = "SELECT * FROM member WHERE id=? AND name=? AND email=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, name);
			psmt.setString(3, email);
			
			rs =  psmt.executeQuery();
			
			if (rs.next()) {
				pass = rs.getString(2);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return pass;
	}
}

















