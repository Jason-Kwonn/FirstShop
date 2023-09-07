<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

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
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		var menu;
		//=====기존Code 주석 처리 후  jQuery 변경 ======//
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetProductList(currentPage, menu) {
			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
		   	//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
		}
		//===========================================//
		//==> 추가된부분 : "검색" ,  prodNo link  Event 연결 및 처리
		 $(function() {
			 
			// 현재 페이지의 URL을 가져옵니다.
			var url = window.location.search;
			
			// URL을 파싱하여 URLSearchParams 객체를 생성합니다.
			var urlSearchParams = new URLSearchParams(url);
			
			// menu 파라미터를 가져옵니다.
			menu = urlSearchParams.get("menu");
			//alert(menu);
			 
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				//Debug..
				alert(  $( "td.ct_btn01:contains('검색')" ).html() );
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
			
			//==> UI 수정 추가부분  :  prodNo LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			
			//==> 아래와 같이 정의한 이유는 ??
			//==> 아래의 주석을 하나씩 풀어 가며 이해하자.					
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
				<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0" ${!empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>상품번호</option>
					<option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>상품명</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>상품가격</option>
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
			<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
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
						<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">배송하기</a>
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

	<!--  페이지 Navigator 끝 -->
	
	</form>
	
	</div>
	</body>
</html>
