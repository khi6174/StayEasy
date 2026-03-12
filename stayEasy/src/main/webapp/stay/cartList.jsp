<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니 목록</title>
<style type="text/css">
.body {
	background-color: #f8f9fa;
}
/* 전체 컨테이너 */
.container {
    max-width: 900px;
    margin: auto;
    padding: 20px;
    text-align: center;
}

/* 장바구니 제목 */
h1 {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* 장바구니 아이템 */
.cart-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #fff;
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

/* 객실 이미지 */
.cart-item img {
    width: 120px;
    height: 100px;
    border-radius: 10px;
    object-fit: cover;
    border: 1px solid #ccc;
}

/* 객실 정보 */
.cart-info {
    flex: 1;
    text-align: left;
    padding: 0 15px;
}

.cart-info h2 {
    font-size: 20px;
    margin-bottom: 5px;
}

.cart-info p {
    font-size: 14px;
    margin: 3px 0;
    color: #333;
}

/* 버튼 컨테이너 */
.cart-buttons {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
}

/* 수정 & 삭제 버튼 */
.cart-buttons button {
    padding: 8px 12px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 5px;
    cursor: pointer;
    border: none;
    transition: all 0.3s ease-in-out;
}

.btn-modify {
    background-color: #007bff;
    color: white;
}

.btn-modify:hover {
    background-color: #0056b3;
}

.btn-delete {
    background-color: #dc3545;
    color: white;
}

.btn-delete:hover {
    background-color: #b02a37;
}

/* 총 결제 금액 */
.total-price {
    margin: 30px 0;
    font-size: 22px;
    font-weight: bold;
    color: #333;
}

/* 결제 버튼 */
.checkout-container {
    text-align: center;
}

.checkout-btn {
    padding: 15px 30px;
    font-size: 18px;
    font-weight: bold;
    background-color: #28a745;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 8px;
    transition: background-color 0.3s ease-in-out, transform 0.2s;
}

.checkout-btn:hover {
    background-color: #218838;
    transform: scale(1.05);
}
</style>
</head>
<body>

<c:if test="${message != null}">
    <script>
        alert("${message}");
    </script>
</c:if>

<div class="container">
    <h1>장바구니</h1>

    <c:choose>
        <c:when test="${empty cartList}">
            <h2>장바구니가 텅텅 비어있습니다.</h2>
        </c:when>
        <c:otherwise>
            <c:forEach var="cart" items="${cartList}">
                <div class="cart-item">
                    <!-- 객실 이미지 -->
                    <img src="${pageContext.request.contextPath}/imgs/${cart.room.room_image}" alt="객실 이미지">
                    
                    <!-- 객실 정보 -->
                    <div class="cart-info">
                        <h2>${cart.room.accommodation.accname}</h2>
                        <p>방: ${cart.room.name}</p>
                        <p>1박 가격: <fmt:formatNumber value="${cart.room.price_per_night}" pattern="#,###"/>원</p>
                        <p>예약일: <fmt:formatDate value="${cart.check_in_date}" pattern="yyyy-MM-dd"/> ~ 
                            <fmt:formatDate value="${cart.check_out_date}" pattern="yyyy-MM-dd"/> (${cart.nights}박)</p>
                        <p>인원: ${cart.count}명</p>
                        <p>결제금액: <fmt:formatNumber value="${cart.total_price}" pattern="#,###"/>원</p>
                    </div>

                    <!-- 수정 & 삭제 버튼 -->
                    <div class="cart-buttons">
                        <button class="btn-modify" onclick="goToPage('../cart/modify.html', '${cart.cartitem_id}')">수정</button>
                        <form action="../cart/delete.html" method="post">
                            <input type="hidden" name="cartItemId" value="${cart.cartitem_id}">
                            <button class="btn-delete" type="submit">삭제</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty cartList}">
        <!-- 총 결제 금액 -->
        <div class="total-price">
            총 결제 금액: <fmt:formatNumber value="${rtotal_price}" pattern="#,###"/>원
        </div>

        <!-- 결제 버튼 -->
        <form id="checkoutForm" action="../reserv/reservPayCart.html" method="post" onsubmit="return confirmCheckout()">
            <div class="checkout-container">
                <button class="checkout-btn" type="submit">결제하기</button>
            </div>
        </form>
    </c:if>
</div>

</body>
<script type="text/javascript">
function goToPage(url, cartItemId) {
    window.location.href = url + "?cartItemId=" + cartItemId;
}
function confirmCheckout() {
    return confirm("정말 결제하시겠습니까?");
}
</script>
</html>
