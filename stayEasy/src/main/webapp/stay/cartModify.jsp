<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        display: flex; 
        justify-content: center;
        align-items: flex-start;
        max-width: 60%;
        margin: 20px auto;
        gap: 40px;
    }
    .left-panel img {
        width: 350px; 
        height: auto;
        border-radius: 10px;
        box-shadow: 2px 2px 10px rgba(0,0,0,0.2);
    }
    .right-panel {
        width: 60%;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 2px 2px 10px rgba(0,0,0,0.2);
        background: #f9f9f9;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }
    .form-group input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .error {
        color: red;
        font-size: 0.9em;
    }
    .btn {
        display: block;   
        width: 100%;
        height: 45px;
        font-size: 16px;
        font-weight: bold;
        background-color: #28a745;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        margin-top: 20px;
        transition: background-color 0.3s ease;
    } 
    .btn:hover {
        background-color: #218838;
    }
    .person { 
        width: 60px !important; /* 입력 필드 크기 조정 */
        padding: 5px;
    }
    .date-input {
        width: 140px !important; /* 날짜 입력칸 크기 조정 */
        padding: 5px;
    }
     .date-group {
        display: flex;
        align-items: center;
        gap: 10px; /* 체크인과 체크아웃 사이 간격 */
    }

    .date-group label {
        font-weight: bold;
    }

    .date-input {
        width: 120px !important; /* 입력 칸 크기 조정 */
        padding: 5px;
        text-align: center;
    }

    .error {
        display: block;
        color: red;
        font-size: 0.9em;
        margin-top: 5px;
    }
    
</style>
<meta charset="EUC-KR">
<title>장바구니 숙박 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

</head>
<body>
<c:if test="${message != null}">
	<script>
		alert("${message}");
	</script>
</c:if>
<div align="center">
    <h1>숙박 예약 수정하기</h1>
    <h2>${acc.accname}</h2>
</div>
<div class="container">
    <div class="left-panel">
    <!-- 목록으로 돌아가기 버튼 -->
    <a href="../cart/cartList.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
        <img src="${pageContext.request.contextPath}/imgs/${cartItem.room.room_image}"
             alt="숙박 이미지">
    </div>

    <div class="right-panel">
        <form:form action="../cart/modifyDo.html" method="post" modelAttribute="cartItem">
        	<form:hidden path="cartitem_id"/>
        	<form:hidden path="user.user_id"/>
            <form:hidden path="room.id.roomId"/>
            <form:hidden path="room.id.accommodationId"/>

            <div class="form-group">
				<label>기존 날짜:</label>
                <fmt:formatDate value="${cartItem.check_in_date}" pattern="yyyy-MM-dd"/>
                ~ 
                <fmt:formatDate value="${cartItem.check_out_date}" pattern="yyyy-MM-dd"/>
            </div>
            
            <div class="form-group">
                <label>기존 인원</label>
                <p>${cartItem.count}명</p>
            </div>

            <div class="form-group date-group">
		    <label>체크인</label>
		    <form:input path="check_in_date" type="text" class="date-input" id="checkIn"/>
		    
		    <label>체크아웃</label>
		    <form:input path="check_out_date" type="text" class="date-input" id="checkOut"/>
			</div>
			
			<span class="error"><form:errors path="check_in_date"/> <form:errors path="check_out_date"/></span>
			
			<div class="form-group">
			    <label>숙박 기간</label>
			    <p id="nightsStay">0 박</p>
			</div>
			

            <div class="form-group">
                <label>방 이름</label>
                <p>${cartItem.room.name}</p>
            </div>

            <div class="form-group">
                <label>인원 수</label>
			    <form:input path="count" type="number" class="person" id="countInput" min="1"/>명
			    <span class="error"><form:errors path="count"/></span>
            </div>

            <div class="form-group">
                <label>1박 가격</label>
                <p id="pricePerNight">
                <fmt:formatNumber value="${cartItem.room.price_per_night}" pattern="#,###"/>원</p>
            </div>

            <div class="form-group">
                <label>총 결제 금액</label>
                <p id="totalPrice">${cartItem.total_price} 원</p>
                <form:hidden path="total_price" id="hiddenTotalPrice"/>
            </div>

            <input type="submit" value="수정하기" class="btn"/>
        </form:form>
    </div>
</div>
</body>
<script type="text/javascript">
// 컨트롤러에서 가져온 예약된 날짜 정보 (checkInDates, checkOutDates)
var reservedDates = ${reservedDatesJson};

// 예약된 날짜 구간을 모두 막기 위해 날짜 범위로 변환
let unavailableDates = [];

// checkInDates와 checkOutDates 배열이 존재할 때만 동작
const checkInDates = reservedDates.checkInDates || [];
const checkOutDates = reservedDates.checkOutDates || [];

for (let i = 0; i < checkInDates.length; i++) {
    const start = new Date(checkInDates[i]);
    const end = new Date(checkOutDates[i]);

    // start ~ end 바로 전날까지 반복
    for (let d = new Date(start); d < end; d.setDate(d.getDate() + 1)) {
        const formattedDate = $.datepicker.formatDate('yy-mm-dd', d);
        unavailableDates.push(formattedDate);
    }
}

// 중복 제거 (혹시 몰라서)
unavailableDates = [...new Set(unavailableDates)];

console.log('예약 불가능 날짜 목록:', unavailableDates); // 콘솔 확인

// datepicker 적용 (체크인, 체크아웃)
$('input[name="check_in_date"], input[name="check_out_date"]').datepicker('destroy').datepicker({
    dateFormat: 'yy-mm-dd',
    minDate: 0, // 오늘 이후
    beforeShowDay: function(date) {
        const formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
        // 예약 불가능 날짜면 선택 불가
        if (unavailableDates.includes(formattedDate)) {
            return [false, "", "예약 불가"];
        }
        return [true, "", ""]; // 예약 가능
    }
});

// 총 결제 금액 계산 함수
document.addEventListener("DOMContentLoaded", function () {
    let countInput = document.getElementById("countInput");
    let checkInInput = document.getElementById("checkIn");
    let checkOutInput = document.getElementById("checkOut");
    let pricePerNight = ${cartItem.room.price_per_night}; // JSP에서 1박 가격 가져오기
    let totalPriceElement = document.getElementById("totalPrice");
    let nightsStayElement = document.getElementById("nightsStay");
    let hiddenTotalPrice = document.getElementById("hiddenTotalPrice");

    function updateTotalPrice() {
        let count = parseInt(countInput.value) || 1; // 인원 수 (기본 1)
        let checkInDate = new Date(checkInInput.value);
        let checkOutDate = new Date(checkOutInput.value);

        if (!isNaN(checkInDate) && !isNaN(checkOutDate)) {
            // 시간 제거해서 날짜만 비교
            checkInDate.setHours(0, 0, 0, 0);
            checkOutDate.setHours(0, 0, 0, 0);

            let nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));

            if (nights > 0) {
                nightsStayElement.textContent = nights + " 박";
                let totalPrice = pricePerNight * nights * count;
                totalPriceElement.textContent = totalPrice.toLocaleString() + " 원"; // 천 단위 콤마
                hiddenTotalPrice.value = totalPrice;
            } else {
                nightsStayElement.textContent = "0 박";
                totalPriceElement.textContent = "0 원";
                alert("체크아웃 날짜는 체크인 날짜보다 이후여야 합니다.");
            }
        } else {
            nightsStayElement.textContent = "0 박";
            totalPriceElement.textContent = "0 원";
        }
    }

    // 페이지 로드 시 자동 계산
    if (checkInInput.value && checkOutInput.value) {
        updateTotalPrice();
    }

    // 값이 바뀔 때마다 자동으로 업데이트
    countInput.addEventListener("input", updateTotalPrice);
    checkInInput.addEventListener("input", updateTotalPrice);
    checkOutInput.addEventListener("input", updateTotalPrice);
});
</script>
</html>
