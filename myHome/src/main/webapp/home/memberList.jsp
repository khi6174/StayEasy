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
<h2>회원 조회 목록</h2>
<table border="1">
<tr><th>계정</th><th>이름</th><th>주소</th><th>전화번호</th><th>이메일</th><th>성별</th>
	<th>등급</th><th>직업</th></tr>
<c:forEach var="member" items="${memberList}">
<tr><td><a href="../admin/getMember.html?id=${member.user_id }">${member.user_id }</a></td>
	<td>${member.name }</td><td>${member.addr }</td>
	<td>${member.phone }</td><td>${member.email }</td><td>
		<c:if test="${member.gender == 'M' }">남자</c:if>
		<c:if test="${member.gender == 'F'  }">여자</c:if></td>
	<td>${member.grade }</td><td>${member.job }</td></tr>
</c:forEach>	
</table><br/>
<c:forEach begin="1" end="${pageCount }" var="page">
	<a href="#" onclick="movePage(${page})">${page }</a>
</c:forEach>
<form method="post" name="frm">
<input type="hidden" name="ID" value="${ID }"/>
<input type="hidden" name="NAME" value="${NAME }"/>
<input type="hidden" name="ADDR" value="${ADDR }"/>
<input type="hidden" name="EMAIL" value="${EMAIL }"/>
<input type="hidden" name="PAGE"/>
</form>
<script type="text/javascript">
function movePage(num){
	document.frm.action = "../admin/findmember.html";
	document.frm.PAGE.value=num;
	document.frm.submit();
}
</script>
</div>
</body>
</html>












