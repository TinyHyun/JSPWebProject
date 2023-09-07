package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager {

	//쿠키생성
	public static void makeCookie(HttpServletResponse response, String cName, String cValue, int cTime) {
		
		//생성자를 통해 쿠키 생성
		Cookie cookie = new Cookie(cName, cValue);
		//경로설정
		cookie.setPath("/");
		//유효시간 설정
		cookie.setMaxAge(cTime);
		//응답 헤더에 추가하여 클라이언트로 전송
		response.addCookie(cookie);
	}
	
	//쿠키값 읽기
	public static String readCookie(HttpServletRequest request, String cName) {
		
		String cookieValue = "";
		
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				String cookieName = c.getName();
				if (cookieName.equals(cName)) {
					cookieValue = c.getValue();
				}
			}
		}
		
		return cookieValue;
	}
	
	//쿠키삭제
	public static void deleteCookie (HttpServletResponse response, String cName) {
		makeCookie(response, cName, "", 0);
	}
}
