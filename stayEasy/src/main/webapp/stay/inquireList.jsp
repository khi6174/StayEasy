<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 문의 목록</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }

    h2 {
        margin: 30px 0;
        font-size: 30px;
        color: #333;
    }

    .container {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .table th, .table td {
        border: 1px solid #ddd;
        padding: 15px;
        text-align: center;
        font-size: 14px;
    }

    .table th {
        background-color: #f8d7da;
        color: #333;
        font-weight: bold;
    }

    .table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .table tr:hover {
        background-color: #f1f1f1;
    }

    a {
        color: #007bff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    .button-container {
        margin-top: 20px;
    }

    button {
        background-color: #FF9AA2;
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }

    button:hover {
        background-color: #ff6b81;
    }

	/* 페이지네이션 스타일 */
	.pagination {
	    margin-top: 20px;
	    text-align: center;
	}
	
	.pagination a {
	    padding: 8px 12px;
	    margin: 0 5px;
	    border-radius: 5px;
	    text-decoration: none;
	    color: #333;
	    background-color: #e3f2fd;
	    font-size: 14px;
	}
	
	.pagination a:hover {
	    background-color: #64b5f6;
	    color: white;
	}
	
	.pagination .active {
	    background-color: #2196f3;
	    color: white;
	    font-weight: bold;
	}
    .empty-message {
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
    margin-top: 20px;
    text-align: center;
    color: #777;
    font-size: 18px;
	}
	.back-button {
    font-weight: bold;
	background: none !important;  /* 배경색 제거 */
    border: none;
    cursor: pointer;
    padding: 5px 10px;
	}
	/* hover 시 색상 변경 (배경색 없음) */
	.back-button:hover {
	    color: #ff6b81;
	    text-decoration: none !important;
	}
</style>
</head>
<body>
<c:if test="${not empty msg}">
	<script type="text/javascript">
        alert("${msg}");
    </script>
</c:if>
<div class="container">

    <h2>
        <c:choose>
            <c:when test="${sessionScope.loginUser.id == 'admin'}">문의 목록</c:when>
            <c:otherwise>내 문의 목록</c:otherwise>
        </c:choose>
    </h2>
    <c:choose>
            <c:when test="${sessionScope.loginUser.id == 'admin'}">
            	<c:choose>
            		<c:when test="${not empty param.userId and param.userId != '' }">
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
            </c:when>
            <c:otherwise>            
				<!-- 목록으로 돌아가기 버튼 -->
			    <a href="../mypage/mypageMain.html" class="back-button">
			        <i class="fas fa-arrow-left"></i>
			    </a>
            </c:otherwise>
    </c:choose>
    <!-- 리스트가 있는 경우 테이블 출력 -->
<c:if test="${not empty INQUIRE}">
    <table class="table">
        <tr>
            <th>글번호</th><th>제목</th><th>아이디</th><th>예약번호</th><th>작성일시</th><th>답변 상태</th>
        </tr>
        <c:forEach var="dto" items="${INQUIRE}">
            <tr>
                <td>${dto.inquire_id}</td>
                <td><a href="../inquire/detail.html?inquire_id=${dto.inquire_id}">${dto.title}</a></td>
                <td>${dto.user.user_id}</td>
                <td>${dto.reservation.reservation_id}</td>
                <td><fmt:formatDate value="${dto.i_date}" pattern="yyyy-MM-dd"/></td>
                <td>${dto.status}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<!-- 리스트가 없는 경우 메시지 표시 -->
<c:if test="${empty INQUIRE}">
    <div class="empty-message">
        현재 등록된 문의가 없습니다.
    </div>
</c:if>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <c:set var="currentPage" value="${currentPage}" />
        <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}" />
        <c:set var="endPage" value="${startPage + 9}" />
        <c:set var="pageCount" value="${PAGES}" />
        <c:if test="${endPage > pageCount}">
            <c:set var="endPage" value="${pageCount}" />
        </c:if>

        <c:if test="${startPage > 10}">
            <a href="../inquire/inquireList.html?pageNo=${startPage - 1}">[이전]</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <span class="current">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="../inquire/inquireList.html?pageNo=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${endPage < pageCount}">
            <a href="../inquire/inquireList.html?pageNo=${endPage + 1}">[다음]</a>
        </c:if>
    </div>

    <!-- 문의 작성 버튼 -->
    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id != 'admin'}">
        <div class="button-container">
            <button onclick="location.href='../inquire/inquireWrite.html'">문의 작성하기</button>
        </div>
    </c:if>
</div>
</body>
</html>
