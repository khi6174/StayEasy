<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 상세화면</title>
<!-- jQuery & jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>

<style>
/* 전체 컨테이너 */
.body {
	background-color: #f8f9fa;
}
.container {
    display: flex;
    gap: 20px;
    justify-content: center;
    max-width: 1200px;
    margin: auto;
}

.left-panel {
    width: 65%;
}
/* 방 리스트 스타일 */
.right-panel {
    width: 35%;
    overflow-y: auto;
    max-height: 600px;
    padding-left: 20px;
}

/* 체크인, 체크아웃, 인원 수 입력 스타일 */
.check-info {
    display: flex;
    justify-content: center;
    gap: 15px;
    align-items: center;
    padding: 10px 0;
    background-color: #f8f9fa;
    border-radius: 10px;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
}

.check-info label {
    font-weight: bold;
    color: #333;
}

.check-info input {
    width: 120px;
    padding: 8px;
    border: 2px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    text-align: center;
    transition: border-color 0.3s;
}

.check-info input:focus {
    border-color: #007BFF;
    outline: none;
}

/* 숙소 이미지 */
.hotel-image img {
    width: 100%;
    height: 450px;
    min-width: 400px; /* 최소 너비 지정 */
    min-height: 300px; /* 최소 높이 지정 */
    object-fit: cover;
    border-radius: 10px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
}

/* 숙소 설명 */
.left-panel h2 {
    font-size: 24px;
    margin-top: 15px;
}
.left-panel p {
    font-size: 16px;
    color: #555;
}

/* 방 컨테이너 스타일 */
.room-table {
    width: 100%;
    border: 2px solid #ddd;
    border-radius: 10px;
    overflow: hidden;
    margin-bottom: 15px;
    transition: all 0.3s ease-in-out;
    background-color: white;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

.room-table:hover {
    transform: scale(1.02);
    box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
}

/* 방 이미지 */
.room-image {
    width: 100%;
    height: auto;
    border-bottom: 1px solid #ddd;
}

/* 방 선택 버튼 */
.reserve-btn {
    background-color: #007BFF;
    color: white;
    font-size: 14px;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
    transition: background-color 0.3s, transform 0.2s;
}

.reserve-btn:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

/* 선택한 방 강조 (테두리 & 버튼 색 변경) */
.selected-room {
    border: 3px solid #007BFF !important;
    box-shadow: 0px 0px 12px rgba(0, 123, 255, 0.5);
}

.selected-room .reserve-btn {
    background-color: #0056b3;
    color: #fff;
}

.selected-room .reserve-btn:hover {
    background-color: #004494;
    transform: scale(1.05);
}

/* 버튼 스타일 */
.btn {
    padding: 10px 15px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    font-size: 16px;
    font-weight: bold;
}
.btn:hover {
    opacity: 0.9;
}

/* 예약하기 & 장바구니 버튼 */
.button-wrap {
    display: none;  /* 기본적으로 숨김 */
    justify-content: center;
    gap: 20px;
    margin-top: -10px; /* 살짝 위로 조정 */
}

/* 예약 & 장바구니 버튼 스타일 */
#finalReserveBtn, #cart-btn {
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    cursor: pointer;
    border: none;
}

/* 예약하기 버튼 */
#finalReserveBtn {
    background-color: #28a745;
    color: white;
}


#finalReserveBtn:hover {
    background-color: #218838;
    transform: scale(1.05);
}

/* 장바구니 버튼 */
#cart-btn {
    background-color: #ff9800;
    color: white;
}

#cart-btn:hover {
    background-color: #e68900;
    transform: scale(1.05);
}


</style>
</head>

<body>
<c:if test="${message != null}">
    <script>alert("${message}");</script>
</c:if>

<form:form modelAttribute="reservation">
<form:hidden path="room.id.accommodationId" value="${ACC.accommodation_id}"/>
<form:hidden path="room.id.roomId" id="roomIdHidden"/>
<a href="../reserv/reservList.html?TYPE=${TYPE }&pageNo=1" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<!-- 예약 정보 입력 (상단으로 이동) -->
<div class="check-info">
    <label>체크인:</label> <form:input path="check_in_date" type="text" disabled="true"/>
    <label>체크아웃:</label> <form:input path="check_out_date" type="text" disabled="true"/>
    <label>인원수:</label> <form:input path="count" type="number" cssClass="person" id="countInput" value="1" min="1"/>
   
	<div class="button-wrap">
    <button type="button" id="finalReserveBtn" onclick="submitForm('../reserv/reservGo.html')">예약하기</button>
    <button type="button" id="cart-btn" onclick="submitForm('../cart/addCart.html')">장바구니</button>
  	<c:if test="${not empty message}">
		    <script>
		        alert("${message}");
		    </script>
	</c:if>
	</div>
</div>
<!-- 본문 -->
<div class="container">
    <div class="left-panel">
    <div class="hotel-image">
        <img src="${pageContext.request.contextPath}/imgs/${ACC.acc_image}" alt="숙박 이미지">
    </div>
    <h2>${ACC.accname}</h2>
    <p>위치: ${ACC.location}</p>
    <p>${ACC.description}</p>
    <button type="button" class="btn" onclick="goToPage('../review/list.html?ACC=${ACC.accommodation_id}')">리뷰 보러가기</button>
</div>

    <div class="right-panel">
    <c:forEach var="room" items="${RoomList}">
        <table class="room-table" data-room-id="${room.id.roomId}">
            <tr><td colspan="2"><img class="room-image" src="${pageContext.request.contextPath}/imgs/${room.room_image}" alt="방 이미지"></td></tr>
            <tr><td>${room.name}</td><td>최대 인원: ${room.capacity}</td></tr>
            <tr><td colspan="2">1박 가격: <fmt:formatNumber value="${room.price_per_night}" pattern="#,###"/>원</td></tr>
            <tr>
                <td class="center" colspan="2">
                    <button class="btn reserve-btn" type="button">방 선택하기</button>
                </td>
            </tr>
        </table>
    </c:forEach>
</div>
</div>
</form:form>
<script>
function openCartPopup() {
    let form = document.getElementById("cartForm");
    let formData = new FormData(form);
    let actionUrl = form.getAttribute("action");

    let popupWindow = window.open("", "cartPopup", "width=400,height=300");

    form.target = "cartPopup"; // 팝업 창에서 결과를 띄우기
    form.submit();
}
</script>
<script type="text/javascript">
var reservedDates = ${reservedDatesJson};
let selectedRoomId = null, unavailableDates = [];

$(document).ready(function() { initDatepicker(); });

$(document).ready(function() {
    $(".reserve-btn").click(function() {
        const roomTable = $(this).closest(".room-table");
        selectedRoomId = roomTable.data("room-id");

        // 기존 선택된 방 스타일 초기화
        $(".room-table").removeClass("selected-room");

        // 선택한 방 스타일 강조 (테두리 & 버튼 색 변경)
        roomTable.addClass("selected-room");

        // 예약 & 장바구니 버튼 보이기 (display: flex 적용)
        $(".button-wrap").css("display", "flex");

        // 방 선택 시 입력 가능하게 변경
        $("#check_in_date").prop("disabled", false);
        $("#check_out_date").prop("disabled", false);
        $("#count").prop("disabled", false);

        // 선택한 roomID를 hidden 필드에 저장
        $("#roomIdHidden").val(selectedRoomId);

        const checkInDates = reservedDates[selectedRoomId]?.checkInDates.map(d => d.split(" ")[0]) || [];
        const checkOutDates = reservedDates[selectedRoomId]?.checkOutDates.map(d => d.split(" ")[0]) || [];

        unavailableDates = [];
        for (let i = 0; i < checkInDates.length; i++) {
            const start = new Date(checkInDates[i]), end = new Date(checkOutDates[i]);
            for (let d = new Date(start); d < end; d.setDate(d.getDate() + 1)) {
                unavailableDates.push($.datepicker.formatDate("yy-mm-dd", d));
            }
        }
        initDatepicker();
    });
});


function initDatepicker() {
    $('input[name="check_in_date"]').datepicker('destroy').datepicker({
        dateFormat: 'yy-mm-dd',
        minDate: 0,
        beforeShowDay: function(date) {
            let formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
            return unavailableDates.includes(formattedDate) ? [false] : [true];
        },
        onSelect: function(selectedDate) {
            let minCheckoutDate = new Date(selectedDate);
            minCheckoutDate.setDate(minCheckoutDate.getDate() + 1); // 체크인 다음 날부터 선택 가능
            $('input[name="check_out_date"]').datepicker('destroy').datepicker({
                dateFormat: 'yy-mm-dd',
                minDate: minCheckoutDate, // 체크인 날짜 +1일부터 선택 가능
                beforeShowDay: function(date) {
                    let formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
                    return unavailableDates.includes(formattedDate) ? [false] : [true];
                }
            });
        }
    });

    // 체크아웃 datepicker 초기화
    $('input[name="check_out_date"]').datepicker('destroy').datepicker({
        dateFormat: 'yy-mm-dd',
        minDate: 1, // 체크인 날짜 선택 전까지는 최소 하루 이후로 설정
        beforeShowDay: function(date) {
            let formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
            return unavailableDates.includes(formattedDate) ? [false] : [true];
        }
    });
}


function submitForm(url) { $('form').attr('action', url).submit(); }
function goToPage(url) { location.href = url; }

//체크인, 체크아웃, 인원수가 비어 있을때 안내 alert창 띄우기
function submitForm(url) {
    const checkIn = $('input[name="check_in_date"]').val();
    const checkOut = $('input[name="check_out_date"]').val();
    const count = $('input[name="count"]').val();

    // 값이 비어있는 경우 알림 표시
    if (!checkIn) {
        alert('체크인 날짜를 선택해주세요.');
        return;
    }
    if (!checkOut) {
        alert('체크아웃 날짜를 선택해주세요.');
        return;
    }
    
    if (checkIn === checkOut) {
        alert('체크인과 체크아웃 날짜가 동일할 수 없습니다.');
        return;
    }
    
    if (!count || count <= 0) {
        alert('인원 수를 1명 이상 입력해주세요.');
        return;
    }

    // 모두 입력되었을 때만 submit
    $('form').attr('action', url).submit();
}
function goToPage(url) {
    location.href = url;
}
</script>
</body>
</html>