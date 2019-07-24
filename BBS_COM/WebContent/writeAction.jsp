<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8"); //셋으로 쓰는습관을 들이자던데 이거 메타셋으로 한방에 때려박던 부분인가?
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<%
	System.out.println("게시판처리 시작..");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
<title>좋은생각</title>
</head>
<body>


	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}

	
	if (userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}else{

		if(bbs.getBbsTitle()==null|| bbs.getBbsContent() ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 누락된 란이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기가 올바르게 실행되지 않았습니다.')");
				script.println("history.back()");
				script.println("</script>");
			
			}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'BBS.jsp'");
			script.println("</script>");
			}
		}
	}
	%>
<%
	System.out.println("게시판처리 끝..");
%>

</body>
</html>