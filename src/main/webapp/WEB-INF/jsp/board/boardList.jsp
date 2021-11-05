<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-11-01
  Time: 오후 7:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>NaTime</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@include file="/WEB-INF/include/head.jspf"%>

    <style>
        .box {
            margin: 30px auto;
        }
        .card-text {
            width: auto;
        }
    </style>
</head>
<body style="width: 70%">
<%@ include file="/WEB-INF/include/topbar.jspf"%>
    <section class="container">
        <form action="./boardList.jsp" class="form-inline mt-3" method="get">
            <select name="lectureDivide" class="form-control max-1 mt-2">
                <option value="전체">전체</option>
                <option value="전공">전공</option>
                <option value="교양">교양</option>
                <option value="기타">기타</option>
            </select>
            <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="검색">
            <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
            <a class="btn btn-primary mx-1 mt-2" href="#">등록하기</a>
        </form>

        <c:forEach items="${list}" var="list">
            <div class="card bg-light mt-3">
                <div class="card-header bg-light">
                    <div class="row">
                        <div class="col-8 text-left">${list.lecture}&nbsp; <small>${list.professor} 교수님</small></div>
                        <div class="col-4 text-right" style="border-right: 1px; solid-color: gray; font-weight: bold">
                            종합 별점 <span style="color: #f4b30d; font-weight: bold"> ${star[list.star]} </span>
                            &nbsp;&nbsp; ${list.nickname}
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h5 class="card-title" style="font-weight: bold">
                        ${list.title}&nbsp;&nbsp;<small>(${list.year}년도 ${list.semester}학기)</small>
                    </h5>
                    <p class="card-text">
                            ${list.content}
                    </p>
                </div>
                <div class="card-body">

                    <div class="row">
                        <div class="col-9 text-left">
                            <%--성적<span style="color: red;">A</span>
                            강의<span style="color: red;">B</span>--%>
                            <span style="color: green;">(추천: ${list.like})</span>
                        </div>
                        <div class="col-3 text-right">
                            <a onclick="return confirm('추천하시겠습니까?')" href="#">추천</a>
                            <c:if test="${member_info.id eq list.id}">
                                <a onclick="return confirm('삭제하시겠습니까?')" href="#">삭제</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </section>

<%@include file="/WEB-INF/include/script.jspf"%>
<script text="text/javascript">
    $(document).ready(function(){

        $('.card-body').each(function(){
            var content = $(this).children('.card-text');
            //var content = $(this).find('.contentStr');

            var content_txt = content.text();
            var content_html = content.html();
            var content_txt_short = content_txt.substring(0,100)+"...";
            var btn_more = $('<a href="javascript:void(0)" class="more">더보기</a>');


            $(this).append(btn_more);

            if(content_txt.length >= 100){
                content.html(content_txt_short)

            }else{
                btn_more.hide()
            }

            btn_more.click(toggle_content);
            function toggle_content(){
                if($(this).hasClass('short')){
                    // 접기 상태
                    $(this).html('더보기');
                    content.html(content_txt_short)
                    $(this).removeClass('short');
                }else{
                    // 더보기 상태
                    $(this).html('접기');
                    content.html(content_html);
                    $(this).addClass('short');

                }
            }
        });
    });
</script>
</body>

<%--<script type="text/javascript">
    $(function () {
        $("p").slice(0, 10).show();
        $("#load").click(function (e) {
            e.preventDefault();
            $("p:hidden").slice(0, 10).show();
            if ($("p:hidden").length == 0) {
                alert("No more p");
            }
        });
    })
</script>--%>
</html>
