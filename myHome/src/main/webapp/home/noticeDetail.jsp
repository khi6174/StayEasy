<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table { width: 90%; height: 60%; border: 1px solid blue; background-color: skyblue;
		border-collapse: collapse; margin-left: 20px; margin-right: 20px;}
</style>
</head>
<body>
<h3 align="center">공지글 상세보기</h3>
<table>
	<tr><th>글번호</th><td>${NOTICE.num}</td></tr>
	<tr><th>제 목</th><td>${NOTICE.title}</td></tr>
	<tr><th>작성자</th><td>${NOTICE.writer }</td></tr>
	<tr><th>작성일</th><td>${NOTICE.write_date }</td></tr>
	<tr><th>내 용</th><td><textarea rows="4" name="CONTENT"
			cols="40" readonly="readonly">${NOTICE.content }</textarea></td></tr>
	
</table>
</body>
</html>















