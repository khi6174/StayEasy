<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제 완료</title>
<!-- Font Awesome 아이콘 라이브러리 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        display: flex;
        justify-content: center;
        height: 100vh;
    }

    .container {
        background: white;
        padding: 40px;
        margin-top: 50px;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        max-width: 400px;
        width: 100%;
    }

    .success-icon {
        font-size: 50px;
        color: #28a745;
        margin-bottom: 15px;
    }

    h2 {
        color: #333;
        font-size: 24px;
        margin-bottom: 15px;
    }

    p {
        font-size: 16px;
        color: #555;
        margin-bottom: 20px;
    }

    .btn {
        display: block;
        width: 100%;
        padding: 12px 20px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
        transition: background 0.3s ease-in-out;
    }

    .btn-main {
        background-color: #ff6b81;
        color: white;
    }

    .btn-main:hover {
        background-color: #e05670;
    }

    .btn-reserv {
        background-color: #007bff;
        color: white;
    }

    .btn-reserv:hover {
        background-color: #0056b3;
    }

</style>
</head>
<body>

<div class="container">
    <i class="fas fa-check-circle success-icon"></i>
    <h2>결제가 완료되었습니다!</h2>
    <p>StayEasy를 이용해 주셔서 감사합니다.</p>

    <button class="btn btn-main" onclick="location.href='../stay/main.html'">메인 페이지로 이동</button>
    <button class="btn btn-reserv" onclick="location.href='../mypage/accList.html'">예약 내역 확인</button>
</div>

</body>
</html>
