<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
<h2>상품 상세 정보</h2>
<form:form modelAttribute="sellingItem">
<table border="1">
<tr><th>상품 번호</th><td><form:input path="item_code" readonly="true"/></td></tr>
<tr><th>상품 이름</th><td><form:input path="item_title" readonly="true"/></td></tr>
<tr><th>상품 가격</th><td><form:input path="price" readonly="true"/></td></tr>
<tr><th>등 록 일</th><td><form:input path="reg_date" readonly="true"/></td></tr>
<tr><th>원 산 지</th><td><form:input path="madein" readonly="true"/></td></tr>
<tr><th colspan="2" align="center">상품 설명</th></tr>
<tr><td colspan="2" align="center"><form:textarea path="item_spec"
			rows="5" cols="80" readonly="true"/></td></tr>
</table>
</form:form><br/><br/>
</div>
</body>
</html>













