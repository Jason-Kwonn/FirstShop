<%@ page contentType="text/html; charset=euc-kr" %>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!DOCTYPE html>
		<html>

		<head>
			<title>���� ���</title>
			<!-- ���� : http://getbootstrap.com/css/   ���� -->
			<meta name="viewport" content="width=device-width, initial-scale=1.0" />

			<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		</head>

		<body>
			<!--  ///////////////////////// CSS ////////////////////////// -->
			<style>
				body {
					padding-top: 50px;
				}

				body>div.container {
					border: 3px solid #D6CDB7;
					margin-top: 10px;
				}
			</style>

			<div class="container">
				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->
				<div class="page-header">
					<h3 class=" text-info">���� ���</h3>
					<h5 class="text-muted"><strong class="text-danger">������ ���� ���Ű� �Ǿ����ϴ�.</strong></h5>
				</div>

				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>���� ���̵�</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>���� ���</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.paymentOption}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>������ ����</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>������ ����ó</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>������ �ּ�</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyAddr}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>��� ��û����</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyRequest}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>��� �����</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyDate}</div>
				</div>
				<hr>
				<br>

			</div>
			<!-- div.container end -->

		</body>

		</html>