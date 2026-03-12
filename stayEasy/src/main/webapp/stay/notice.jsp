<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공지사항 목록</title>
<link rel="stylesheet" type="text/css" href="../css/notice.css">
</head>
<body>

<div class="container">
    <h1>공지사항</h1>
    <p class="notice-desc">StayEasy 업데이트 정보 등 다양한 소식을 알려드립니다.</p>

    <!-- 관리자 전용 버튼 -->
    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id=='admin' }">
        <div class="button-container">
            <button onclick="location.href='../notice/input.html'">작성하기</button>
        </div>
    </c:if>

    <!-- 공지사항 리스트 -->
    <ul class="notice-list">
        <c:forEach var="dto" items="${NOTICES}">
            <li class="notice-item">
        		<span class="notice-label">공지</span>
                <div class="notice-title">
                    <a href="../notice/detail.html?notice_id=${dto.notice_id}">${dto.title}</a>
                </div>
                <div class="notice-date">
                    <fmt:formatDate value="${dto.n_date}" pattern="yyyy.MM.dd"/>
                </div>
            </li>
        </c:forEach>
    </ul>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <c:set var="currentPage" value="${currentPage}" />
        <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1 }" />
        <c:set var="endPage" value="${startPage + 9}"/>
        <c:set var="pageCount" value="${PAGES }"/>

        <c:if test="${endPage > pageCount}">
            <c:set var="endPage" value="${pageCount }" />
        </c:if>
        <c:if test="${startPage > 10}">
            <a href="../notice/notice.html?pageNo=${startPage - 1 }">[이전]</a>
        </c:if>

        <c:forEach begin="${startPage }" end="${endPage }" var="i">
            <a href="../notice/notice.html?pageNo=${ i }" 
               class="${currentPage == i ? 'active' : ''}">${ i }</a>
        </c:forEach>

        <c:if test="${endPage < pageCount}">
            <a href="../notice/notice.html?pageNo=${endPage + 1 }">[다음]</a>
        </c:if>
    </div>
</div>

</body>
</html>
