<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
body {
    background-color: #f8f9fa;
    color: #333;  
    font-family: 'Noto Sans KR', sans-serif;
    display: flex;
    height: 100vh;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

h2 {
    color: #333;
    font-size: 22px; 
    margin-bottom: 15px;
}

form {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 15px 20px;  
    width: 100%;
    max-width: 300px;  
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

input[type="text"] {
    width: 60%;  
    padding: 6px; 
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: #fafafa;
    outline: none;
    margin-right: 8px;
}

input[type="submit"],
input[type="button"] {
    margin-top: 8px;
    background-color: #FF9AA2; 
    color: white;
    border: none;
    padding: 6px 15px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    margin-left: 5px;
    font-size: 12px; 
}

input[type="submit"]:hover,
input[type="button"]:hover {
    background-color: #FF69B4; 
}

</style>
</head>
<body>
<h2 align="center">계정 중복 확인</h2>
<form action="../login/idCheck.html">
계 정 : <input type="text" name="USER_ID" value="${ID }"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'NO' }">
		${ID }는 사용 가능합니다. <input type="button" value="사용" onclick="idOk('${ID}')"/>
	</c:when>
	<c:otherwise>
		${ID }는 사용 중입니다.
		<script type="text/javascript">
			opener.document.frm.ID.value = "";
		</script>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
function idOk(userId){
	opener.document.frm.user_id.value = userId;
	opener.document.frm.user_id.readOnly = true;//편집이 안되게 속성을 readOnly로 바꾼다.
	opener.document.frm.idChecked.value = "yes";//ID중복검사용 파라미터(idChecked)에 값을 넣는다.
	self.close();
}
</script>
</body>
</html>















