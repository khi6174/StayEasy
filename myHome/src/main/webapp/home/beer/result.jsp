<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<h2>맥 주 추 천 결 과</h2>
<c:forEach var="beer" items="${BRANDS}">
	${beer }<br/>
</c:forEach>
</div>
</body>
</html>





