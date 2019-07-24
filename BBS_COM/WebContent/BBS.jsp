<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="bbs.Bbs"%>
<%@ page import ="bbs.BbsDAO"%>
<%@ page import ="java.util.ArrayList"%>
<%
	int myPage = 1;
	int numPerPage = 10;
	int numPerBlock = 3;
	int togo = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content=Type" content="text/html; charset="EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title> 3 조 </title>
</head>
<body>
	<%
// 		String pstr = request.getParameter("page");
// 		myPage = Integer.parseInt(pstr);
// 		myPage = 1;
	
	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		
		if(request.getParameter("myPage") != null){
			myPage = Integer.parseInt(request.getParameter("myPage"));
		}
		
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-hearder">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle=collapse" data-taget="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				</button>
				<a class="navbar-brand" href="main.jsp"> 3 조 </a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp"> 3 조 메 인 </a>
				<li class = "active"><a href="BBS.jsp"> 게 시 판 </a></li>
			</ul>
			
			<%
				if(userID ==null){
			%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}else{
			
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						
					</ul>
				</li>
			</ul>
			
			<%
				
				}
			%>
			
			
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border; 1px solid #dddddd">
				<thread>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thread>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs>list = bbsDAO.getList(myPage, numPerPage);
						 for(int i = 0; i<list.size(); i++){
					%>
					<tr>
						<td><%=list.get(i).getBbsID()%></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>&myPage=<%=myPage%>"><%=list.get(i).getBbsTitle()%></a></td>	 
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getBbsDate()%></td>	 
					</tr>
					<%
					}
					%>
					<!-- <tr>
						<td>9999</td>
						<td>안녕하세요.</td>
						<td>홍길동</td>
						<td>2017-05-04</td>
					</tr> -->
				</tbody>
			</table>
			<%
				int currentBlock = (int)Math.ceil( myPage / (double)numPerBlock);
				double totalPage = bbsDAO.getPageCount(numPerPage);
				int totalBlock = (int)Math.ceil(totalPage/numPerBlock);
				
				if(currentBlock > 1){
			%>
			
				<a href="BBS.jsp?myPage=<%=(currentBlock-1) * numPerBlock %>" class = "btn btn-primary">이전</a>
			
			<%
				}
				for(int i = 1; i<= numPerBlock; i++){
					int pn = numPerBlock * (currentBlock -1 ) +i;
					if( pn > totalPage ) continue;
						if( pn == myPage){	
			%>
				<a href = "BBS.jsp?myPage=<%= pn %>" class = "btn btn-primary"> <!-- 1페이지 -->
					<span style= "text-decoration: underline;"><%=pn %></span>
				</a>
			<%}else{ %>
				<a href = "BBS.jsp?myPage=<%=pn %>" class = "btn btn-primary"><%=pn %></a> <!-- 나머지페이지 -->
			<% 
					}
			}
			
				if(totalBlock > currentBlock){
					togo = (currentBlock+1)*numPerBlock;
					if( togo > totalPage) togo = (int)totalPage;
				%>
				<a href = "BBS.jsp?myPage=<%=togo%>" class = "btn btn-primary"> 다음 </a>
			<%
				}
			    
			%>
			
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>














