<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>접근 불가</title>
<style>
    body {
    font-family: Arial, sans-serif;
    display: flex;
    flex-direction: column;  /* 세로 정렬 */
    /* align-items: center; 이게 메뉴해더 옆으로 밀리는 원인 */ 
    justify-content: center;
    height: 100vh;
    background-color: #f8f9fa;
    margin: 0;
}

/* menu_header가 밀리는 문제 해결 */
header {
    width: 100%; /* 헤더 전체를 화면 너비만큼 차지 */
    margin: 0;
    padding: 0;
}

.message-container {
    text-align: center;
    background: white;
    padding: 30px;
    margin-top: 50px;
    max-width: 600px; /* 최대 너비 조정 */
    border-radius: 10px;
    box-shadow: 2px 2px 15px rgba(0, 0, 0, 0.1);
}


    .message-container h2 {
        font-size: 22px;
        color: #dc3545;
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<div class="message-container">
    <h2>장바구니는 사용자 계정만 이용 가능합니다.</h2>
</div>

</body>
</html>
