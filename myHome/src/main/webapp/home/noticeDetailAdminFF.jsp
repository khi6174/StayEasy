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
<h3>공지사항 상세보기</h3>
<form:form action="../notice/modifyFF.html" method="post" modelAttribute="notice">
<table>
	<tr><th>글번호</th><td><form:input path="num" readonly="true"/></td></tr>
	<tr><th>작성자</th><td><form:input path="writer" readonly="true"/></td></tr>
	<tr><th>작성일</th><td><form:input path="write_date" readonly="true"/></td></tr>
	<tr><th>제 목</th><td><form:input path="title"/>
		<font color="red"><form:errors path="title"/></font></td></tr>
	<tr><th>내 용</th><td><form:textarea path="content" rows="5" cols="40"/>
		<font color="red"><form:errors path="content"/></font></td></tr>
	<tr><td colspan="2" align="center">
		<input type="submit" value="수 정" name="BTN"/>
		<input type="submit" value="삭 제" name="BTN"/></td></tr>
</table>
</form:form>
</div>
</body>
</html>













