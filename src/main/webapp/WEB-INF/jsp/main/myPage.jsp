<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-11-12
  Time: 오전 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>NaTime</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <style>
        body {
            min-height: 100vh;

            background: -webkit-gradient(linear, left bottom, right top, from(#f8aebf), to(#FF4E4E));
            background: -webkit-linear-gradient(bottom left,   #f8aebf 0%, #FF4E4E 100%);
            background: -moz-linear-gradient(bottom left,   #f8aebf 0%, #FF4E4E 100%);
            background: -o-linear-gradient(bottom left,  #f8aebf 0%, #FF4E4E 100%);
            background: linear-gradient(to top right,  #f8aebfbf 0%, #FF4E4E 100%); }



        .input-form {
            max-width: 680px;
            margin-top: 80px;
            padding: 32px;
            background: #fff;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
            box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
        }
    </style>
</head>
<body>
<div class="container">

    <div class="input-form-backgroud row">
        <div style="margin-top: 35px; height: 50px; color: white;">
        <span style="cursor: pointer;"
              onclick="javascript:window.location.href='${pageContext.request.contextPath}/boardList_page.do'"><-- Back</span>
        </div>
        <div class="input-form col-md-12 mx-auto">
            <h4 class="mb-3">마이페이지</h4>

            <ul class="nav nav-tabs">
                <li class="nav-item"><a class="nav-link active" style="color: black" data-toggle="tab" href="#profileTab">프로필 변경</a> </li>
                <li class="nav-item"><a class="nav-link" style="color: black" data-toggle="tab" href="#passwordTab">비밀번호 변경</a> </li>
            </ul>
            <div class="tab-content">
                <div id="profileTab" class="profile-edit tab-pane fade in active show">
                    <br>
                    <form name="frm" action="${pageContext.request.contextPath}/edit_profile.do" method="post">
                        <div class="mb-1">
                            <label for="id">아이디</label>
                            <input type="text" class="form-control" id="id" name="id" value="${userInfo.id}" readonly>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name">이름</label>
                                <input type="text" class="form-control" id="name" name="name" value="${userInfo.name}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="nickname">별명</label>
                                <input type="text" class="form-control" id="nickname" name="nickname" value="${userInfo.nickname}">
                            </div>
                        </div>
                        <div class="mb-1">
                            <label for="email">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" value="${userInfo.email}">
                        </div>
                        <br>
                        <div class="mb-1">
                            <label for="phone">휴대폰 번호</label>
                            <input type="phone" class="form-control" id="phone" name="phone" placeholder="010-XXXX-XXXX" value="${userInfo.phone}">
                        </div>

                        <div class="mb-4"></div>
                        <a href="#" class="btn btn-primary btn-danger btn-block" onclick="check_editProfile();">프로필 변경</a>
                    </form>
                </div>

                <div id="passwordTab" class="profile-edit tab-pane fade">
                    <br>
                    <form name="frm2" action="${pageContext.request.contextPath}/edit_password.do" method="post">
                        <input type="hidden" name="id" value="${userInfo.id}">
                        <div class="mb-1">
                            <label for="pw">새로운 비밀번호</label>
                            <input type="password" class="form-control" id="pw" name="pw">
                        </div>
                        <br>
                        <div class="mb-1">
                            <label for="confirmpw">비밀번호 확인</label>
                            <input type="password" class="form-control" id="confirmpw" name="confirmpw">
                        </div>

                        <div class="mb-4"></div>
                        <a href="#" class="btn btn-primary btn-danger btn-block" onclick="check_editPassword();">비밀번호 변경</a>
                    </form>
                </div>
            </div>

        </div>
    </div>
    <footer class="my-3 text-center text-small">
        <p class="mb-1">&copy; NATIME</p>
    </footer>
</div>
<%@include file="/WEB-INF/include/script.jspf"%>

<script>
    function check_editProfile() {
        theForm = document.frm;
        const exptext_mail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
        const exptext_phone = /^\d{2,3}-\d{3,4}-\d{4}$/;

        if (theForm.name.value == "") {
            alert('이름을 입력해주세요.');
            theForm.name.focus();
            return false;
        } else if (theForm.nickname.value == "") {
            alert('별명을 입력해주세요.');
            theForm.nickname.focus();
            return false;
        } else if (theForm.email.value == "") {
            alert('이메일을 입력해주세요.');
            theForm.email.focus();
            return false;
        } else if (exptext_mail.test(theForm.email.value) ==  false) {
            alert('이메일 형식이 올바르지 않습니다.');
            theForm.email.focus();
            return false;
        } else if (theForm.phone.value == "") {
            alert('휴대폰 번호를 입력해주세요.');
            theForm.phone.focus();
            return false;
        } else if (exptext_phone.test(theForm.phone.value) == false) {
            alert('휴대폰 번호 형식이 올바르지 않습니다. ex)010-XXXX-1234');
            theForm.phone.focus();
            return false;
        } else {
            theForm.submit();
            alert('프로필이 변경되었습니다.');
            return true;
        }
    }
    
    function check_editPassword() {
        theForm = document.frm2;

        if (theForm.pw.value == "") {
            alert('새로운 비밀번호를 입력해주세요.');
            theForm.pw.focus();
            return false;
        } else if (theForm.confirmpw.value == "") {
            alert('비밀번호 확인을 입력해주세요.');
            theForm.confirmpw.focus();
            return false;
        } else if (theForm.pw.value != theForm.confirmpw.value) {
            alert('비밀번호가 서로 같지 않습니다.');
            theForm.pw.focus();
            return false;
        } else {
            theForm.submit();
            alert('비밀번호가 변경되었습니다.');
            return true;
        }
    }
</script>
</body>
</html>
