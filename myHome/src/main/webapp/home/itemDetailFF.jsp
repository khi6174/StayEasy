<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.Item" %>    
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
<h3>상품 상세 정보</h3>
<form:form modelAttribute="item">
<table>
	<tr><th>상품번호</th><td><form:input path="item_code" readonly="true"/></td></tr>
	<tr><th>상품이름</th><td><form:input path="item_title" readonly="true"/></td></tr>
	<tr><th>상품가격</th><td>${item.price }원</td></tr>
	<tr><th>원 산 지</th><td>${item.madein }</td></tr>
	<tr><th>등 록 일</th><td><form:input path="reg_date"/></td></tr>
	<tr><th>상품설명</th><td>
		<form:textarea path="item_spec" rows="5" cols="40"/></textarea>
		</td></tr>
</table>
</form:form>
</div>
</body>
</html>








