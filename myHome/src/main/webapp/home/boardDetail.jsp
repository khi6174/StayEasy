<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3 align="center">게시글 상세 정보</h3>
<div align="center">
<form action="../write/modify.html" method="post">
<input type="hidden" name="SEQ" value="${BOARD.seq }">
	<table border="1">
		<tr><th>글제목</th>
			<td><input type="text" name="TITLE" value="${BOARD.title }"></td></tr>
		<tr><th>작성자</th><td>${BOARD.id }</td></tr>
		<tr><th>작성일</th><td>${BOARD.write_date }</td></tr>
		<tr><th>글내용</th>
			<td><textarea rows="4" cols="40" name="CONTENT">${BOARD.content }</textarea>
			</td></tr>
			<c:if test="${sessionScope.loginUser.id != null && 
							sessionScope.loginUser.id == BOARD.id }">
				<tr><td colspan="2" align="center">
					<input type="submit" value="수정" name="BTN"/>
					<input type="submit" value="삭제" name="BTN"/></td></tr>
			</c:if>
	</table>
</form>	
</div>
</body>
</html>











