<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자 문의 답변</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
body {
    background-color: #f8f9fa;
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}

/* 전체 테이블 */
.table {
    width: 620px;
    margin: 40px auto;
    margin-top: 0;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
    border-collapse: separate;
    border-spacing: 0 15px;
}

/* 항목 제목 셀 */
.table th {
    width: 140px;
    background-color: #f1f1f1;
    text-align: left;
    font-weight: bold;
    padding: 10px 12px;
    border-radius: 8px;
    color: #333;
    vertical-align: top;
}

/* 입력 영역 셀 */
.table td {
    padding: 10px 12px;
    vertical-align: top;
}

/* 입력 요소 스타일 */
input[type="text"], textarea, select {
    width: 100%;
    padding: 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 10px;
    transition: border-color 0.2s ease-in-out;
    box-sizing: border-box;
    resize: vertical;
}

input[type="text"]:focus,
textarea:focus,
select:focus {
    border-color: #ff7a99;
    outline: none;
}

/* 오류 메시지 */
font[color="red"] {
    display: block;
    margin-top: 6px;
    font-size: 13px;
}

/* 버튼 영역 */
.center {
    text-align: center;
    padding-top: 25px;
}

input[type="submit"],
input[type="reset"] {
    background-color: #ff7a99;
    color: white;
    border: none;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 10px;
    margin: 0 10px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

input[type="submit"]:hover,
input[type="reset"]:hover {
    background-color: #ff4f78;
    transform: translateY(-2px);
}

</style>
<script>
// 예약 선택 시 예약번호 자동 입력
function updateReservId(select) {
    const reservId = select.value;
    document.getElementById("reserv_id_input").value = reservId;
}
</script>
</head>

<body>

<form:form action="../inquire/replyDo.html" method="post" modelAttribute="inquire">
	<br/>
	<!-- 목록으로 돌아가기 버튼 -->
    <a href="../inquire/detail.html?inquire_id=${param.inquire_id}" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <!-- 숨겨진 필드들 -->
    <form:hidden path="order_no" />
    <form:hidden path="group_id" />
    <form:hidden path="parent_id" />
    <form:hidden path="inquire_id"/>
    <form:hidden path="reservation.reservation_id" id="reserv_id_input" /> <!-- 선택된 예약 ID 저장 -->

    <table class="table">
        <!-- 문의 번호 -->
        <tr>
            <th>문의 번호</th>
            <td>${inquire.inquire_id }</td>
        </tr>
        <tr>
            <th>예약 번호</th>
            <td>${inquire.reservation.reservation_id}</td>
        </tr>
        <!-- 예약 선택 -->
        <tr>
            <th>예약한 숙소</th>
      		<td>${acc.accname}</td>
        </tr>
         <tr>
            <th>예약한 방</th>
      		<td>${reservation.room.name}</td>
        </tr>
        <tr>
        	<th>예약일</th>
        	<td><fmt:formatDate value="${reservation.r_date}" pattern="yyyy-MM-dd" /></td>
        	
        </tr>
        
        <tr>
            <th>예약자</th>
            <td>${reservation.user.user_id}</td>
        </tr>

        <!-- 작성자 -->
        <tr>
            <th>작성자</th>
            <td>${sessionScope.loginUser.id}</td>
        </tr>

        <!-- 제목 -->
        <tr>
            <th>제목</th>
            <td>
                <form:input path="title" value="${title}" />
                <font color="red"><form:errors path="title" /></font>
            </td>
        </tr>

        <!-- 내용 -->
        <tr>
            <th>내 용</th>
            <td>
                <form:textarea path="content" rows="8" cols="60" />
                <font color="red"><form:errors path="content" /></font>
            </td>
        </tr>

	    <tr>
	        <th>답변 상태</th>
	        <td>
	            <form:input path="status" readonly="true"/>
	        </td>
	    </tr>

        <!-- 작성일 -->
        <tr>
            <th>문의 작성일</th>
            <td><fmt:formatDate value="${i_date}" pattern="yyyy-MM-dd" /></td>
        </tr>

        <!-- 버튼 -->
        <tr>
            <td colspan="2" class="center">
                <input type="submit" value="답변하기" />
                <input type="reset" value="취소" />
            </td>
        </tr>
    </table>
</form:form>

</body>
</html>
