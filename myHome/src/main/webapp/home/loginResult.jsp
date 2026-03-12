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
<c:choose>
	<c:when test="${ FAIL == 'YES' }">
		<h3>로그인되지 않았습니다. 계정과 암호를 확인하세요.</h3>
	</c:when>
	<c:otherwise>
		<h3>환영합니다~${ sessionScope.loginUser.id }님~</h3>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>

