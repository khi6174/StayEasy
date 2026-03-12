<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 정보 수정 리스트 화면</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        text-align: center;
        margin: 0;
    }

    .container {
        max-width: 1000px; 
        margin: 50px auto;
        padding: 30px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    h2 {
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
        padding: 18px 20px;
        text-align: center;
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

    a {
        text-decoration: none;
        color: #007bff;
        font-weight: bold;
    }

    a:hover {
        color: #0056b3;
        text-decoration: underline;
    }
    .status-waiting {
       color: #ff6b6b;  
       font-weight: bold;
   }
   
   .status-approved {
       color: #28a745;   
       font-weight: bold; 
   }
   
   
    .img-container img {
        width: 100%;
        max-height: 250px;
        border-radius: 10px;
        margin-bottom: 15px;
    }
    .approve-btn {
        background: #28a745;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 20px;
    }
    .approve-btn:hover {
        background: #218838;
    }
     .alert {
            margin: 20px 0;
            padding: 15px;
            border-radius: 5px;
            color: #333;
            font-weight: bold;
        }
        .alert-info {
            background: #e9ecef;
            border: 1px solid #ccc;
        }
        .alert-success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
        }
	/* 목록으로 돌아가기 버튼 (기존 스타일 유지) */
	.back-button {
	    font-weight: bold;
	    background: none;
	    border: none;
	    cursor: pointer;
	    padding: 5px 10px;
	}
    .hidden {
    display: none;
    }
    .btn-container {
        margin-bottom: 20px;
    }
    .btn {
        background: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        margin: 5px;
    }
    .btn:hover {
        background: #0056b3;
    }
   	.status-pending {
        color: black;
        font-weight: bold;
    }
    .status-rejected {
        color: red;
        font-weight: bold;
    }
    .status-approved {
        color: green;
        font-weight: bold;
    }
    
</style>
</head>
<body>
<!-- 메시지 출력 -->
<c:if test="${not empty msg}">
    <div class="alert alert-info" role="alert">
        ${msg}
    </div>
</c:if>

<div class="container">
    <h2>숙소 수정 목록</h2>
	<!-- 목록으로 돌아가기 버튼 (POST 방식) -->
	<form action="../admin/viewUserInfo.html" method="post" style="display: inline;">
	    <input type="hidden" name="user_id" value="${param.userId}">
	    <button type="submit" class="back-button">
	        <i class="fas fa-arrow-left"></i>
	    </button>
	</form>
    <!-- 버튼 추가 -->
    <div class="btn-container">
        <button class="btn" onclick="showTable('waiting')">승인 대기 목록 보기</button>
        <button class="btn" onclick="showTable('approved')">승인 완료,거절 목록 보기</button>
    </div>

    <!-- 승인 대기 목록 -->
    <div id="waitingList">
        <h2>숙소 수정 승인 대기 목록</h2>
        <table>
            <tr>
                <th>숙소명</th>
                <th>위치</th>
                <th>판매자명</th>
                <th>승인 요청일</th>
                <th>승인 상태</th>
            </tr>
            
            <c:set var="waitingCount" value="0" />
            <c:forEach var="acc" items="${accUpdateList}">
                <c:if test="${acc.acc_approval_status == '대기'}">
                    <tr>
                        <td>
                            <a href="<c:url value='/admin/adminAccAcceptDetail.html?accId=${acc.accommodation.accommodation_id}&accRequestId=${acc.acc_request_id}' />">
                                ${acc.accname}
                            </a>
                        </td>
                        <td>${acc.location}</td>
                        <td>${acc.user.username}</td>
                        <td><fmt:formatDate value="${acc.acc_request_date}" pattern="yyyy-MM-dd"/></td>
                        <td><span class="status-pending">${acc.acc_approval_status}</span></td>
                    </tr>
                    <c:set var="waitingCount" value="${waitingCount + 1}" />
                </c:if>
            </c:forEach>
            
            <c:if test="${waitingCount == 0}">
                <tr>
                    <td colspan="5">승인 대기 중인 숙소가 없습니다.</td>
                </tr>
            </c:if>
        </table>
    </div>

    <!-- 승인 완료 목록 (초기에는 숨김) -->
    <div id="approvedList" class="hidden">
        <h2>숙소 수정 승인 완료 목록</h2>
        <table>
            <tr>
                <th>숙소명</th>
                <th>위치</th>
                <th>판매자명</th>
                <th>승인 요청일</th>
                <th>승인 상태</th>
            </tr>
            
            <c:set var="approvedCount" value="0" />
            <c:forEach var="acc" items="${accUpdateList}">
                <c:if test="${acc.acc_approval_status == '승인완료' || acc.acc_approval_status == '승인거절'}">
                    <tr>
                        <td>
                            <a href="<c:url value='/admin/adminAccAcceptDetail.html?accId=${acc.accommodation.accommodation_id}&accRequestId=${acc.acc_request_id}' />">
                                ${acc.accname}
                            </a>
                        </td>
                        <td>${acc.location}</td>
                        <td>${acc.user.username}</td>
                        <td><fmt:formatDate value="${acc.acc_request_date}" pattern="yyyy-MM-dd"/></td>
                        <c:if test="${acc.acc_approval_status == '승인거절'}">
                        <td><span class="status-rejected">${acc.acc_approval_status}</span></td>
                        </c:if>
                        <c:if test="${acc.acc_approval_status == '승인완료'}">
                        <td><span class="status-approved">${acc.acc_approval_status}</span></td>
                        </c:if>
                    </tr>
                    <c:set var="approvedCount" value="${approvedCount + 1}" />
                </c:if>
            </c:forEach>

            <c:if test="${approvedCount == 0}">
                <tr>
                    <td colspan="5">승인 완료된 숙소가 없습니다.</td>
                </tr>
            </c:if>
        </table>
    </div>
</div>

<script>
function showTable(type) {
    if (type === 'waiting') {
        document.getElementById('waitingList').classList.remove('hidden');
        document.getElementById('approvedList').classList.add('hidden');
    } else {
        document.getElementById('waitingList').classList.add('hidden');
        document.getElementById('approvedList').classList.remove('hidden');
    }
}
</script>

</body>
</html>