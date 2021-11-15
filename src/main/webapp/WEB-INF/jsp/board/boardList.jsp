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

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            data_value = [];

            var data = google.visualization.arrayToDataTable(
                [["lecture","Rating"], ${chart}]
            );

            var options = {
                title: "시스템 이용자에 한해서 가장 많이 수강한 과목입니다."
            };
            var chart = new google.visualization.PieChart(document.getElementById("mostlecture_piechart"));
            chart.draw(data, options);
        }

        function scroll_follow(id) {
            $(window).scroll(function () {
                var position = $(window).scrollTop();
                $(id).stop().animate({top:position + "px"}, 1);
            });
        }
        scroll_follow( "#scroll" );
        $(document).ready(function(){ for( var i=0; i<200; i++ ) {$('#brr').html($('#brr').html() +"<br>" + i);} });
    </script>

</head>
<body style="width: 85%"> <%--style="width: 70%"--%>
<%@ include file="/WEB-INF/include/topbar.jspf"%>
    <section class="container">
        <form action="${pageContext.request.contextPath}/boardList_page.do" class="form-inline mt-3" method="post">
            <select name="sort" class="form-control max-1 mt-2">
                <option value="전체">정렬</option>
                <option value="year_value">연도순</option>
                <option value="like_value">추천순</option>
                <option value="star">별점순</option>
            </select>
            <select name="lectureDivide" class="form-control max-1 mt-2">
                <option value="전체">검색조건</option>
                <option value="lecture">강의명</option>
                <option value="professor">담당 교수명</option>
                <%--<option value="nickname">닉네임</option>--%>
                <option value="title">제목</option>
                <option value="content">내용</option>
                <%--<option value="like">추천 순</option>
                <option value="star">별점 순</option>--%>
            </select>
            <input type="text" name="search" id="search" class="form-control mx-1 mt-2" placeholder="검색">
            <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
            <a class="btn btn-primary mx-1 mt-2" href="${pageContext.request.contextPath}/boardWrite_page.do">등록하기</a>
        </form>
        <div class="row">
            <div class="col-xl-8 col-lg-7">
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
                                ${list.title}&nbsp;&nbsp;<small>(${list.year_value}년도 ${list.semester}학기)</small>
                            </h5>
                            <p class="card-text">
                                    ${list.content}
                            </p>
                        </div>
                        <div class="card-body">

                            <div class="row">
                                <div class="col-9 text-left">
                                    성적<span style="color: red;">${list.creditScore}</span>
                                    강의<span style="color: red;">${list.lectureScore}</span>
                                    과제 양<span style="color: red;">${list.projectScore}</span>
                                    <span style="color: green;">(추천: ${list.like_value})</span>
                                </div>
                                <div class="col-3 text-right">
                                    <input type="hidden" name="idx" value="${list.idx}"/>
                                    <%--<a onclick="return confirm('추천하시겠습니까?')" href="#">추천</a>--%>
                                    <input type="submit" value="추천" class="btn btn-success btn-sm" onclick="if (!confirm('추천하시겠습니까?')){return false;}">
                                    <c:if test="${member_info.id eq list.id}">
                                        <form action="${pageContext.request.contextPath}/deleteBoard.do" method="post" style="display: inline;">
                                            <input type="hidden" name="idx" value="${list.idx}">
                                            <input type="submit" value="삭제" class="btn btn-danger btn-sm" onclick="if(!confirm('삭제하시겠습니까?')){return false;}">
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>


            <div class="col-xl-4 col-lg-5">
                <div class="input-form col-md-12 mx-auto">
                    <div id="scroll" style="position: absolute; width: 100%">
                        <h4 class="mb-3">차트</h4>

                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" style="color: black" data-toggle="tab" href="#mostCourse">과목별</a> </li>
                        </ul>
                        <div class="tab-content">
                            <div id="mostCourse" class="profile-edit tab-pane fade in active show">
                                <br>
                                <div id="mostlecture_piechart"></div>
                                <canvas id="myChart" align="center"></canvas>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>

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
</html>
