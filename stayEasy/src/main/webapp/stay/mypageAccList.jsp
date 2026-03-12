<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>마이페이지 예약 리스트</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
.body {
	background-color: #f8f9fa;
}
/* 돌아가기 텍스트를 가운데 정렬 */
.back-text {
    display: block; /* 블록 요소로 변경하여 한 줄 차지 */
    text-align: center; /* 가운데 정렬 */
    font-size: 25px;
    color: #666;
    font-weight: bold;
    margin-top: 10px;
    transition: color 0.3s ease-in-out;
    text-decoration: none;
}

.back-text:hover {
    color: #ff6b81;
    text-decoration: none;
}
.back-button {
    font-weight: bold;
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px 10px;
	}

</style>
<link rel="stylesheet" type="text/css" href="../css/mypageacc.css">
</head>
<body>
<div class="container">
    <h1>
        <c:choose>
            <c:when test="${sessionScope.loginUser.id == 'admin'}">예약 내역</c:when>
            <c:otherwise>나의 예약 내역</c:otherwise>
        </c:choose>
    </h1>
    <c:choose>
        <c:when test="${empty reservList}">
            <p class="no-reservations">현재 예약 내역이 없습니다.</p>
            <div></div>
            <a href="../mypage/mypageMain.html" class="back-text">돌아가기</a>
        </c:when>
        <c:otherwise>
        	<c:choose>
        		<c:when test="${sessionScope.loginUser.id == 'admin' }">
	        		<!-- 목록으로 돌아가기 버튼 (POST 방식) -->
					<form action="../admin/viewUserInfo.html" method="post" style="display: inline;">
					    <input type="hidden" name="user_id" value="${param.userId}">
					    <button type="submit" class="back-button">
					        <i class="fas fa-arrow-left"></i>
					    </button>
					</form>
        		</c:when>
        		<c:otherwise>        		
		        	<a href="../mypage/mypageMain.html" class="back-button">
			        	<i class="fas fa-arrow-left"></i>
					</a>
        		</c:otherwise>
        	</c:choose>
            <c:forEach var="reservation" items="${reservList}">
                <div class="cart-item">
                    <img src="${pageContext.request.contextPath}/imgs/${reservation.room.room_image}" alt="객실 이미지" />
                    <div class="cart-info">
                        <h2>${reservation.room.accommodation.accname}</h2>
                        <p>예약번호: ${reservation.reservation_id}</p>
                        <p>예약날짜: <fmt:formatDate value="${reservation.r_date}" pattern="yyyy-MM-dd"/></p>
                        <p>방: ${reservation.room.name}</p>
                        <p>1박: <fmt:formatNumber value="${reservation.room.price_per_night}" pattern="#,###"/>원</p>
                        <p>인원: ${reservation.count}명</p>
	                    <p>체크인: <fmt:formatDate value="${reservation.check_in_date}" pattern="yyyy-MM-dd"/></p>
	                    <p>체크아웃: <fmt:formatDate value="${reservation.check_out_date}" pattern="yyyy-MM-dd"/></p>
	                    <p>숙박일: ${reservation.nights}박</p>
                       	<div class="date-box">
                          	  총 결제금액: <fmt:formatNumber value="${reservation.total_price}" pattern="#,###"/>원
                        </div>
                        <c:if test="${reservation.check_in_date > today}">
                            <button class="cancel-btn" onclick="cancelReservation('${reservation.reservation_id}')">예약 취소</button>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script>
function cancelReservation(reservationId) {
    if (confirm('정말로 예약을 취소하시겠습니까?')) {
        location.href = '../mypage/cancelReserv.html?reservation_id=' + reservationId;
    }
}
</script>
</body>
</html>
