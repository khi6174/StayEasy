<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
body {
    background-color: #f8f9fa;
    color: #333;
    font-family: 'Noto Sans KR', sans-serif;
    display: flex;
    padding-top: 50px;
}

.container {
    background-color: #fff;
    border: 1px solid #ddd;
    padding: 40px 30px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    text-align: center;
    margin-top: 30px; 
}

table {
    width: 100%;
    border-spacing: 0 8px;
}

td:first-child, 
td:nth-child(3) {
    text-align: right;    
    font-weight: bold;  
    padding-right: 15px; 
}

input[type="text"],
input[type="password"],
input[type="date"],
input[type="email"] {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: #fafafa;
    color: #333;
    box-sizing: border-box;
    outline: none;
}

td {
    padding: 6px 15px; 
}

input[type="button"] {
    background-color: #6c757d; 
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

input[type="button"]:hover {
    background-color: #5a6268;  
}

input[type="submit"] {
    background-color: #FF9AA2;
    color: white;
    border: none;
    width: 100%;
    padding: 12px;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 15px;
}

input[type="submit"]:hover {
    background-color: #ff6b81;
}

form:errors {
    color: #ff6b6b; 
    font-size: 12px;
}

.gender-container {
    display: flex;
    gap: 10px;
    margin-top: 8px;
}

.gender-container label {
    flex: 1;
    text-align: center;
    background-color: #e9ecef;
    padding: 8px 0;
    border-radius: 6px;
    cursor: pointer;
    border: 1px solid #ccc;
}

.gender-container input[type="radio"]:checked + label {
    background-color: #03C75A;
    color: #fff;
    border: 1px solid #02B457;
}

</style>
</head>
<body>
<div align="center">
<form:form action="../login/registerDo.html" name="frm" method="post" 
	onsubmit="return check()"  modelAttribute="user">
<form:hidden path="idChecked"/>
<!-- 목록으로 돌아가기 버튼 -->
<a href="../login/login.html" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<table style="display: inline-block; vertical-align: middle;">
	<tr>
		<th colspan="4" style="font-weight: bold; font-size: 30px;">
		회원가입<br/><br/></th>
	</tr>
	<tr>
	<td>
	아이디</td><td><form:input path="user_id" size="18"/>
	<font color="red"><form:errors path="idChecked"/></font>
	</td>
	<td>비밀번호</td><td><form:password path="user_pwd" size="18"/>
	<font color="red"><form:errors path="user_pwd"/></font></td>
	</tr>
	<tr><td></td>
	<td><input type="button" value="ID 중복체크" onclick="idCheck()" /></td>
	<td>비밀번호 확인</td><td><input type="password" size="18" name="CONFPWD"/></td>
	</tr>
	<tr>
	<td>이름</td><td><form:input path="username" size="18"/>
	<font color="red"><form:errors path="username"/></font></td>
	<td>전화번호</td><td><form:input path="phone" size="18"/>
	<font color="red"><form:errors path="phone"/></font></td>
	</tr>
	<tr>
	<td>이메일</td><td><form:input path="email" size="18"/>
	<font color="red"><form:errors path="email"/></font></td>
	<td>주소</td><td><form:input path="addr" size="18"/>
	<font color="red"><form:errors path="addr"/></font></td>
	</tr>
	<tr>
	<td>생년월일</td><td><form:input path="birth" type="date" name="birth" />
	<font color="red"><form:errors path="birth"/></font></td>
	<td>성별</td>
	<td>
		<form:radiobutton path="gender" value="남자"/>남자
		<form:radiobutton path="gender" value="여자"/>여자
		<font color="red"><form:errors path="gender"/></font>
	</td>
	</tr>
</table><br/><br/>
<input type="submit" value="회원가입"/>
</form:form>
</div>
<script type="text/javascript">
function check(){
	if(document.frm.user_pwd.value != document.frm.CONFPWD.value){
		alert("암호가 일치하지 않습니다."); return false;
	}
}
function idCheck(){
	if(document.frm.user_id.value == ''){
		alert("계정을 입력하세요."); document.frm.user_id.focus(); return false;
	}
	var url="../login/idCheck.html?USER_ID="+document.frm.user_id.value;
	window.open(url, "_blank_", "width=450,height=200");
}
</script>
</body>
</html>