<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>내 숙소 목록</title>
    <script>
    window.onload = function() {
        var message = "${successMessage}";
        if (message) {
            alert(message); // ✅ JavaScript alert로 메시지 표시
        }
    };
</script>
<!-- Font Awesome 아이콘 라이브러리 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="../css/backbutton.css">

<style>
	/* 전체 페이지 스타일 */
	body {
	    font-family: 'Noto Sans KR', sans-serif;
	    background-color: #f8f9fa;
	    margin: 0;
	    padding-top: 20px;
	    text-align: center;
	}
	
	h2 {
	    font-size: 24px;
	    font-weight: bold;
	    margin-bottom: 20px;
	}
	
	/* 테이블 스타일 */
	table {
	    width: 90%;
	    max-width: 1000px;
	    margin: 0 auto;
	    border-collapse: collapse;
	    background: white;
	    border-radius: 10px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    overflow: hidden;
	}
	
	th, td {
	    padding: 12px;
	    text-align: center;
	    border-bottom: 1px solid #ddd;
	}
	
	th {
	    background: #ff6b81;
	    color: white;
	    font-size: 16px;
	}
	
	tr:hover {
	    background: #f2f2f2;
	}
	
	/* 버튼 스타일 */
	.btn {
	    padding: 8px 14px;
	    text-decoration: none;
	    border-radius: 6px;
	    font-size: 14px;
	    transition: 0.3s;
	    display: inline-block;
	}
	
	.btn:hover {
	    transform: scale(1.05);
	}
	
	.btn-success {
	    background: #4CAF50;
	    color: white;
	    border: none;
	}
	
	.btn-success:hover {
	    background: #45a049;
	}
	
	.btn-danger {
	    background: #f44336;
	    color: white;
	    border: none;
	}
	
	.btn-danger:hover {
	    background: #d32f2f;
	}
	
	.btn-disabled {
	    background: #ccc;
	    color: #666;
	    cursor: not-allowed;
	}
	
	   /* 숙소 추가하기 버튼 */
	.add-btn {
	    display: inline-block;
	    background: linear-gradient(135deg, #ff6b81, #ff8a6c);
	    color: white;
	    font-size: 16px;
	    font-weight: bold;
	    padding: 12px 20px;
	    border-radius: 8px;
	    text-decoration: none;
	    transition: 0.3s ease-in-out;
	    box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.15);
	}
	
	.add-btn:hover {
	    background: linear-gradient(135deg, #ff8a6c, #ff6b81);
	    transform: scale(1.05);
	    box-shadow: 3px 6px 12px rgba(0, 0, 0, 0.2);
	}
	
	/* 반응형 디자인 */
	@media (max-width: 768px) {
	    table {
	        width: 100%;
	    }
	
	    th, td {
	        font-size: 14px;
	        padding: 10px;
	    }
	
	    .btn {
	        padding: 6px 10px;
	        font-size: 12px;
	    }
	
	     .add-btn {
	     font-size: 14px;
	     padding: 10px 16px;
		}
	}
	/* 목록으로 돌아가기 버튼 컨테이너 */
	.back-container {
	    display: flex;
	    justify-content: flex-start; /* 왼쪽 정렬 */
	    align-items: center;
	    width: 90%;
	    max-width: 1000px;
	    margin: 0 auto 10px; /* 표와의 간격 조정 */
	}
	.bottom-btn {
    display: inline-block;
    background: linear-gradient(135deg, #ff6b81, #ff8a6c);
    color: white;
    font-size: 16px;
    font-weight: bold;
    padding: 12px 24px;
    margin: 10px 12px;
    border-radius: 8px;
    text-decoration: none;
    transition: all 0.3s ease-in-out;
    box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.15);
	}
	
	.bottom-btn:hover {
	    background: linear-gradient(135deg, #ff8a6c, #ff6b81);
	    transform: translateY(-2px);
	    box-shadow: 3px 6px 12px rgba(0, 0, 0, 0.2);
	}
	 .status-pending {
        color: black;
        font-weight: bold;
    }
    .status-rejected {
        color: red;
        font-weight: bold;
    }
    .status-approved {
        color: green;
        font-weight: bold;
    }
	.edit-btn {
    background-color: #5dade2;  /* 딥스카이블루 느낌 */
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    text-decoration: none; /* 밑줄 제거 */
    transition: background-color 0.3s ease;
    margin-left: 5px;
}

.edit-btn:hover {
    background-color: #3498db; /* hover 시 진해짐 */
}

	
</style>

</head>
<body>
<c:if test="${not empty msg}">
	<script type="text/javascript">
        alert("${msg}");
    </script>
</c:if>
    <h2>내 숙소 목록</h2>
	<!-- 목록으로 돌아가기 버튼 컨테이너 추가 -->
	<div class="back-container">
	    <a href="../mypage/mypageMain.html" class="back-button">
	        <i class="fas fa-arrow-left"></i>
	    </a>
	</div>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>신청 날짜</th>
                <th>숙소명</th>
                <th>카테고리</th>
                <th>승인 여부</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty accommodations}">
                    <c:forEach var="accommodation" items="${accommodations}" varStatus="stat">
                        <tr>
                            <td>${stat.count}</td>
                            <td>${accommodation['a_date']}</td>
                            <td><a href="../mypage/myAccDetail.html?accId=${accommodation['accommodation_id']}">
                           		 ${accommodation['accname']}</a></td>
                            <td>${accommodation['cate_name']}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${accommodation['app_status'] == 0}"> 
                                    	<span class="status-pending">승인 대기</span>
                                    </c:when>
                                    <c:when test="${accommodation['app_status'] == 2}">
										<span class="status-rejected">승인 거절</span>
									</c:when>
                                    <c:otherwise> 
                                    	<span class="status-approved">승인 완료</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${accommodation['app_status'] == 1}">
                                        <a href="../mypage/accUpdate.html?accId=${accommodation['accommodation_id']}" class="edit-btn">수정</a>
                                         <form action="../mypage/deleteAccommodation.html" method="post" style="display:inline;">
								             <input type="hidden" name="accId" value="${accommodation['accommodation_id']}">
								             <button type="submit" class="btn btn-danger" 
								             onclick="return confirm('숙소에 대한 모든 정보가 삭제됩니다. 정말 삭제하시겠습니까?')">삭제</button>
							        	 </form>
                                    </c:when>
                                    <c:when test="${accommodation['app_status'] == 2}">
                                         <span class="btn btn-disabled">수정 불가</span>
                                      	 <form action="../mypage/deleteAccommodation.html" method="post" style="display:inline;">
								             <input type="hidden" name="accId" value="${accommodation['accommodation_id']}">
								             <button type="submit" class="btn btn-danger" 
								             onclick="return confirm('숙소에 대한 모든 정보가 삭제됩니다. 정말 삭제하시겠습니까?')">삭제</button>
							        	 </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="btn btn-disabled">수정 불가</span>
                                      	 <form action="../mypage/deleteAccommodation.html" method="post" style="display:inline;">
								             <input type="hidden" name="accId" value="${accommodation['accommodation_id']}">
								             <button type="submit" class="btn btn-danger" 
								             onclick="return confirm('숙소에 대한 모든 정보가 삭제됩니다. 정말 삭제하시겠습니까?')">삭제</button>
							        	 </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6">등록된 숙소가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <br>
    <a href="putAcc.html?CHECK=my" class="bottom-btn">숙소 추가하기</a>
    <a href="../mypage/accUpdateList.html" class="bottom-btn">숙소 수정 신청 목록</a>
</body>
</html>