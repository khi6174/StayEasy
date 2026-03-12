<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.Accommodation" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 상세 정보</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
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
    background-color: #ffccdc;
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
    width: 45%; 
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.room-section {
    width: 65%;  
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
    background-color: #f9f9f9;
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
    border: 1px solid #FFC1D6;
    padding: 15px 20px;
    text-align: center;
}

th {
    background-color: #FF8FA3;
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

.approve-btn-container {
    width: 100%;          
    text-align: center;     
    margin-top: 30px;       
}

.approve-btn {
    background: linear-gradient(135deg, #FF758F, #FF92A5);
    color: #ffffff;
    border: none;
    padding: 12px 30px;
    border-radius: 25px;
    cursor: pointer;
    width: 200px;
    font-size: 18px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    transition: background 0.3s ease;
    display: inline-block;
}

.approve-btn:hover {
    background: #FF5F7E;
}
	/* 목록으로 돌아가기 버튼 (기존 스타일 유지) */
	.back-button {
	    font-weight: bold;
	    background: none;
	    border: none;
	    cursor: pointer;
	    padding: 5px 10px;
	}
</style>
</head>
<body>

<div class="container">
    <div class="info-section">
    <c:choose>
    	<c:when test="${not empty param.userId and param.userId != ''}">
		    <!-- 목록으로 돌아가기 버튼 (POST 방식) -->
			<form action="../admin/adminPendingAccByAdmin.html" method="post" style="display: inline;">
			    <input type="hidden" name="userId" value="${param.userId}">
			    <button type="submit" class="back-button">
			        <i class="fas fa-arrow-left"></i>
			    </button>
			</form>
    	</c:when>
    	<c:otherwise>
			<!-- 목록으로 돌아가기 버튼 -->
		    <a href="../admin/adminPendingAcc.html" class="back-button">
		        <i class="fas fa-arrow-left"></i>
		    </a>
    	</c:otherwise>
    </c:choose>
        <div class="table-title">승인 대기 숙소 상세 정보</div>

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
            <td>${accommodation.category_id}</td>
        </tr>
        <tr>
            <th>등록자명</th>
            <td>${accommodation.username}</td>
        </tr>
        <tr>
            <th>위치</th>
            <td>${accommodation.location}</td>
        </tr>
        <tr>
            <th>연락처</th>
            <td>${accommodation.phone}</td>
        </tr>
        <tr>
            <th>숙소 설명</th>
            <td>${accommodation.description}</td>
        </tr>
    </table>
    </div>

    <!-- 공백 추가 -->
    <div style="height: 30px;"></div>

	<div class="room-section">
	<br/>
        <div class="table-title">방 정보</div>    <table>
        <tr>
            <th>방 번호</th>
            <th>방 이름</th>
            <th>방 사진</th>
            <th>1박 요금</th>
            <th>최대 인원</th>
        </tr>
        <c:forEach var="room" items="${rooms}">
            <tr>
                <td>${room.room_id}</td>
                <td>${room.room_name}</td>
                <td><img src="${pageContext.request.contextPath}/imgs/${room.room_image}" width="80"></td>
                <td>${room.room_price} 원</td>
                <td>${room.room_capacity} 명</td>
            </tr>
        </c:forEach>
    </table>
    </div>
   </div>

<div class="approve-btn-container">
    <form action="<c:url value='/admin/approveAccommodation.html'/>" method="POST">
        <input type="hidden" name="accommodationId" value="${accommodation.accommodation_id}" />
        <button type="submit" class="approve-btn" name="btn" value="승인">승인</button>
        <button type="submit" class="approve-btn" name="btn" value="거절">거절</button>
   	</form>
</div>

</body>
</html>