<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div align="center" class="body">
<h2>구매 화면</h2>
<font color="red"><b>배송 받을 곳</b></font>
<table>
	<tr><th>사용자ID</th><td>${loginUser.user_id }</td></tr>
	<tr><th>이 름</th><td>${loginUser.name }</td></tr>
	<tr><th>주 소</th><td>${loginUser.addr }</td></tr>
	<tr><th>이메일</th><td>${loginUser.email }</td></tr>
</table><br/><br/>
<font color="red"><b>구매 목록</b></font>
<table>
	<tr><th width="200">상품명</th><th width="150">가 격</th><th width="50">갯 수</th>
		<th width="150">소 계</th></tr>
	<c:forEach items="${itemList}" var="itemSet">
	<tr><td align="left">${itemSet.item.item_title }</td>
		<td align="right">${itemSet.item.price }원</td>
		<td align="right">${itemSet.quantity }개</td>
		<td align="right">${itemSet.quantity * itemSet.item.price }원</td></tr>
	</c:forEach>
</table><br/><br/><b>구 매 총 액 : ${totalAmount }원 </b><br/><br/>
<form action="../end/end.html">
	<input type="submit" value="구매 확정" name="btn">
</form>
</div>
</body>
</html>















