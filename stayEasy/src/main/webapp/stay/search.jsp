<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="model.*, java.time.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    LocalDate today = LocalDate.now(); // 오늘 날짜 가져오기
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>STAYEASY - 숙소 검색</title>
<link rel="stylesheet" type="text/css" href="../css/accsearch.css">
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<script>
    function setCheckoutMinDate() {
        var checkin = document.getElementById("checkin").value;
        var checkout = document.getElementById("checkout");

        if (checkin) {
            let checkinDate = new Date(checkin);
            checkinDate.setDate(checkinDate.getDate() + 1); // 체크인 날짜 +1일
            checkout.min = checkinDate.toISOString().split("T")[0]; // YYYY-MM-DD 형식으로 변환
        }
    }
</script>
</head>
<body>
<div class="container">
<c:choose>
    <c:when test="${not empty param.TYPE and param.TYPE != ''}">
        <!-- 목록으로 돌아가기 버튼 (TYPE이 존재할 경우) -->
        <a href="../reserv/reservList.html?TYPE=${param.TYPE}&pageNo=1" class="back-button">
            <i class="fas fa-arrow-left"></i>
        </a>
    </c:when>
    <c:otherwise>    
        <!-- 목록으로 돌아가기 버튼 (TYPE이 없을 경우) -->
        <a href="../reserv/reserv.html" class="back-button">
            <i class="fas fa-arrow-left"></i>
        </a>
    </c:otherwise>
</c:choose>
<h2>숙소 검색</h2>
<br/>
<form action="../search/result.html" method="post">
    <input type="hidden" name="pageNo" id="pageNo" value="1">
    <div class="search-box">
        <div class="input-group">
            <label>키워드:</label>
            <input type="text" name="KEY" placeholder="여행지나 숙소를 입력하세요." required="required"/>
        </div>
	
        <div class="input-group">
            <label>숙소 유형:</label>
            <select name="type" required>
                <option value="" disabled ${empty selectedType ? 'selected' : ''}>숙소 유형 선택</option>
                <c:forEach var="t" items="${typeList}">
                    <option value="${t}" ${selectedType == t ? 'selected' : ''}>
                        ${t == 'MOT' ? '모텔' :
                        t == 'HOT' ? '호텔/리조트' :
                        t == 'PEN' ? '펜션/풀빌라' :
                        t == 'CAM' ? '캠핑/글램핑' :
                        t == 'GUE' ? '게스트 하우스' : '공간 대여'}
                    </option>
                </c:forEach>
            </select>
        </div>

		<div class="inline-group">
	        <!-- 체크인 날짜 선택 -->
	        <div class="input-group">
	            <label>체크인:</label>
	            <input type="date" id="checkin" name="CHECKIN" required="required" min="<%= today %>" onchange="setCheckoutMinDate()">
	        </div>
	
	        <!-- 체크아웃 날짜 선택 -->
	        <div class="input-group">
	            <label>체크아웃:</label>
	            <input type="date" id="checkout" name="CHECKOUT" required="required">
	        </div>
	
	        <div class="input-group">
	            <label>인원수:</label>
	            <input type="number" name="capacity" value="1" min="1" required/>
	        </div>
		</div>

        <div class="input-group">
            <input type="submit" value="검색하기"/>
        </div>
        
    </div>
</form>
</div>
</body>
</html>
