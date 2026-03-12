<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>검색 결과가 없음</title>
<style type="text/css">
.body {
	background-color: #f8f9fa;
}
/* 검색 다시하기 버튼 */
.back-search {
    display: inline-block;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    padding: 12px 18px;
    border-radius: 8px;
    background: #ff6b81;
    color: white;
    transition: 0.3s;
    margin-bottom: 20px;
}
.back-search:hover {
    background: #d83f5b;
}
</style>
</head>
<body>
<div align="center">
<h2>
<a href="../search/search.html" class="back-search">다시 검색하기</a>
<br/>
검색 결과가 존재하지 않습니다.
</h2>
</div>
</body>
</html>