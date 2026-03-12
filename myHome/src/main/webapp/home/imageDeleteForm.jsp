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
</head>
<body>
<div align="center">
<h3>이미지 게시글 상세 보기</h3>
<form:form action="../image/deleteDo.html" method="post" modelAttribute="imagebbs" 
		onsubmit="return check(this)">
<form:hidden path="w_id"/>
<form:hidden path="password"/>
<table>
	<tr><th>제 목</th><td>
		<form:input path="title" readonly="true"/></td></tr>
	<tr><th>작성자</th><td>
		<form:input path="writer" readonly="true"/></td></tr>
	<tr><th>암 호</th><td>
		<input type="password" name="PWD"/></td></tr>
	<tr><th>작성일</th><td>
		<form:input path="w_date" readonly="true"/></td></tr>
	<tr><td colspan="2" align="center">
		<img alt="" src="${pageContext.request.contextPath}/upload/${imagebbs.imagename}"
			width="250" height="200"/></td></tr>
	<tr><th>내 용</th><td><form:textarea path="content" readonly="true"
			rows="5" cols="60"/></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="삭제"/>
		<input type="reset" value="취 소"/></td></tr>
</table>
</form:form>
<script type="text/javascript">
function check(frm){
	if(frm.PWD.value == ''){alert("암호를 입력하세요."); frm.PWD.focus(); return false;	}
	else {
		if(frm.password.value != frm.PWD.value){//입력한 암호와 DB의 암호가 다른 경우
			alert("입력한 암호와 게시글의 암호가 일치하지 않습니다. 암호를 확인하세요.");
			frm.PWD.focus();
			return false;
		}
	}
	if( ! confirm("정말로 삭제하시겠습니까?")) return false;
}
</script>
</div>
</body>
</html>










