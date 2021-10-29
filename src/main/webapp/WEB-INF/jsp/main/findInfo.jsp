<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-10-29
  Time: 오후 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
    <title>NaTime</title>
    <%@include file="/WEB-INF/include/head.jspf" %>

    <style>
        @media (min-width: 817px) {
            .body-registeration {
                width: 817px;
            }
        }

        dl dt {
            float: left;
            width: 25%;
        }

        dl dd {
            margin-left: 25%;
        }

        li a {
            color: #555;
        }
    </style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
</head>
<body class="bg-gradient-primary body-registeration" style="box-shadow: none">

<div class="container">
    <div style="margin-top: 35px; height: 50px; color: white">
        <span style="cursor: pointer;" onclick="javascript:window.location.href='${pageContext.request.contextPath}/login_page.do'"><-- Back</span>
    </div>

    <div class="card o-hidden border-0 shadow-lg">
        <div style="width: 85%; margin: auto;" class="card-body p-0">
            <div class="row">
                <div class="col-lg-7">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">아이디/비밀번호 찾기</h1>
                            <p style="font-size: 16px; width: 400px">아이디 혹은 비밀번호가 기억나지 않으세요? 등록된 e-mail 주소로 정보를 찾을 수 있습니다!</p>
                        </div>
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#userID">아이디 찾기</a> </li>
                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#userPW">비밀번호 찾기</a> </li>
                        </ul>
                        <div class="tab-content">
                            <div id="userID" class="id-find tab-pane fade in active show">
                                <br>
                                <form name="frm" id="formtag" class="user" method="post" onsubmit="return false">
                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" autofocus name="name" placeholder="이름">
                                    </div>
                                    <div class="form-group">
                                        <input type="email" class="form-control form-control-user" name="email" placeholder="e-mail 주소">
                                    </div>
                                    <hr>
                                    <button class="btn btn-primary btn-user btn-block" data-style="slide-down" onclick="find_id()">
                                        아이디 찾기
                                    </button>
                                </form>
                            </div>
                            <div id="userPW" class="pw-find tab-pane fade">
                                <br>
                                <form name="frm2" id="formtag2" class="user" method="post" onsubmit="return false">
                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" autofocus name="name" placeholder="이름">
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" name="id" placeholder="아이디">
                                    </div>
                                    <hr>
                                    <button class="btn btn-primary btn-user btn-block" data-style="slide-down" onclick="find_pw()">
                                        비밀번호 찾기
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/include/script.jspf"%>

<script type="text/javascript">
    jQuery(document).ready(function () {
        App.init();
    });
</script>
<script type="text/javascript">
    function find_id() {
        var formData = $("#formtag").serialize();
        $.ajax({
            type: 'post',
            url: 'find_id.do',
            dataType: 'json',
            data: formData,
            success: function (data) {
                var meg = data.msg;
                alert(meg);
            },
            error: function (request, status, error) {
                console.log("code: " + request.status+ "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                alert('일치하는 정보가 없습니다.\n회원가입을 해주세요.');
            },
            async: true
        });
    }
</script>
<script type="text/javascript">
    function find_pw() {
        var formData = $("#formtag2").serialize();
        $.ajax({
            type: 'post',
            url: 'find_pw.do',
            dataType: 'json',
            data: formData,
            success: function (data) {
                var meg = data.msg;
                alert(meg);
            },
            error: function (request, status, error) {
                console.log("code: " + request.status+ "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                alert('다시 시도해주세요.');
            },
            async: true
        });
    }
</script>

</body>
</html>
