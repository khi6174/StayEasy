<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>이벤트 상세보기 (관리자)</title>
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

.event-form input, .event-form textarea {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-sizing: border-box;
    margin-bottom: 10px;
}

.event-form textarea {
    height: 200px;
    resize: none;
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

.button-container {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

.button-container input[type="submit"] {
    background-color: #ff6699;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: 0.3s ease-in-out;
}

.button-container input[type="submit"]:hover {
    background-color: #ff3366;
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
        <h1>이벤트 상세보기</h1>
        <p class="event-date">
            <fmt:formatDate value="${event.start_date}" pattern="yyyy-MM-dd"/> ~ 
            <fmt:formatDate value="${event.end_date}" pattern="yyyy-MM-dd"/>
        </p>
    </div>

    <form:form action="../event/modify.html" method="post" modelAttribute="event" enctype="multipart/form-data" class="event-form">
        <label for="event_id">글번호</label>
        <form:input path="event_id" id="event_id" readonly="true"/>

        <label for="title">제목</label>
        <form:input path="title" id="title"/>

        <label for="start_date">이벤트 시작일</label>
        <form:input path="start_date" id="start_date" type="date"/>

        <label for="end_date">이벤트 종료일</label>
        <form:input path="end_date" id="end_date" type="date"/>

        <label>이벤트 이미지</label>
        <input type="file" name="image"/><br/>
        <img class="event-image" src="${pageContext.request.contextPath}/imgs/${event.event_image}" alt="이벤트 이미지">

        <label for="content">내용</label>
        <form:textarea path="content" id="content"/>

        <div class="button-container">
            <input type="submit" value="수 정" name="BTN"/>
            <input type="submit" value="삭 제" name="BTN"/>
        </div>
    </form:form>
</div>

</body>
</html>
