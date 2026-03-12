<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 숙소 수정 신청 목록</title>
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
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
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

    .view-details {
        background-color: #007bff;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        display: inline-block;
    }

    .view-details:hover {
        background-color: #0056b3;
    }

    .no-data {
        text-align: center;
        padding: 20px;
        color: #777;
    }
</style>
</head>
<body>

<div class="container">
    <h2>내 숙소 수정 신청 목록</h2>
	<a href="../acc/myAccommodations.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <c:if test="${empty accUpdate}">
        <div class="no-data">신청 내역이 없습니다.</div>
    </c:if>

    <c:if test="${not empty accUpdate}">
        <table>
            <thead>
                <tr>
                    <th>숙소명</th>
                    <th>신청일</th>
                    <th>승인 상태</th>
                    <th>상세 보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="acc" items="${accUpdate}">
                    <tr>
                        <td>${acc.accname}</td>
                        <td><fmt:formatDate value="${acc.acc_request_date}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${acc.acc_approval_status == '대기'}">
                                    <span class="status-pending">대기</span>
                                </c:when>
                                <c:when test="${acc.acc_approval_status == '승인완료'}">
                                    <span class="status-approved">승인 완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-rejected">거절됨</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        
                        <td>
                            <a href="<c:url value='../mypage/accRejectDetail.html?accReqId=${acc.acc_request_id}' />" class="view-details">
								상세 보기
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>