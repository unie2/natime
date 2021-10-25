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
<html>
<head>
    <title>NaTime</title>

    <style>
        .id_input_re_1 {
            color: green;
            display: none;
        }

        .id_input_re_2 {
            color: red;
            display: none;
        }
    </style>
</head>
<body class="body-container" id="page-top">

<div id="wrapper" style="width: 1600px; margin: auto">
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <div>
                <div class="jumbotron bg-white remove-space" style="background-color: #FF4848; text-align: center; height: 180px;">
                    <h1 style="color: #FFC6C6; font-weight: 900; margin-top: 10px;">회원 가입</h1>
                </div>
                <form name="frm" action="${pageContext.request.contextPath}/registration.do" class="user" method="post">
                    <div class="form-group">
                        <label class="control-label" for="id">아이디</label>
                        <input type="text" class="form-control" id="id" name="id" placeholder="아이디"/>
                        <button class="idCheck" type="button" id="idCheck" onclick="idCK();" value="N">중복확인</button>
                    </div>
                    <div class="form-group row">
                        <label class="control-label" for="pw">비밀번호</label>
                        <input type="password" class="form-control form-control-user" id="pw" name="pw" placeholder="비밀번호">
                    </div>
                    <div>
                        <label class="control-label" for="confirmpw">비밀번호 확인</label>
                        <input type="password" class="form-control form-control-user" id="confirmpw" name="confirmpw" placeholder="비밀번호 확인">
                    </div>
                    <div>
                        <label class="control-label" for="name">이름</label>
                        <input type="text" class="form-control form-control-user" id="name" name="name" placeholder="이름">
                    </div>
                    <div>
                        <label class="control-label" for="phone">전화번호</label>
                        <input type="phone" class="form-control form-control-user" id="phone" name="phone" placeholder="휴대폰번호">
                    </div>
                    <div>
                        <label class="control-label" for="email">이메일주소</label>
                        <input type="email" class="form-control form-control-user" id="email" name="email" placeholder="이메일주소">
                    </div>

                    <hr>
                    <a href="#" class="btn btn-user btn-block" style="color: white; background-color: red" onclick="check_onclick();">
                        가입
                    </a>
                </form>
            </div>
        </div>
    </div>
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
                    alert("중복된 아이디입니다.");
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

        if (theForm.id.value == "") {
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
        } else if (theForm.name.value == "") {
            alert("이름을 입력해주세요.");
            theForm.name.focus();
            return false;
        } else if (theForm.phone.value == "") {
            alert("휴대폰 번호를 입력해주세요.");
            theForm.phone.focus();
            return false;
        } else if (exptext_phone.test(theForm.phone.value) == false) {
            alert("전화번호 형식이 올바르지 않습니다. ex) 010-1234-5678");
            theForm.phone.focus();
            return false;
        } else if (theForm.email.value == "") {
            alert("이메일주소를 입력해주세요.");
            theForm.email.focus();
            return false;
        } else if (exptext_mail.test(theForm.email.value) == false) {
            alert("이메일주소 형식이 올바르지 않습니다.");
            theForm.email.focus();
            return false;
        } else {
            theForm.submit();
            return true;
        }
    }
</script>

</body>
</html>
