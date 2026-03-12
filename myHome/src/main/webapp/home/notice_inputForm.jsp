<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<h3 align="center">공지사항 쓰기</h3>
<form:form action="../notice/putForm.html" method="post" modelAttribute="notice">
<table border="1">
	<tr><th>공지사항 제목</th>
		<td><form:input path="title"/>
			<font color="red"><form:errors path="title"/></font></td></tr>
	<tr><th>공지사항 내용</th>
		<td><form:textarea path="content" rows="6" cols="40"/>
			<font color="red"><form:errors path="content"/></font></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="글 올리기"/>
						<input type="reset" value="취 소"/></td></tr>
</table>
</form:form>
</div>
</body>
</html>










