<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html> 
<head>
<meta charset="EUC-KR">
<title>사용자 관리</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        text-align: center;
    }
    .container {
        max-width: 900px;
        margin: 50px auto;
        padding: 30px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
    }
    h2 {
        color: #333;
        margin-bottom: 30px;
        font-size: 32px;
    }
    .input-box {
        margin: 30px 0;
    }
    input[type="text"] {
        width: 90%;
        padding: 15px;
        border: 2px solid #ccc;
        border-radius: 8px;
        text-align: center;
        font-size: 18px;
    }
    .menu {
        margin-top: 30px;
        display: flex;
        flex-direction: column;
        gap: 20px; /* 버튼 간격 추가 */
    }
    .menu button {
    width: 100%; /* 가로 길이 전체 */
    height: 70px; /* 높이 더 크게 */
    padding: 15px; /* 내부 여백 */
    background: #FF6699;
    color: white;
    border: none;
    border-radius: 12px; /* 조금 더 둥글게 */
    font-size: 20px; /* 글자 크게 */
    font-weight: bold;
    cursor: pointer;
    transition: background 0.3s ease-in-out, transform 0.2s ease;
    box-shadow: 0 4px 10px rgba(255, 102, 153, 0.3); /* 약간의 그림자 */
}

.menu button:hover {
    background: #FF3366;
    transform: translateY(-3px); /* 살짝 올라가는 효과 */
}

.menu {
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    gap: 25px; /* 버튼 간격도 조금 넓힘 */
}

.menu-grid {
    display: flex;
    min-width: 200px; /* 버튼 최소 너비 추가 */
    justify-content: space-between;
    gap: 25px; /* 가로 버튼 간격 */
}

.menu-grid button {
    flex: 1;
    height: 70px; /* 높이 동일하게 */
    padding: 15px;
    border-radius: 12px;
    font-size: 20px;
    font-weight: bold;
    background: #FF6699;
    color: white;
    border: none;
    white-space: nowrap; /* 줄 바꿈 방지 */
    cursor: pointer;
    transition: background 0.3s ease-in-out, transform 0.2s ease;
    box-shadow: 0 4px 10px rgba(255, 102, 153, 0.3);
}

.menu-grid button:hover {
    background: #FF3366;
    transform: translateY(-3px);
}

</style>

</head>
<body>

<div class="container">
<c:if test="${not empty error}">
    <div style="color: red; font-weight: bold; margin-bottom: 20px;">
        ${error}
    </div>
</c:if>

    <h2>사용자 관리</h2>

    <!-- 사용자 조회 폼 -->
	<div class="input-box">
	    <label><strong>아이디</strong></label><br>
	    <form action="../admin/viewUserInfo.html" method="POST">
	        <input type="text" id="user_id" name="user_id" placeholder="사용자 아이디 입력">
	        <div class="menu">
	            <button type="submit">사용자 조회하기</button>
	        </div>
	    </form>
	</div>

    <div class="menu">
        <button onclick="location.href='../inquire/inquireList.html'">문의 리스트</button>
		<button onclick="location.href='../admin/adminRegisteredAcc.html'">등록된 숙소 목록</button>
        <div class="menu-grid">
            <button onclick="location.href='../admin/adminAccAccept.html'">숙소 수정 목록</button>
            <button onclick="location.href='../admin/adminPendingAcc.html'">승인대기 숙소 목록</button>
        </div>
    </div>
</div>

</body>
</html>
