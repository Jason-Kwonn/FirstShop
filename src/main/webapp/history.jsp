<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
<title>열어본 상품 보기</title>
</head>

<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>

${request.setCharacterEncoding("euc-kr")}
${response.setCharacterEncoding("euc-kr")}
<c:set var="cookieHistory" value="${ cookie['history'].value }"/>

<c:forEach var="prodNo" items="${ fn:split(cookieHistory , '/') }">
	    <a href="/getProduct.do?prodNo=${prodNo}&menu=search" target="rightFrame">${prodNo}</a>
	    <br>
</c:forEach>


</body>
</html>