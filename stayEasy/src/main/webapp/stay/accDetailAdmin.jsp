<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자용 숙소 상세화면</title>
<style type="text/css">
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
    body { padding: 20px; background-color: #f8f9fa; }
    .container { display: flex; margin-top: 10px;}
    .left-panel { width: 60%; }
    .hotel-image img { width: 100%; height: auto; }
    .hotel-info { margin-top: 10px; font-size: 16px; line-height: 1.5; }
    .review-btn { background-color: yellow; border: 1px solid black; font-weight: bold; cursor: pointer; margin-top: 10px; padding: 5px; }
    .right-panel { margin-left: 20px; width: 35%; }
</style>
</head>
<body>
<form action="" method="post">
<input type="submit" value="수정"/>
</form>
<form action="" method="post">
<input type="submit" value="삭제"/>
</form>
<button class="admin-btn">삭제(관리자)</button>

<!-- 체크인, 체크아웃, 인원수 선택 -->
<div class="check-info">
    체크인: <input type="date">
    체크아웃: <input type="date">
 인원수: <input type="number" min="1" max="10" value="2">

</div>

<!-- 본문 -->
<div class="container">
    <!-- 왼쪽 패널: 호텔 이미지 및 설명 -->
    <div class="left-panel">
        <div class="hotel-image">
            <img src="${ACC.acc_image}" alt="숙박 이미지">
        </div>
        <div class="hotel-info">
            <h2>${ACC.accname}</h2>
            위치: ${ACC.location}<br>
            ${ACC.description}<br><br>
           <br>
            <button class="review-btn">리뷰 보러가기</button>
        </div>
    </div>

    <!-- 오른쪽 패널: 객실 리스트 -->
    <div class="right-panel">
        객실정보
    </div>
</div>
</body>
</html>
