<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>정보 수정 승인완료 디테일 화면</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 30px;
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    th, td {
        border-bottom: 1px solid #eee;
        padding: 14px;
        text-align: center;
    }

    th {
        background-color: #007bff;
        color: white;
    }

    img {
        max-width: 150px;
        height: auto;
        border-radius: 8px;
    }

    .action-buttons {
        text-align: center;
        margin: 20px 0;
    }

    .btn {
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        border-radius: 8px;
        margin: 5px;
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        cursor: pointer;
    }

    .btn-approve {
        background-color: #28a745;
        color: white;
    }

    .btn-reject {
        background-color: #dc3545;
        color: white;
    }
</style>
</head>
<body>

<h2>숙소 수정한 정보</h2>
<div class="container">
    <table>
        <thead>
            <tr>
                <th>항목</th>
                <th>수정한 정보</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>숙소명</td>
                <td><c:out value="${accUpdate.accname}" default="-" /></td>
            </tr>
            <tr>
                <td>주소</td>
                <td><c:out value="${accUpdate.location}" default="-" /></td>
            </tr>
            <tr>
                <td>가격(1박)</td>
                <td><fmt:formatNumber value="${accUpdate.price_per_night}" pattern="#,###"/>원</td>
            </tr>
            <tr>
                <td>설명</td>
                <td><c:out value="${accUpdate.description}" default="-" /></td>
            </tr>
            <tr>
                <td>대표 이미지</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty accUpdate.acc_image}">
                            <img src="${pageContext.request.contextPath}/imgs/${accUpdate.acc_image}" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </tbody>
    </table>

    <h2>방 수정한 정보</h2>
    <table>
        <thead>
            <tr>
                <th>방 번호</th>
                <th>항목</th>
                <th>수정 요청 정보</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="roomCompare" items="${roomCompareList}" varStatus="status">
            <c:set var="updateRoom" value="${roomCompare.updateRoom}" />
            <tr>
                <td rowspan="4">방 ${status.index + 1}</td>
                <td>방 이름</td>
                <td><c:out value="${updateRoom.name}" default="-" /></td>
            </tr>
            <tr>
                <td>1박 가격</td>
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
                <td><c:out value="${updateRoom.capacity}" default="-" /> 명</td>
            </tr>
            <tr>
                <td>방 이미지</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty updateRoom.room_image}">
                            <img src="${pageContext.request.contextPath}/imgs/${updateRoom.room_image}" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
