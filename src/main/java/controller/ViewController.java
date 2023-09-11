package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import board1.BoardDAO;
import board1.BoardDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/controller/photoView.tj")
public class ViewController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	//서블릿의 수명주기 메서드 중 전송 방식에 상관없이 요청을 처리하는 service() 메서드 오버라이딩
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse reps) 
			throws ServletException, IOException {
		
		//게시물 불러오기
		BoardDAO dao = new BoardDAO(getServletContext());
		
		//파라미터로 전달된 일련번호 받기
		String num = req.getParameter("num");
		String virtualNum = req.getParameter("virtualNum");
		//String virtualNum = dao.getVirtualNum(num, "photoboard");
		
		//조회수 1 증가
		dao.updatePhVisitCount(num);
		
		//게시물을 인출한다.
		BoardDTO dto = dao.selectView(num);
		
		dao.close();
		
		//내용의 경우 줄바꿈을 하게 되므로 웹브라우저 출력시 <br>로 변경
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		
		//첨부파일 확장자 추출 및 이미지 타입 확인
		String ext = null, fileName = dto.getSfile();
		if (fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".") + 1);
		}
		
		String[] mimeStr = { "png", "jpg", "gif" };
		List<String> miList = Arrays.asList(mimeStr);
		
		boolean isImage = false;
		if (miList.contains(ext)) {
			isImage = true;
		}
		
		//게시물(dto)을 request 영역에 저장한 후 뷰로 포워드
		req.setAttribute("dto", dto);
		req.setAttribute("isImage", isImage);
		req.setAttribute("virtualNum", virtualNum);
		req.getRequestDispatcher("/space/photoView.jsp").forward(req, reps);
	}
}































