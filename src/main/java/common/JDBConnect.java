package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.ServletContext;

public class JDBConnect {

	//멤버변수
	public Connection con;
	public Statement stmt; //정적 쿼리문
	public PreparedStatement psmt; //동적 쿼리문
	public ResultSet rs; //select 했을 때 실행결과를 반환
	
	//JSP에서 application 내장 객체를 매개변수로 전달
	public JDBConnect(ServletContext application) {
		
		//Java클래스의 메서드내에서 web.xml을 접근
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공");
		}
		catch (Exception e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}
	}
	
	//자원반납
	public void close() {
		
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		}
		catch (Exception e) {
			System.out.println("JDBC 자원 해제 실패");
			e.printStackTrace();
		}
	}
	
}
