<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">

				<link rel="stylesheet" href="/css/admin.css" type="text/css">

				<title>상품 구매</title>

				<script type="text/javascript" src="../javascript/calendar.js">
				</script>
				<!-- CDN(Content Delivery Network) 호스트 사용 -->
				<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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

				<!-- ////////////////////////////// JavaSript ////////////////////////////// -->
				<script type="text/javascript">

					$(function () {
						// DOM Object GET 3가지 방법: 1. $(tagName), 2. #id, 3. .className
						// 1과 3 방법을 조합하여 $("tagName.className:filter함수")를 사용함.
						$("a[href='#']:contains('구매')").on("click", function () {
							// Debug
							// alert($("td.ct_btn01:contains('구매')").html());
							fncAddPurchase();
						});
					});

					/* ================== jQuery 변경 주석처리 ================
					function resetData(){
						document.detailForm.reset();
					} ===================================================== */
					$(function () {

						$("a[href='#' ]:contains('취소')").on("click", function () {
							//alert($("a[href='#' ].contains('취소')").html());
							$("form")[0].reset();
						});
					});

					function fncAddPurchase() {
						//Form 유효성 검증
						// var name = $("input[name='prodName']").val();
						// var detail = $("input[name='prodDetail']").val();
						// var manuDate = $("input[name='manuDate']").val();
						// var price = $("input[name='price']").val();
						// // var files = $("input[name='files']").val();

						// if (name == null || name.length < 1) {
						// 	alert("상품명은 반드시 입력하여야 합니다.");
						// 	return;
						// }
						// if (detail == null || detail.length < 1) {
						// 	alert("상품상세정보는 반드시 입력하여야 합니다.");
						// 	return;
						// }
						// if (manuDate == null || manuDate.length < 1) {
						// 	alert("제조일자는 반드시 입력하셔야 합니다.");
						// 	return;
						// }
						// if (price == null || price.length < 1) {
						// 	alert("가격은 반드시 입력하셔야 합니다.");
						// 	return;
						// }

						//document.purchase.submit();
						$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
					}

				</script>
			</head>

			<body>
				<!-- ToolBar Start ///////////////////////////////////// -->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->
				<!-- contents start -->
				<div class="container">
					<h1 class="bg-primary text-center">상품구매</h1>

					<!-- form start -->
					<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">

						<div class="form-group">
							<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.prodNo}
								<input type="hidden" class="form-control" id="prodNo" name="prodNo"
									value="${purchase.purchaseProd.prodNo}">
							</div>
						</div>
						<div class="form-group">
							<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.prodName}
								<input type="hidden" class="form-control" id="prodName" name="prodName"
									value="${purchase.purchaseProd.prodName}">
							</div>
						</div>

						<div class="form-group">
							<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상세정보</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.prodDetail}
								<input type="hidden" class="form-control" id="prodDetail" name="prodDetail"
									value="${purchase.purchaseProd.prodDetail}">
							</div>
						</div>

						<div class="form-group">
							<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.manuDate}
								<input type="hidden" class="form-control" id="manuDate" name="manuDate"
									value="${purchase.purchaseProd.manuDate}">
							</div>
						</div>

						<div class="form-group">
							<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.price}
								<input type="hidden" class="form-control" id="price" name="price"
									value="${purchase.purchaseProd.price}">
							</div>
						</div>

						<div class="form-group">
							<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
							<div class="col-sm-4">
								${purchase.purchaseProd.regDate}
								<input type="hidden" class="form-control" id="regDate" name="regDate"
									value="${purchase.purchaseProd.regDate}">
							</div>
						</div>

						<div class="form-group">
							<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매 아이디</label>
							<div class="col-sm-4">
								${purchase.buyer.userId}
								<input type="hidden" class="form-control" id="userId" name="userId"
									value="${purchase.buyer.userId}">
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
							<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">받는 분 이름</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverName" name="receiverName"
									value="${purchase.buyer.userName}">
							</div>
						</div>

						<div class="form-group">
							<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">받는 분 연락처</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="receiverPhone" name="receiverPhone"
									value="${purchase.buyer.phone}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyAddr" class="col-sm-offset-1 col-sm-3 control-label">수령지 주소</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyAddr" name="dlvyAddr"
									value="${purchase.buyer.addr}">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송 시 요청 내용</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest"
									placeholder="요청 내용을 입력해 주세요.">
							</div>
						</div>

						<div class="form-group">
							<label for="dlvyDate" class="col-sm-offset-1 col-sm-3 control-label">배송 희망일</label>
							<div class="col-sm-4">
								<input type="text" readonly="readonly" class="form-control" id="dlvyDate"
									name="dlvyDate">
							</div>
							<div>
								<img src="../images/ct_icon_date.gif"
									onclick="show_calendar('document.purchase.dlvyDate', document.purchase.dlvyDate.value)" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-4  col-sm-4 text-center">
								<button type="button" class="btn btn-primary" href="#">구매</button>
								<a class="btn btn-primary btn" href="#" role="button">취소</a>
							</div>
						</div>

					</form>
					<!-- form end -->
				</div>
				<!-- contents end -->
			</body>

			</html>