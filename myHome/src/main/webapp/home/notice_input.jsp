<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<h3 align="center">공지사항 쓰기</h3>
<form action="../notice/input.html" method="post" onsubmit="return check()" name="frm">
<table border="1">
	<tr><th>공지사항 제목</th><td><input type="text" name="TITLE" size="30"/></td></tr>
	<tr><th>공지사항 내용</th><td><textarea rows="4" cols="50" name="CONTENT"></textarea></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="글 올리기"/>
						<input type="reset" value="취 소"/></td></tr>
</table>
</form>
<script type="text/javascript">
function check(){
	if(document.frm.TITLE.value == ''){
		alert("제목을 입력하세요."); return false;
	}
	if(document.frm.CONTENT.value == ''){
		alert("내용을 입력하세요."); return false;
	}
	if( ! confirm("정말로 등록하시겠습니까?")) return false;
}
</script>
</div>
</body>
</html>










