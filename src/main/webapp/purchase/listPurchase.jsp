<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>구매 목록조회</title>

				<!-- 참조 : http://getbootstrap.com/css/   참조 -->
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />

				<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
				<link rel="stylesheet"
					href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
				<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


				<!-- Bootstrap Dropdown Hover CSS -->
				<link href="/css/animate.min.css" rel="stylesheet">
				<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
				<!-- Bootstrap Dropdown Hover JS -->
				<script src="/javascript/bootstrap-dropdownhover.min.js"></script>


				<!-- jQuery UI toolTip 사용 CSS-->
				<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
				<!-- jQuery UI toolTip 사용 JS-->
				<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

				<!--  ///////////////////////// CSS ////////////////////////// -->
				<style>
					body {
						padding-top: 50px;
					}

					.thumbnail {
						width: 100px;
						height: 100px;
						object-fit: cover;
						/* 이미지 비율을 유지하면서 채우기 */
					}
				</style>

				<!--  ///////////////////////// JavaScript ////////////////////////// -->
				<script type="text/javascript">

					//=====기존Code 주석 처리 후  jQuery 변경 ======//
					// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
					function fncGetProductList(currentPage) {
						//document.getElementById("currentPage").value = currentPage;
						$("#currentPage").val(currentPage)
						//document.detailForm.submit();
						$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
					}
					//===========================================//
					//==> 추가된부분 : "검색" ,   link  Event 연결 및 처리
					$(function () {

						//==> 검색 Event 연결처리부분
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
						$("button:contains('검색')").on("click", function () {
							//Debug..
							alert($("button:contains('검색')").html());
							fncGetPurchaseList(1);
						});
						$(document).on("keydown", function (e) {
							if (e.keyCode === 13) { // Enter key
								fncGetProductList(1);
							}
						});

						// 구매정보 수정 (img, 상품명 click)
						$(function () {
							$(document).on("click", "td[title='Click : 구매정보 수정'], td:nth-child(3)", function () {
								self.location = "/purchase/updatePurchase?tranNo=" + tranNo;
							});
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

					<div class="page-header text-info">
						<h3>
							구매 정보
						</h3>
					</div>

					<!-- table 위쪽 검색 Start /////////////////////////////////////-->
					<div class="row">

						<div class="col-md-6 text-left">
							<p class="text-primary">
								전체 구매 ${resultPage.totalCount } 건
							</p>
						</div>

						<div class="col-md-6 text-right">
							<form class="form-inline" name="detailForm">
								<!--
								<div class="form-group">
									<select class="form-control" name="searchCondition">
										<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0
											? "selected" : "" }>상품명</option>
										<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1
											? "selected" : "" }>가격 조회(입력한 가격 이하)</option>
										<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2
											? "selected" : "" }>가격 조회(입력한 가격 이상)</option>
									</select>
								</div>

								<div class="form-group">
									<label class="sr-only" for="searchKeyword">검색어</label>
									<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
										placeholder="검색어"
										value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
								</div>

								<button type="button" class="btn btn-default">검색</button>
-->
								<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
								<input type="hidden" id="currentPage" name="currentPage" value="" />

							</form>
						</div>

					</div>
					<!-- table 위쪽 검색 End /////////////////////////////////////-->


					<!--  table Start /////////////////////////////////////-->
					<table class="table table-hover table-striped">

						<thead>
							<tr>
								<th align="center">No</th>
								<th align="center">이미지</th>
								<th align="center">상품명</th>
								<th align="center">구매수량</th>
								<th align="center">배송정보</th>
								<th align="center">구매취소</th>
							</tr>
						</thead>

						<tbody id="listPurchase">

							<c:set var="i" value="0" />
							<c:forEach var="purchase" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr>
									<td align="center">${ i }</td>
									<td align="left" title="Click : 구매정보 수정">
										<img src="/images/uploadFiles/${product.fileName}"
											class="img-thumbnail thumbnail" />
									</td>
									<td align="left">${product.prodName}</td>
									<td align="left">${purchase.purchaseQty}</td>
									<td align="left" class="tranCode">${purchase.tranCode}</td>
									<td align="left">
										<!-- 해당 버튼 누르면 취소하겠습니까? 확인 시 쿼리 보내면서 취소분 만큼 수량 재고로 입고됨.. -->
										<i class="glyphicon glyphicon-ok" id="${product.prodNo}"></i>
										<input type="hidden" value="${product.prodNo}">
									</td>
								</tr>
							</c:forEach>

						</tbody>

					</table>
					<!--  table End /////////////////////////////////////-->

				</div>
				<!--  화면구성 div End /////////////////////////////////////-->


				<!-- 무한 스크롤 구현을 위한 주석 처리 -->
				<!-- PageNavigation Start... -->
				<%-- <jsp:include page="../common/pageNavigator_new.jsp" /> --%>
				<!-- PageNavigation End... -->

			</body>

			</html>