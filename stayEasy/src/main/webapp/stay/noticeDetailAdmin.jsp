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
<title>공지사항 상세보기 (관리자)</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
body {
    background-color: #f8f9fa;
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    width: 65%;
    max-width: 900px;
    margin: 40px auto;
    padding: 20px 0;
}

.notice-header {
    border-bottom: 2px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

h1 {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 5px;
}

.notice-date {
    font-size: 14px;
    color: #888;
}

.notice-form input, .notice-form textarea {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-sizing: border-box;
    margin-bottom: 10px;
}

.notice-form textarea {
    height: 200px;
    resize: none;
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
	<a href="../notice/notice.html?pageNo=1" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    
    <div class="notice-header">
        <h1>공지글 상세보기</h1>
        <p class="notice-date">
            <fmt:formatDate value="${notice.n_date}" pattern="yyyy-MM-dd"/>
        </p>
    </div>

    <form:form action="../notice/modify.html" method="post" modelAttribute="notice" class="notice-form">
        <label for="notice_id">글번호</label>
        <form:input path="notice_id" id="notice_id" readonly="true"/>

        <label for="title">제목</label>
        <form:input path="title" id="title"/>

        <label for="n_date">작성일</label>
        <form:input path="n_date" id="n_date" readonly="true"/>

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
