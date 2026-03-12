<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>정보 수정 승인 디테일 화면</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
        width: 100vw; 
    	min-width: 1300px;
    }

    .container {
    	width: 60vw;  
        margin: 0 auto;
        padding: 30px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }

    h2, h3 {
        color: #333;
        margin-bottom: 30px;
        font-weight: 700; 
        text-align: center; 
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffe4e9;  
        border-radius: 15px;  
        overflow: hidden;  
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); 
    }

    th, td {
        border: 1px solid #FFC1D6; 
        padding: 20px 25px;
        text-align: center;
        word-wrap: break-word;
    }

    th {
        background-color: #FF8FA3; 
        color: #ffffff;
        font-weight: bold;
        font-size: 16px;
    }

    td {
        background-color: white;
        font-size: 15px;
    }

    img {
        max-width: 150px;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
    }

    .compare-title {
        margin-top: 40px;
        font-size: 22px;
        color: #555;
        text-align: center; 
    }

    .action-buttons {
        text-align: center;
        margin: 40px 0;
    }

.btn {
        display: inline-block;
        padding: 12px 35px;
        font-size: 17px;
        font-weight: bold;
        border: none;
        text-decoration: none;
        border-radius: 25px;
        margin: 0 15px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    }

    .btn-approve {
        background: linear-gradient(135deg, #5cb85c, #4cae4c); 
        color: #ffffff;
    }

    .btn-approve:hover {
        background: #45a049;
        transform: scale(1.05); 
    }

    .btn-reject {
        background: linear-gradient(135deg, #ff6b6b, #ff4c4c);
        color: #ffffff;
    }

    .btn-reject:hover {
        background: #e44d4d;
        transform: scale(1.05);
    }

    @media (max-width: 768px) {
        table, th, td {
            font-size: 14px;
        }

        img {
            max-width: 100px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 14px;
        }
    }  
    
</style>
</head>
<body>

<h2 class="compare-title">숙소 수정사항 확인</h2>
<div class="container">
<!-- 목록으로 돌아가기 버튼 -->
<a href="../admin/adminAccAccept.html" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<table>
    <thead>
        <tr>
            <th>항목</th>
            <th>기존 정보</th>
            <th>수정 요청 정보</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>숙소명</td>
            <td>${acc.accname}</td>
            <td>${accUpdate.accname}</td>
        </tr>
        <tr>
            <td>주소</td>
            <td>${acc.location}</td>
            <td>${accUpdate.location}</td>
        </tr>
        <tr>
            <td>가격(1박)</td>
            <td><fmt:formatNumber value="${acc.price_per_night}" pattern="#,###"/>원</td>
            <td><fmt:formatNumber value="${accUpdate.price_per_night}" pattern="#,###"/>원</td>
        </tr>
        <tr>
            <td>설명</td>
            <td>${acc.description}</td>
            <td>${accUpdate.description}</td>
        </tr>
        <tr>
            <td>대표 이미지</td>
            <td><img src="${pageContext.request.contextPath}/imgs/${acc.acc_image}" /></td>
            <td><img src="${pageContext.request.contextPath}/imgs/${accUpdate.acc_image}" /></td>
        </tr>
    </tbody>
</table>

<h3 class="compare-title">방 정보 비교 (기존 vs 수정 요청)</h3>

<table>
    <thead>
        <tr>
            <th>방 번호</th>
            <th>항목</th>
            <th>기존 정보</th>
            <th>수정 요청 정보</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="roomCompare" items="${roomCompareList}" varStatus="status">
        <c:set var="room" value="${roomCompare.originRoom}" />
        <c:set var="updateRoom" value="${roomCompare.updateRoom}" />
        <tr>
            <td rowspan="4">방 ${status.index + 1}</td>
            <td>방 이름</td>
            <td>${room.name}</td>
            <td><c:out value="${updateRoom.name}" default="-" /></td>
        </tr>
        <tr>
            <td>1박 가격</td>
            <td><fmt:formatNumber value="${room.price_per_night}" pattern="#,###"/>원</td>
            <td>
                <c:choose>
                    <c:when test="${not empty updateRoom}">
                        <fmt:formatNumber value="${updateRoom.price_per_night}" pattern="#,###"/>원
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>최대 인원</td>
            <td>${room.capacity} 명</td>
            <td><c:out value="${updateRoom.capacity}" default="-" /> 명</td>
        </tr>
        <tr>
            <td>방 이미지</td>
            <td><img src="${pageContext.request.contextPath}/imgs/${room.room_image}" /></td>
            <td>
                <c:choose>
                    <c:when test="${not empty updateRoom}">
                        <img src="${pageContext.request.contextPath}/imgs/${updateRoom.room_image}" />
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="action-buttons">
	<c:if test="${accUpdate.acc_approval_status == '대기' }">
    <form action="../admin/approveAccUpdate.html" method="post" style="display: inline;">
        <input type="hidden" name="acc_request_id" value="${accUpdate.acc_request_id}" />
        <button type="submit" class="btn btn-approve">수정 승인</button>
    </form>
    <form action="../admin/rejectAccUpdate.html" method="post" style="display: inline;">
        <input type="hidden" name="acc_request_id" value="${accUpdate.acc_request_id}" />
        <button type="submit" class="btn btn-reject">수정 거절</button>
    </form>
    </c:if>
</div>
</div>
</body>
</html>
