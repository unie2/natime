<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-11-07
  Time: 오후 3:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>NaTime</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@include file="/WEB-INF/include/head.jspf"%>
</head>
<body style="width: 70%">
<%@ include file="/WEB-INF/include/topbar.jspf"%>
<section class="container">
    <div class="col-md-12">
        <div>
            <div class="card mb-8 ml-0 mr-2 mt-2">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between" style="float: left; position: relative; height: 90px;">
                    <h4 class="m-0" style="position: absolute; top: 30px;">강의평가 등록</h4>
                </div>

                <form action="${pageContext.request.contextPath}/insertBoard.do" method="post" name="frm" onsubmit="return checkform();">
                    <input type="hidden" name="id" value="${member_info.id}">
                    <input type="hidden" name="name" value="${member_info.name}">
                    <input type="hidden" name="nickname" value="${member_info.nickname}">

                    <div class="card-body">
                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <label>강의명</label>
                                <input type="text" name="lectureName" id="lectureName" class="form-control" maxlength="20">
                            </div>
                            <div class="form-group col-sm-6">
                                <label>담당 교수명</label>
                                <input type="text" name="professor" id="professor" class="form-control" maxlength="20">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-sm-4">
                                <label>수강 연도</label>
                                <select name="lectureYear" id="lectureYear" class="form-control">
                                    <option value="2014">2014</option>
                                    <option value="2015">2015</option>
                                    <option value="2016">2016</option>
                                    <option value="2017">2017</option>
                                    <option value="2018">2018</option>
                                    <option value="2019">2019</option>
                                    <option value="2020">2020</option>
                                    <option value="2021" selected>2021</option>
                                    <option value="2022">2022</option>
                                </select>
                            </div>
                            <div class="form-group col-sm-4">
                                <label>수강 학기</label>
                                <select name="semester" id="semester" class="form-control">
                                    <option value="1" selected>1학기</option>
                                    <option value="2">2학기</option>
                                </select>
                            </div>
                            <div class="form-group col-sm-4">
                                <label>종합별점</label>
                                <select name="star" id="star" class="form-control" style="color: #f4b30d; font-weight: bold;">
                                    <option value="0" selected>☆☆☆☆☆</option>
                                    <option value="1">★☆☆☆☆</option>
                                    <option value="2">★★☆☆☆</option>
                                    <option value="3">★★★☆☆</option>
                                    <option value="4">★★★★☆</option>
                                    <option value="5">★★★★★</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>제목</label>
                            <input type="text" name="title" id="title" class="form-control" maxlength="30">
                        </div>
                        <div class="form-group">
                            <label>내용</label>
                            <textarea name="content" id="content" class="form-control" mexlength="2048" style="height: 200px;"></textarea>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-sm-3">
                                <label>성적</label>
                                <select name="creditScore" class="form-control">
                                    <option value="A" selected>A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
                            </div>
                            <div class="form-group col-sm-3">
                                <label>강의</label>
                                <select name="lectureScore" class="form-control">
                                    <option value="A" selected>A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
                            </div>
                            <div class="form-group col-sm-3">
                                <label>과제 양</label>
                                <select name="projectScore" class="form-control">
                                    <option value="매우 많음" selected>매우 많음</option>
                                    <option value="많음">많음</option>
                                    <option value="보통">보통</option>
                                    <option value="적음">적음</option>
                                    <option value="매우 적음">매우 적음</option>
                                </select>
                            </div>
                        </div>
                        <button type="button" style="float: right; margin-left: 10px;" class="btn btn-secondary btn-sm" onclick="window.history.back();">취소</button>
                        <input type="submit" id="button" class="btn btn-primary btn-sm" style="float: right;" value="등록하기">
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/include/script.jspf"%>

<script type="text/javascript">
    function checkform() {
        theForm = document.frm;
        if (theForm.lectureName.value == "") {
            alert("강의명을 입력해주세요.");
            theForm.lectureName.focus();
            return false;
        } else if (theForm.professor.value == "") {
            alert("담당 교수명을 입력해주세요.");
            theForm.professor.focus();
            return false;
        } else if (theForm.title.value == "") {
            alert("제목을 입력해주세요.");
            theForm.title.focus();
            return false;
        } else if (theForm.content.value == "") {
            alert("내용을 입력해주세요.");
            theForm.content.focus();
            return false;
        } else {
            return true;
        }
    }
</script>
</body>
</html>
