<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-10-07
  Time: 오후 4:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>natime</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@include file="/WEB-INF/include/head.jspf"%>
</head>
<body>
    <div class="bg-gradient body-boardList" style="box-shadow: none;">
        <div class="container">
            <%@ include file="/WEB-INF/include/topbar.jspf"%>
            <div class="card o-hidden border-0">
                <h2>목록</h2>
                <table style="border: 1px solid #ccc">
                    <colgroup>
                        <col width="10%"/>
                        <col width="*"/>
                        <col width="15%"/>
                        <col width="20%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">id</th>
                        <th scope="col">pw</th>
                        <th scope="col">이름</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${fn:length(list) > 0}">
                            <c:forEach items="${list }" var="row">
                                <tr>
                                    <td>${row.id}</td>
                                    <td>${row.pw}</td>
                                    <td>${row.name}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4">조회된 결과가 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
