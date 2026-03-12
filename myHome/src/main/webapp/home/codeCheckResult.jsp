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
<h3 align="center">상품 코드 중복 검사 결과</h3>
<form action="../item/codecheck.html" name="frm">
	상품 코드 : <input type="text" name="CODE" value="${CODE }"/>
	<input type="submit" value="중복 검사"/>
</form><br/>
<c:choose>
	<c:when test="${DUP == 'NO' }">
	${CODE }는 사용 가능합니다. <input type="button" value="사용" onclick="codeOk()">
	</c:when>
	<c:otherwise>
	${CODE }는 이미 사용 중입니다.
	</c:otherwise>
</c:choose>
<script type="text/javascript">
function codeOk(){
	//팝업창 폼(codeCheckResult.jsp)에 입력된 상품코드를 상품등록폼(inputItems.jsp)로 이동시킨다.
	//즉, 자식JSP에서 부모JSP로 데이터 전송
	opener.document.itemFrm.item_code.value = document.frm.CODE.value;
	opener.document.itemFrm.item_code.readOnly = true;
	opener.document.itemFrm.codeChecked.value = "YES";//중복검사용 파라미터에 값을 넣는다.
	self.close();//팝업창을 닫는다.
}
</script>
</body>
</html>













