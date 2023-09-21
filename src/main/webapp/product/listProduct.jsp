<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>
					상품 검색
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
						width: 120px;
						height: 120px;
						object-fit: cover;
						/* 이미지 비율을 유지하면서 채우기 */
					}
					
					td {
					    vertical-align: middle;
					   	align: center;
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
							var stockStatus = $(this).siblings(".stock").text();
							if (stockStatus === "판매중") {
								console.log("TD clicked");  // 이 로그가 출력되는지 확인
								var prodNo = $(this).siblings().find("input[type='hidden']").val();
								console.log("Prod No: ", prodNo);  // prodNo 값이 올바른지 확인
								self.location = "/product/getProduct?prodNo=" + prodNo;
							}
						});
					});



					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						$(document).on("click", "td:nth-child(6) > i", function () {

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
					
					

					$(document).ready(function() {
					    let currentPage = 1;
					    let totalCount = 0;
					    let globalIndex = 0;
					    
						
					 	// 초기 데이터 로드
					    loadData(currentPage);
						
						// 스크롤 이벤트 추가
					    $(window).on('scroll', function() {
					        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
					            currentPage++; // 페이지 증가
					            loadData(currentPage); // 새로운 데이터 로드
					        }
					    });
						
					 	/* // 검색 조건이나 검색 키워드가 변경되면
					    $('select[name="searchCondition"], #searchKeyword').change(function() {
					        currentPage = 1; // 페이지를 1로 초기화
					        $('#productList').empty(); // 기존 리스트를 비움
					        loadData(currentPage); // 새로운 데이터 로드
					    }); */
					    
					    function loadData(page) {
					        $.ajax({
					            url: "/product/json/listProduct",
					            type: 'GET',
					            dataType: "json",
								headers: {
									"Accept": "application/json",
									"Content-Type": "application/json"
								},
					            data: {
					                currentPage: page,
					                searchCondition: $('select[name="searchCondition"]').val(),
					                searchKeyword: $('#searchKeyword').val()
					            },
					            success: function(JSONData) {
					                if (JSONData && JSONData.list) {
					                    let products = JSONData.list;
					                    totalCount = JSONData.totalCount;
					                    let currentCount = $("#productList tr").length;
					                   	console.log(products);

					                    if (currentCount >= totalCount) {
					                        $(window).off('scroll'); // 스크롤 이벤트 제거
					                        return;
					                    }

					                    products.forEach(function(product) {
					                    	
					                    	globalIndex++;
					                    	
					                        $('#productList').append(
					                            "<tr>"
					                                +"<td>" + globalIndex + "</td>"
					                                +"<td><img src='/images/uploadFiles/" + product.fileName + "' class='img-thumbnail thumbnail' /></td>"
					                                +"<td>" + product.prodName + "</td>"
					                                +"<td>" + product.price + "</td>"
					                                +"<td class='stock'>" + product.stock + "</td>"
					                                +"<td><i class='glyphicon glyphicon-ok' id='" + product.prodNo + "'></i><input type='hidden' value=" + product.prodNo + "></td>"
					                            +"</tr>"
					                        );
					                    });
					                } else {
					                    console.log("Invalid data received:", JSONData);
					                }
					            },
					            error: function(error) {
					                console.log("Error:", error);
					            }
					        });
					    }

					});


				</script>
			</head>

			<body>
				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->

				<!--  화면구성 div Start /////////////////////////////////////-->
				<div class="container main">

					<div class="page-header text-info">
						<h3>
							상품 검색
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
				</div>
				<!--  화면구성 div End /////////////////////////////////////-->

					<!--  table Start /////////////////////////////////////-->
					<div class="container contents">
					<table class="table table-hover table-striped">

						<thead>
							<tr>
								<th align="center">No</th>
								<th align="center">이미지</th>
								<th align="center">상품명</th>
								<th align="center">가격</th>
								<th align="center">재고유무</th>
								<th align="center">간략정보</th>
							</tr>
						</thead>
						<tbody id="productList">
						<%--
								<tr class="listProduct">
								
									<td align="center">${ i }</td>
									<td align="left" title="Click : 상품정보 확인">
										<img src="/images/uploadFiles/${product.fileName}"
											class="img-thumbnail thumbnail" />
									</td>
									<td align="left">${product.prodName}</td>
									<td align="left">${product.price}</td>
									<td align="left" class="stock">${product.stock}</td>
									<td align="left">
										<i class="glyphicon glyphicon-ok" id="${product.prodNo}"></i>
										<input type="hidden" value="${product.prodNo}">
									</td>
									
								</tr>
						 --%>
<%--
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
									<td align="left" class="stock">${product.stock}</td>
									<td align="left">
										<i class="glyphicon glyphicon-ok" id="${product.prodNo}"></i>
										<input type="hidden" value="${product.prodNo}">
									</td>
								</tr>
							</c:forEach>
 --%>
						</tbody>
					</table>
					<!--  table End /////////////////////////////////////-->
</div>

				<!-- 무한 스크롤 구현을 위한 주석 처리 -->
				<!-- PageNavigation Start... -->
				<%-- <jsp:include page="../common/pageNavigator_new.jsp" /> --%>
				<!-- PageNavigation End... -->

			</body>

			</html>