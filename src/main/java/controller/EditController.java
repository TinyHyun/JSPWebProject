package controller;

import java.io.IOException;

import board1.BoardDAO;
import board1.BoardDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.websocket.Session;
import utils.FileUtil;
import utils.JSFunction;

@WebServlet("/controller/photoEdit.tj")
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 10,
		maxRequestSize = 1024 * 1024 * 100
	)
public class EditController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	//수정 페이지로 진입하면 기존의 내용을 가져와서 쓰기 폼에 세팅
	//단순한 페이지 이동이므로 get방식 요청
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//일련번호를 받는다.
		String num = req.getParameter("num");
		
		//DAO 객체를 생성한 후 기존 게시물의 내용을 가져온다.
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = dao.selectView(num);
		
		//DTO 객체를 request 영역에 저장한 후 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("../space/photoEdit.jsp").forward(req, resp);
	}
	
	//수정할 내용을 입력한 후 전송된 폼값을 update 쿼리문으로 갱신
	//게시판은 post방식으로 전송되므로 doPost()를 오버라이딩 한다.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		//1. 파일 업로드 처리=========================
		//업로드 디렉토리의 물리적 경로를 가져온다.
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		
		
		//파일 업로드
		String originalFileName = "";
		
		try {
			//업로드가 정상적으로 완료되면 원본 파일명을 반환
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		}
		catch (Exception e) {
			//파일 업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동
			JSFunction.alertBack(resp, "파일 업로드 오류입니다.");
			e.printStackTrace();
			
			return;
		}
		
		//2. 파일 업로드 외 처리======================
		//
		String num = req.getParameter("num");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		
		String name = req.getParameter("name");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		//DTO에 저장
		BoardDTO dto = new BoardDTO();
		dto.setNum(num);
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		
		if (originalFileName != "") {
			
			//수정페이지 새롭게 등록한 파일이 있다면 기존 내용을 수정해야 한다.
			//파일명의 이름을 변경한 후 원본파일명과 저장된 파일명을 DTO에 저장
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			//원본과 변경된 파일 명을 DTO에 저장
			dto.setOfile(originalFileName);
			dto.setSfile(savedFileName);
			
			//기존 파일 삭제
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		else {
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		//DAO에 수정 내용 반영
		BoardDAO dao = new BoardDAO(getServletContext());
		int result = dao.updateEdit(dto);
		dao.close();
		
		//성공 or 실패?
		if (result == 1) {
			JSFunction.alertLocation(resp, "게시물 수정이 완료되었습니다.", "../space/sub01List.jsp?tname=photoboard");
		}
		else {
			JSFunction.alertLocation(resp, "게시물 수정을 실패했습니다.", "../space/sub01List.jsp?tname=photoboard");
		}
	}
}











































