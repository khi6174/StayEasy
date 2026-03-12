<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.Item" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:set var="dto" value="${ITEM }"/>
<div align="center">
<h3>상품 상세 정보</h3>
<table>
	<tr><th>상품번호</th><td>${dto.item_code}</td></tr>
	<tr><th>상품이름</th><td>${dto.item_title}</td></tr>
	<tr><th>상품가격</th><td>${dto.price}원</td></tr>
	<tr><th>원 산 지</th><td>${dto.madein}</td></tr>
	<tr><th>등 록 일</th><td>${dto.reg_date}</td></tr>
	<tr><th>상품설명</th><td><textarea rows="5" cols="40" readonly="readonly">${dto.item_spec}</textarea>
		</td></tr>
</table>
</div>
</body>
</html>








