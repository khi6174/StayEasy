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
<c:choose>
	<c:when test="${param.R == 'NO' }">
		<script type="text/javascript">
			setTimeout(function(){
				alert("답글이 존재하므로 게시글이 삭제되지 않았습니다.");
				location.href="../image/imageList.html";
			},100);
		</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			setTimeout(function(){
				alert("게시글이 삭제되었습니다.");
				location.href="../image/imageList.html";
			},100);
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>
















