<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<link rel="stylesheet" href="/css/admin.css" type="text/css">

				<title>�������� ����</title>

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
				</style>

				<script type="text/javascript" src="../javascript/calendar.js">
				</script>

				<script type="text/javascript">

					<!-- ////////////////////////////// JavaSript ////////////////////////////// -->
					function fncUpdatePurchase() {
						$("form").attr("method", "POST").attr("enctype", "multipart/form-data").attr("action", "/purchase/updatePurchase").submit();
					} //==> �߰��Ⱥκ� : "����" Event ����
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.
						$("button.btn.btn-primary:contains('����')").on("click", function () {
							//Debug..
							alert($("button.btn.btn-primary:contains('����')").html());
							fncUpdatePurchase();
						});
					});

					//==> �߰��Ⱥκ� : "���" Event ���� �� ó��
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.
						$("a[href='#' ]:contains('���')").on("click", function () {
							//Debug..
							//alert( $( "td.ct_btn01:contains('���')" ).html() );
							history.go(-1);
						});
					});

				</script>

			</head>

			<body>
				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!-- contents start -->
				<div class="container">
					<h1 class="bg-primary text-center">���� ���� ����</h1>

					<!-- form start -->
					<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">


						<input type="hidden" name="tranNo" value="${purchase.tranNo}" />

						<div class="form-group">
							<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
							<div class="col-sm-4">
								<input type="text" readonly="readonly" class="form-control" id="prodName"
									name="prodName" value="${product.prodName}">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
							<div class="col-sm-12">
								<c:choose>
									<c:when test="${ ! empty product.fileNames}">
										<c:forEach var="image" items="${product.fileNames}">
											<img src="../images/uploadFiles/${image}" />
										</c:forEach>
									</c:when>
									<c:otherwise>
										<!-- ������ ǥ���ϰų� �ƹ� �͵� ���� ���� -->
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="form-group">
							<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
							<div class="col-sm-4">
								<input type="text" readonly="readonly" class="form-control" id="price" name="price"
									value="${product.price}" placeholder="����">
							</div>
						</div>

						<div class="form-group">
							<label for="purchaseQty" class="col-sm-offset-1 col-sm-3 control-label">����</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="purchaseQty" name="purchaseQty"
									value="${purchase.purchaseQty}" placeholder="���� ����">
							</div>
						</div>

						<div class="form-group">
							<label for="finalPrice" class="col-sm-offset-1 col-sm-3 control-label">���� ���Ű�</label>
							<div class="col-sm-4">
								${=product.price * purchase.purchaseQty}
							</div>
						</div>

						<div class="form-group">
							<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
							<div class="col-sm-4">
								<select name="paymentOption">
									<option value="1" selected="selected">���ݱ���</option>
									<option value="2">�ſ뱸��</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�޴� �� ����</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverName" name="receiverName"
									value="${purchase.receiverName}">
							</div>
						</div>

						<div class="form-group">
							<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�޴� �� ����ó</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverPhone" name="receiverPhone"
									value="${purchase.receiverPhone}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyAddr" class="col-sm-offset-1 col-sm-3 control-label">�޴� �� �ּ�</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyAddr" name="dlvyAddr"
									value="${purchase.dlvyAddr}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">��� ��û����</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest"
									value="${purchase.dlvyRequest}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyDate" class="col-sm-offset-1 col-sm-3 control-label">��� �����</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyDate" name="dlvyDate"
									value="${purchase.dlvyDate}">
							</div>
							<div>
								&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
									onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-4  col-sm-4 text-center">
								<button type="button" class="btn btn-primary">����</button>
								<a class="btn btn-primary btn" href="#" role="button">���</a>
							</div>
						</div>
					</form>
					<!-- form end -->
				</div>
				<!-- contents end -->
			</body>

			</html>