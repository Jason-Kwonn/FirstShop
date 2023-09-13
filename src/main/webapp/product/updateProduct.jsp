<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>��ǰ����</title>
				<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
					//============= "����"  Event ���� =============
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
						$("button.btn.btn-primary:contains('����')").on("click", function () {
							//Debug..
							alert($("button.btn.btn-primary:contains('����')").html());
							fncUpdateProduct();
						});
					});

					//============= "���"  Event ó�� ��  ���� =============
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
						$("a[href='#' ]:contains('���')").on("click", function () {
							//Debug..
							//alert(  $( "a[href='#' ]:contains('���')" ).html() );
							history.go(-1);
						});
					});


					function fncUpdateProduct() {
						//Form ��ȿ�� ����
						//var name = document.detailForm.prodName.value;
						//var detail = document.detailForm.prodDetail.value;
						//var manuDate = document.detailForm.manuDate.value;
						//var price = document.detailForm.price.value;

						var name = $("input[name='prodName']").val();
						var detail = $("input[name='prodDetail']").val();
						var manuDate = $("input[name='manuDate']").val();
						var price = $("input[name='price']").val();

						if (name == null || name.length < 1) {
							alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
							return;
						}
						if (detail == null || detail.length < 1) {
							alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
							return;
						}
						if (manuDate == null || manuDate.length < 1) {
							alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
							return;
						}
						if (price == null || price.length < 1) {
							alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
							return;
						}

						//document.detailForm.action='/product/updateProduct';
						//document.detailForm.submit();
						$("form").attr("method", "POST").attr("enctype", "multipart/form-data").attr("action", "/product/updateProduct").submit();
					}


					// $(function(){
					// 	////////////�߰� �κ� ////////////
					// 	// no-cache class �� src �ڿ� ������ ���� �ξ� ĳ���� �����Ѵ�.
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
					<h1 class="bg-primary text-center">��ǰ����</h1>

					<!-- form start -->
					<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">

						<div class="form-group">
							<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="prodName" name="prodName"
									value="${product.prodName}" placeholder="��ǰ��">
							</div>
						</div>

						<div class="form-group">
							<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">������</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="prodDetail" name="prodDetail"
									value="${product.prodDetail}" placeholder="������">
							</div>
						</div>

						<div class="form-group">
							<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="manuDate" name="manuDate"
									value="${product.manuDate}" placeholder="��������">
							</div>
							<div>
								&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
									onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
							</div>
						</div>

						<div class="form-group">
							<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="price" name="price" value="${product.price}"
									placeholder="����">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
							<div class="col-sm-4">
								<input type="file" class="form-control" id="files" name="files">
							</div>
						</div>

						<div class="form-group">
							<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
							<div class="col-sm-12">
								<c:choose>
									<c:when test="${ ! empty product.fileNames}">
										<c:forEach var="image" items="${product.fileNames}">
											<img class="no-cache" src="../images/uploadFiles/${image}" />
										</c:forEach>
									</c:when>
									<c:otherwise>
										<!-- ������ ǥ���ϰų� �ƹ� �͵� ���� ���� -->
									</c:otherwise>
								</c:choose>
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