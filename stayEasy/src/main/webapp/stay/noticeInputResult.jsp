<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공지 등록 완료</title>
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
</head>
<body>
<h3 align="center">공지글이 등록되었습니다.</h3>
<div class="button-container">
    <a href="../notice/notice.html">목록으로 돌아가기</a>
</div>
</body>
</html>
