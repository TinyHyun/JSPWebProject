package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class FileUtil {

	//파일 업로드 처리
	public static String uploadFile(HttpServletRequest req, String sDirectory)
		throws ServletException, IOException {
		
		//input태그의 name속성값을 이용해서 Part객체를 생성
		//해당 객체를 통해 파일을 서버에 저장
		Part part = req.getPart("ofile");
		
		//Part 객체에서 아래 헤더값을 읽어오면 전송된 파일의 원본명을 알 수 있다. (콘솔에서 확인할 것)
		String partHeader = part.getHeader("content-disposition");
		System.out.println("partHeader: " + partHeader);
		
		//"filename=" 을 구분자로 헤더값을 split() 하면 String 타입의 배열로 반환된다.
		String[] phArr = partHeader.split("filename=");
		
		/*
		앞에서 split()한 결과 중 인덱스 1은 파일명이 된다.
		여기서 ""을 제거하면 순수한 파일명만 남는다.
		replace()를 통해 제거한다.
		이때 ""을 제거할 문자열로 사용하기 위해 \을 붙여줘야한다.
		*/
		String originalFileName = phArr[1].trim().replace("\"", "");
		
		/*
		전송된 파일이 있는 경우라면 디렉토리에 파일을 저장
		이때 write() 메서드를 사용
		
		File.separator: 운영체제(OS)마다 경로를 표시하는 기호가 다르므로 해당 OS에 맞는 것을 자동으로 기술한다.
		*/
		if (!originalFileName.isEmpty()) {
			part.write(sDirectory + File.separator + originalFileName);
		}
		
		//원본 파일명을 반환
		return originalFileName;
	}
	
	//서버에 저장된 파일명을 변경한다.
	public static String renameFile(String sDirectory , String fileName) {
		
		//파일명에 2개 이상의 .을 사용할 수 있기에 뒤에서 부터 .이 있는 위치를 찾아 확장자를 잘라낸다.
		String ext = fileName.substring(fileName.lastIndexOf("."));
		
		//날짜와 시간을 이용해서 파일명으로 사용할 문자열 생성
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		
		//파일명과 확장자를 결합
		String newFileName = now + ext;
		
		//원본파일명과 새로운 파일명을 통해 File 객체를 생성
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		
		//파일명을 변경한다.
		oldFile.renameTo(newFile);
		
		//변경된 파일명을 반환
		return newFileName;
	}
	
	//첨부파일 삭제
	public static void deleteFile(HttpServletRequest req, String direvtory, String filename) {
		
		//파일이 저장된 디렉토리의 물리적 경로 가져오기
		String sDirectory = req.getServletContext().getRealPath(direvtory);
		
		//저장된 파일의 경로를 통해 File 객체를 생성
		File file = new File(sDirectory + File.separator + filename);
		
		//해당 경로에 파일이 있으면 삭제한다.
		if (file.exists()) {
			file.delete();
		}
	}
	
	//파일 다운로드
	public static void download(HttpServletRequest req, HttpServletResponse resp,
			String directory, String sfileName, String ofileName) {
		
		//디렉토리의 물리적 경로 얻어오기
		String sDirectory = req.getServletContext().getRealPath(directory);
		
		try {
			//파일을 찾아 입력 스트림 생성
			File file = new File(sDirectory, sfileName);
			InputStream iStream = new FileInputStream(file);
			
			//한글 파일명 깨짐 방지
			String client = req.getHeader("User-Agent");
			
			if (client.indexOf("WOW64") == -1) {
				ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
			}
			else {
				ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
			}
			
			//파일 다운로드용 응답 헤더 설정
			resp.reset();
			resp.setContentType("application/octet-stream");
			
			//서버에 저장된 파일을 다운로드 할 때 원본파일명으로 변경
			//파일명이 한글인 경우 깨짐 현상이 발생할 수 있으므로 앞에서 깨짐 처리를 먼저 진행
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + ofileName + "\"");
			resp.setHeader("Contnent-Length", "" + file.length());
			
			//response 내장 객체로부터 새로운 출력 스트림 생성
			OutputStream oStream = resp.getOutputStream();
			
			//출력 스트림에 파일 내용 출력
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while ((readBuffer = iStream.read(b)) > 0) {
				oStream.write(b, 0, readBuffer);
			}
			
			//입출력 스크림 닫음
			iStream.close();
			oStream.close();
		}
		catch (FileNotFoundException e) {
			System.out.println("파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
		catch (Exception e) {
			System.out.println("다운로드 중 예외발생");
			e.printStackTrace();
		}
	}
}































