<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 수정 신청하기</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
	body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        text-align: center;
    }
	.container {
	    max-width: 1200px;
	    margin: 50px auto;
	    padding: 20px;
	    background: white;
	    border-radius: 15px;
	    box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
	}
	.header-title {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .content {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: flex-start;
        gap: 30px;
        width: 100%;
    }
    .left, .right {
        flex: 1;
        min-width: 0;
    }
	.input-box {
		margin: 10px 0;
	text-align: left;
	}
	label {
	    font-weight: bold;
	    display: block;
	    margin-bottom: 5px;
	}
	input[type="text"], input[type="file"], select, input[type="number"] {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
     box-sizing: border-box;
	}
	.submit-btn {
	background-color: #FF6699;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 25px;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
	transition: 0.3s;
	box-shadow: 0 4px 6px rgba(255, 102, 153, 0.3);
	margin-top: 20px;
	}
	.submit-btn:hover {
		background-color: #FF3366;
		box-shadow: 0 6px 12px rgba(255, 51, 102, 0.5);
		transform: translateY(-2px);
	}
    .photo-section img {
        width: 100%;
        max-width: 300px;
        border-radius: 10px;
        margin-top: 10px;
    }
    .room-section {
	    border: 1px solid #ddd;
	    border-radius: 10px;
	    padding: 15px;
	    margin-bottom: 15px;
	    background: #fff;
    }
    .room-section h4 {
        text-align: center;
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<div class="container">
    <div class="header-title">숙소 수정 신청하기</div>
	<a href="../acc/myAccommodations.html" class="back-button">
	    <i class="fas fa-arrow-left"></i>
	</a>
    <!-- 첫 번째 form:form (숙소 기본 정보 + 방 정보) -->
    <form:form modelAttribute="accUpdate" 
    action="../mypage/accUpdateDo.html" method="post" enctype="multipart/form-data">
    <form:hidden path="user.user_id"/>
    <form:hidden path="accommodation.accommodation_id"/>
    <form:hidden path="price_per_night"/>
        <div class="content">
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
                    <label>숙소명</label>
                    <form:input path="accname"/>
                </div>

                <div class="input-box">
                    <label>등록자명</label>
                    <form:input path="user.username" readonly="true"/>
                </div>

                <div class="input-box">
                    <label>주소</label>
                    <form:input path="location" placeholder="주소를 입력하세요"/>
                </div>

                <div class="input-box">
                    <label>전화번호</label>
                    <form:input path="user.phone" readonly="true"/>
                </div>
                
               <div class="input-box">
                    <h4>숙소 설명</h4>
                    <form:input path="description" placeholder="체크인 16시 이후, 체크아웃 12시 이전, 애견동반 가능 등"/>
                </div>

                <div class="photo-section">
                    <label>숙소 대표 사진</label>
                    <!-- 기존 이미지 -->
                    <img id="preview" src="${pageContext.request.contextPath}/imgs/${accUpdate.accommodation.acc_image}" 
                    alt="기존 숙소 이미지" width="200px" height="auto" style="margin-bottom:10px;"><br>
                    <!-- 새 파일 업로드 -->
                    <input type="file" name="mainPhoto" id="mainPhotoInput">
                    <!-- 기존 이미지 파일명 hidden으로 같이 보내기 -->
					<input type="hidden" name="old_mainPhoto" value="${accUpdate.accommodation.acc_image}">
                </div>
            </div>

            <div class="right">
            	<c:forEach var="room" items="${roomList}" varStatus="status">
                <div class="room-section">
                    <h4>방  ${status.index + 1}</h4>
                    <label>방 이름 : <input type="text" value="${room.name}" name="roomUpdates[${status.index}].name"/></label><br/>
                     <!-- 기존 이미지 -->
   					 <img id="room${status.index + 1}_preview" 
   					 src="${pageContext.request.contextPath}/imgs/${room.room_image}" 
        			 alt="기존 이미지" width="200px" height="auto" style="margin-bottom:10px;"><br>
        			 
        			 <!-- 새 파일 업로드 -->
                    <input type="file" name="roomPhotos"
					id="room${status.index}_photo_input" multiple>
					
                    <!-- 기존 파일명 hidden (서버로 같이 넘기기) -->
    				<input type="hidden"
    				name="roomUpdates[${status.index}].room_image" value="${room.room_image}">
    				
    				<!-- 나머지 정보 -->
                    <label>1박 가격:<input type="number" value="${room.price_per_night}"
                     name="roomUpdates[${status.index}].price_per_night" max="9999999999" step="1000"/></label>
                    <label>최대 인원:<input type="number" name="roomUpdates[${status.index}].capacity" 
                    value="${room.capacity}"/></label>
                    
                    <input type="hidden" name="roomUpdates[${status.index}].room.id.roomId" value="${room.id.roomId}"/>
                    <input type="hidden" name="roomUpdates[${status.index}].room.id.accommodationId" value="${room.id.accommodationId}"/>
                    <input type="hidden" name="roomUpdates[${status.index}].availability" value="${room.availability}"/>
                </div>

                </c:forEach>
            </div>
        </div>
  	    <button type="submit" class="submit-btn">수정 신청하기</button>  
    </form:form>


</div>


</body>
<script type="text/javascript">
window.onload = function() {
    // 여러 방에 대해 반복
    const roomPhotoInputs = document.querySelectorAll('input[type="file"][name^="roomPhotos"]'); // roomPhotos로 시작하는 모든 파일 input

    roomPhotoInputs.forEach(function(input, index) {
        input.addEventListener('change', function(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('room' + (index + 1) + '_preview'); // room1_preview, room2_preview...

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result; // 새 이미지 미리보기
                };
                reader.readAsDataURL(file);
            } else {
                // 선택 취소 시 기존 이미지로 복원 (선택사항)
                preview.src = '${pageContext.request.contextPath}/imgs/' + document.querySelector(`input[name='rooms[${index}].room_image']`).value;
            }
        });
    });
};

document.getElementById('mainPhotoInput').addEventListener('change', function(event) {
    const file = event.target.files[0]; // 선택된 파일
    const preview = document.getElementById('preview'); // 이미지 태그

    if (file) {
        const reader = new FileReader(); // 파일 읽기 객체
        reader.onload = function(e) {
            preview.src = e.target.result; // 읽은 데이터로 src 교체
        };
        reader.readAsDataURL(file); // 파일을 base64로 읽기 (미리보기용)
    } else {
        // 파일 선택 취소 시 기존 이미지 복원 (선택 사항)
        preview.src = '${pageContext.request.contextPath}/imgs/${accommodation.acc_image}';
    }
});
</script>
</html>