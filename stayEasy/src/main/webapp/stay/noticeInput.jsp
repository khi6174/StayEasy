<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공지사항 작성</title>

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

/* 제목 및 설명 스타일 */
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

.notice-desc {
    font-size: 14px;
    color: #888;
}

/* 입력 폼 스타일 */
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

/* 에러 메시지 스타일 */
.error-message {
    color: red;
    font-size: 14px;
}

/* 버튼 컨테이너 */
.button-container {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

/* 버튼 스타일 */
.button-container input[type="submit"], .button-container input[type="reset"] {
    background-color: #ff6699;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: 0.3s ease-in-out;
}

.button-container input[type="submit"]:hover, .button-container input[type="reset"]:hover {
    background-color: #ff3366;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
    .container {
        width: 90%;
    }
}
</style>
</head>
<body>

<div class="container">
    <div class="notice-header">
        <h1>공지사항 작성</h1>
        <p class="notice-desc">새로운 공지사항을 작성하세요.</p>
    </div>

    <form:form modelAttribute="notice" action="../notice/putForm.html" method="post" class="notice-form">
        <label for="title">공지사항 제목</label>
        <form:input path="title" id="title"/>
        <form:errors path="title" cssClass="error-message"/>

        <label for="content">공지사항 내용</label>
        <form:textarea path="content" id="content"/>
        <form:errors path="content" cssClass="error-message"/>

        <div class="button-container">
            <input type="submit" value="게시하기" name="BTN"/>
            <input type="reset" value="취 소" name="BTN"/>
        </div>
    </form:form>
</div>

</body>
</html>
