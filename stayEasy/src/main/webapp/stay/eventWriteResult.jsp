<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style>
	.body {
		background-color: #f8f9fa;
	}
    .button-container {
        width: 40%; /* 기존 테이블과 정렬 맞춤 */
        display: flex;
        justify-content: center; /* 가운데 정렬 */
        margin: 20px auto;
    }
    .button-container a {
        background-color: #ff6699;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 5px;
        text-decoration: none;
        text-align: center;
    }
    .button-container a:hover {
        background-color: #ff3366;
    }
</style>
<title>이벤트 등록</title>
</head>
<body>
<h3 align="center">이벤트가 등록되었습니다.</h3>
<div class="button-container" align="center">
    <a href="../event/eventList.html">이벤트 목록으로 돌아가기</a>
</div>
</body>
</html>
