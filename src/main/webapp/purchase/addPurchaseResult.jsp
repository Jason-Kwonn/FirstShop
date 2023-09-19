<%@ page contentType="text/html; charset=euc-kr" %>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!DOCTYPE html>
		<html>

		<head>
			<title>구매 결과</title>
			<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
					<h3 class=" text-info">구매 결과</h3>
					<h5 class="text-muted"><strong class="text-danger">다음과 같이 구매가 되었습니다.</strong></h5>
				</div>

				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>물품번호</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>구매 아이디</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>구매 방법</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.paymentOption}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>수령자 성함</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>수령자 연락처</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>수령자 주소</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyAddr}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>배송 요청사항</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyRequest}</div>
				</div>
				<div class="row">
					<div class="col-xs-4 col-md-2"><strong>배송 희망일</strong></div>
					<div class="col-xs-8 col-md-4">${purchase.dlvyDate}</div>
				</div>
				<hr>
				<br>

			</div>
			<!-- div.container end -->

		</body>

		</html>