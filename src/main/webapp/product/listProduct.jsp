<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>
		<c:if test="${param.menu eq 'manage' }">
			��ǰ ����
		</c:if>
		<c:if test="${param.menu eq 'search' }">
			��ǰ �˻�
		</c:if>
	</title>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		var menu;
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
		// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
		function fncGetProductList(currentPage, menu) {
			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
		   	//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
		}
		//===========================================//
		//==> �߰��Ⱥκ� : "�˻�" ,  prodNo link  Event ���� �� ó��
		 $(function() {
			 
			// ���� �������� URL�� �����ɴϴ�.
			var url = window.location.search;
			
			// URL�� �Ľ��Ͽ� URLSearchParams ��ü�� �����մϴ�.
			var urlSearchParams = new URLSearchParams(url);
			
			// menu �Ķ���͸� �����ɴϴ�.
			menu = urlSearchParams.get("menu");
			//alert(menu);
			 
			//==> �˻� Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
			 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
				//Debug..
				alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
				fncGetProductList(1);
			});
			
			
			$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
					//Debug..
					alert(  $( this ).text().trim() );
					alert(menu);
					if(menu === "search"){
						self.location ="/product/getProduct?prodNo="+$(this).text().trim();
					} else {
						self.location ="/product/updateProduct?prodNo="+$(this).text().trim();
					}
					
			});
			
			//==> UI ���� �߰��κ�  :  prodNo LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			
			//==> �Ʒ��� ���� ������ ������ ??
			//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� ��������.					
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
			//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
			//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
			//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
			//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
			//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
			//console.log ( $(".ct_list_pop:nth-child(7)" ).html() );
		});
	</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
	
	<div style="width:98%; margin-left:10px;">
	
	<!-- 
	<form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">
	 -->
	<form name="detailForm" action="/product/listProduct?menu="${param.menu}>
	<input type="hidden" name="menu" value="${param.menu}"/>
	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">
						
							<c:if test="${param.menu eq 'manage' }">
								��ǰ ����
							</c:if>
							<c:if test="${param.menu eq 'search' }">
								��ǰ �˻�
							</c:if>
						
						</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0" ${!empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>��ǰ��ȣ</option>
					<option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>��ǰ��</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>��ǰ����</option>
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
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- 
							<a href="javascript:fncGetProductList('1');">�˻�</a>
							 -->
							�˻�
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
			<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
		</tr>
		<tr>
			<td class="ct_list_b" width="100">No</td>
			<td class="ct_line02"></td>
			<!-- 
			<td class="ct_list_b" width="150">��ǰ��</td>
			 -->
			<td class="ct_list_b" width="150">
				��ǰ��<br>
				<h7>(name click:������)</h7>
			</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">����</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">�����</td>	
			<td class="ct_line02"></td>
			<td class="ct_list_b">�������</td>	
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
					<c:when test="${param.menu eq 'manage' && product.proTranCode eq '���ſϷ�'}">
						${product.proTranCode}
						<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
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
		<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
		<jsp:include page="../common/pageNavigator.jsp">
			<jsp:param name="type" value="Product"/>
		</jsp:include>
    	</td>
	</tr>
</table>

	<!--  ������ Navigator �� -->
	
	</form>
	
	</div>
	</body>
</html>
