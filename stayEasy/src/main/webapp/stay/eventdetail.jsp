<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>이벤트 상세보기</title>
<link rel="stylesheet" type="text/css" href="../css/event.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    width: 65%;
    max-width: 900px;
    margin: 40px auto;
    padding: 20px 0;
}

.event-header {
    border-bottom: 2px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

h1 {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 5px;
}

.event-date {
    font-size: 14px;
    color: #888;
}

.event-image {
    width: 100%; 
    max-width: 500px; 
    height: auto; 
    display: block;
    margin: 20px auto;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.event-content {
    font-size: 16px;
    color: #333;
    line-height: 1.7;
    margin-bottom: 20px;
}

.event-period {
    font-size: 14px;
    color: #555;
    background: #f8f8f8;
    padding: 15px;
    border-radius: 8px;
    margin-top: 20px;
}

@media (max-width: 768px) {
    .container {
        width: 90%;
    }
}
</style>
</head>
<body>

<div class="container">
	<!-- 목록으로 돌아가기 버튼 -->
    <a href="../event/eventList.html?pageNo=1" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <div class="event-header">
        <h1>${event.title}</h1>
        <p class="event-date">
            <fmt:formatDate value="${event.start_date}" pattern="yyyy-MM-dd"/> ~ 
            <fmt:formatDate value="${event.end_date}" pattern="yyyy-MM-dd"/>
        </p>
    </div>

    <div>
        <img class="event-image" src="${pageContext.request.contextPath}/imgs/${event.event_image}" alt="이벤트 이미지">
    </div>

    <div class="event-content">
    	<p style="white-space: pre-line;">
	        <c:out value="${event.content}" />
	    </p>
    </div>

    <div class="event-period">
        ※ 이벤트 기간: 
        <fmt:formatDate value="${event.start_date}" pattern="yyyy-MM-dd"/> ~ 
        <fmt:formatDate value="${event.end_date}" pattern="yyyy-MM-dd"/>
    </div>
</div>

</body>
</html>
