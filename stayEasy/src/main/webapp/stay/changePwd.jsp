<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
</head>
<body>
<c:if test="${not empty msg}">
    <script type="text/javascript">
    alert('${msg}');
    </script>
</c:if>
<div class="container">
<h1>비밀번호 변경</h1>
<form action="../mypage/changePwdDo.html" method="post">
<table>
       <tr>
           <th>현재 비밀번호</th>
           <td><input type="password" name="nowPwd" placeholder="현재 비밀번호 입력"/>
       </tr>
       <tr>
           <th>변경 비밀번호</th>
           <td><input type="password" name="ChangePwd" placeholder="변경 비밀번호 입력"/>
       </tr>
        <tr>
           <th>변경 비밀번호 확인</th>
           <td><input type="password" name="ConfirmPwd" placeholder="변경 비밀번호 확인"/>
       </tr>
       
      </table>
        <button type="submit">변경하기</button>
</form>
</div>
</body>
</html>