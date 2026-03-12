<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입 완료</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        text-align: center;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 50%;
        margin: 100px auto;
        padding: 30px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
    }

    p {
        font-size: 18px;
        color: #555;
        margin-bottom: 30px;
    }

    .btn {
        display: inline-block;
        padding: 12px 25px;
        font-size: 16px;
        font-weight: bold;
        color: white;
        background-color: #FF9AA2;
        border: none;
        border-radius: 8px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        background-color: #ff6b81;
    }
</style>

</head>
<body>

<div class="container">
    <h2>회원가입 완료</h2>
    <p>회원가입이 성공적으로 완료되었습니다!</p>
    
    <!-- 로그인 페이지로 이동하는 버튼 -->
    <a href="../login/login.html" class="btn">로그인하러 가기</a>
</div>

</body>
</html>
