<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="../logout/logout.html">
<font color="red">환영합니다~${sessionScope.loginUser.id }님~</font>
<input type="submit" value="로그아웃">
</form>
</body>
</html>







