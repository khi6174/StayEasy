<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table { width: 90%; height: 90%; border: 1px solid blue; background-color: skyblue;
		border-collapse: collapse; margin-left: 20px; margin-right: 20px;}
td.main { width: 30%; border: 1px solid green; }
#menu { margin-left: 10px; margin-top: 10px; margin-right: 10px; 
		background-color: lightgreen; width: 90%; border: 1px dashed red; }
#login { margin-left: 10px; margin-top: 10px; width: 90%; background-color: yellow;
		border: 1px dashed orange; }	
#content { background-color: wheat; }			
</style>
</head>
<body onload="startClock()">
<header>
	<div align="center"><img alt="" src="../imgs/logo.gif"></div>
</header>
<section>
<c:set var="body" value="${param.BODY }"/>
<c:set var="id" value="${sessionScope.ID }"/>
	<table id="body">
		<tr>
			<td width="40%" height="300px" class="main">
				<div id="login">
				<c:choose>
					<c:when test="${sessionScope.loginUser == null }">
						<jsp:include page="../login/login.html"/>
					</c:when>
					<c:otherwise>
						<jsp:include page="logout.jsp"/>
					</c:otherwise>
				</c:choose>
				
				</div>
				<div id="menu">
					<a href="../home/index.html">■ 홈으로</a><br/>
					
					<c:if test="${sessionScope.loginUser != null && 
									sessionScope.loginUser.id != 'admin'}">
						<a href="../mypage/index.html">■ MY PAGE</a><br/>
					</c:if>
					<c:if test="${sessionScope.loginUser != null && 
									sessionScope.loginUser.id == 'admin'}">
						<a href="../admin/findpage.html">■ 가입자 조회</a><br/>
					</c:if>
					
					<a href="../write/read.html">■ 게시글 보기</a><br/>
					<c:if test="${sessionScope.loginUser != null }">
						<a href="../write/write.html">■ 게시글 쓰기</a><br/>
					</c:if>
					<a href="../item/itemList.html">■ 상품 보기</a><br/>
					<c:if test="${sessionScope.loginUser != null && 
									sessionScope.loginUser.id !='admin' }">
						<a href="../cart/show.html">■ 장바구니 보기</a><br/>
					</c:if>
					<c:if test="${sessionScope.loginUser != null && 
									sessionScope.loginUser.id=='admin' }">
						<a href="../admin/deliverymenu.html">■ 배송 상태 변경</a><br/>
						<a href="../nation/inputNation.html">■ 상품 원산지 등록</a><br/>
						<a href="">■ 상품 원산지 등록(form:form)</a><br/>
						<a href="../item/entry.html">■ 상품 등록</a><br/>
					</c:if>
					<a href="../notice/list.html">■ 공지사항 보기</a><br/>
					<c:if test="${sessionScope.loginUser != null &&
									sessionScope.loginUser.id != 'admin' }">
						<a href="../image/imageWrite.html">■ 이미지 및 답글 게시글 쓰기</a><br/>
					</c:if>
					<a href="../image/imageList.html">■ 이미지 및 답글 게시글 보기</a><br/>
					<c:if test="${sessionScope.loginUser != null && 
									sessionScope.loginUser.id=='admin' }">
						<a href="../notice/inputForm.html">■ 공지사항 쓰기</a><br/>
						<a href="../notice/formform.html">■ 공지사항 쓰기(form:form)</a><br/>
					</c:if>
				</div>
			</td>
			<td id="content">
			<c:choose>
				<c:when test="${ BODY != null }">
					<jsp:include page="${ BODY }"/>
				</c:when>
				<c:otherwise>
					<div align="center">
					<img alt="" src="../imgs/chocolate-islands.jpg" width="400" height="250">
					</div>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
	</table>
</section>
<footer>
	<h3 align="center">웹 어플리케이션 작성 프로젝트. Copyright 2024 
	<font color="red"><span id="clock"></span></font></h3>
</footer>
<script type="text/javascript">
function workingClock(){
	var today = new Date();
	var year = today.getFullYear(); 	var month = today.getMonth() + 1;
	if(month < 10) month = "0" + month; var date = today.getDate();
	if(date < 10) date = "0" + date;	var hour = today.getHours();
	if(hour < 10) hour = "0" + hour;	var min = today.getMinutes();
	if(min < 10) min = "0" + min;		var sec = today.getSeconds();
	if(sec < 10) sec = "0" + sec;		
	var str = year+"/"+month+"/"+date+" "+hour+":"+min+":"+sec;
	document.getElementById("clock").innerHTML = str;
}
function startClock(){
	workingClock();//현재 시간을 보여주는 시계를 출력한다.
	setInterval(workingClock, 1000);//1초 간격으로 workingClock함수를 계속 호출한다.
}</script>
</body>
</html>









