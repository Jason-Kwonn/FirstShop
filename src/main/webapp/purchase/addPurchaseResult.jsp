<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<title>���� ���</title>
</head>

<body>
<!-- 
<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=0" method="post">
 -->
������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}</td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${purchase.buyer.userId}</td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>${purchase.paymentOption}</td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${purchase.receiverName}</td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${purchase.receiverPhone}</td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${purchase.dlvyAddr}</td>
	</tr>
	<tr>
		<td>���ſ�û����</td>
		<td>${purchase.dlvyRequest}</td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${purchase.dlvyDate}</td>
	</tr>
</table>
<!-- 
</form>
 -->
</body>
</html>