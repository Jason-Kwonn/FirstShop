<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>상품수정</title>
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

				<script type="text/javascript" src="../javascript/calendar.js">
				</script>

				<!-- ////////////////////////////// JavaSript ////////////////////////////// -->
				<script type="text/javascript">
					//============= "수정"  Event 연결 =============
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
						$("button.btn.btn-primary:contains('수정')").on("click", function () {
							//Debug..
							alert($("button.btn.btn-primary:contains('수정')").html());
							fncUpdateProduct();
						});
					});

					//============= "취소"  Event 처리 및  연결 =============
					$(function () {
						//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
						$("a[href='#' ]:contains('취소')").on("click", function () {
							//Debug..
							//alert(  $( "a[href='#' ]:contains('취소')" ).html() );
							history.go(-1);
						});
					});


					function fncUpdateProduct() {
						//Form 유효성 검증
						//var name = document.detailForm.prodName.value;
						//var detail = document.detailForm.prodDetail.value;
						//var manuDate = document.detailForm.manuDate.value;
						//var price = document.detailForm.price.value;

						var name = $("input[name='prodName']").val();
						var detail = $("input[name='prodDetail']").val();
						var manuDate = $("input[name='manuDate']").val();
						var price = $("input[name='price']").val();

						if (name == null || name.length < 1) {
							alert("상품명은 반드시 입력하여야 합니다.");
							return;
						}
						if (detail == null || detail.length < 1) {
							alert("상품상세정보는 반드시 입력하여야 합니다.");
							return;
						}
						if (manuDate == null || manuDate.length < 1) {
							alert("제조일자는 반드시 입력하셔야 합니다.");
							return;
						}
						if (price == null || price.length < 1) {
							alert("가격은 반드시 입력하셔야 합니다.");
							return;
						}

						//document.detailForm.action='/product/updateProduct';
						//document.detailForm.submit();
						$("form").attr("method", "POST").attr("enctype", "multipart/form-data").attr("action", "/product/updateProduct").submit();
					}


					// $(function(){
					// 	////////////추가 부분 ////////////
					// 	// no-cache class 에 src 뒤에 랜덤한 수를 두어 캐싱을 방지한다.
					// 	$('.no-cache').attr('src',function () { return $(this).attr('src') + "?a=" + Math.random() });
					// 	alert(attr('src'));
					// });

				</script>
			</head>

			<body>
				<!-- ToolBar Start /////////////////////////////////////-->
				<jsp:include page="/layout/toolbar.jsp" />
				<!-- ToolBar End /////////////////////////////////////-->
				<!-- ToolBar Start /////////////////////////////////////-->
				<!-- <div class="navbar  navbar-default">
					<div class="container">
						<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
					</div>
				</div> -->
				<!-- ToolBar End /////////////////////////////////////-->

				<!-- contents start -->
				<div class="container">
					<h1 class="bg-primary text-center">상품수정</h1>

					<!-- form start -->
					<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">

						<div class="form-group">
							<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="prodName" name="prodName"
									value="${product.prodName}" placeholder="상품명">
							</div>
						</div>

						<div class="form-group">
							<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상세정보</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="prodDetail" name="prodDetail"
									value="${product.prodDetail}" placeholder="상세정보">
							</div>
						</div>

						<div class="form-group">
							<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="manuDate" name="manuDate"
									value="${product.manuDate}" placeholder="제조일자">
							</div>
							<div>
								&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
									onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
							</div>
						</div>

						<div class="form-group">
							<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="price" name="price" value="${product.price}"
									placeholder="가격">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
							<div class="col-sm-4">
								<input type="file" class="form-control" id="files" name="files">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
							<div class="col-sm-12">
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