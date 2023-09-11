package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board1.BoardDAO;
import board1.BoardDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.BoardPage;
import utils.FileUtil;
import utils.JSFunction;

@WebServlet("/controller/photoWrite.tj")
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
	)
public class WriteController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	//글쓰기 페이지로 진입할 때는 다른 로직없이 포워드만 진행한다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		req.getRequestDispatcher("/space/photoWrite.jsp").forward(req, resp);
	}
	
	//글쓰기는 post방식의 전송이므로 doPost()에서 요청을 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		//1. 파일 업로드 처리========================
		//업로드 디렉토리의 물리적 경로 확인
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		//파일 업로드
		String originalFileName = "";
		
		try {
			//업로드가 정상적으로 완료되면 원본 파일명을 반환
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		}
		catch (Exception e) {
			JSFunction.alertLocation(resp, "파일 업로드 오류입니다.", "../controller/photoWrite.tj?tname=photoboard");
			e.printStackTrace();
			
			return;
		}
		
		//2. 파일 업로드 외 처리========================
		//첨부파일 이외의 폼값을 DTO에 저장
		BoardDTO dto = new BoardDTO();
		
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		
		// 세션영역에서 id를 가져오기
		HttpSession sess = req.getSession();
		dto.setId(sess.getAttribute("id").toString());
		
		//첨부파일이 정상적으로 등록되어 원본파일명이 반환되었다면
		if (originalFileName != "") {
			//파일명 변경 "날짜_시간.확장자" 형식으로 변경
			String saveFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			//원본과 변경된 파일명을 DTO에 저장
			dto.setOfile(originalFileName); //원래 파일 이름
			dto.setSfile(saveFileName); //서버에 저장된 파일 이름
		}
		
		//DAO를 통해 DB에 내용저장
		BoardDAO dao = new BoardDAO(getServletContext());
		
		int result = dao.insertWritePh(dto);
		dao.close();
		
		//성공 or 실패?
		if (result == 1) {
			//글쓰기 성공 시 목록 페이지로 이동
			resp.sendRedirect("../space/sub01List.jsp?tname=photoboard");
		}
		else {
			//글쓰기 실패시 쓰기 페이지로 이동
			JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.", "../controller/photoWrite.tj?tname=photoboard");
		}
	}
}






























