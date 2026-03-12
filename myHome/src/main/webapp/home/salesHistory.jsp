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
<div align="center">
	<h2>구매 내역</h2>
	<c:if test="${sales == null}">
	<h3>구매 내역이 존재하지 않습니다.</h3>
	</c:if>
	<c:if test="${sales != null }">
	<h3>구매 내역은 다음과 같습니다.</h3>
	<table border="1">
	<tr><th width="30">구매번호</th><th width="200">구매시간</th>
		<th width="50">상품번호</th><th width="80">구매수량</th>
		<th width="80">배송상태</tr>
	<c:forEach var="sale" items="${sales }">
	<tr><td>${sale[0].sale_id }</td><td>${sale[0].sale_time }</td>
		<td><a href="../mypage/itemdetail.html?id=${sale[1].item_id }">${sale[1].item_id }</a></td>
		<td>${sale[1].quantity }개</td>
		<td><c:choose>
			<c:when test="${sale[1].delivery_state == 0 }">주문완료</c:when>
			<c:when test="${sale[1].delivery_state == 1 }">배송중</c:when>
			<c:when test="${sale[1].delivery_state == 2 }">배송완료</c:when>
			</c:choose></td></tr>
	</c:forEach>
	</table>
	</c:if>
</div>
</body>
</html>














