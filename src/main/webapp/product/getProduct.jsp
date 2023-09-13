<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>

			<html>

			<head>
				<meta charset="EUC-KR">

				<title>상품상세조회</title>

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
					body>div.container {
						border: 3px solid #D6CDB7;
						margin-top: 10px;
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
							alert($("a:contains('이전')").html());
							history.go(-1);
						});

						$("button.btn btn-primary:contains('구매')").on("click", function () {
							//Debug..
							alert($("button.btn btn-primary:contains('구매')").html());
							self.location = "/purchase/addPurchase?prodNo=${product.prodNo}"
						});
					});

					// $(function () {
					// 	////////////추가 부분 ////////////
					// 	// no-cache class 에 src 뒤에 랜덤한 수를 두어 캐싱을 방지한다.
					// 	$('.no-cache').attr('src', function () { return $(this).attr('src') + "?a=" + Math.random() });
					// });

				</script>

			</head>

			<body>

				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!--  화면구성 div Start /////////////////////////////////////-->
				<div class="container">

					<div class="page-header">
						<h3 class=" text-info">상품조회</h3>
						<h5 class="text-muted">상세 정보는 <strong class="text-danger">다음과 같습니다.</strong></h5>
					</div>

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodNo}</div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodName}</div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>상품 상세정보</strong></div>
						<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
						<div class="col-xs-8 col-md-4">${product.manuDate} </div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
						<div class="col-xs-8 col-md-4">${product.price}</div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
						<div class="col-xs-8 col-md-4">${product.regDate}</div>
					</div>

					<hr />

					<div class="row">
						<div class="col-xs-4 col-md-2 "><strong>상품 이미지</strong></div>
						<div class="col-xs-8 col-md-4">
							<c:choose>
								<c:when test="${ ! empty product.fileNames}">
									<c:forEach var="image" items="${product.fileNames}">
										<img class="no-cache" src="../images/uploadFiles/${image}" />
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
						<div class="col-md-12 text-center ">
							<button type="button" class="btn btn-primary">구매</button>
							<a class="btn btn-primary" href="#" role="button">이전</a>
						</div>
					</div>

					<br />

				</div>
				<!--  화면구성 div end /////////////////////////////////////-->

			</body>

			</html>