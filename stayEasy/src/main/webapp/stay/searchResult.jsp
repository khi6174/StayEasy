<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 검색 결과</title>
<link rel="stylesheet" type="text/css" href="../css/acclist.css">
<style>
/* 전체 컨테이너 */
.container {
    width: 85%;
    max-width: 1100px;
    margin: 0 auto;
    text-align: center;
    padding: 30px 0;
}

/* 검색 다시하기 버튼 */
.back-search {
    display: inline-block;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    padding: 12px 18px;
    border-radius: 8px;
    background: #ff6b81;
    color: white;
    transition: 0.3s;
    margin-bottom: 20px;
}
.back-search:hover {
    background: #d83f5b;
}

/* 숙소 리스트 (2열 유지) */
.grid-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr); /* 2열 유지 */
    gap: 25px;
    justify-content: center;
    margin-top: 20px;
}

/* 카드 스타일 */
.card {
    background: white;
    border-radius: 16px;
    padding: 18px;
    text-align: center;
    box-shadow: 3px 5px 12px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.card:hover {
    transform: scale(1.03);
    box-shadow: 5px 8px 20px rgba(0, 0, 0, 0.15);
}
.card img {
    width: 100%;
    height: 180px;
    border-radius: 12px;
    object-fit: cover;
}
.card h3 {
    margin: 12px 0 6px;
    font-size: 18px;
    font-weight: bold;
    color: #222;
}
.card p {
    font-size: 15px;
    color: #555;
}

/* 가격 강조 스타일 */
.card p.price {
    font-size: 18px;
    font-weight: bold;
    color: #ff5733;
    margin-top: 5px;
}

</style>
</head>
<body>
<div class="container">
    <a href="../search/search.html" class="back-search">다시 검색하기</a>

    <!-- 숙소 리스트 -->
    <div class="grid-container">
        <c:forEach var="acc" items="${accList}">
            <div class="card">
                <a href="../reserv/reservDatil.html?accID=${acc.accommodation_id}">
                    <img src="${pageContext.request.contextPath}/imgs/${acc.acc_image}" alt="숙박 이미지">
                </a>
                <h3>${acc.accname}</h3>
                <p class="price">
                <fmt:formatNumber value="${acc.price_per_night}" type="number" pattern="#,###"/>원 ~
            	</p>
                <p>${acc.location}</p>
            </div>
        </c:forEach>
    </div>

<!-- 페이지네이션 -->
<c:if test="${PAGES > 0}">
    <div class="pagination">
        <c:if test="${startPage > 10}">
            <a href="../reserv/reservListLOC.html?TYPE=${TYPE}&pageNo=${startPage - 1}&LOC=${LOC}">[이전]</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <a class="active">${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="../reserv/reservListLOC.html?TYPE=${TYPE}&pageNo=${i}&LOC=${LOC}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${endPage < PAGES}">
            <a href="../reserv/reservListLOC.html?TYPE=${TYPE}&pageNo=${endPage + 1}&LOC=${LOC}">[다음]</a>
        </c:if>
    </div>
</c:if>

</div>
</body>
</html>
