<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<link rel="stylesheet" href="/css/admin.css" type="text/css">

				<title>구매정보 수정</title>

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
					} //==> 추가된부분 : "수정" Event 연결
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
						$("button.btn.btn-primary:contains('수정')").on("click", function () {
							//Debug..
							alert($("button.btn.btn-primary:contains('수정')").html());
							fncUpdatePurchase();
						});
					});

					//==> 추가된부분 : "취소" Event 연결 및 처리
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
						$("a[href='#' ]:contains('취소')").on("click", function () {
							//Debug..
							//alert( $( "td.ct_btn01:contains('취소')" ).html() );
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
					<h1 class="bg-primary text-center">구매 정보 수정</h1>

					<!-- form start -->
					<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">


						<input type="hidden" name="tranNo" value="${purchase.tranNo}" />

						<div class="form-group">
							<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
							<div class="col-sm-4">
								<input type="text" readonly="readonly" class="form-control" id="prodName"
									name="prodName" value="${product.prodName}">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
							<div class="col-sm-12">
								<c:choose>
									<c:when test="${ ! empty product.fileNames}">
										<c:forEach var="image" items="${product.fileNames}">
											<img src="../images/uploadFiles/${image}" />
										</c:forEach>
									</c:when>
									<c:otherwise>
										<!-- 공백을 표시하거나 아무 것도 하지 않음 -->
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="form-group">
							<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
							<div class="col-sm-4">
								<input type="text" readonly="readonly" class="form-control" id="price" name="price"
									value="${product.price}" placeholder="가격">
							</div>
						</div>

						<div class="form-group">
							<label for="purchaseQty" class="col-sm-offset-1 col-sm-3 control-label">수량</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="purchaseQty" name="purchaseQty"
									value="${purchase.purchaseQty}" placeholder="구매 수량">
							</div>
						</div>

						<div class="form-group">
							<label for="finalPrice" class="col-sm-offset-1 col-sm-3 control-label">최종 구매가</label>
							<div class="col-sm-4">
								${=product.price * purchase.purchaseQty}
							</div>
						</div>

						<div class="form-group">
							<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
							<div class="col-sm-4">
								<select name="paymentOption">
									<option value="1" selected="selected">현금구매</option>
									<option value="2">신용구매</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">받는 분 성함</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverName" name="receiverName"
									value="${purchase.receiverName}">
							</div>
						</div>

						<div class="form-group">
							<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">받는 분 연락처</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverPhone" name="receiverPhone"
									value="${purchase.receiverPhone}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyAddr" class="col-sm-offset-1 col-sm-3 control-label">받는 분 주소</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyAddr" name="dlvyAddr"
									value="${purchase.dlvyAddr}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송 요청사항</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest"
									value="${purchase.dlvyRequest}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyDate" class="col-sm-offset-1 col-sm-3 control-label">배송 희망일</label>
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
								<button type="button" class="btn btn-primary">수정</button>
								<a class="btn btn-primary btn" href="#" role="button">취소</a>
							</div>
						</div>
					</form>
					<!-- form end -->
				</div>
				<!-- contents end -->
			</body>

			</html>