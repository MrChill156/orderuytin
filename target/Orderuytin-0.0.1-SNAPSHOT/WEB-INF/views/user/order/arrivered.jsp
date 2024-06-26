<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
	<script>
		$(document).ready(function(){
			$(".Confirm").click( function confirm(){
				let id = $(this).attr('id') ;
				let orderID = id.substring(7);
				let orderStatusID = 'orderStatus' + orderID;
				let formID = 'form' + orderID;
				document.getElementById(orderStatusID).value = 'Thanh cong';
				document.getElementById(formID).submit();
			});
			$(".Claim").click( function myFunction() {
				let id = $(this).attr('id') ;
				let orderID = id.substring(5);
				let orderStatusID = 'orderStatus' + orderID;
				let formID = 'form' + orderID;
				let userNoteID = 'userNote' + orderID;
				document.getElementById(orderStatusID).value = 'Khieu nai';
				let x =  $("."+userNoteID).val();
				if(x == ""){ alert("Hãy nhập nội dung muốn khiếu nại trước khi nộp đơn khiếu nại.")}
				if(x != ""){
				document.getElementById(formID).submit();}
			})
			var freightKGval = $("#freightKG").val();
			if(freightKGval == 0){
				$(".KG").hide();
			}
		});
	</script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
	<!-- ! Sidebar -->
	<jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
	<div class="main-wrapper">
		<!-- ! Main nav -->
		<nav class="main-nav--bg" style="background-color: black">
			<div class="container main-nav">
				<div class="main-nav-start">
					<form  action="/user/search/searchOrder" method="post">
						<div class="search-wrapper" style="display:flex;flex-direction:row">
							<i data-feather="search" aria-hidden="true"></i>
							<input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
							<button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
						</div>
					</form>
				</div>
				<div class="main-nav-end">
					<button class="sidebar-toggle transparent-btn" class="mainnavIcon" title="Menu" type="button">
						<span class="sr-only">Toggle menu</span>
						<span class="icon menu-toggle--gray" aria-hidden="true"></span>
					</button>

					<div style="color:white;font-size:35px" >
						<a href="/user/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
					</div>

					<div style="color:white;font-size:35px" ><a href="/user/home"><i class="fa-solid fa-house-user"></i> </a> </div>
					<div style="color:white;">
						<a href="/user/item/cart">
							<p style="color:red;font-size:15px;float:right">${countCartItem}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
						</a>
					</div>

					<div >
						<!-- Add a logout button -->
						<form:form action="/logout"   method="POST">
							<button type="submit"  style="color:white;background-color:black;font-size:35px"><i class="fa-solid fa-right-from-bracket"></i></button>
						</form:form>
					</div>
				</div>
			</div>
			<div style="display:flex;flex-direction:row;justify-content:space-between;margin:5px;text-align:center;color:white">
				<div>
					<p style="font-size:15px;float:right">${countWholeOrder}</p> </br><a style="font-size:15px" href="/user/order/whole">Tất cả</a>
				</div>
				<div>
					</br>|</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countPendingOrder}</p>  </br><a style="font-size:15px"  href="/user/order/pending"> Chờ mua </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countBoughtOrder}</p></br> <a style="font-size:15px"  href="/user/order/bought"> Đã mua</a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countDeliveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/deliveried"> Đã phát</a>
				</div>
				<div>
					</br>|</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countArriveredOrder}</p></br> <a style="color:yellow;font-size:25px;font-weight:bold"  href="/user/order/arrivered">Về kho </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countComplainOrder}</p> </br><a style="font-size:15px"  href="/user/order/complain"> Khiếu nại </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div >
					<p style="font-size:15px;float:right">${countFinishedOrder}</p></br> <a style="font-size:15px"  href="/user/order/finished"> Thành công </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countCancelOrder+countCancelItem}</p></br> <a style="font-size:15px"  href="/user/order/cancel"> Đơn huỷ  </a>
				</div>
			</div>
		</nav>

		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
			<div class="container">
				<div style="display:flex;flex-direction:column;">
					<div style="margin:5px;color:red"><p >${message}</p></div>
				</div>
				<div class="row stat-cards">
					<div class="KG" style="margin: 5px">
						<article class="stat-cards-item" style="margin: 5px">
							<div style="font-size:30px;text-align:center;margin:3px;width:100%">
								<p >ĐƠN HÀNG KI GỬI</p>
							</div>
							<div style="margin:3px;width:100%">
								<table>
									<tr>
										<th>Mã vận đơn</th>
										<th>Thành tiền</th>
										<th>Ngày về</th>
										<th>Kg</th>
										<th>m3</th>
										<th>Tỉ giá Kg</th>
										<th>Tỉ giá m3</th>
									</tr>
						<c:forEach items="${showKGwaybillsList}" var="wbKG" >
							<c:set var="totalFreightKG" value="${totalFreightKG + wbKG.freight}"></c:set>
									<tr >
										<td>${wbKG.wayBillCode}</td>
										<td>${wbKG.freight}</td>
										<td><fmt:formatDate value = "${wbKG.arriveredDate}" type = "date"/></td>
										<td><fmt:formatNumber value = "${wbKG.kg}" type = "number"/></td>
										<td><fmt:formatNumber value = "${wbKG.cubic}" type = "number"/></td>
										<td><fmt:formatNumber value = "${wbKG.rateKg}" type = "number"/> </td>
										<td><fmt:formatNumber value = "${wbKG.rateCubic}" type = "number"/></td>
									</tr>
						</c:forEach>
									<tr style="color:red">
										<td>Tổng cước</td>
										<td><fmt:formatNumber value = "${totalFreightKG}" type = "number"/></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<input type="text"  value = "${totalFreightKG}" id="freightKG"   hidden/>
									</tr>
								</table>
							</div>
						</article>
					</div>
					<c:forEach items="${showArriveredOrderListofClient}" var="saol" >
						<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">

						<div style="display:flex;flex-direction:row;justify-content:space-between;margin:5px;width:100%">
								<div > Ngày đặt: <fmt:formatDate value = "${saol.receivedDate}" type = "date"/></div>
								<div > Mã đơn hàng : ${saol.orderNo} </div>
							</div>
							<div class="row">
							<c:forEach items="${saol.items}" var="i" >
								<c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
								<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
								<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>

								<form:form method="post" action="/user/item/save" modelAttribute="itemDAO">
									<div style="margin:5px;display:flex;flex-direction:column">
										<div style="padding:5px;margin:2px;border-radius:10px;border-style:solid;border-width: thin;border-color:white;display:flex" >
											<div >
												<img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" >
											</div>
											<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:10px">
												<div style="width:100%"> <a href="${i.link}"> Click Link :</a>  <input style="width:100px" value="${i.link}"  /></div>
												<div style="width:100%"> ${i.describle}</div>
												<div style="width:100%"> Giá : <fmt:formatNumber value = "${i.price}" type = "number"/> ¥</div>
												<div style="width:100%"> Số lượng : ${i.quantity}</div>
												<div style="width:100%"> Tỉ giá : ${i.CNYrateVND} đ/¥</div>
												<div style="width:100%"> Thành tiền : <fmt:formatNumber value = "${i.price*i.quantity}" type = "number"/> ¥</div>
												<div style="width:100%">  =  <fmt:formatNumber value = "${i.price*i.quantity*i.CNYrateVND}" maxFractionDigits="0" type = "number"/> đ</div>
											</div>
										</div>
										<div style="display:flex;flex-direction:row;width:100%">
											<div style="margin:2px;" >Nội dung </br>khiếu nại</div>
											<div style="margin:2px">
												<input type="text"  name="userNote" class="userNote${saol.orderId}" value="${i.userNote}" onblur="this.form.submit()" placeholder="Hãy nhập nội dung khiếu nại ." path="userNote" />
												<div style="display:none">
													<input type="text"  name="CNYrateVND" value="${i.CNYrateVND}"          path="CNYrateVND" />
													<input type="text"  name="quantity" value="${i.quantity}"              path="quantity" />
													<input type="text"  name="price" value="${i.price}"                    path="price" />
													<input type="text"  name="describle" value="${i.describle}"            path="describle" />
													<input type="text"  name="link" value="${i.link}"                      path="link" />
													<input type="text"  name="orderId" value="${i.orderId}"                path="orderId" />
													<input type="text"  name="itemUserName" value="${i.itemUserName}"      path="itemUserName" />
													<input type="text"  name="itemStatus" value="Khieu nai"                path="itemStatus" />
													<input type="text"  name="itemId" value="${i.itemId}"                  path="itemId" />
													<input type="text"  name="image" value="${i.image}"                    path="image" />
													<input type="text"  name="adminNote" value="${i.adminNote}"            path="adminNote" />
													<input type="text"  name="quantityRefund" value="${i.quantityRefund}"  path="quantityRefund" />
													<input type="text"  name="refundDate" value="${i.refundDate}"          path="refundDate" />
												</div>
											</div>
										</div>
									</div>
								</form:form>
							</c:forEach >
							</div>
							<div style="margin:3px;width:100%">
								<table>
									<tr>
										<th>Mã vận đơn</th>
										<th>Thành tiền</th>
										<th style="font-size:20px">Ngàyvềkho</th>
										<th>Kg</th>
										<th>m3</th>
										<th>Tỉ giá Kg</th>
										<th>Tỉ giá m3</th>
									</tr>
									<c:forEach items="${saol.waybills}" var="wb" >
										<c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
										<c:set var="totalFreightVN" value="${totalFreightVN + wb.freight}"></c:set>
									<tr >
										<td>${wb.wayBillCode}</td>
										<td><fmt:formatNumber value = "${wb.freight}" maxFractionDigits="0" type = "number"/></td>
										<td style="font-size:15px"><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
										<td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
										<td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
										<td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
										<td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
									</tr>
									</c:forEach>
									<tr style="color:red">
										<td>Tổng cước</td>
										<td><fmt:formatNumber value = "${totalFreight}" maxFractionDigits="0" type = "number"/></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</table>
							</div>
							<div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:70%">
								<form:form method="post" id ='form${saol.orderId}' action="/user/order/save" modelAttribute="ordersDAO">
									<div style="display:flex;flex-direction:row;margin:5px">Tổng số lượng sp trong đh : ${totalQuantity}</div>
								    <div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:40%">Tiền hàng </br><p style="font-weight: bold">(ko ship nđ) </p></div>
										<div><p>  <fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/> đ ( <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥ )</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:40%">Ship nội địa  </div>
										<div><p> <fmt:formatNumber maxFractionDigits="0" value = "${saol.shipFeeVND}" type = "number"/> đ ( <fmt:formatNumber value = "${saol.shipFeeCNY}" type = "number"/> ¥ )</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:40%">Tiền hàng  </br><p style="font-weight: bold">(có ship nđ)</p></div>
										<div><p>  <fmt:formatNumber maxFractionDigits="0" value = "${saol.totalVN}" type = "number"/> đ (<fmt:formatNumber value = "${saol.totalCN}" type = "number"/> ¥ )</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:40%">Tổng tiền đh </br><p style="font-weight: bold">(gồm cước vc) </p></div>
										<div><p><fmt:formatNumber maxFractionDigits="0" value = "${saol.totalVN+totalFreight}" type = "number"/> đ</p></div>
									</div>
								<div style="display:flex;flex-direction:row;margin:10px">
									<button  type="button" id="Claim${saol.orderId}" class="Claim" style="border-radius:5px;margin-left:-5%;padding:5px;background-color:#ff0015" >Khiếu nại</button>
									<button  type="button" id="Confirm${saol.orderId}" class="Confirm" style="border-radius:5px;margin-left:10%;padding:10px;background-color:#00ff15">Xác nhận thành công</button>
								</div>
								<div style="display:none" >
									<input type="text"  name="orderStatus"    value=""                        path="orderStatus"   id="orderStatus${saol.orderId}"/>
									<input type="text"  name="orderUserName"  value="${saol.orderUserName}"   path="orderUserName" />
									<input type="text"  name="receivedDate"   value="${saol.receivedDate}"    path="receivedDate" />
									<input type="text"  name="totalVN"        value="${saol.totalVN}"         path="totalVN" />
									<input type="text"  name="totalCN"        value="${saol.totalCN}"         path="totalCN" />
									<input type="text"  name="orderNo"        value="${saol.orderNo}"         path="orderNo" />
									<input type="text"  name="orderId"        value="${saol.orderId}"         path="orderId" />
									<input type="text"  name="shipFeeCNY"     value="${saol.shipFeeCNY}"      path="shipFeeCNY" />
									<input type="text"  name="shipFeeVND"     value="${saol.shipFeeVND}"      path="shipFeeVND" />
									<input type="text"  name="cancelDate"     value="${saol.cancelDate}"      path="cancelDate" />
									</div>
								</form:form>
							</div>

						</article>
				<c:set var="totalQuantity" value="0"></c:set>
				<c:set var="totalItemCN" value="0"></c:set>
				<c:set var="totalItemVN" value="0"></c:set>
				<c:set var="totalFreight" value="0"></c:set>
				<c:set var="totalCN" value="${totalCN+saol.totalCN}"></c:set>
				<c:set var="totalVN" value="${totalVN+saol.totalVN}"></c:set>
					</c:forEach>
				</div>

			</div>

	</main>
		<footer class="footer">
			<div class="container footer--flex">
				<div class="footer-start">
					<nav aria-label="..." style="width:300px">
						<ul class="pagination">
							<div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
								<div>
									<li class="page-item <c:if test="${page == 1}">disabled</c:if>">
										<a class="page-link" href="/user/order/arrivered?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/user/order/arrivered?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/user/order/arrivered?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li></div>
							</div>
						</ul>
					</nav>
				</div>
				<ul class="footer-end">
					<li><p>Tổng tiền hàng đã về kho ：<fmt:formatNumber maxFractionDigits="0" value = "${totalVN}" type="number"/>đ(<fmt:formatNumber  value = "${totalCN}" type = "number"/>¥)</p> </li>
					<li><p>Tổng tiền cước  ：<fmt:formatNumber value = "${totalFreightVN+totalFreightKG}" type="number"/>đ</p></li>
				</ul>
			</div>
		</footer>
	</div>

	<!-- Chart library -->
	<script src="/plugins/chart.min.js"></script>
	<!-- Icons library -->
	<script src="/plugins/feather.min.js"></script>
	<!-- Custom scripts -->
	<script src="/js/script.js"></script>
</div>

</body>
</html>
