<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table.member {width:50%;}
</style>
</head>
<body>
<div align="center">
<h2>가입자 조회</h2>
<form action="../admin/findmember.html" method="post">
<h3>검색할 항목을 입력하고 조회버튼을 누르세요.</h3>
<table border="1" class="member">
	<tr><th>계 정</th><td><input type="text" name="ID"/></td></tr>
	<tr><th>이 름</th><td><input type="text" name="NAME"/></td></tr>
	<tr><th>주 소</th><td><input type="text" name="ADDR"/></td></tr>
	<tr><th>이메일</th><td><input type="text" name="EMAIL"/></td></tr>
	<tr><td colspan="2" align="center">
		<input type="submit" value="조 회"/>
		<input type="reset" value="취 소"/></td></tr>
</table>
</form>
</div>
</body>
</html>













