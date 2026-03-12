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
<h2>고객의 주문 목록</h2>
<table border="1">
	<tr><th>계정</th><th>주문번호</th><th>상세번호</th><th>상품번호</th><th>주문수량</th>
		<th>배송상태</th><th>상태변경</th></tr>
	<c:forEach var="sales" items="${salesList}">
<form action="../admin/orderModify.html" >	
<input type="hidden" name="user_id" value="${sales.user_id }">
<input type="hidden" name="sale_id" value="${sales.sale_id }">
<input type="hidden" name="sale_detail_id" value="${sales.sale_detail_id }">
	<tr><td>${sales.user_id }</td><td>${sales.sale_id }</td>
		<td>${sales.sale_detail_id }</td><td>${sales.item_id }</td>
		<td>${sales.quantity }</td><td><select name="state">
			<c:choose>
				<c:when test="${sales.delivery_state == 0}">
					<option value="0" selected="selected">주문완료</option>
				</c:when>
				<c:otherwise><option value="0">주문완료</option></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${sales.delivery_state == 1}">
					<option value="1" selected="selected">배송중</option>
				</c:when>
				<c:otherwise><option value="1">배송중</option></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${sales.delivery_state == 2}">
					<option value="2" selected="selected">배송완료</option>
				</c:when>
				<c:otherwise><option value="2">배송완료</option></c:otherwise>
			</c:choose>
			</select></td>
			<td><input type="submit" value="상태변경"/></td>
			</tr></form>
	</c:forEach>
</table>
</div>
</body>
</html>










