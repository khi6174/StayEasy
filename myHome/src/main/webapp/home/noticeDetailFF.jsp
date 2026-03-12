<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
<form:form modelAttribute="notice">
<table>
	<tr><th>글번호</th><td><form:input path="num" readonly="true"/></td></tr>
	<tr><th>제 목</th><td><form:input path="title" readonly="true"/></td></tr>
	<tr><th>작성자</th><td><form:input path="writer" readonly="true"/></td></tr>
	<tr><th>작성일</th><td><form:input path="write_date" readonly="true"/></td></tr>
	<tr><th>내 용</th><td><form:textarea path="content" rows="4" cols="50"
								readonly="true"/></td></tr>
</table>
</form:form>
</body>
</html>















