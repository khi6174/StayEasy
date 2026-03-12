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
<h2>모든 고객의 주문 목록</h2>

<form action="../admin/orderStateSearch.html">
배송상태:<select name="state">
	<option value="0">주문완료</option><option value="1">배송중</option>
	<option value="2">배송완료</option>
</select>
<input type="submit" value="조 회"/>
</form><br/>

<table border="1">
<tr><th>계 정</th><th>주문번호</th><th>주문상세번호</th><th>상품번호</th><th>주문 수량</th>
	<th>주문시간</th><th>배송상태</th><th>상태수정</th></tr>
<c:forEach var="order" items="${allOrders}">
<form action="../admin/orderModifyFromList.html">
<input type="hidden" name="user_id" value="${order.user_id }">
<input type="hidden" name="sale_id" value="${order.sale_id }">
<input type="hidden" name="sale_detail_id" value="${order.sale_detail_id}">
<tr><td>${order.user_id }</td><td>${order.sale_id }</td><td>${order.sale_detail_id}</td>
	<td>${order.item_id }</td><td>${order.quantity }</td><td>${order.sale_time }</td>
	<td><select name="state">
			<c:choose>
				<c:when test="${order.delivery_state == 0}">
					<option value="0" selected="selected">주문완료</option>
				</c:when>
				<c:otherwise><option value="0">주문완료</option></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${order.delivery_state == 1}">
					<option value="1" selected="selected">배송중</option>
				</c:when>
				<c:otherwise><option value="1">배송중</option></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${order.delivery_state == 2}">
					<option value="2" selected="selected">배송완료</option>
				</c:when>
				<c:otherwise><option value="2">배송완료</option></c:otherwise>
			</c:choose>
			</select>
	</td>
	<td><input type="submit" value="정보수정"/></td></tr></form>
</c:forEach>	
</table><br/>
<c:forEach begin="1" end="${pageCount }" var="page">
	<a href="../admin/orderStateSearch.html?PAGE=${page }&state=${state}">${page }</a>
</c:forEach>
<br/>
</div>
</body>
</html>















