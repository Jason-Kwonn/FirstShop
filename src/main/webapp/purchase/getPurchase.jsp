<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">

				<title>���� ������ȸ</title>

				<!-- ���� : http://getbootstrap.com/css/   ���� -->
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />

				<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
				<link rel="stylesheet"
					href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
				<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

				<!--  ///////////////////////// CSS ////////////////////////// -->
				<style>
					body {
						padding-top: 50px;
					}

					body>div.container {
						border: 3px solid #D6CDB7;
						margin-top: 10px;
					}

					.thumbnail {
						width: 100px;
						height: 100px;
						object-fit: cover;
						/* �̹��� ������ �����ϸ鼭 ä��� */
					}
				</style>

				<!-- ////////////////////////////// JavaSript ////////////////////////////// -->
				<script type="text/javascript">

					//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
						$("a:contains('����')").on("click", function () {
							//Debug..
							//alert($("a:contains('����')").html());
							history.go(-1);
						});

						$("button.btn.btn-primary:contains('����')").on("click", function () {
							//Debug..
							//alert($("button.btn.btn-primary:contains('����')").html());
							self.location = "/purchase/updatePurchase?prodNo=${product.prodNo}"
						});
					});

				</script>

			</head>

			<body>

				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
				<div class="container">

					<div class="page-header">
						<h3 class="text-info">���� ������ȸ</h3>
						<h5 class="text-muted">�� ������ <strong class="text-danger">������ �����ϴ�.</strong></h5>
					</div>

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>���� ���̵�</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>��ǰ �̹���</strong></div>
						<div class="col-xs-8 col-md-4">
							<c:choose>
								<c:when test="${ ! empty product.fileNames}">
									<c:forEach var="image" items="${product.fileNames}">
										<img src="/images/uploadFiles/${image}" class="img-thumbnail thumbnail" />
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- ������ ǥ���ϰų� �ƹ� �͵� ���� ���� -->
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
						<div class="col-xs-8 col-md-4">${product.price}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>���� ����</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseQty} </div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>���� ���Ű�</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.price}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>���� ���</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.paymentOption}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>�޴� �� �̸�</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>�޴� �� ����ó</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>����� �ּ�</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyAddr}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>��� ��û����</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyRequest}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>��� �����</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyDate}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>�ֹ� ����</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-md-12 text-center ">
							<button type="button" class="btn btn-primary" href="#">����</button>
							<a class="btn btn-primary" href="#" role="button">����</a>
						</div>
					</div>

					<br>
					<br>
				</div>
				<!--  ȭ�鱸�� div end /////////////////////////////////////-->
			</body>

			</html>