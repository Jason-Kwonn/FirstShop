<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>
					<c:if test="${param.menu eq 'manage' }">
						상품 관리
					</c:if>
					<c:if test="${param.menu eq 'search' }">
						상품 검색
					</c:if>
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
				</style>

				<!--  ///////////////////////// JavaScript ////////////////////////// -->
				<script type="text/javascript">

					var menu;
					//=====기존Code 주석 처리 후  jQuery 변경 ======//
					// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
					function fncGetProductList(currentPage, menu) {
						//document.getElementById("currentPage").value = currentPage;
						$("#currentPage").val(currentPage)
						//document.detailForm.submit();
						$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=" + menu).submit();
					}
					//===========================================//
					//==> 추가된부분 : "검색" ,  prodNo link  Event 연결 및 처리
					$(function () {

						// 현재 페이지 URL
						var url = window.location.search;

						// URL 파싱 URLSearchParams 객체 생성
						var urlSearchParams = new URLSearchParams(url);

						// get parameter menu 
						menu = urlSearchParams.get("menu");
						//alert(menu);

						//==> 검색 Event 연결처리부분
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
						$("button:contains('검색')").on("click", function () {
							//Debug..
							// alert($("button:contains('검색')").html());
							fncGetProductList(1);
						});

						$(document).on("keydown", function (e) {
							if (e.keyCode === 13) { // Enter key
								fncGetProductList(1);
							}
						});

						$("a:contains('files')").on("click", function () {
							//Debug..
							alert($(this).text().trim());
							alert(menu);
							// 수정할 부분
							////////////////////////////////////////////////////////////////////////////////
							if (menu === "search") {
								self.location = "/product/getProduct?prodNo=" + $(this).text().trim();
							} else {
								self.location = "/product/updateProduct?prodNo=" + $(this).text().trim();
							}
							////////////////////////////////////////////////////////////////////////////////
						});

						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						$("td:nth-child(5) > i").on("click", function () {

							var prodNo = $(this).next().val();

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

										var displayValue = "<h6>"
											+ "상품번호 : " + JSONData.prodNo + "<br/>"
											+ "상품명 : " + JSONData.prodName + "<br/>"
											+ "상품상세 : " + JSONData.prodDetail + "<br/>"
											+ "재고수량 : " + JSONData.productQty + "<br/>"
											+ "제조일자 : " + JSONData.manuDate + "<br/>"
											+ "</h6>";
										$("h6").remove();
										$("#" + prodNo + "").html(displayValue);
									}
								});
							////////////////////////////////////////////////////////////////////////////////////////////

							//==> UI 수정 추가부분  :  prodNo LINK Event End User 에게 보일수 있도록 
							$(".ct_list_pop td:nth-child(3)").css("color", "red");
							$("h7").css("color", "red");

							$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");//console.log ( $(".ct_list_pop:nth-child(7)" ).html() );
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
							<c:if test="${param.menu eq 'manage' }">
								상품 관리
							</c:if>
							<c:if test="${param.menu eq 'search' }">
								상품 검색
							</c:if>
						</h3>
					</div>

					<!-- table 위쪽 검색 Start /////////////////////////////////////-->
					<div class="row">

						<div class="col-md-6 text-left">
							<p class="text-primary">
								전체 ${resultPage.totalCount } 건수, 페이징 유닛 수 ${resultPage.pageUnit} EA
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
					<!-- table 위쪽 검색 Start /////////////////////////////////////-->


					<!--  table Start /////////////////////////////////////-->
					<table class="table table-hover table-striped">

						<thead>
							<tr>
								<th align="center">No</th>
								<th align="left">회원 ID</th>
								<th align="left">회원명</th>
								<th align="left">이메일</th>
								<th align="left">간략정보</th>
							</tr>
						</thead>

						<tbody>

							<c:set var="i" value="0" />
							<c:forEach var="user" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr>
									<td align="center">${ i }</td>
									<td align="left" title="Click : 회원정보 확인">${user.userId}</td>
									<td align="left">${user.userName}</td>
									<td align="left">${user.email}</td>
									<td align="left">
										<i class="glyphicon glyphicon-ok" id="${user.userId}"></i>
										<input type="hidden" value="${user.userId}">
									</td>
								</tr>
							</c:forEach>

						</tbody>

					</table>
					<!--  table End /////////////////////////////////////-->

				</div>
				<!--  화면구성 div End /////////////////////////////////////-->


				<!-- PageNavigation Start... -->
				<jsp:include page="../common/pageNavigator_new.jsp" />
				<!-- PageNavigation End... -->

			</body>


			<body bgcolor="#ffffff" text="#000000">

				<div style="width:98%; margin-left:10px;">

					<!-- 
	<form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">
	 -->
					<form name="detailForm" action="/product/listProduct?menu=" ${param.menu}>
						<input type="hidden" name="menu" value="${param.menu}" />
						<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="15" height="37">
									<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
								</td>
								<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="93%" class="ct_ttl01">

												<c:if test="${param.menu eq 'manage' }">
													상품 관리
												</c:if>
												<c:if test="${param.menu eq 'search' }">
													상품 검색
												</c:if>

											</td>
										</tr>
									</table>
								</td>
								<td width="12" height="37">
									<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
							<tr>
								<td align="right">
									<select name="searchCondition" class="ct_input_g" style="width:80px">
										<option value="0" ${!empty search.searchCondition && search.searchCondition==0
											? "selected" : "" }>상품번호</option>
										<option value="1" ${!empty search.searchCondition && search.searchCondition==1
											? "selected" : "" }>상품명</option>
										<option value="2" ${!empty search.searchCondition && search.searchCondition==2
											? "selected" : "" }>상품가격</option>
									</select>
									<input type="text" name="searchKeyword"
										value="${!empty search.searchKeyword ? search.searchKeyword : ''}"
										class="ct_input_g" style="width:200px; height:20px" />
								</td>
								<td align="right" width="70">
									<table border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="17" height="23">
												<img src="/images/ct_btnbg01.gif" width="17" height="23">
											</td>
											<td background="/images/ct_btnbg02.gif" class="ct_btn01"
												style="padding-top:3px;">
												<!-- 
							<a href="javascript:fncGetProductList('1');">검색</a>
							 -->
												검색
											</td>
											<td width="14" height="23">
												<img src="/images/ct_btnbg03.gif" width="14" height="23">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
							<tr>
								<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
							</tr>
							<tr>
								<td class="ct_list_b" width="100">No</td>
								<td class="ct_line02"></td>
								<!-- 
			<td class="ct_list_b" width="150">상품명</td>
			 -->
								<td class="ct_list_b" width="150">
									상품명<br>
									<h7>(name click:상세정보)</h7>
								</td>
								<td class="ct_line02"></td>
								<td class="ct_list_b" width="150">가격</td>
								<td class="ct_line02"></td>
								<td class="ct_list_b">등록일</td>
								<td class="ct_line02"></td>
								<td class="ct_list_b">현재상태</td>
							</tr>
							<tr>
								<td colspan="11" bgcolor="808285" height="1"></td>
							</tr>
							<c:set var="i" value="0" />
							<c:forEach var="product" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr class="ct_list_pop">
									<td align="center">${ i }</td>
									<td></td>
									<td align="left">
										<!--
				<c:set var="getUpdate" value="/product/getProduct"/>
				<c:if test="${param.menu eq 'manage' }">
					<c:set var="getUpdate" value="/product/updateProduct"/>
				</c:if>
				 
				<a href="${getUpdate}?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>
				 -->
										${product.prodNo}
									</td>
									<td></td>
									<td align="left">${product.price}</td>
									<td></td>
									<td align="left">${product.regDate}</td>
									<td></td>
									<td align="left">
										<c:choose>
											<c:when test="${param.menu eq 'manage' && product.proTranCode eq '구매완료'}">
												${product.proTranCode}
												<a
													href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">배송하기</a>
											</c:when>
											<c:otherwise>
												${product.proTranCode}
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<td colspan="11" bgcolor="D6D7D6" height="1"></td>
								</tr>
							</c:forEach>
						</table>

						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
							<tr>
								<td align="center">
									<input type="hidden" id="currentPage" name="currentPage"
										value="${resultPage.currentPage}" />
									<jsp:include page="../common/pageNavigator.jsp">
										<jsp:param name="type" value="Product" />
									</jsp:include>
								</td>
							</tr>
						</table>

						<!--  페이지 Navigator 끝 -->

					</form>

				</div>
			</body>

			</html>