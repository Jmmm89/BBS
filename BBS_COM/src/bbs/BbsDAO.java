package bbs;

import java.sql.*;
import java.util.ArrayList;

import oracle.jdbc.proxy.annotation.Pre;

public class BbsDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
		String driverName = "oracle.jdbc.driver.OracleDriver";  
	    String dbURL = "jdbc:oracle:thin:@localhost:1521:lindswell";
	    Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "lindswell", "bit129");
	    
		}catch(Exception e) {
		e.printStackTrace();
		}
	}//BBSDAO end
	
	public int write(String bbsTitle, String userID, String bbsContent) {
	
			String SQL = "INSERT INTO BBS VALUES(?, ?, ?, SYSDATE, ?, ?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bbsContent);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
		
		
		
	}
	
	public int getPageCount(int numPerPage) {
		String SQL = "select count(bbsID) from BBS";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			int max = 0;
			
			while(rs.next()) {
				max = rs.getInt(1);
				break;
			}
			
			int pageCount = (int)Math.ceil((double)max / numPerPage );
			pageCount = Math.max(pageCount, 1);
			
			return pageCount;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
		
		
	}
	/*
	 * 
	

		PreparedStatement pstmt = conn.prepareStatement(sb.toString());
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		Vector<BookVO> data = new Vector<BookVO>();
		
		while( rs.next() ) {
			BookVO vo = new BookVO();
			vo.setName(rs.getString("name"));
			vo.setEmail(rs.getString("email"));
			vo.setHome(rs.getString("home"));
			vo.setContents(rs.getString("contents"));
			
			data.add(vo);
		} // while end
		
		ConnectionCloseHelper.close(rs);
		ConnectionCloseHelper.close(pstmt);
		
		return data;  
	} // getData() end

}

	 */
	public ArrayList<Bbs>getList(int myPage, int numPerPage){//int pageNumber
		
		int start = (myPage -1 ) * numPerPage;
		int end =  myPage * numPerPage;
		
		String SQL="SELECT * FROM BBS where bbsID > ? AND bbsID <= ? AND bbsAvailable = 1 ORDER BY bbsID desc";	
		ArrayList<Bbs>list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
			Bbs bbs = new Bbs();
			bbs.setBbsID(rs.getInt(1));
			bbs.setBbsTitle(rs.getString(2));
			bbs.setUserID(rs.getString(3));
			bbs.setBbsDate(rs.getString(4));
			bbs.setBbsContent(rs.getString(5));
			bbs.setBbsAvailable(rs.getInt(6));
			list.add(bbs);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
		
		
		
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL="SELECT * FROM BBS where bbsID =? and bbsAvailable = 1 ORDER BY bbsID desc";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
		
	public int update(int bbsID, String bbsTitle, String bbsContent) {

		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? where bbsID = ?";
	
	try {
		PreparedStatement pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, bbsTitle);
		pstmt.setString(2, bbsContent);
		pstmt.setInt(3, bbsID);
		return pstmt.executeUpdate();
	} catch (Exception e) {
		// TODO: handle exception
	}
	
	return -1;

	}
	
	public int delete(int bbsID) {

		String SQL = "UPDATE BBS SET bbsAvailable=0 where bbsID = ?";
	
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
		// TODO: handle exception
		}
	
		return -1;
	} // delete end
	
	public int getNext() {
		String SQL = "Select bbsID from bbs order by bbsID desc";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return -1;
		
		
		
	}
	
}