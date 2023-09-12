package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board1.BoardDAO;
import board1.BoardDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/main/main.tj")
public class MainCtrl extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//DB 연결
		BoardDAO dao = new BoardDAO(getServletContext());
		
		//DAO로 전달할 파라미터 저장을 위한 Map 컬렉션
		Map<String, Object> param = new HashMap<>();
		param.put("start", 1);
		param.put("end", 6);
		
		//공지사항 최근 게시물 4개 인출(board)
		param.put("tname", "board");
		List<BoardDTO> notice = dao.selectListPage(param);
		
		
		//자유게시판 최근 게시물 4개 인출(freeboard)
		param.put("tname", "freeboard");
		List<BoardDTO> free = dao.selectListPage(param);
		
		param.put("tname", "photoboard");
		List<BoardDTO> photo = dao.selectPhPage(param);
		
		//request 영역에 저장
		req.setAttribute("notice", notice);
		req.setAttribute("free", free);
		req.setAttribute("photo", photo);
		
		//View로 포워드
		req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
	}
}
