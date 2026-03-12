<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>등록된 숙소 목록</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
    body {
        font-family: Arial, sans-serif;
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
        background-color: #E0F7FA;  
        border-radius: 15px;
        overflow: hidden;  
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); 
    }

    th, td {
        border: 1px solid #A7C7E7; 
        padding: 18px 20px;
        text-align: center;
    }

    th {
        background-color: #A7C7E7;
        color: #ffffff;
        font-weight: bold;
        font-size: 16px;
    }

    td {
        background-color: white;
        font-size: 15px;
    }
    
    tbody tr:hover {
        background-color: #f0f8ff; 
        cursor: pointer;
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
   	.back-button {
    font-weight: bold;
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px 10px;
	}
    
</style>
</head>
<body>

<div class="container">
    <h2>등록된 숙소 목록</h2>
    <c:choose>
    	<c:when test="${not empty param.userId and param.userId != ''}">
		    <!-- 목록으로 돌아가기 버튼 (POST 방식) -->
			<form action="../admin/viewUserInfo.html" method="post" style="display: inline;">
			    <input type="hidden" name="user_id" value="${param.userId}">
			    <button type="submit" class="back-button">
			        <i class="fas fa-arrow-left"></i>
			    </button>
			</form>
    	</c:when>
    	<c:otherwise>
			<!-- 목록으로 돌아가기 버튼 -->
		    <a href="../admin/adminUserManagement.html" class="back-button">
		        <i class="fas fa-arrow-left"></i>
		    </a>
    	</c:otherwise>
    </c:choose>
    <table>
        <tr>
            <th>숙소명</th>
            <th>위치</th>
            <th>판매자명</th>
            <th>연락처</th>
        </tr>
   	    <c:choose>
        <c:when test="${not empty registeredAccommodations}">
            <c:forEach var="accommodation" items="${registeredAccommodations}">
                <tr>
                    <td>
                        <a href="<c:url value='/admin/viewRegisteredAccommodationDetail.html?accommodationId=${accommodation.accommodation_id}' />">
                            ${accommodation.accname}
                        </a>
                    </td>
                    <td>${accommodation.location}</td>
                    <td>${accommodation.username}</td>
                    <td>${accommodation.phone}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- 숙소 목록이 없을 때 메시지 출력 -->
            <tr>
                <td colspan="4" style="text-align:center; padding: 20px; font-size: 16px; color: #555; font-weight: bold;">
                    	등록된 숙소가 없습니다.
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
    </table>
</div>

</body>
</html>