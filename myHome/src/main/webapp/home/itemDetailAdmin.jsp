<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*, java.util.*" %>    
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
<form action="../item/modify.html" method="post" onsubmit="return check(this)">
<input type="hidden" name="CODE" value="${dto.item_code}">
<table>
	<tr><th>상품번호</th><td>${dto.item_code}</td></tr>
	<tr><th>상품이름</th><td><input type="text" name="NAME" value="${dto.item_title}"></td></tr>
	<tr><th>상품가격</th><td><input type="text" name="PRICE"
			value="${dto.price}"/>원</td></tr>
	<tr><th>원 산 지</th><td><select name="NATION">
		<c:forEach var="nation" items="${NATIONS }">
			<c:choose>
				<c:when test="${nation.code == dto.madein }">
					<option value="${nation.code }" selected="selected">${nation.name }</option>				
				</c:when>
				<c:otherwise>
					<option value="${nation.code }" >${nation.name }</option>				
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</select></td></tr>
	<tr><th>등 록 일</th><td>${dto.reg_date}</td></tr>
	<tr><th>상품설명</th><td><textarea rows="5" cols="40" 
		name="SPEC">${dto.item_spec}</textarea></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="수정" name="BTN"/>
		<input type="submit" value="삭제" name="BTN"/></td></tr>
</table>
</form>
<script type="text/javascript">
function check(frm){
	if(frm.NAME.value==''){	alert("상품이름을 입력하세요."); frm.NAME.focus(); return false;	}
	if(frm.SPEC.value==''){ alert("상품설명을 입력하세요."); frm.SPEC.focus(); return false; }
	if(frm.PRICE.value==''){alert("가격을 입력하세요."); frm.PRICE.focus(); return false; }
	if( ! confirm("정말로 작업을 진행하시겠습니까?")) return false;
}
</script>
</div>
</body>
</html>








