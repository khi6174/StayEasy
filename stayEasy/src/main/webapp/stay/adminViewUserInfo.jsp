<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 조회</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        text-align: center;
    }
    .container {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 { 
    	font-size: 28px; 
    	margin-bottom: 20px; 
 	}
    .input-box {
        margin: 10px 0;
        text-align: left;
    }
    input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        background-color: #f1f1f1;
    }
    button {
        width: 100%;
        height: 50px;
        background: #FF6699;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 20px;
    }
    button:hover { background: #FF3366; }
</style>
</head>
<body>

<div class="container">
    <h2>회원 정보 조회</h2>
	<!-- 목록으로 돌아가기 버튼 -->
    <a href="../admin/adminUserManagement.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <div class="input-box">
        <label><strong>아이디</strong></label>
        <input type="text" value="${userInfo.user_id}" readonly>
    </div>

    <div class="input-box">
        <label><strong>이름</strong></label>
        <input type="text" value="${userInfo.username}" readonly>
    </div>

	<div class="input-box">
	    <label><strong>생년월일</strong></label>
	    <input type="text" value="<fmt:formatDate value='${userInfo.birth}' pattern='yyyy-MM-dd' />" readonly>
	</div>

    <div class="input-box">
        <label><strong>이메일</strong></label>
        <input type="text" value="${userInfo.email}" readonly>
    </div>

    <div class="input-box">
        <label><strong>전화번호</strong></label>
        <input type="text" value="${userInfo.phone}" readonly>
    </div>

    <div class="input-box">
        <label><strong>주소</strong></label>
        <input type="text" value="${userInfo.addr}" readonly>
    </div>

    <div class="input-box">
        <label><strong>성별</strong></label>
        <input type="text" value="${userInfo.gender}" readonly>
    </div>
    <button onclick="location.href='../admin/adminAccAcceptByAdmin.html?userId=${userInfo.user_id}'">
        숙소 수정 목록 조회하기
    </button>
    <button onclick="location.href='../admin/adminPendingAccByAdmin.html?userId=${userInfo.user_id}'">
        승인대기 숙소 목록 조회하기
    </button>
    <button onclick="location.href='../admin/adminRegisteredAccByAdmin.html?userId=${userInfo.user_id}'">
        등록된 숙소 목록 조회하기
    </button>
    <button onclick="location.href='../admin/userReservList.html?userId=${userInfo.user_id}'">
        예약 목록 조회하기
    </button>
    <button onclick="location.href='../admin/userInqList.html?userId=${userInfo.user_id}'">
        문의 목록 조회하기
    </button>
</div>

</body>
</html>