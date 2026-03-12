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
<title>문의 상세 (관리자)</title>
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

.container {
    width: 60%;
    margin: 20px auto;
    background: #ffffff;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
}

h3 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
    font-size: 24px; 
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    padding: 15px;
    border: 1px solid #ddd;
    text-align: left;
}

th {
    width: 25%;
    background-color: #f0f4f8; 
    color: #444;
    font-weight: bold;
}

td {
    background-color: #fff;
}

textarea[readonly], input[readonly] {
    background-color: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 8px 10px;
    width: 100%;
    resize: none;
}

.button-container {
    text-align: center;
    margin-top: 30px;
}

.btn {
    padding: 12px 30px;
    margin: 0 10px;
    border: none;
    border-radius: 20px;
    font-size: 15px;
    cursor: pointer;
    text-decoration: none;
    color: white;
    transition: background 0.3s;
}

.btn-reply {
    background-color: #28a745;
}
.btn-reply:hover {
    background-color: #218838;
}

.btn-list {
    background-color: #007bff;
}
.btn-list:hover {
    background-color: #0056b3;
}

.btn-delete {
    background-color: #ff4d4d; 
}
.btn-delete:hover {
    background-color: #e60000;
}

.answer-box {
    margin-top: 30px;
    padding: 20px;
    background: #eef3f8; 
    border-left: 5px solid #4CAF50;  
    border-radius: 8px;
}

.answer-box h4 {
    margin-bottom: 10px;
    color: #4CAF50; 
}

.answer-box p {
    margin: 5px 0;
}
</style>
</head>
<body>

<div class="container">
<a href="../inquire/inquireList.html" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
    <h3>문의 상세 보기 (관리자)</h3>

    <form:form action="../inquire/modify.html" method="post" modelAttribute="inquire">
        <!-- 숨겨진 필드 -->
        <form:hidden path="inquire_id"/>
        <form:hidden path="parent_id"/>
        <form:hidden path="group_id"/>
        <form:hidden path="status"/>

        <table>
            <tr>
                <th>문의 번호</th>
                <td><form:input path="inquire_id" readonly="true"/></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><form:input path="title" readonly="true"/></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><form:textarea path="content" rows="5" readonly="true"/></td>
            </tr>
            <tr>
                <th>작성일</th>
                <td><fmt:formatDate value="${inquire.i_date}" pattern="yyyy-MM-dd"/></td>
            </tr>
            <tr>
                <th>답변 상태</th>
                <td>${inquire.status}</td> 
            </tr>
        </table>

        <div class="button-container">
        	<c:if test="${empty reply}">
        	<a href="javascript:goReply()" class="btn btn-reply">답변</a>
        	</c:if>
            <button onclick="javascript:goDelete()" value="삭 제" name="BTN" class="btn btn-delete">삭제</button>
            <a href="../inquire/inquireList.html" class="btn btn-list">목록</a>
        </div>
    </form:form>

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

<script type="text/javascript">
function goReply(){
	const inquireId = "${inquire.inquire_id}";
    let form = document.forms[0]; // 첫 번째 form 사용
    form.action = "../inquire/inquireReply.html?inquire_id="+inquireId; // 답변 페이지로 이동
    form.submit(); // 제출
}
function goDelete(){
    let form = document.forms[0]; // 첫 번째 form 사용
    form.action = "../inquire/modify.html"; // 답변 페이지로 이동
    form.submit(); // 제출
}
</script>

</body>
</html>
