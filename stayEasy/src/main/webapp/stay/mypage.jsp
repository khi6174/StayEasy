<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
</head>
<body>
<c:if test="${not empty msg}">
    <script type="text/javascript">
    alert('${msg}');
    </script>
</c:if>
<div class="container">
    <h1>마이페이지</h1>
    <form:form modelAttribute="userInfo" action="../mypage/update.html" method="post">
        <table>
            <tr>
                <th>아이디</th>
                <td><form:input path="user_id" readonly="true"/>
                <font color="red"><form:errors path="user_id"/></font></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><form:input path="username" readonly="true"/>
                <font color="red"><form:errors path="username"/></font></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><form:input path="email" type="email"/>
                <font color="red"><form:errors path="email"/></font></td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td><form:input path="birth" type="date"/>
                <font color="red"><form:errors path="birth"/></font></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><form:password path="user_pwd" placeholder="비밀번호 입력"/>
                <font color="red"><form:errors path="user_pwd"/></font></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><form:input path="phone"/>
                <font color="red"><form:errors path="phone"/></font></td>
            </tr>
            <tr>
                <th>주소</th>
                <td><form:input path="addr"/>
                <font color="red"><form:errors path="addr"/></font></td>
            </tr>
			<tr>
			    <th>성별</th>
			    <td class="gender-container">
			        <label><form:radiobutton path="gender" value="남자"/> 남자</label>
			        <label><form:radiobutton path="gender" value="여자"/> 여자</label>
			    </td>
			</tr>
			        </table>
        <button type="submit">수정하기</button>
    </form:form>
    <button onclick="location.href='../mypage/changePwd.html'">비밀번호 변경하기</button>
</div>

<c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id !='admin'}">
    <div class="button-container">
        <button onclick="location.href='../inquire/inquireList.html'">내 문의</button>
        <button onclick="location.href='../acc/myAccommodations.html'">내 숙소</button>
        <button onclick="location.href='../acc/putAcc.html'">숙소 신청하기</button>
        <button onclick="location.href='../mypage/accList.html'">예약 내역</button>
    </div>
</c:if>

</body>
</html>