<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
</head>
<body style="background-color: black">>
<!-- ! Body -->
<div class="page-flex">
  <!-- ! Sidebar -->
  <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
  <div class="main-wrapper">
    <!-- ! Main nav -->
    <jsp:include page="/WEB-INF/views/common/mainnav.jsp"></jsp:include>
    <!-- ! Main -->
    <main class="main users chart-page" id="skip-target">
      <div class="container">
        <div style="color: #5eff00;font-size:40px;text-align:center">CHI TIẾT TIỀN VẬN CHUYỂN</div>
        <form  action="/backend/statistics/freightDetailBetween2Days" method="post">
          <div  style="justify-content: space-between;display:flex;flex-direction:row;margin:10px">
            <div> <input type="date" name="startDate" style="width:200px"></div>
            <div> <input type="date" name="endDate"  value="<%=java.time.LocalDate.now()%>" style="width:200px"></div>
            <button type="submit" class="primary-default-btn" style="width:80px">搜索</button>
          </div>
        </form>
        <div style="font-size:20px;text-align:center">
          Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/>
        </div>
        <div class="row stat-cards">
          <div style="margin:3px;width:100%">
            <table>
              <tr >
                <th style="text-align:center">收到日</th>
                <th style="text-align:center">运单号</th>
                <th style="text-align:center">客户</th>
                <th style="text-align:center">重量</th>
                <th style="text-align:center">m3</th>
                <th style="text-align:center">重量率</th>
                <th style="text-align:center">立方米率</th>
                <th style="text-align:center">运费</th>
              </tr>
              <c:forEach items="${freightDetail}" var="w" >
                <c:set var="totalFreight" value="${totalFreight + w.freight}"></c:set>
                <tr >
                  <td style="text-align:center"><fmt:formatDate value = "${w.arriveredDate}" type ="date"/></td>
                  <td style="text-align:center">${w.wayBillCode}</td>
                  <td style="text-align:center">${w.wbUserName}</td>
                  <td style="text-align:center"><fmt:formatNumber value = "${w.kg}" type = "number"/></td>
                  <td style="text-align:center"><fmt:formatNumber value = "${w.cubic}" type = "number"/></td>
                  <td style="text-align:center"><fmt:formatNumber value = "${w.rateKg}" type = "number"/></td>
                  <td style="text-align:center"><fmt:formatNumber value = "${w.rateCubic}" type = "number"/></td>
                  <td style="text-align:center"><fmt:formatNumber value = "${w.freight}" type = "number"/></td>
                </tr>
              </c:forEach>
              <tr >
                <th style="text-align:center;color:#00ff15">合计</th>
                <th style="text-align:center;color:#00ff15"><fmt:formatNumber value = "${totalFreight}" type = "number"/></th>
              </tr>
            </table>
          </div>
        </div>
      </div>

      <nav aria-label="..." style="margin:10px">
        <ul class="pagination">
          <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
            <div>
              <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                <a class="page-link" href="/backend/statistics/freightDetail?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
              </li></div>
            <c:forEach begin="1" end="${total}" step="1" var="num">
              <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                <a class="page-link" href="/backend/statistics/freightDetail?page=${num}&perpage=${perpage}">${num}</a>
              </li></div>
            </c:forEach>
            <div>
              <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                <a class="page-link" href="/backend/statistics/freightDetail?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
              </li></div>
          </div>
        </ul>
      </nav>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
  </div>


  <!-- Chart library -->
  <script src="/plugins/chart.min.js"></script>
  <!-- Icons library -->
  <script src="/plugins/feather.min.js"></script>
  <!-- Custom scripts -->
  <script src="/js/script.js"></script>

</body>

</html>

