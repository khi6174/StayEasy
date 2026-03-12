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
<form:form action="../image/updateDo.html" method="post" enctype="multipart/form-data"
	onsubmit="return check(this)" modelAttribute="imagebbs">
<form:hidden path="w_id"/>
<form:hidden path="password"/>
<form:hidden path="imagename"/>
<table>
	<tr><th>글제목</th><td><form:input path="title"/></td></tr>
	<tr><th>작성자</th><td>${imagebbs.writer }</td></tr>
	<tr><th>작성일</th><td>${imagebbs.w_date }</td></tr>
	<tr><th>암 호</th><td><input type="password" name="PWD"/></td></tr>
	<tr><td colspan="2" align="center"><input type="file" name="image"/><br/>
		<img alt="" src="${pageContext.request.contextPath}/upload/${imagebbs.imagename }"
			 width="250" height="200"/></td></tr>
	<tr><th>내 용</th><td><form:textarea path="content" rows="5" cols="60"/></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="수정"/>
		<input type="reset" value="취소"/></td></tr>
</table>
</form:form>
<script type="text/javascript">
function check(frm){
	if(frm.title.value == ''){	alert("제목을 입력하세요."); frm.title.focus(); return false;}
	if(frm.PWD.value == ''){
		alert("암호를 입력하세요."); frm.PWD.focus(); return false;
	}else {
		if(frm.password.value != frm.PWD.value){//입력한 암호와 DB의 암호가 일치하지 않는 경우
			alert("암호가 일치하지 않습니다. 암호를 확인하세요."); frm.PWD.focus(); return false;
		}
	}
	if(frm.content.value == ''){
		alert("내용을 입력하세요."); frm.content.focus(); return false;
	}
	if( ! confirm("정말로 수정하시겠습니까?")) return false;
}
</script>
</div>
</body>
</html>
















