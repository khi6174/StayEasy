<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    padding-top: 100px;
}

.container {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 15px;
    padding: 40px 30px;
    width: 100%;
    max-width: 360px; 
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    margin-top: 50px; 
}


input[type="text"], 
input[type="password"] {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: #fafafa;
    box-sizing: border-box;
}

input[type="submit"] {
    background-color: #FF9AA2;
    color: white;
    border: none;
    padding: 12px 0;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

input[type="submit"]:hover {
    background-color: #ff6b81;
}

td[rowspan="2"] {
    padding-left: 10px; 
}

a {
    text-decoration: none;
    color: #666;
    font-size: 18px;
}

a:hover {
    color: #333;
}

.options {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
}

</style>
</head>
<body>
<div align="center">

<form:form action="../login/loginDo.html" method="post" 
		modelAttribute="loginUser">
<table style="display: inline-block; vertical-align: middle;">
	<tr>
		<th colspan="3" style="font-weight: bold; font-size: 30px;">
		로그인<br/><br/></th>
	</tr>
	
	<tr>
	<td style="padding-right: 3px; font-weight: bold;">아이디</td>
	<td><form:input path="id" size="18" tabindex="1"/><br/>
	<c:if test="${not empty errors}">
    <ul style="color: red;">
        <c:forEach var="error" items="${errors}">
             <c:if test="${error.field == 'id'}">
                ${error.defaultMessage}
            </c:if>
        </c:forEach>
    </ul>
	</c:if>
	</td>
	
	<td rowspan="2"><input type="submit" value="로그인"
	style="width: 90px; height: 47px; font-weight: bold;" tabindex="3"/>
	</td>
	</tr>
	
	<tr>
	<td style="padding-right: 3px; font-weight: bold;">비밀번호</td>
	<td><form:password path="password" size="18" tabindex="2"/><br/>
	<c:if test="${not empty errors}">
    <ul style="color: red;">
        <c:forEach var="error" items="${errors}">
             <c:if test="${error.field == 'password'}">
                ${error.defaultMessage}
            </c:if>
        </c:forEach>
    </ul>
	</c:if></td>
	</tr>
</table><br/>
<br/><br/>
</form:form>
<c:if test="${FAIL eq 'YES'}">
    <h3 style="color: red;">로그인되지 않았습니다. 계정과 암호를 확인하세요.</h3>
</c:if>

<table>
<tr>
	<td style="padding-right: 20px;"><a href="../login/register.html">회원가입</a></td>
	<td style="padding-right: 20px;"><a href="../find/findId.html">아이디 찾기</a></td>
	<td><a href="../find/findPwd.html">비밀번호 찾기</a></td>
</tr>
</table>
</div>
</body> 
</html>