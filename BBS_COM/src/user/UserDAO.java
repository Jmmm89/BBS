package user;

import java.sql.*;

public class UserDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
		String driverName = "oracle.jdbc.driver.OracleDriver";  
	    String dbURL = "jdbc:oracle:thin:@localhost:1521:lindswell";
	    Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "lindswell", "bit129");
	    
		}catch(Exception e) {
		e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from BOARD_user where userID = ?";
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공
				}
				else
					return 0;//로그인 실패
			}
			return -1;//아이디가 없음
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
		
	}
	
	public int join(User user) {
		String SQL = "Insert into BOARD_user values (?, ?, ?, ?, ?)";
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
}
