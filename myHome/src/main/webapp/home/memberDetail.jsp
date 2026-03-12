<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table.member {width:60%;}
</style>
</head>
<body>
<div align="center">
<h2>회 원 정 보</h2>
<form action="../admin/memberUpdate.html" method="post" onsubmit="return check(this)">
<input type="hidden" name="ID" value="${user.user_id }"/>
<table border="1" class="member">
<tr><th>계 정</th><td>${user.user_id }</td></tr>
<tr><th>이 름</th><td>${user.name }</td></tr>
<tr><th>암 호</th><td><input type="password" name="PWD" value="${user.user_pwd }"/>
				</td></tr>
<tr><th>주 소</th><td><input type="text" name="ADDR" value="${user.addr }"/></td></tr>
<tr><th>전화번호</th><td><input type="text" name="PHONE" value="${user.phone }"/></td></tr>
<tr><th>성 별</th><td><c:if test="${user.gender == 'M' }">남</c:if>
					<c:if test="${user.gender == 'F'}">여</c:if></td></tr>
<tr><th>등 급</th><td><input type="text" name="GRADE" value="${user.grade }"/></td></tr>
<tr><th>이메일</th><td>${user.email }</td></tr>
<tr><th>생 일</th><td>${user.birth }</td></tr>
<tr><th>직 업</th><td>${user.job }</td></tr>
<tr><td colspan="2" align="center"><input type="submit" value="정보 수정"/>
		<input type="reset" value="취 소"/></td></tr>
</table></form><br/><br/>
</div>
<script type="text/javascript">
function check(frm){
	if(frm.PWD.value == ''){alert("암호를 입력하세요."); frm.PWD.focus(); return false;	}
	if(frm.ADDR.value == ''){alert("주소를 입력하세요.");frm.ADDR.focus(); return false;}
	if(frm.PHONE.value==''){alert("전화번호를 입력하세요.");frm.PHONE.focus();return false;}
	if(frm.GRADE.value==''){
		alert("등급을 입력하세요."); frm.GRADE.focus(); return false;
	}else {
		if(isNaN(frm.GRADE.value)){
			alert("등급은 숫자로 입력하세요."); frm.GRADE.focus(); return false;
		}else {
			var grade = parseInt(frm.GRADE.value);
			if(grade > 2 || grade < 0){
				alert("등급은 0과 2사이로 입력하세요."); frm.GRADE.focus(); return false;
			}
		}
	}
	if( ! confirm("정말로 변경하시겠습니까?")) return false;
}
</script>
</body>
</html>














