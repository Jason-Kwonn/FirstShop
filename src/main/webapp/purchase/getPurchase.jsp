<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">

				<title>구매 정보조회</title>

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

					.thumbnail {
						width: 100px;
						height: 100px;
						object-fit: cover;
						/* 이미지 비율을 유지하면서 채우기 */
					}
				</style>

				<!-- ////////////////////////////// JavaSript ////////////////////////////// -->
				<script type="text/javascript">

					//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
						$("a:contains('이전')").on("click", function () {
							//Debug..
							//alert($("a:contains('이전')").html());
							history.go(-1);
						});

						$("button.btn.btn-primary:contains('수정')").on("click", function () {
							//Debug..
							//alert($("button.btn.btn-primary:contains('구매')").html());
							self.location = "/purchase/updatePurchase?prodNo=${product.prodNo}"
						});
					});

				</script>

			</head>

			<body>

				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!--  화면구성 div Start /////////////////////////////////////-->
				<div class="container">

					<div class="page-header">
						<h3 class="text-info">구매 정보조회</h3>
						<h5 class="text-muted">상세 정보는 <strong class="text-danger">다음과 같습니다.</strong></h5>
					</div>

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>구매 아이디</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>상품 이미지</strong></div>
						<div class="col-xs-8 col-md-4">
							<c:choose>
								<c:when test="${ ! empty product.fileNames}">
									<c:forEach var="image" items="${product.fileNames}">
										<img src="/images/uploadFiles/${image}" class="img-thumbnail thumbnail" />
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 공백을 표시하거나 아무 것도 하지 않음 -->
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
						<div class="col-xs-8 col-md-4">${product.price}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>구매 수량</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.purchaseQty} </div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>최종 구매가</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.price}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>구매 방법</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.paymentOption}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>받는 분 이름</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>받는 분 연락처</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>배송지 주소</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyAddr}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>배송 요청사항</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyRequest}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>배송 희망일</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.dlvyDate}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>주문 일자</strong></div>
						<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
					</div>
					<hr />

					<div class="row">
						<div class="col-md-12 text-center ">
							<button type="button" class="btn btn-primary" href="#">수정</button>
							<a class="btn btn-primary" href="#" role="button">이전</a>
						</div>
					</div>

					<br>
					<br>
				</div>
				<!--  화면구성 div end /////////////////////////////////////-->
			</body>

			</html>