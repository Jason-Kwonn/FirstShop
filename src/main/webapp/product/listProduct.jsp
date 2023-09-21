<%@ page contentType="text/html; charset=euc-kr" %>
	<%@ page pageEncoding="EUC-KR" %>

		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="EUC-KR">
				<title>
					��ǰ �˻�
				</title>
				<!-- ���� : http://getbootstrap.com/css/   ���� -->
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


				<!-- jQuery UI toolTip ��� CSS-->
				<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
				<!-- jQuery UI toolTip ��� JS-->
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
						/* �̹��� ������ �����ϸ鼭 ä��� */
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

					//==> �߰��Ⱥκ� : "�˻�" ,  prodNo link  Event ���� �� ó��
					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
						//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") ��뵵 ����. 
						$("button:contains('�˻�')").on("click", function () {
							//Debug..
							// alert($("button:contains('�˻�')").html());
							fncGetProductList(1);
						});
					});
					$(document).on("keydown", function (e) {
						if (e.keyCode === 13) { // Enter key
							fncGetProductList(1);
						}
					});

					// ��ǰ���� Ȯ�� (img, ��ǰ�� click)
					$(function () {
						$(document).on("click", "td[title='Click : ��ǰ���� Ȯ��'], td:nth-child(3)", function () {
							var stockStatus = $(this).siblings(".stock").text();
							if (stockStatus === "�Ǹ���") {
								console.log("TD clicked");  // �� �αװ� ��µǴ��� Ȯ��
								var prodNo = $(this).siblings().find("input[type='hidden']").val();
								console.log("Prod No: ", prodNo);  // prodNo ���� �ùٸ��� Ȯ��
								self.location = "/product/getProduct?prodNo=" + prodNo;
							}
						});
					});



					$(function () {
						//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
											+ "��ǰ��ȣ : " + JSONData.prodNo + "<br/>"
											+ "��ǰ�� : " + JSONData.prodName + "<br/>"
											+ "��ǰ�� : " + JSONData.prodDetail + "<br/>"
											+ "������ : " + JSONData.productQty + "<br/>"
											+ "�������� : " + JSONData.manuDate + "<br/>"
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
					    
						
					 	// �ʱ� ������ �ε�
					    loadData(currentPage);
						
						// ��ũ�� �̺�Ʈ �߰�
					    $(window).on('scroll', function() {
					        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
					            currentPage++; // ������ ����
					            loadData(currentPage); // ���ο� ������ �ε�
					        }
					    });
						
					 	/* // �˻� �����̳� �˻� Ű���尡 ����Ǹ�
					    $('select[name="searchCondition"], #searchKeyword').change(function() {
					        currentPage = 1; // �������� 1�� �ʱ�ȭ
					        $('#productList').empty(); // ���� ����Ʈ�� ���
					        loadData(currentPage); // ���ο� ������ �ε�
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
					                        $(window).off('scroll'); // ��ũ�� �̺�Ʈ ����
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

				<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
				<div class="container main">

					<div class="page-header text-info">
						<h3>
							��ǰ �˻�
						</h3>
					</div>

					<!-- table ���� �˻� Start /////////////////////////////////////-->
					<div class="row">

						<div class="col-md-6 text-left">
							<p class="text-primary">
								��ü ��ǰ ${resultPage.totalCount } ��
							</p>
						</div>

						<div class="col-md-6 text-right">
							<form class="form-inline" name="detailForm">

								<div class="form-group">
									<select class="form-control" name="searchCondition">
										<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0
											? "selected" : "" }>��ǰ��</option>
										<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1
											? "selected" : "" }>���� ��ȸ(�Է��� ���� ����)</option>
										<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2
											? "selected" : "" }>���� ��ȸ(�Է��� ���� �̻�)</option>
									</select>
								</div>

								<div class="form-group">
									<label class="sr-only" for="searchKeyword">�˻���</label>
									<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
										placeholder="�˻���"
										value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
								</div>

								<button type="button" class="btn btn-default">�˻�</button>

								<!-- PageNavigation ���� ������ ���� ������ �κ� -->
								<input type="hidden" id="currentPage" name="currentPage" value="" />

							</form>
						</div>

					</div>
					<!-- table ���� �˻� End /////////////////////////////////////-->
				</div>
				<!--  ȭ�鱸�� div End /////////////////////////////////////-->

					<!--  table Start /////////////////////////////////////-->
					<div class="container contents">
					<table class="table table-hover table-striped">

						<thead>
							<tr>
								<th align="center">No</th>
								<th align="center">�̹���</th>
								<th align="center">��ǰ��</th>
								<th align="center">����</th>
								<th align="center">�������</th>
								<th align="center">��������</th>
							</tr>
						</thead>
						<tbody id="productList">
						<%--
								<tr class="listProduct">
								
									<td align="center">${ i }</td>
									<td align="left" title="Click : ��ǰ���� Ȯ��">
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
									<td align="left" title="Click : ��ǰ���� Ȯ��">
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

				<!-- ���� ��ũ�� ������ ���� �ּ� ó�� -->
				<!-- PageNavigation Start... -->
				<%-- <jsp:include page="../common/pageNavigator_new.jsp" /> --%>
				<!-- PageNavigation End... -->

			</body>

			</html>