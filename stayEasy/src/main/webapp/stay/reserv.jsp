<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙박 예약</title>
<link rel="stylesheet" type="text/css" href="../css/reservindex.css">
</head>
<body>

<h1>숙박 예약</h1>
<br/>
<div>
<a href="../search/search.html" class="back-search">숙소 검색하기</a>
</div>
<br/><br/>

<div class="icon-container">
    <a href="../reserv/reservList.html?TYPE=MOT" class="icon">
        <img src="../imgs/motel.png" alt="모텔 아이콘">
        <span>모텔</span>
    </a>

    <a href="../reserv/reservList.html?TYPE=HOT" class="icon">
        <img src="../imgs/hotel.png" alt="호텔·리조트 아이콘">
        <span>호텔·리조트</span>
    </a>

    <a href="../reserv/reservList.html?TYPE=PEN" class="icon">
        <img src="../imgs/pension.png" alt="펜션·풀빌라 아이콘">
        <span>펜션·풀빌라</span>
    </a>

    <a href="../reserv/reservList.html?TYPE=CAM" class="icon">
        <img src="../imgs/camping.png" alt="캠핑·글램핑 아이콘">
        <span>캠핑·글램핑</span>
    </a>

    <a href="../reserv/reservList.html?TYPE=GUE" class="icon">
        <img src="../imgs/guesthouse.png" alt="게스트하우스 아이콘">
        <span>게스트 하우스</span>
    </a>

    <a href="../reserv/reservList.html?TYPE=SPA" class="icon">
        <img src="../imgs/space.png" alt="공간 대여 아이콘">
        <span>공간 대여</span>
    </a>
</div>

</body>
</html>
