package controller;

import java.io.IOException;

import board1.BoardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.FileUtil;

@WebServlet("/controller/download.tj")
public class DownloadController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	//다운로드 링크를 클릭하므로 get방식의 요청
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//파라미터 받기
		String ofile = req.getParameter("ofile");
		String sfile = req.getParameter("sfile");
		
		String num = req.getParameter("num");
		
		//파일 다운로드
		FileUtil.download(req, resp, "/Uploads", sfile, ofile);
		
		//해당 게시물의 다운로드 수 1 증가
		BoardDAO dao = new BoardDAO(getServletContext());
		dao.downCountPlus(num);
		dao.close();
	}
}
