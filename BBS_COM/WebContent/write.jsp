<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content=Type" content="text/html; charset="EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title> 3 조  </title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
		
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align: center; border; 1px solid #dddddd">
					<thread>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">
							게시판 글쓰기 양식</th>
						
						</tr>
					</thread>
					<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" 
						name="bbsTitle" maxlength="50"></td>
					</tr>
					
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" 
						name="bbsContent" maxlength="2048" style="height : 350px;"></textarea></td>
					</tr>
					</tbody>
				</table>
				
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
				
				
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>














