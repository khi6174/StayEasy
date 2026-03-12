<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 수정 신청 거절</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 30px;
        text-align: center;
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        text-align: left;
    }

    h2 {
        text-align: center;
        color: #dc3545;
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
        background-color: #dc3545;
        color: white;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
    }

    textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        resize: none;
    }

    .btn {
        display: inline-block;
        padding: 12px 20px;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        border-radius: 8px;
        cursor: pointer;
        text-align: center;
        margin-top: 10px;
        width: 100%;
        border: none;
    }

    .btn-reject {
        background-color: #dc3545;
        color: white;
    }

    .btn-reject:hover {
        background-color: #c82333;
    }

    .btn-cancel {
        background-color: #6c757d;
        color: white;
    }

    .btn-cancel:hover {
        background-color: #5a6268;
    }
</style>
</head>
<body>

<div class="container">
    <h2>숙소 수정 신청 거절</h2>

    <h3>숙소 정보</h3>
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
            <th>요청자</th>
            <td>${user.username}</td>
        </tr>
        <tr>
            <th>신청일</th>
            <td><fmt:formatDate value="${accUpdate.acc_request_date}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </table>

    <h3>객실 정보</h3>
    <table>
        <tr>
            <th>방 이름</th>
            <th>1박 가격</th>
            <th>최대 인원</th>
        </tr>
        <c:forEach var="room" items="${roomUpdate}" varStatus="status">
            <tr>
                <td>${room.name}</td>
                <td>${room.price_per_night} 원</td>
                <td>${room.capacity} 명</td>
            </tr>
        </c:forEach>
    </table>

    
    <form action="../admin/rejectAccUpdateDo.html" method="post">
        <input type="hidden" name="acc_request_id" value="${accUpdate.acc_request_id}" />

        <div class="form-group">
            <label for="acc_rejection_reason">거절 사유:</label>
            <textarea id="acc_rejection_reason" name="rejection_reason" rows="4" placeholder="거절 사유를 입력하세요." required></textarea>
        </div>

        <button type="submit" class="btn btn-reject">거절하기</button>
        <a href="../admin/accUpdateList.html" class="btn btn-cancel">취소</a>
    </form>
</div>

</body>
</html>