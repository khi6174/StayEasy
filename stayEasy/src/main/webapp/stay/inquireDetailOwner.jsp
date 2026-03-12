<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>문의사항 상세</title>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style type="text/css">
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
    }
    .container {
        width: 60%;
        margin: 0 auto;
        background: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    h3 {
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 10px;
        border: 1px solid #ddd;
    }
    th {
        background: #f8d7da;
    }
    .button-container {
        text-align: center;
    }
    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    input[type="text"]:focus, textarea:focus {
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.4);
        outline: none;
    }
    input[type="submit"], .btn-back {
        padding: 10px 20px;
        margin: 5px;
        border: none;
        border-radius: 5px;
        background: #007bff;
        color: white;
        cursor: pointer;
    }
    input[type="submit"]:hover, .btn-back:hover {
        background: #0056b3;
    }
    .answer-box {
        margin-top: 30px;
        padding: 15px;
        background: #f1f1f1;
        border-radius: 5px;
    }
</style>
</head>
<body>

<h3 align="center">문의 상세 보기</h3>

<div class="container">
<a href="../inquire/inquireList.html" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<!-- 문의 상세 폼 -->
<form:form action="../inquire/modify.html" method="post" modelAttribute="inquire">
    <table>
        <tr><th>문의 번호</th>
        <td>${inquire.inquire_id}<form:hidden path="inquire_id"/></td></tr>
        <tr><th>제목</th>
	    <td>
	        <c:choose>
	            <c:when test="${empty reply}">
	                <form:input path="title" />
	            </c:when>
	            <c:otherwise>
	            	${inquire.title }
	            </c:otherwise>
	        </c:choose>
	    </td>
		</tr>
        <tr><th>내용</th>
	    <td>
	        <c:choose>
	            <c:when test="${empty reply}">
	                <form:textarea path="content" rows="4" cols="50" />
	            </c:when>
	            <c:otherwise>
	                <p style="white-space: pre-line;">
				        <c:out value="${inquire.content }" />
				    </p>
	            </c:otherwise>
	        </c:choose>
	    </td>
		</tr>
        <tr><th>답변 상태</th><td>${inquire.status}<form:hidden path="status"/></td></tr>
        <tr><th>작성일</th><td><fmt:formatDate value="${inquire.i_date}" pattern="yyyy-MM-dd"/></td></tr>
    </table>

    <div class="button-container">
    	<c:if test="${empty reply}">
        <input type="submit" value="수 정" name="BTN"/>
        </c:if>
        <button type="button" class="btn-back" onclick="location.href='../inquire/inquireList.html'">목록으로</button>
    </div>
</form:form>

<!-- 답변 표시 영역 -->
<div class="answer-box">
    <h4>관리자 답변</h4>
    <c:choose>
        <c:when test="${not empty reply}">
            <p><strong>답변일:</strong> <fmt:formatDate value="${reply.i_date}" pattern="yyyy-MM-dd"/></p>
            <p><strong>답변 내용:</strong></p>
            <p style="white-space: pre-line;">
				        <c:out value="${reply.content}" />
			</p>
        </c:when>
        <c:otherwise>
            <p>아직 답변이 등록되지 않았습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

</div>

</body>
</html>
