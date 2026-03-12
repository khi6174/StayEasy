<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">
	body {
		font-family: Arial, sans-serif;
		background-color: #f8f9fa;
	}
	.container {
		text-align: center;
		margin-top: 20px;
	}
	.table {
		width: 40%;
		border-collapse: collapse;
		margin: 20px auto;
	}
	.table th, .table td {
		border: 1px solid black;
		padding: 10px;
		text-align: center;
	}
	.table th {
		background-color: #ffccdd;
		color: black;
		font-weight: bold;
	}
	.button-container {
    width: 40%; /* 테이블 너비(40%)에 맞춤 */
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    margin: 10px auto;
	}
	.button-container input[type="submit"] {
		background-color: #ff6699;
		color: white;
		border: none;
		padding: 8px 15px;
		font-size: 14px;
		cursor: pointer;
		border-radius: 5px;
		margin-left: 10px; /* 버튼 간격 조정 */
	}
	.button-container input[type="submit"]:hover {
		background-color: #ff3366;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	setTimeout(function(){
		alert("문의가 변경되었습니다.");
		location.href="../inquire/inquireList.html";
	},100);
</script>

</body>
</html>











