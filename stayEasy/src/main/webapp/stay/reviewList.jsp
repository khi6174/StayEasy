<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${accname} 리뷰</title>
<link rel="stylesheet" type="text/css" href="../css/review.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

</head>
<body>
<div class="container">
<h2>${accname} Review</h2>
	<!-- 돌아가기 버튼 -->
	<a href="../reserv/reservDatil.html?accID=${ACC}" class="back-button">
    	<i class="fas fa-arrow-left"></i>
	</a>

	<div class="overall-rating">
		<strong>평점 :</strong>
		<span>
        <c:choose>
            <c:when test="${not empty rating}">
                ${rating}
            </c:when>
            <c:otherwise>
                0
            </c:otherwise>
        </c:choose>
    </span>
	</div>
	
	<!-- 리뷰 작성하기 버튼 -->
    <button class="write-button" onclick="location.href='../review/write.html?ACC=${ACC}'">
		리뷰 작성하기
	</button>
	
	<div class="review-container">
		<c:set var="reviewCount" value="0"/>
		<c:forEach var="reservation" items="${reservations}">
			<c:forEach var="review" items="${reservation.review}">
				<div class="review-box">
					<table>
					<tr>
					<div class="review-user">${review.user.username}</div>
					<div class="review-room">객실명: ${reservation.room.name}</div>
					<div class="review-dates">
						체크인: 
						<fmt:formatDate value="${reservation.check_in_date}" pattern="yyyy년 MM월 dd일"/>
						|
						체크아웃:
						<fmt:formatDate value="${reservation.check_out_date}" pattern="yyyy년 MM월 dd일"/>
					</div>
					<div class="review-rating">
						평점: <span>${review.rating}</span>
					</div>
					<div class="review-content">
					    <p style="white-space: pre-line;">
					        <c:out value="${review.content}" />
					    </p>
					</div>
					<div class="review-date">작성일:
					<fmt:formatDate value="${review.v_date}" pattern="yyyy년 MM월 dd일" />
					</div>
					</tr>
					<tr>
					<c:if test="${sessionScope.loginUser.id == 'admin' or sessionScope.loginUser.id == review.user.user_id}">
						<div class="delete-button">
						<a href="../review/delete.html?review_id=${review.review_id}&ACC=${ACC}">삭제</a>
						</div>
					</c:if>
					</tr>
					</table>
				</div>
				<c:set var="reviewCount" value="${reviewCount + 1}"/>
			</c:forEach>
		</c:forEach>
		
		<!-- 리뷰가 없을 경우 메시지 출력 -->	
        <c:if test="${reviewCount == 0}">
			<p class="no-reviews">현재 작성된 리뷰가 없습니다.</p>
		</c:if>
	</div>
</div>

</body>
</html>
