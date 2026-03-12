<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>${accname} 리뷰 작성하기</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        width: 50%;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f9f9f9;
    }
    label {
        font-weight: bold;
        display: block;
        margin-top: 10px;
    }
    select, input, textarea, button {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    button {
        cursor: pointer;
        margin-top: 15px;
    }
    .btn-submit {
        background-color: green;
        color: white;
    }
    .btn-reset {
        background-color: red;
        color: white;
    }
</style>
</head>
<body>

<div class="container">
	<!-- 목록으로 돌아가기 버튼 -->
    <a href="../review/list.html?ACC=${ACC}" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <h2>${accname} 리뷰 작성하기</h2>

    <form:form modelAttribute="review" action="../review/input.html?ACC=${ACC}" method="post">
        <!-- 숙소 ID 및 사용자 ID (숨겨진 값) -->
        <input type="hidden" name="user.user_id" value="${sessionScope.loginUser.id}" />

        <!-- 예약 목록 (사용자가 체크아웃한 숙소만 표시) -->
        <label for="reservationId">예약 목록</label>
        <form:select path="reservation.reservation_id">
            <c:forEach var="reserv" items="${reservList}">
                <form:option value="${reserv.reservation_id}">
                    ${reserv.room.name} - 체크인: <fmt:formatDate value="${reserv.check_in_date}" pattern="yyyy/MM/dd"/> 
                    체크아웃: <fmt:formatDate value="${reserv.check_out_date}" pattern="yyyy/MM/dd"/>
                </form:option>
            </c:forEach>
        </form:select>

        <!-- 별점 -->
        <label for="rating">별점</label>
        <form:input type="number" path="rating" min="1" max="5" step="0.5" required="true"/>

        <!-- 리뷰 내용 -->
        <label for="content">내용</label>
        <form:textarea path="content" rows="5" required="true"/>

        <!-- 버튼 -->
        <button type="submit" class="btn-submit">작성하기</button>
        <button type="reset" class="btn-reset">취소</button>
    </form:form>
</div>

</body>
</html>
