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
<meta charset="UTF-8">
<title>숙박 리스트</title>
<link rel="stylesheet" type="text/css" href="../css/acclist.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
/* 제목 스타일 */
h2 {
    font-size: 2.4em;
    font-weight: bold;
    margin-bottom: 20px;
}


</style>
</head>
<body>
<div class="container">
    <h2>숙박 리스트</h2>
    <!-- 목록으로 돌아가기 버튼 -->
    <a href="../reserv/reserv.html" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>
    <a href="../search/search.html?TYPE=${TYPE }" class="back-search">숙소 검색하기</a>

<form action="../reserv/reservListLOC.html" method="post">
	
	<label>숙소 유형:
		<select name="TYPE">
			<c:forEach var="type" items="${typeList}">
				<option value="${type}" ${TYPE == type ? 'selected' : ''}>
				${type == 'MOT' ? '모텔' :
				type == 'HOT' ? '호텔/리조트' :
				type == 'PEN' ? '펜션/풀빌라' :
				type == 'CAM' ? '캠핑/글램핑' :
				type == 'GUE' ? '게스트 하우스' : '공간 대여'}
				</option>
			</c:forEach>
		</select>
	</label>
	<input type="hidden" name="pageNo" value="1" />
	
	<input type="text" placeholder="여행지를 입력하세요." name="LOC" value="${LOC}"/>
    
    <input type="submit" value="적용"/>
</form>
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
                <p>${acc.location }</p>
            </div>
        </c:forEach>
    </div>
<br/><br/>
<div class="pagination">
<c:set var="currentPage" value="${currentPage}" />
<c:set var="startPage"
	value="${currentPage - (currentPage % 10 == 0 ? 10 :(currentPage % 10)) + 1 }" />
<c:set var="endPage" value="${startPage + 9}"/>	
<c:set var="pageCount" value="${PAGES }"/>
<c:if test="${endPage > pageCount }">
	<c:set var="endPage" value="${pageCount }" />
</c:if>
<c:if test="${startPage > 10 }">
	<a href="../reserv/reservList.html?TYPE=${TYPE }&pageNo=${startPage - 1 }">[이전]</a>
</c:if>
<c:forEach begin="${startPage }" end="${endPage }" var="i">
	<c:choose>
		<c:when test="${currentPage == i }">
		<a class="active">${ i }</a>
		</c:when>
		<c:otherwise>
		<a href="../reserv/reservList.html?TYPE=${TYPE }&pageNo=${ i }">${ i }</a>
		</c:otherwise>
	</c:choose>
	<c:if test="${currentPage == i }"></c:if>
</c:forEach>
<c:if test="${endPage < pageCount }">
	<a href="../reserv/reservList.html?TYPE=${TYPE }&pageNo=${endPage + 1 }">[다음]</a>
</c:if>
</div>
</div>
</body>
</html>