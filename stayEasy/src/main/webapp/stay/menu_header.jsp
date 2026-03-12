<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>StayEasy</title>
<link rel="stylesheet" type="text/css" href="../css/menuheader.css">
</head>
<body>
<div class="menu-container">
<div class="menu-left">
<div class="menu-item"><a href="../stay/main.html">메인화면</a></div>
<div class="menu-item"><a href="../reserv/reserv.html">숙박예약</a></div>
<div class="menu-item"><a href="../notice/notice.html">공지사항</a></div>
<div class="menu-item"><a href="../event/eventList.html">이벤트</a></div>
</div>

<div class="menu-center">
<a href="../stay/main.html">
<img src="../imgs/SElogoB.png" alt="StayEasy 로고">
</a>
</div>

<div class="menu-right">
   <c:choose>
      <c:when test="${sessionScope.loginUser == null }">
         <div class="menu-item2"><a href="../login/login.html">로그인</a></div>
      </c:when>
      <c:otherwise>
         <div class="menu-item2"><a href="../logout/logout.html">로그아웃</a></div>
      </c:otherwise>
   </c:choose> 
      
   <c:choose>
      <c:when test="${sessionScope.loginUser.id == 'admin' && sessionScope.loginUser != null}">
         <div class="menu-item2"><a href="../cart/noAdmin.html">장바구니</a></div>
      </c:when>
      <c:otherwise>
               <div class="menu-item2"><a href="../cart/cartList.html">장바구니</a></div>
      </c:otherwise>
   </c:choose>
   
	<c:choose>
	    <c:when test="${sessionScope.loginUser.id == 'admin' }">
	        <div class="menu-item2"><a href="../admin/adminUserManagement.html">사용자관리</a></div>
	    </c:when>
	    <c:otherwise>
	        <c:choose>
	            <c:when test="${sessionScope.loginUser != null}">
	                <div class="menu-item2"><a href="../mypage/mypageMain.html">마이페이지</a></div>
	            </c:when>
	            <c:otherwise>
	                <div class="menu-item2"><a href="../login/login.html">마이페이지</a></div>
	            </c:otherwise>
	        </c:choose>
	    </c:otherwise>
	</c:choose>

   </div>
</div>
<c:if test="${count != 1 }">
<br/>
</c:if>
</body>
</html>
