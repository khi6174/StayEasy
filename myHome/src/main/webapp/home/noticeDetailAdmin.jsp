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
<h3>공지사항 상세보기</h3>
<form action="../notice/modify.html" method="post" onsubmit="return check(this)">
<input type="hidden" name="NUM" value="${NOTICE.num }">
<table>
	<tr><th>공지글 번호</th><td>${NOTICE.num }</td></tr>
	<tr><th>공지글 제목</th><td><input type="text" name="TITLE" 
								value="${NOTICE.title }"/></td></tr>
	<tr><th>작성자</th><td>${NOTICE.writer }</td></tr>
	<tr><th>작성일</th><td>${NOTICE.write_date }</td></tr>
	<tr><th>글내용</th><td><textarea rows="5" cols="40" 
						name="CONTENT">${NOTICE.content }</textarea></td></tr>
	<tr><td colspan="2" align="center">
		<input type="submit" value="수 정" name="BTN"/>
		<input type="submit" value="삭 제" name="BTN"/></td>
</table>
</form>
</div>
<script type="text/javascript">
function check(frm){
	if(frm.TITLE.value == ''){alert("제목을 입력하세요."); return false;}
	if(frm.CONTENT.value == ''){alert("내용을 입력하세요."); return false;}
	if( ! confirm("정말로 작업을 진행하시겠습니까?")) return false;
}
</script>
</body>
</html>














