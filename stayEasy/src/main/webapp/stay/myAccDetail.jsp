<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 숙소 상세 정보</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
body {
    font-family: Arial, sans-serif;
    color: #333;
    background-color: #f8f9fa;
    margin: 0;
    padding-top: 5px;
    width: 100vw;
    min-width: 1400px;
}

.header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background-color: #A7C7E7;
    z-index: 1000;
    padding: 10px 0;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.container {
    width: 70vw;
    max-width: 2500px;
    height: auto;
    display: flex;
    justify-content: space-between;
    background: #ffffff;
    border-radius: 20px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    overflow: hidden;
    padding: 30px;
    margin: 20px auto;
    gap: 30px;
}

.info-section {
    width: 60%;
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.room-section {
    width: 60%;
    display: flex;
    flex-direction: column;
    gap: 15px;
    align-self: flex-start;
}


h3 {
    font-size: 26px;
    font-weight: 700;
    color: #333;
    margin-bottom: 10px;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: #E0F7FA;  
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
}
.table-title {
    font-size: 26px;     
    font-weight: 700;    
    color: #333;           
    text-align: center;    
    margin-bottom: 10px;
}

th, td {
    border: 1px solid #A7C7E7;
    padding: 15px 20px;
    text-align: center;
}

th {
    background-color: #A7C7E7; 
    color: #ffffff;
    font-weight: bold;
    font-size: 15px;
}

td {
    background-color: white;
    font-size: 15px;
}

img[alt="방 사진"] {
    border-radius: 10px;
    width: 100px;
    height: 80px;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
}
back-button {
	margin-bottom: 0;
}
</style>
</head>
<body>

<div class="container">
    <div class="info-section">
    <!-- 목록으로 돌아가기 버튼 -->
    <a href="../acc/myAccommodations.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
        <div class="table-title">내 숙소 상세 정보</div>
        
    <table>
        <tr>
        <th>대표 사진</th>
            <td><img src="${pageContext.request.contextPath}/imgs/${accommodation.acc_image}" alt="숙소 사진" width="200"></td>
        </tr>
        <tr>
            <th>숙소명</th>
            <td>${accommodation.accname}</td>
        </tr>
        <tr>
            <th>숙소 유형</th>
            <td>${accommodation.category.category_id}</td>
        </tr>
        <tr>
            <th>위치</th>
            <td>${accommodation.location}</td>
        </tr>
        <tr>
            <th>등록자명</th>
            <td>${accommodation.user.username}</td>
        </tr>
        <tr>
            <th>연락처</th>
            <td>${accommodation.user.phone}</td>
        </tr>
        <tr>
            <th>숙소 설명</th>
            <td>${accommodation.description}</td>
        </tr>
    </table>
    </div>
    
    <div style="height: 30px;"></div>
    

	<div class="room-section">
		<br/><br/>
        <div class="table-title">방 정보</div>    
        <table>
        <tr>
            <th>방 이름</th>
            <th>방 사진</th>
            <th>가격</th>
            <th>수용 인원</th>
        </tr>
        <c:forEach var="room" items="${rooms}">
            <tr>
                <td>${room.name}</td>
                <td>
                    <img src="${pageContext.request.contextPath}/imgs/${room.room_image}" alt="방 사진" style="width: 100px; height: 80px;">
                </td>
                <td><fmt:formatNumber value="${room.price_per_night}" pattern="#,###"/>원</td>
                <td>${room.capacity}</td>
            </tr>
        </c:forEach>
    </table>
    </div>
</div>

</body>
</html>