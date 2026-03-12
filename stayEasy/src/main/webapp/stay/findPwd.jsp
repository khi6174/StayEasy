<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Noto Sans KR', sans-serif;
        display: flex;
        padding-top: 50px;    
    }

    .container {
        margin-top: 30px; 
        background-color: #fff;
        border: 2px solid #FFB6C1;
        border-radius: 15px;
        padding: 40px 30px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 100%;
        max-width: 360px;
    }

    .title {
        font-size: 30px;
        font-weight: bold;
        color: #FF69B4;
        margin-bottom: 20px;
    }

    input[type="text"], 
    input[type="email"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        background-color: #fafafa;
        box-sizing: border-box;
        outline: none;
        margin-bottom: 10px;
    }

    input[type="submit"] {
        background-color: #FF9AA2;
        color: white;
        border: none;
        width: 100%;
        padding: 12px;
        border-radius: 6px;
        cursor: pointer;
        margin-top: 10px;
        font-weight: bold;
    }

    input[type="submit"]:hover {
        background-color: #ff6b81;
    }

    .result {
        font-weight: bold;
        margin-top: 20px;
        color: #333;
    }
</style>
</head>
<body>
<c:if test="${not empty message}">
	<script type="text/javascript">
		alert('${message}');
	</script>
</c:if>
<div align="center">
<form:form action="../find/findPwdDo.html" method="post" modelAttribute="userPwd">
<!-- 돌아가기 버튼 -->
<a href="../login/login.html" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<table style="display: inline-block; vertical-align: middle;">
	<tr>
		<th colspan="3" style="font-weight: bold; font-size: 30px;">
		비밀번호 찾기<br/><br/></th>
	</tr>
	<tr>
	<td style="padding-right: 3px; font-weight: bold;">이메일</td>
	<td><form:input path="email" type="email" size="18"/>
	<font color="red"><form:errors path="email"/></font>
	</tr>
	
	<tr>
	<td style="padding-right: 3px; font-weight: bold;">아이디</td>
	<td><form:input path="user_id" type="text" size="18"/>
	<font color="red"><form:errors path="user_id"/></font>
	</tr>
	
	<tr>
	<td style="padding-right: 3px; font-weight: bold;">이름</td>
	<td><form:input path="username" type="text" size="18"/>
	<font color="red"><form:errors path="username"/></font>
	</tr>
	
	<tr><td></td>
	<td><input type="submit" value="비밀번호 찾기"
	style="width: 153px; height: 40px; font-weight: bold;"/>
	</td>
	</tr>
</table><br/>
<br/><br/>
<c:if test="${not empty findUserPwd}">
    <div style="font-weight: bold;">
        ${ userPwd.username }님의 비밀번호는 "${ findUserPwd }"입니다.
    </div>
</c:if>

<c:if test="${empty findUserPwd and submitted}">
    <div style="font-weight: bold; color: red;">
        <p>회원 정보가 존재하지 않습니다.</p>
        <p>관리자에게 문의하세요.</p>
    </div>
</c:if>

</form:form>
</div>
</body>
</html>