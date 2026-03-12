<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 신청하기</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

/* 컨테이너 전체 박스 */
.container {
    max-width: 1200px;
    margin: 50px auto;
    padding: 30px;
    background: white;
    border-radius: 15px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.15);
}

/* 제목 */
.header-title {
    font-size: 26px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 30px;
}

/* 좌우 나누는 flex 컨테이너 */
.content {
    display: flex;
    flex-direction: row; /* 핵심! 위아래가 아니라 옆으로 배치 */
    justify-content: space-between;
    gap: 40px;
    width: 100%;
    flex-wrap: wrap; /* 작은 화면에서도 자동 줄바꿈 */
}

/* 왼쪽/오른쪽 박스 공통 */
.left, .right {
    flex: 1;
    min-width: 400px;
}

/* 입력 필드 박스 */
.input-box {
    margin-bottom: 18px;
    text-align: left;
}

label {
    font-weight: bold;
    display: block;
    margin-bottom: 6px;
}

input[type="text"], input[type="file"], input[type="number"], select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 14px;
}
input[name$="_name"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-top: 5px;
    margin-bottom: 10px;
    box-sizing: border-box;
    font-size: 14px;
}


/* 숙소 대표사진 영역 */
.photo-section {
    margin-top: 25px;
    font-weight: bold;
    text-align: center;
}

/* 방 정보 블럭 */
.room-section {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 18px;
    margin-top: 20px;
    background: #fdfdfd;
    text-align: left;
}

.room-section h4 {
    text-align: center;
    font-size: 16px;
    margin-bottom: 12px;
}

/* 신청하기 버튼 위치 */
.form-footer {
    text-align: center;
    margin-top: 40px;
}

/* 버튼 디자인 */
.submit-btn {
    background-color: #FF6699;
    color: white;
    padding: 12px 26px;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px rgba(255, 102, 153, 0.3);
}

.submit-btn:hover {
    background-color: #FF3366;
    box-shadow: 0 6px 12px rgba(255, 51, 102, 0.5);
    transform: translateY(-2px);
}
.delete-room-btn {
    float: right;
    background: none;
    border: none;
    font-size: 18px;
    color: #999;
    cursor: pointer;
    margin-top: -8px;
}
.delete-room-btn:hover {
    color: #e74c3c;
}
.error-message {
    color: red;
    font-size: 14px;
}

</style>
</head>
<body>

<div class="container">
    <div class="header-title">숙소 신청하기</div>
	<a href="../mypage/mypageMain.html" class="back-button">
	    <i class="fas fa-arrow-left"></i>
	</a>
    <form:form modelAttribute="accommodation" action="../acc/submitAcc.html" id="accForm"
        method="post" enctype="multipart/form-data">
        <div class="content">
            <!-- 왼쪽: 숙소 정보 -->
            <div class="left">
                <div class="input-box">
                    <label>유형</label>
                    <form:select path="category.category_id">
                        <form:option value="MOT">모텔</form:option>
                        <form:option value="HOT">호텔/리조트</form:option>
                        <form:option value="PEN">펜션/풀빌라</form:option>
                        <form:option value="CAM">캠핑/글램핑</form:option>
                        <form:option value="GUE">게스트 하우스</form:option>
                        <form:option value="SPA">공간대여</form:option>
                    </form:select>
                </div>

                <div class="input-box">
                    <label>숙소명 <form:errors path="accname" cssClass="error-message"/></label>
                    <form:input path="accname" placeholder="숙소명을 입력하세요"/>
                </div>

                <div class="input-box">
                    <label>등록자명   <form:errors path="user.username" cssClass="error-message"/></label>
                    <form:input path="user.username" readonly="true"/>
                </div>

                <div class="input-box">
                    <label>주소   <form:errors path="location" cssClass="error-message"/></label>
                    <form:input path="location" placeholder="주소를 입력하세요"/>
                </div>

                <div class="input-box">
                    <label>전화번호   <form:errors path="user.phone" cssClass="error-message"/></label>
                    <form:input path="user.phone" readonly="true"/>
                </div>

                <div class="input-box">
                    <label>숙소 설명   <form:errors path="description" cssClass="error-message"/></label>
                    <form:input path="description" placeholder="체크인 16시 이후, 체크아웃 12시 이전, 애견동반 가능 등"/>
                </div>

                <div class="photo-section">
                    <label>숙소 대표 사진</label>
                    <input type="file" name="main_photo" id="main_photo">
                </div>
            </div>

            <!-- 오른쪽: 방 정보 -->
            <div class="right">
                <div class="room-section" id="room1-section">
                    <h4>방 1 </h4>
                    <label>방1 사진</label>
                    <input type="file" name="room1_photo">
                    <input name="room1_name" placeholder="방 이름 입력" />
                    <input name="room1_price_per_night" placeholder="1박 가격 입력" type="number" step="1000"/>
                    <label>최대 인원:
                        <input type="number" name="room1_capacity" min="1" max="20" value="1" />
                    </label>
                </div>

				<div class="room-section" id="room2-section" data-room-visible="false" style="display: none;">
    				<h4>방 2 <button type="button" class="delete-room-btn" onclick="deleteRoom(2)">×</button></h4>
                    <label>방2 사진</label>
                    <input type="file" name="room2_photo">
                    <input name="room2_name" placeholder="방 이름 입력" />
                    <input name="room2_price_per_night" placeholder="1박 가격 입력" type="number" step="1000"/>
                    <label>최대 인원:
                        <input type="number" name="room2_capacity" min="1" max="20" value="1" />
                    </label>
                </div>

                <div class="room-section" id="room3-section" data-room-visible="false" style="display: none;">
    				<h4>방 3 <button type="button" class="delete-room-btn" onclick="deleteRoom(3)">×</button></h4>
                    <label>방3 사진</label>
                    <input type="file" name="room3_photo">
                    <input name="room3_name" placeholder="방 이름 입력" />
                    <input name="room3_price_per_night" placeholder="1박 가격 입력" type="number" step="1000"/>
                    <label>최대 인원:
                        <input type="number" name="room3_capacity" min="1" max="20" value="1" />
                    </label>
                </div>

                <div style="text-align: center; margin-top: 15px;">
                    <button type="button" class="submit-btn" id="add-room-btn">+ 방 추가하기</button>
                </div>
            </div>
        </div>

        <!-- 가운데 하단: 신청 버튼 -->
        <div class="form-footer">
            <button type="submit" class="submit-btn">신청하기</button>
        </div>
    </form:form>
</div>
</body>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const addRoomBtn = document.getElementById("add-room-btn");

    // 방 추가 버튼 클릭 시: 숨겨진 방 섹션을 표시
    addRoomBtn.addEventListener("click", function () {
        const room2 = document.getElementById("room2-section");
        const room3 = document.getElementById("room3-section");

        if (room2.style.display === "none") {
            room2.style.display = "block";
            room2.setAttribute("data-room-visible", "true");
        } else if (room3.style.display === "none") {
            room3.style.display = "block";
            room3.setAttribute("data-room-visible", "true");
        }
        
        // 모든 방 섹션이 보이면 추가 버튼 비활성화
        if (room2.style.display !== "none" && room3.style.display !== "none") {
            addRoomBtn.disabled = true;
            addRoomBtn.innerText = "더 이상 추가할 수 없습니다";
        }
    });
    
    // 폼 제출 시: 필수 입력 항목(숙소 대표 사진, 각 방의 사진, 이름, 가격) 체크
    const accForm = document.getElementById("accForm");
    accForm.addEventListener("submit", function (event) {
        const mainPhoto = document.getElementById("main_photo");
        if (!mainPhoto.value) {
            alert("숙소 대표 사진을 선택해 주세요.");
            event.preventDefault();
            return;
        }
        
        // 각 방 섹션에 대해 유효성 체크
        const roomSections = [
            document.getElementById("room1-section"),
            document.getElementById("room2-section"),
            document.getElementById("room3-section")
        ];
        for (let i = 0; i < roomSections.length; i++) {
            if (roomSections[i].style.display !== "none") {
                const roomPhoto = roomSections[i].querySelector("input[type='file']");
                const roomName = roomSections[i].querySelector("input[name^='room'][name$='_name']");
                const roomPrice = roomSections[i].querySelector("input[name^='room'][name*='price']");
                if (!roomPhoto.value || !roomName.value.trim() || !roomPrice.value.trim()) {
                    alert("모든 객실 정보(사진, 이름, 1박 가격)를 입력해 주세요.");
                    event.preventDefault();
                    return;
                }
            }
        }
    });
});

// 삭제 버튼 클릭 시 호출되는 함수: 해당 방 섹션을 숨기고 입력값 초기화, 추가 버튼 재활성화
function deleteRoom(roomNumber) {
    const roomSection = document.getElementById("room" + roomNumber + "-section");
    const roomSections = [
        document.getElementById("room1-section"),
        document.getElementById("room2-section"),
        document.getElementById("room3-section")
    ];
    
    // 현재 보이는 방의 수 계산 (최소 1개는 남아야 함)
    let visibleCount = 0;
    roomSections.forEach(section => {
        if (section.style.display !== "none") {
            visibleCount++;
        }
    });
    if (visibleCount <= 1) {
        alert("최소 1개의 객실 정보는 필요합니다.");
        return;
    }
    
    // 해당 방 섹션 숨기고 내부 입력값 초기화
    roomSection.style.display = "none";
    roomSection.setAttribute("data-room-visible", "false");
    roomSection.querySelectorAll("input").forEach(input => {
        input.value = "";
    });
    
    // 추가 버튼 재활성화 (보이지 않는 방이 하나라도 있으면)
    const addRoomBtn = document.getElementById("add-room-btn");
    if (document.getElementById("room2-section").style.display === "none" ||
        document.getElementById("room3-section").style.display === "none") {
        addRoomBtn.disabled = false;
        addRoomBtn.innerText = "+ 방 추가하기";
    }
}
</script>

</html>