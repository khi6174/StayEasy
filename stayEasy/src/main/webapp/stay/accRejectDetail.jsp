<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 수정 신청 상세보기</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        text-align: center;
        margin: 0;
        padding-top: 30px;
    }

    .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        text-align: left;
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: center;
    }

    th {
        background-color: #007bff;
        color: white;
    }

    .highlight {
        background-color: #ffeb3b; /* 변경된 값 강조 */
        font-weight: bold;
    }

    .status-pending {
        color: #ff9800;
        font-weight: bold;
    }

    .status-approved {
        color: #28a745;
        font-weight: bold;
    }

    .status-rejected {
        color: #dc3545;
        font-weight: bold;
    }

    .back-btn {
        background-color: #6c757d;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        display: inline-block;
    }

    .back-btn:hover {
        background-color: #5a6268;
    }

    .rejection-reason {
        background-color: #f8d7da;
        color: #721c24;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #f5c6cb;
        margin-top: 10px;
    }
</style>
</head>
<body>

<div class="container">
    <h2>숙소 수정 신청 상세보기</h2>
	<a href="../mypage/accUpdateList.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <h3>신청 정보</h3>
    <table>
        <tr>
            <th>승인 상태</th>
            <td>
                <c:choose>
                    <c:when test="${accUpdate.acc_approval_status == '대기'}">
                        <span class="status-pending">대기</span>
                    </c:when>
                    <c:when test="${accUpdate.acc_approval_status == '승인완료'}">
                        <span class="status-approved">승인 완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-rejected">거절됨</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <c:if test="${accUpdate.acc_approval_status == '승인거절'}">
            <tr>
                <th>거절 사유</th>
                <td class="rejection-reason">${accUpdate.acc_rejection_reason}</td>
            </tr>
        </c:if>
    </table>

<c:if test="${accUpdate.acc_approval_status != '승인완료'}">
    <h3>숙소 정보 비교</h3>
    <table>
        <tr>
            <th>항목</th>
            <th>기존 정보</th>
            <th>수정 요청 정보</th>
        </tr>
        <tr>
            <td>숙소명</td>
            <td>${acc.accname}</td>
            <td class="${acc.accname != accUpdate.accname ? 'highlight' : ''}">${accUpdate.accname}</td>
        </tr>
        <tr>
            <td>주소</td>
            <td>${acc.location}</td>
            <td class="${acc.location != accUpdate.location ? 'highlight' : ''}">${accUpdate.location}</td>
        </tr>
        <tr>
            <td>가격 (1박)</td>
            <td><fmt:formatNumber value="${acc.price_per_night}" pattern="#,###"/> 원</td>
            <td class="${acc.price_per_night != accUpdate.price_per_night ? 'highlight' : ''}">
                <fmt:formatNumber value="${accUpdate.price_per_night}" pattern="#,###"/> 원
            </td>
        </tr>
        <tr>
            <td>설명</td>
            <td>${acc.description}</td>
            <td class="${acc.description != accUpdate.description ? 'highlight' : ''}">${accUpdate.description}</td>
        </tr>
        <tr>
            <td>대표 이미지</td>
            <td><img src="${pageContext.request.contextPath}/imgs/${acc.acc_image}" width="150px"></td>
            <td>
                <c:choose>
                    <c:when test="${acc.acc_image != accUpdate.acc_image}">
                        <img src="${pageContext.request.contextPath}/imgs/${accUpdate.acc_image}" width="150px" class="highlight">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/imgs/${accUpdate.acc_image}" width="150px">
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
    
    <h3>객실 정보 비교</h3>
	<table>
    <tr>
        <th>방 번호</th>
        <th>항목</th>
        <th>기존 정보</th>
        <th>수정 요청 정보</th>
    </tr>

    <c:forEach var="room" items="${roomList}" varStatus="status">
        <c:set var="updatedRoom" value="" />
        <c:forEach var="ru" items="${roomUpdate}">
            <c:if test="${ru.room.id.roomId == room.id.roomId}">
                <c:set var="updatedRoom" value="${ru}" />
            </c:if>
        </c:forEach>

        <tr>
            <td rowspan="4">방 ${status.index + 1}</td>
            <td>방 이름</td>
            <td>${room.name}</td>
            <td class="${(not empty updatedRoom and updatedRoom.name != room.name) ? 'highlight' : ''}">
                <c:choose>
                    <c:when test="${not empty updatedRoom}">${updatedRoom.name}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>1박 가격</td>
            <td><fmt:formatNumber value="${room.price_per_night}" pattern="#,###"/> 원</td>
            <td class="${(not empty updatedRoom and updatedRoom.price_per_night != room.price_per_night) ? 'highlight' : ''}">
                <c:choose>
                    <c:when test="${not empty updatedRoom}">
                        <fmt:formatNumber value="${updatedRoom.price_per_night}" pattern="#,###"/> 원
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>최대 인원</td>
            <td>${room.capacity} 명</td>
            <td class="${(not empty updatedRoom and updatedRoom.capacity != room.capacity) ? 'highlight' : ''}">
                <c:choose>
                    <c:when test="${not empty updatedRoom}">${updatedRoom.capacity} 명</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>객실 이미지</td>
            <td><img src="${pageContext.request.contextPath}/imgs/${room.room_image}" width="150px"></td>
            <td>
                <c:choose>
                    <c:when test="${not empty updatedRoom and updatedRoom.room_image != room.room_image}">
                        <img src="${pageContext.request.contextPath}/imgs/${updatedRoom.room_image}" width="150px" class="highlight">
                    </c:when>
                    <c:when test="${not empty updatedRoom}">
                        <img src="${pageContext.request.contextPath}/imgs/${updatedRoom.room_image}" width="150px">
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    <!-- 추가된 객실 표시 -->
    <c:forEach var="ru" items="${roomUpdate}">
        <c:set var="isNewRoom" value="true" />
        <c:forEach var="room" items="${roomList}">
            <c:if test="${ru.room.id.roomId == room.id.roomId}">
                <c:set var="isNewRoom" value="false" />
            </c:if>
        </c:forEach>
        
        <c:if test="${isNewRoom}">
            <tr>
                <td rowspan="4" class="highlight">새 방</td>
                <td>방 이름</td>
                <td>-</td>
                <td class="highlight">${ru.name}</td>
            </tr>
            <tr>
                <td>1박 가격</td>
                <td>-</td>
                <td class="highlight"><fmt:formatNumber value="${ru.price_per_night}" pattern="#,###"/> 원</td>
            </tr>
            <tr>
                <td>최대 인원</td>
                <td>-</td>
                <td class="highlight">${ru.capacity} 명</td>
            </tr>
            <tr>
                <td>객실 이미지</td>
                <td>-</td>
                <td class="highlight"><img src="${pageContext.request.contextPath}/imgs/${ru.room_image}" width="150px"></td>
            </tr>
        </c:if>
    </c:forEach>
    </table>
</c:if>

<c:if test="${accUpdate.acc_approval_status == '승인완료'}">
    <!-- 승인완료일 때: 수정 요청 정보만 보여주는 테이블 -->
    <h3>수정된 숙소 정보</h3>
    <table>
        <tr>
            <th>숙소명</th>
            <td>${accUpdate.accname}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${accUpdate.location}</td>
        </tr>
        <tr>
            <th>가격 (1박)</th>
            <td><fmt:formatNumber value="${accUpdate.price_per_night}" pattern="#,###"/> 원</td>
        </tr>
        <tr>
            <th>설명</th>
            <td>${accUpdate.description}</td>
        </tr>
        <tr>
            <th>대표 이미지</th>
            <td><img src="${pageContext.request.contextPath}/imgs/${accUpdate.acc_image}" width="150px"></td>
        </tr>
    </table>
    
    <h3>수정된 객실 정보</h3>
    <table>
        <tr>
            <th>방 번호</th>
            <th>방 이름</th>
            <th>1박 가격</th>
            <th>최대 인원</th>
            <th>객실 이미지</th>
        </tr>
        <c:forEach var="ru" items="${roomUpdate}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${ru.name}</td>
                <td><fmt:formatNumber value="${ru.price_per_night}" pattern="#,###"/> 원</td>
                <td>${ru.capacity} 명</td>
                <td><img src="${pageContext.request.contextPath}/imgs/${ru.room_image}" width="150px"></td>
            </tr>
        </c:forEach>
    </table>
</c:if>

    
    

    



    <div style="text-align: center; margin-top: 20px;">
        <a href="../mypage/accUpdateList.html" class="back-btn">목록으로 돌아가기</a>
    </div>
</div>

</body>
</html>