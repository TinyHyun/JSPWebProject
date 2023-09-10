package board1;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class BoardDAO extends JDBConnect {
	
	public BoardDAO(ServletContext application) {
		
		super(application);
	}
	
	//게시물의 갯수 카운트
	public int selectCount(Map<String, Object> map) {
		
		int totalCount = 0;

		//String query = "SELECT COUNT(*) FROM board";
		
		String query = "SELECT COUNT(*) FROM " + map.get("tname");
		
		//검색
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//게시물 목록 가져오기
	public List<BoardDTO> selectList(Map<String, Object> map){
		
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		String query = "SELECT * FROM " + map.get("tname");
		
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY num DESC ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("count"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	 public int insertWrite(BoardDTO dto, String tname) {
		 
	    int result = 0;  
	    
	    try {
	    	/* 인파라미터가 있는 동적쿼리문으로 insert문을 작성한다. 
		게시물의 일련번호는 시퀀스를 통해 자동부여하고, 조회수는 
		0으로 입력한다. */
	    /*String query = "INSERT INTO board ( "
	                 + " num,title,content,id,visitcount) "
	                 + " VALUES ( "
	                 + " seq_board_num.NEXTVAL, ?, ?, ?, 0)";  */
	    
    	String query = "INSERT INTO " + tname + " ( "
	                 + " num,title,content,id,visitcount) "
	                 + " VALUES ( "
	                 + " seq_board_num.NEXTVAL, ?, ?, ?, 0)"; 
	    
	    psmt = con.prepareStatement(query); 
	    //인파라미터는 DTO에 저장된 내용으로 채워준다. 
	    psmt.setString(1, dto.getTitle());  
	    psmt.setString(2, dto.getContent());
	    psmt.setString(3, dto.getId());  
	    
	    //insert쿼리문을 실행한 후 결과값(int)을 반환받는다. 
	    result = psmt.executeUpdate(); 
		}
		catch (Exception e) {
		    System.out.println("게시물 입력 중 예외 발생");
		        e.printStackTrace();
	   }
		    
	    return result;
	}
	
	//사진 게시판 insert
	public int insertWritePh(BoardDTO dto, String tname) {
		 
	    int result = 0;  
	    
	    try {
	    	/* 인파라미터가 있는 동적쿼리문으로 insert문을 작성한다. 
			게시물의 일련번호는 시퀀스를 통해 자동부여하고, 조회수는 
			0으로 입력한다. */
		    /*String query = "INSERT INTO board ( "
		                 + " num,title,content,id,visitcount) "
		                 + " VALUES ( "
		                 + " seq_board_num.NEXTVAL, ?, ?, ?, 0)";  */
		    
			String query = "INSERT INTO " + tname + " ( "
		                 + " num, title, content, id, visitcount, ofile, sfile, downcount) "
		                 + " VALUES ( "
		                 + " seq_board_num.NEXTVAL, ?, ?, ?, 0, ?, ?, 0)"; 
		    
		    psmt = con.prepareStatement(query); 
		    //인파라미터는 DTO에 저장된 내용으로 채워준다. 
		    psmt.setString(1, dto.getTitle());  
		    psmt.setString(2, dto.getContent());
		    psmt.setString(3, dto.getId());
		    psmt.setString(4, dto.getOfile());
		    psmt.setString(5, dto.getSfile());
		    
		    //insert쿼리문을 실행한 후 결과값(int)을 반환받는다. 
		    result = psmt.executeUpdate(); 
		}
		catch (Exception e) {
		    System.out.println("사진 게시물 입력 중 예외 발생");
	        e.printStackTrace();
	   }
		    
	    return result;
	}
	 
	 
	//게시물 상세보기
	public BoardDTO selectView(String num, String tname) { 
	    	//하나의 레코드를 저장하기 위한 DTO객체 생성
		BoardDTO dto = new BoardDTO();
		
		/* 내부조인(inner join)을 통해 member테이블의 name컬럼까지
		select 한다. */
	    String query = "SELECT B.*, M.name " 
	                 + " FROM member M INNER JOIN " + tname + " B " 
	                 + " ON M.id=B.id "
	                 + " WHERE num=?";
	    try {
	    	//쿼리문의 인파라미터를 설정한 후 쿼리문 실행 
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, num);   
	        rs = psmt.executeQuery();
	        /*
	        일련번호는 중복되지 않으므로 단 한개의 게시물만 인출하게된다. 
	        따라서 while문이 아닌 if문으로 처리한다. next() 메서드는 
	        ResultSet으로 반환된 게시물을 확인해서 존재하면 true를 
	        반환해준다. 
	        */
	        if (rs.next()) { 
	            dto.setNum(rs.getString(1)); 
	            dto.setTitle(rs.getString("title")); 
	            /* 
	            각 컬럼의 값을 추출할때 1부터 시작하는 인덱스와 컬럼명
	            둘 다 사용할 수 있다. 날짜인 경우에는 getDate() 메서드로
	            추출할 수 있다.  
	            */
	            dto.setContent(rs.getString("content")); 
	            dto.setPostdate(rs.getDate("postdate")); 
	            dto.setId(rs.getString("id"));
	            dto.setVisitcount(rs.getString("visitcount"));
	            dto.setName(rs.getString("name")); 
	        }
	    } 
	    catch (Exception e) {
	        System.out.println("게시물 상세보기 중 예외 발생");
	        e.printStackTrace();
	    }
	    
	    return dto; 
	}
	
	//사진게시판 상세보기
	public BoardDTO selectViewPh(String num, String tname) { 
	    //하나의 레코드를 저장하기 위한 DTO객체 생성
		BoardDTO dto = new BoardDTO();
		
		/* 내부조인(inner join)을 통해 member테이블의 name컬럼까지
		select 한다. */
	    String query = "SELECT B.*, M.name " 
	                 + " FROM member M INNER JOIN " + tname + " B " 
	                 + " ON M.id=B.id "
	                 + " WHERE num=?";
	    try {
	    	//쿼리문의 인파라미터를 설정한 후 쿼리문 실행 
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, num);   
	        rs = psmt.executeQuery();
	        /*
	        일련번호는 중복되지 않으므로 단 한개의 게시물만 인출하게된다. 
	        따라서 while문이 아닌 if문으로 처리한다. next() 메서드는 
	        ResultSet으로 반환된 게시물을 확인해서 존재하면 true를 
	        반환해준다. 
	        */
	        if (rs.next()) { 
	            dto.setNum(rs.getString(1)); 
	            dto.setTitle(rs.getString("title")); 
	            /* 
	            각 컬럼의 값을 추출할때 1부터 시작하는 인덱스와 컬럼명
	            둘 다 사용할 수 있다. 날짜인 경우에는 getDate() 메서드로
	            추출할 수 있다.  
	            */
	            dto.setContent(rs.getString("content")); 
	            dto.setPostdate(rs.getDate("postdate")); 
	            dto.setId(rs.getString("id"));
	            dto.setVisitcount(rs.getString("visitcount"));
	            dto.setName(rs.getString("name"));
	            dto.setOfile(rs.getString("ofile"));
	            dto.setSfile(rs.getString("sfile"));
	            dto.setDowncount(rs.getString("downcount"));
	        }
	    } 
	    catch (Exception e) {
	        System.out.println("사진 게시물 상세보기 중 예외 발생");
	        e.printStackTrace();
	    }
	    
	    return dto; 
	}
	
	//가상번호를 가져와 메인화면에서 게시물을 눌렀을 때 가상번호로 보이게
	public String getVirtualNum(String num, String tname) {
		
		String virtualNum = "";
		
		String query = " SELECT COUNT(*) FROM " + tname + " WHERE num<=? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				virtualNum = rs.getString(1);
			}
		}
		catch (Exception e) {
			System.out.println("게시물의 가상번호를 가져오는 중 예외발생");
			e.printStackTrace();
		}
		
		//가상번호를 반환한다.
		return virtualNum;
	}
	
	//게시물의 조회수를 1 증가시킨다. 
	public void updateVisitCount(String num, String tname) {
		/* 게시물의 일련번호를 통해 visitcount를 1 증가시킨다. 
		해당 컬럼은 number 타입이므로 사칙연산이 가능하다. */
	    String query = "UPDATE " + tname 
	    			+ " SET visitcount=visitcount+1 "
	                 + " WHERE num=?";
	    
	    try {
	        psmt = con.prepareStatement(query);
	        psmt.setString(1, num);   
	        psmt.executeQuery();   
	    } 
	    catch (Exception e) {
	        System.out.println("게시물 조회수 증가 중 예외 발생");
	        e.printStackTrace();
	    }
	}
	
	//다운로드 횟수를 1 증가시킨다.
    public void downCountPlus(String num, String tname) {
    	
    	String sql = "UPDATE " + tname + " SET "
				+ " downcount=downcount+1 "
				+ " WHERE num=?";
	
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			psmt.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
    }
	
	
	//게시물 수정하기 
    public int updateEdit(BoardDTO dto, String tname) { 
        int result = 0;        
        try {
        	//특정 일련번호에 해당하는 게시물을 수정한다. 
            String query = "UPDATE " + tname + " SET "
                         + " title=?, content=? "
                         + " WHERE num=?";
            //쿼리문의 인파라미터 설정 
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getNum());
            //수정된 레코드의 갯수를 반환한다. 
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; 
    }
    
    //사진 게시판 수정하기
    public int updateEditPh(BoardDTO dto, String tname) { 
        int result = 0;        
        try {
        	//특정 일련번호에 해당하는 게시물을 수정한다. 
            String query = "UPDATE " + tname + " SET "
                         + " title=?, content=?, ofile=?, sfile=? "
                         + " WHERE num=?";
            //쿼리문의 인파라미터 설정 
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getOfile());
            psmt.setString(4, dto.getSfile());
            psmt.setString(5, dto.getNum());
            
            
            //수정된 레코드의 갯수를 반환한다. 
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("사진 게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; 
    }
    
    
    //게시물 삭제하기 
    public int deletePost(BoardDTO dto, String tname) { 
        int result = 0;

        try {
        	//인파라미터가 있는 delete쿼리문 작성
            String query = "DELETE FROM " + tname + " WHERE num=?";
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getNum()); 
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;  
    }
    
  	//게시물 목록 출력시 페이징 기능 추가 
    public List<BoardDTO> selectListPage(Map<String, Object> map) {
        List<BoardDTO> bbs = new ArrayList<BoardDTO>();  
        
        /* 검색조건에 일치하는 게시물을 얻어온 후 각 페이지에 출력할
        구간까지 설정한 서브 쿼리문 작성 */
        String query = " SELECT * FROM ( "
        			+ "    SELECT Tb.*, ROWNUM rNum FROM ( "
                    + "        SELECT * FROM " + map.get("tname").toString();
        //검색어가 있는 경우에만 where절을 추가한다. 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        /* 게시물의 구간을 결정하기 위해 between 혹은 비교연산자를 
        사용할 수 있다. 아래의 where절은 rNum>? 과 같이 변경할수있다. */
        query += "      	ORDER BY num DESC "
               + "     ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?";

        try {
        	//인파라미터가 있는 쿼리문으로 prepared객체 생성
            psmt = con.prepareStatement(query);
            //인파라미터 설정
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            //쿼리문 실행 및 ResultSet반환
            rs = psmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setId(rs.getString("id"));
                dto.setVisitcount(rs.getString("visitcount"));
                //dto.setOfile(rs.getString("ofile")); //원본파일명
                //dto.setSfile(rs.getString("sfile")); //서버에저장된파일명
                //dto.setDowncount(rs.getString("downcount"));

                bbs.add(dto);
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        
        return bbs;
    }
}




































