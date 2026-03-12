<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
.body {
	background-color: #f8f9fa;
}
.container {
    display: flex;
    flex-direction: column; 
    gap: 20px;
    max-width: 1000px; /* 가로 길이 확장 */
    width: 90%; /* 화면 너비에 가깝게 설정 */
    margin: 50px auto;
    background-color: #fff;
    padding: 40px 60px; /* 좌우 패딩 추가 */
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    border: 1px solid #ddd;
}

.motel-title {
    text-align: center;
    width: 100%;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
}

.hotel-image {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.hotel-image img {
    max-width: 400px;        /* 이미지 크기 제한 */
    max-height: 250px;
    width: auto;             /* 부모를 채우지 않도록 설정 */
    height: auto;
    object-fit: cover;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    display: block;
}


.info-box {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.info-box div {
    flex: 1;
    background-color: #ffc9d8;
    text-align: center;
    padding: 15px 0;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    font-size: 15px;
}

.info-text {
    background-color: #fff5f5;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); 
}

.btn {
    width: 100%;
    height: 45px;
    background-color: #ff7f9c;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.btn:hover {
    background-color: #d83f5b;
}


</style>
<meta charset="EUC-KR">
<title>예약하기 화면</title>
</head>
<body>
<div align="center">
    <h1>숙박 예약하기</h1>
</div>

<div class="container">
	<!-- 목록으로 돌아가기 버튼 -->
    <a href="../reserv/reservDatil.html?accID=${ACC.accommodation_id}" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <div class="motel-title">${ACC.accname}</div>

        <div class="hotel-image">
            <img src="${pageContext.request.contextPath}/imgs/${roomInfo.room_image}"
             alt="방 이미지" class="acc-image">
  		</div>

        <form:form action="../reserv/reservPay.html" method="post" modelAttribute="reservation">
            <form:hidden path="room.id.roomId" value="${roomInfo.id.roomId}"/>
            <form:hidden path="room.id.accommodationId" value="${roomInfo.id.accommodationId}"/>
            
            <div class="info-box">
                <div>
                    <strong>체크인</strong><br/>
                    <fmt:formatDate value="${reservation.check_in_date}" pattern="yyyy-MM-dd"/>
                    <form:hidden path="check_in_date"/>
                </div>
                <div>
                    <strong>체크아웃</strong><br/>
                    <fmt:formatDate value="${reservation.check_out_date}" pattern="yyyy-MM-dd"/>
                    <form:hidden path="check_out_date"/>
                </div>
            </div>

            <div class="info-text">
                방 이름: ${roomInfo.name }<br/>
                1박 요금: ${roomInfo.price_per_night}원<br/>
                인원 수: ${reservation.count} 명
                <form:hidden path="count"/>
                <br/><br/>
                <strong>총 결제 금액: ${reservation.total_price}원</strong>
                <form:hidden path="total_price"/>
            </div>
            <br/>
            <input type="submit" value="결제하기" class="btn"/>
        </form:form>
    </div>
</body>
</html>