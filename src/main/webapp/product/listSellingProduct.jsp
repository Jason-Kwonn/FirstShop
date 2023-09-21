<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>
					판매 상품 관리
				</title>
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

					function fncGetProductList(currentPage) {
						//document.getElementById("currentPage").value = currentPage;
						$("#currentPage").val(currentPage)
						//document.detailForm.submit();
						$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
					}

					//==> 추가된부분 : "검색" ,  prodNo link  Event 연결 및 처리
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용도 가능. 
						$("button:contains('검색')").on("click", function () {
							//Debug..
							// alert($("button:contains('검색')").html());
							fncGetProductList(1);
						});
					});
					$(document).on("keydown", function (e) {
						if (e.keyCode === 13) { // Enter key
							fncGetProductList(1);
						}
					});

					// 상품정보 확인 (img, 상품명 click)
					$(function () {
						$(document).on("click", "td[title='Click : 상품정보 확인'], td:nth-child(3)", function () {

							console.log("TD clicked");  // 이 로그가 출력되는지 확인
							var prodNo = $(this).siblings().find("input[type='hidden']").val();
							console.log("Prod No: ", prodNo);  // prodNo 값이 올바른지 확인
							self.location = "/product/updateProduct?prodNo=" + prodNo;

						});
					});



					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						$(document).on("click", "td:nth-child(5) > i", function () {

							var prodNo = $(this).next().val();
							console.log("Prod No: ", prodNo);

							$.ajax(
								{
									url: "/product/json/getProduct/" + prodNo,
									method: "GET",
									dataType: "json",
									headers: {
										"Accept": "application/json",
										"Content-Type": "application/json"
									},
									success: function (JSONData, status) {

										console.log("AJAX Success: ", JSONData);

										var displayValue = "<h6>"
											+ "상품번호 : " + JSONData.prodNo + "<br/>"
											+ "상품명 : " + JSONData.prodName + "<br/>"
											+ "상품상세 : " + JSONData.prodDetail + "<br/>"
											+ "재고수량 : " + JSONData.productQty + "<br/>"
											+ "제조일자 : " + JSONData.manuDate + "<br/>"
											+ "</h6>";
										$("h6").remove();
										$("#" + prodNo + "").html(displayValue);
									},
									error: function (xhr, status, error) {
										console.log("AJAX Error: ", error);
									}
								});
							////////////////////////////////////////////////////////////////////////////////////////////


						});

					});



					// 무한 스크롤을 위한 로직 구현
					// 초기값 설정
					var isLoading = false; // 데이터가 로딩 중인지 확인.

					//무한 스크롤 로직
					$(window).scroll(function () {
						if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
							if (!isLoading) {
								isLoading = true;
								currentPage++; // 페이지 번호 증가
								fncGetProductScroll(currentPage); // 새로운 데이터 로드
							}
						}
					});

					// 무한 스크롤 로직
					function fncGetProductScroll(currentPage) {
						var currentPage = parseInt($("#currentPage").val());
						isLoading = true; // 로딩 시작
						// AJAX 호출 로직 추가
						$.ajax({
							url: "/product/json/listProduct",
							method: "POST",
							data: JSON.stringify({
								currentPage: currentPage + 1,
								pageSize: 5,
								searchCondition: $("select[name='searchCondition']").val(),
								searchKeyword: $("input[name='searchKryword']").val()

							}),
							dataType: "json",
							headers: {
								"Accept": "application/json",
								"Content-Type": "application/json"
							},

							success: function (JSONData, status) {
								// 데이터 추가 로직
								var iValue = $("#listProduct.tr.td.i").value();
								var listProductValue =
									"<tr>"
									+ "<td align='center'>" + iValue + "</td>"
									+ "<td align='left' title='Click : 상품정보 확인'>" + JSONData.fileNames + "</td>"
									+ "<td align='left'>" + JSONData.prodName + "</td>"
									+ "<td align='left'>" + JSONData.stock + "</td>"
									+ "<td align='center'>"
									+ "<i class='glyphicon glyphicon-ok' id='" + JSONData.prodNo + "'></i>"
									+ "<input type='hidden' value='" + JSONData.prodNo + "'>"
									+ "</td>"
									+ "</tr>"

								isLoading = false; // 로딩 완료
							}
						});
					}
				</script>
			</head>

			<body>
				<!-- ToolBar Start ///////////////////////////////////// -->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!--  화면구성 div Start /////////////////////////////////////-->
				<div class="container">

					<div class="page-header text-info">
						<h3>
							판매 상품 관리
						</h3>
					</div>

					<!-- table 위쪽 검색 Start /////////////////////////////////////-->
					<div class="row">

						<div class="col-md-6 text-left">
							<p class="text-primary">
								전체 상품 ${resultPage.totalCount } 건
							</p>
						</div>

						<div class="col-md-6 text-right">
							<form class="form-inline" name="detailForm">

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
								<th align="center">가격</th>
								<th align="center">상품수량</th>
								<th align="center">간략정보</th>
							</tr>
						</thead>

						<tbody id="listProduct">

							<c:set var="i" value="0" />
							<c:forEach var="product" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr>
									<td align="center">${ i }</td>
									<td align="left" title="Click : 상품정보 확인">
										<img src="/images/uploadFiles/${product.fileName}"
											class="img-thumbnail thumbnail" />
									</td>
									<td align="left">${product.prodName}</td>
									<td align="left">${product.price}</td>
									<td align="left" class="productQty">${product.productQty}</td>
									<td align="left">
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