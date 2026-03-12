<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>StayEasy</title>

<!-- 최신 Swiper CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<link rel="stylesheet" type="text/css" href="../css/footer.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<style>

/* 검색창 배경을 위한 스타일 */
.search-background {
    width: 100%;
    background-image: url('../imgs/sea.jpg'); /* 배경 이미지 경로 */
    background-size: cover;
    background-position: center;
    padding: 50px; /* 위아래 여백 추가 */
    display: flex;
    justify-content: center; /* 중앙 정렬 */
}

/* 검색 컨테이너 스타일 */
.search-container {
    width: 80%;
    max-width: 1100px;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* 숙소 검색 제목 스타일 */
.search-container h2 {
    margin-bottom: 25px; /* 제목과 버튼 간격 증가 */
}

/* 숙소 유형 선택 버튼 (왼쪽 정렬) */
.type-selection {
    display: flex;
    justify-content: flex-start;
    gap: 8px;
    flex-wrap: wrap;
    margin-bottom: 20px;
}
.type-btn {
    padding: 8px 15px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 20px;
    background-color: white;
    color: black;
    cursor: pointer;
    transition: 0.3s;
}
.type-btn:hover {
    background-color: #f0f0f0;
}
.type-btn.selected {
    background-color: #007bff;
    color: white;
    border: none;
}

/* 검색창 내부 요소 정렬 */
.search-box {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;
}
.search-box input, .search-box button {
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 8px;
}
.search-box input[type="text"] {
    flex: 1;
    min-width: 200px;
}
.search-box input[type="date"], .search-box input[type="number"] {
    width: 140px;
    text-align: center;
}
.search-box button {
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    padding: 10px 15px;
}
.search-box button:hover {
    background-color: #0056b3;
}

</style>
</head>
<body>

<menu>
    <%@ include file="./menu_header.jsp" %>
</menu>

<div class="content">
    <c:choose>
        <c:when test="${ BODY != null }">
            <jsp:include page="${ BODY }"/>
        </c:when>
        <c:otherwise>
		<!-- 검색 컨테이너 배경 추가 -->
		<div class="search-background">
            <!-- 검색창 -->
            <section class="search-container">
                <h2>숙소 검색</h2>
                <form action="../search/result.html" method="POST">
			        <!-- 숙소 유형 선택 버튼 -->
			        <div class="type-selection">
			            <input type="hidden" name="type" id="selectedType" value="">
			            <button type="button" class="type-btn" data-value="MOT">모텔</button>
			            <button type="button" class="type-btn" data-value="HOT">호텔·리조트</button>
			            <button type="button" class="type-btn" data-value="PEN">펜션·풀빌라</button>
			            <button type="button" class="type-btn" data-value="CAM">캠핑·글램핑</button>
			            <button type="button" class="type-btn" data-value="GUE">게스트 하우스</button>
			            <button type="button" class="type-btn" data-value="SPA">공간 대여</button>
			        </div>
			
			        <!-- 검색 입력란 -->
					<div class="search-box">
					    <input type="text" name="KEY" placeholder="여행지나 숙소를 검색해보세요" required>
					    
					    <!-- 체크인 날짜 -->
					    <input type="date" id="checkin" name="CHECKIN" required>
					    
					    <!-- 체크아웃 날짜 -->
					    <input type="date" id="checkout" name="CHECKOUT" required>
					    
					    <input type="number" name="CAPACITY" min="1" value="1" required placeholder="인원수">
					    
					    <button type="submit" id="search-btn">검색</button>
					</div>
			    </form>
            </section>
		</div>
            <!-- 공지사항 & 이벤트 -->
            <section class="info-container">
                <!-- 공지사항 -->
                <div class="notice">
                    <h2><a href="../notice/notice.html">공지사항</a></h2>
                    <ul class="notice-list">
                        <c:forEach var="dto1" items="${NOTICES}">
                            <li>
                                <span class="notice-label">공지</span>
                                <a href="../notice/detail.html?notice_id=${dto1.notice_id}">${dto1.title}</a>
                                <span class="notice-date">
                                    <fmt:formatDate value="${dto1.n_date}" pattern="yyyy.MM.dd"/>
                                </span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="event">
                    <h2><a href="../event/eventList.html">이벤트</a></h2>
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <c:forEach var="dto2" items="${EVENTS}">
                                <div class="swiper-slide">
                                    <a href="../event/detail.html?event_id=${dto2.event_id}">
                                        <img src="${pageContext.request.contextPath}/imgs/${dto2.event_image}" alt="이벤트 이미지">
                                        <div class="event-title">${dto2.title}</div>
                                        <div class="event-date">
                                            <fmt:formatDate value="${dto2.e_date}" pattern="yyyy/MM/dd HH:mm"/>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="./footer.jsp" %>
<!-- 최신 Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<!-- Swiper 슬라이드 초기화 -->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    var swiper = new Swiper(".mySwiper", {
        slidesPerView: 1, // 한 번에 보이는 슬라이드 개수
        spaceBetween: 20, // 슬라이드 간 간격
        loop: true, // 무한 루프 설정
        autoplay: {
            delay: 2000, // 2초마다 자동 전환
            disableOnInteraction: false // 유저가 조작해도 자동 전환 유지
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        }
    });
});
</script>
<!-- 숙소 유형 선택 JavaScript -->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const typeButtons = document.querySelectorAll(".type-btn");
    const selectedTypeInput = document.getElementById("selectedType");

    typeButtons.forEach(button => {
        button.addEventListener("click", function () {
            typeButtons.forEach(btn => btn.classList.remove("selected"));
            this.classList.add("selected");
            selectedTypeInput.value = this.getAttribute("data-value");
        });
    });
});
</script>
<!-- 날짜 설정 스크립트 -->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const checkinInput = document.getElementById("checkin");
    const checkoutInput = document.getElementById("checkout");
    const searchButton = document.getElementById("search-btn");

    // 오늘 날짜 가져오기
    const today = new Date().toISOString().split("T")[0];

    // 체크인 날짜 최소값을 오늘 날짜로 설정
    checkinInput.setAttribute("min", today);
    
    // 체크인 날짜 변경 시 체크아웃 날짜 최소값 설정
    checkinInput.addEventListener("change", function () {
        let checkinDate = new Date(this.value);
        checkinDate.setDate(checkinDate.getDate() + 1); // 체크인 다음 날부터 선택 가능
        checkoutInput.setAttribute("min", checkinDate.toISOString().split("T")[0]);

        // 체크아웃 날짜가 체크인 날짜 이전이면 초기화
        if (checkoutInput.value && checkoutInput.value < this.value) {
            checkoutInput.value = "";
        }
    });

    // 검색 버튼 클릭 시 체크인/체크아웃 값 확인
    searchButton.addEventListener("click", function (event) {
        if (!checkinInput.value || !checkoutInput.value) {
            alert("체크인 및 체크아웃 날짜를 선택하세요.");
            event.preventDefault(); // 폼 전송 방지
        }
    });
});
</script>

</body>
</html>
