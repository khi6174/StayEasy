<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공지사항 상세보기</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
body {
    background-color: #f8f9fa;
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
}

.container {
    width: 65%;
    max-width: 900px;
    margin: 40px auto;
    padding: 20px 0;
}

/* 공지사항 제목 */
.notice-header {
    border-bottom: 2px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

h1 {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 5px;
}

.notice-date {
    font-size: 14px;
    color: #888;
}

/* 공지사항 내용 */
.notice-content {
    font-size: 16px;
    color: #333;
    line-height: 1.7;
    margin-bottom: 20px;
}

.notice-info {
    font-size: 14px;
    color: #555;
    background: #f8f8f8;
    padding: 15px;
    border-radius: 8px;
    margin-top: 20px;
}

@media (max-width: 768px) {
    .container {
        width: 90%;
    }
}
</style>
</head>
<body>

<div class="container">
    <!-- 목록으로 돌아가기 버튼 -->
    <a href="../notice/notice.html?pageNo=1" class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>

    <div class="notice-header">
        <h1>${notice.title}</h1>
        <p class="notice-date">
            <fmt:formatDate value="${notice.n_date}" pattern="yyyy-MM-dd"/>
        </p>
    </div>

	<div class="notice-content">
	    <p style="white-space: pre-line;">
	        <c:out value="${notice.content}" />
	    </p>
	</div>



    <div class="notice-info">
        ※ 참고하세요<br>
        - 공지는 변경될 수 있습니다.<br>
        - 중요한 내용은 꼭 확인해주세요.<br>
    </div>
</div>

</body>
</html>
