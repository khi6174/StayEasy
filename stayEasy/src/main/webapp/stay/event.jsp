<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>이벤트 목록</title>
<link rel="stylesheet" type="text/css" href="../css/event.css">
</head>
<body>
<c:if test="${not empty msg}">
    <script type="text/javascript">
    alert('${msg}');
    </script>
</c:if>
<div class="container">
    <h1>이벤트</h1>
    
        <!-- 관리자 전용 버튼 -->
    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id=='admin' }">
        <div class="button-container">
            <button onclick="location.href='../event/eventWrite.html'">작성하기</button>
        </div>
    </c:if>

    <!-- 이벤트 리스트 -->
    <div class="event-list">
        <c:forEach var="event" items="${EVENT}">
            <div class="event-card">
                <img src="${pageContext.request.contextPath}/imgs/${event.event_image}" alt="이벤트 이미지">
                <div class="event-content">
                    <div class="event-title">
                        <a href="../event/detail.html?event_id=${event.event_id}">${event.title}</a>
                    </div>
                    <div class="event-date">
                        <fmt:formatDate value="${event.start_date}" pattern="yyyy.MM.dd" var="startDate"/>
                        <fmt:formatDate value="${event.end_date}" pattern="yyyy.MM.dd" var="endDate"/>
                        <p>${startDate} ~ ${endDate}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <c:set var="currentPage" value="${currentPage}" />
        <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1 }" />
        <c:set var="endPage" value="${startPage + 9}"/>
        <c:set var="pageCount" value="${PAGES}" />

        <c:if test="${endPage > pageCount}">
            <c:set var="endPage" value="${pageCount}" />
        </c:if>

        <c:if test="${startPage > 10}">
            <a href="../event/eventList.html?pageNo=${startPage - 1}">[이전]</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="../event/eventList.html?pageNo=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${endPage < pageCount}">
            <a href="../event/eventList.html?pageNo=${endPage + 1}">[다음]</a>
        </c:if>
    </div>
</div>

</body>
</html>
