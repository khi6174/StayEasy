<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 불가</title>
<link rel="stylesheet" type="text/css" href="../css/noreview.css">
</head>
<body>

<!-- 컨텐츠를 기존 페이지와 동일한 위치에 배치 -->
<div class="wrapper">
	<div class="container">
		<h2>리뷰 작성 불가</h2>
		<p>리뷰 작성은 해당 숙소 이용 후 가능합니다.</p>
		
		<!-- 리뷰 목록으로 이동 -->
		<a href="../review/list.html?ACC=${ACC}" class="btn">목록으로 이동</a>
	</div>
</div>
</body>
</html>
