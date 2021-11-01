<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-10-18
  Time: 오후 4:13
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
        <div class="input-form col-md-12 mx-auto">
            <h4 class="mb-3">회원가입</h4>
            <form class="validation-form" name="frm" action="${pageContext.request.contextPath}/registration.do" method="post">
                <div class="row"> <div class="col-md-6 mb-3">
                    <label for="name">이름</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                    <div class="invalid-feedback">
                        이름을 입력해주세요.
                    </div>
                </div>
                    <div class="col-md-6 mb-3">
                        <label for="nickname">별명</label>
                        <input type="text" class="form-control" id="nickname" name="nickname" required>
                        <div class="invalid-feedback">
                            별명을 입력해주세요.
                        </div>
                    </div>
                </div>

                <div class="row"> <div class="col-md-6 mb-3">
                    <label for="id" style="display: block;">아이디</label>
                    <input type="text" class="form-control" style="width: 68%; float: left" id="id" name="id" required>
                    <button class="btn btn-success" type="button" style="font-size: revert; float: right; width: 28%" id="idCheck" onclick="idCK();" value="N">중복확인</button>
                    <div class="invalid-feedback">
                        아이디를 입력해주세요.
                    </div>
                </div>
                    <div class="col-md-6 mb-3">
                        <label for="pw">비밀번호</label>
                        <input type="password" class="form-control" id="pw" name="pw" required>
                        <div class="invalid-feedback">
                            비밀번호를 입력해주세요.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="confirmpw">비밀번호 확인</label>
                    <input type="password" class="form-control" id="confirmpw" name="confirmpw" required>
                    <div class="invalid-feedback">
                        비밀번호를 입력해주세요.
                    </div>

                    <div class="mb-3">
                        <label for="email">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                        <div class="invalid-feedback">
                            이메일을 입력해주세요.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="phone">휴대폰 번호</label>
                        <input type="phone" class="form-control" id="phone" name="phone" placeholder="010-XXXX-XXXX" required>
                        <div class="invalid-feedback">
                            휴대폰 번호를 입력해주세요.
                        </div>
                    </div>


                    <hr class="mb-4">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="agreement" required>
                        <label class="custom-control-label" for="agreement">개인정보 수집 및 이용에 동의합니다.</label>
                    </div>
                    <div class="mb-4"></div>
                    <a href="#" class="btn btn-primary btn-danger btn-block" onclick="check_onclick();">가입</a>
                </div>
            </form>
        </div>
    </div>
    <footer class="my-3 text-center text-small">
        <p class="mb-1">&copy; NATIME</p>
    </footer>
</div>
<%@include file="/WEB-INF/include/script.jspf"%>

<script type="text/javascript">
    function idCK() {
        id = $("#id").val();
        theForm = document.frm;
        if (theForm.id.value == "") {
            alert("아이디를 입력해주세요.");
            theForm.id.focus();
            return false;
        }
        $.ajax({
            url: "id_CK.do",
            type: "POST",
            dataType: "JSON",
            data: {"id": id},
            success : function (data) {
                if (data == 1) {
                    $("#idCheck").attr("value", "N");
                    alert("중복된 아이디입니다.\n다른 아이디를 사용해주세요.");
                } else if (data == 0) {
                    $("#idCheck").attr("value", "Y");
                    alert("사용 가능한 아이디입니다.");
                }
            },
            error : function (request, status, error) {
                alert("문의바람");
            }
            , async: true
        });
    }

    function check_onclick() {
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
        } else if (theForm.id.value == "") {
            alert('아이디를 입력해주세요.');
            theForm.id.focus();
            return false;
        } else if (theForm.idCheck.value == "N") {
            alert('중복확인을 해주세요.');
            theForm.id.focus();
            return false;
        } else if(theForm.pw.value == "") {
            alert("비밀번호를 입력해주세요.");
            theForm.pw.focus();
            return false;
        } else if (theForm.confirmpw.value == "") {
            alert("비밀번호 확인을 입력해주세요.");
            theForm.confirmpw.focus();
            return false;
        } else if (theForm.pw.value != theForm.confirmpw.value) {
            alert("비밀번호가 일치하지 않습니다.");
            theForm.confirmpw.focus();
            return false;
        } else if (theForm.email.value == "") {
            alert("이메일 주소를 입력해주세요.");
            theForm.email.focus();
            return false;
        } else if (exptext_mail.test(theForm.email.value) == false) {
            alert("이메일주소 형식이 올바르지 않습니다.");
            theForm.email.focus();
            return false;
        } else if (theForm.phone.value == "") {
            alert("휴대폰 번호를 입력해주세요.");
            theForm.phone.focus();
            return false;
        } else if (exptext_phone.test(theForm.phone.value) == false) {
            alert("전화번호 형식이 올바르지 않습니다. ex) 010-1234-XXXX");
            theForm.phone.focus();
            return false;
        } else if (!theForm.agreement.checked) {
            alert("개인정보 수집 및 이용에 동의해주세요.");
            theForm.agreement.focus();
            return false;
        } else {
            theForm.submit();
            return true;
        }
    }
</script>
</body>
</html>
