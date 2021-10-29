<%--
  Created by IntelliJ IDEA.
  User: Leeyoonhee
  Date: 2021-10-13
  Time: 오후 5:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
    <title>NaTime</title>

    <%@include file="/WEB-INF/include/head.jspf"%>
    <link rel="stylesheet"href="style.css">
    <script src="jqury-3.4.1.js"></script>

    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {
            font-family: 'Jalnan';
            display: flex;
            justify-content: center;
            height: 100vh;
            background-color: #fff;
            background-size: cover;
        }
        body::before {
            content: "";
            position: absolute; z-index: 1;
            top: 0; right: 0; bottom: 0; left: 0;

        }

        .login-form {position: relative; z-index: 2;}
        .login-form h1 {
            font-size: 40px; color: #E23C43;
            text-align: center;
            margin-top: 150px;
            margin-bottom: 60px;
        }
        .int-area {
            width: 400px; position: relative;
            margin-top: 20px;
        }
        .int-area:first-child {margin: 0;}
        .int-area input {
            width: 100%;
            padding: 20px 10px 10px;
            background-color: transparent;
            border: none;
            border-bottom: 1px solid #999;
            font-size: 18px; color: #F8AEB2;
            outline: none;
        }
        .int-area label {
            position: absolute; left: 10px; top: 15px;
            font-size: 18px; color: #999;
            transition: all .5s ease;
        }
        .int-area label.warning {
            color: red !important;
            animation: warning .3s ease;
            animation-iteration-count: 3;
        }
        @keyframes warning {
            0% {transform: translateX(-8px);}
            25% {transform: translateX(8px);}
            50% {transform: translateX(-8px);}
            75% {transform: translateX(8px);}
        }
        .int-area input:focus + label,
        .int-area input:valid+ label {
            top: -2px;
            font-size: 15px; color: #FF4E4E;
        }
        .btn-area {margin-top: 30px;}
        .btn-area button {
            width: 100%; height: 50px;
            background: #E23C43;
            color: #FFF;
            font-size: 20px;
            border-radius: 25px;
            cursor: pointer;
        }
        .caption {
            margin-top: 20px;
            text-align: center;
        }
        .caption a {
            font-size: 15px; color: #999;
            text-decoration: none;
        }

    </style>
</head>
<body>
    <section class="login-form">
        <h1>NaTime</h1>
        <form action="${pageContext.request.contextPath}/loginCK.do" novalidate="novalidate" method="post">
            <div class="int-area">
                <input type="text" name="id" id="id"
                       autocomplete="off" required>
                <label for="id">USER NAME</label>
            </div>
            <div class="int-area">
                <input type="password" name="pw" id="pw"
                       autocomplete="off" required>
                <label for="pw">PASSWORD</label>
            </div>
            <div class="btn-area">
                <button id="btn"
                        type="submit">LOGIN</button>
            </div>
        </form>
        <div class="caption">
            <a href="${pageContext.request.contextPath}/findInfo_page.do">Forgot Password?</a>
        </div>
    </section>
    <script>
        var id = $('#id');
        var id = $('#pw');
        var id = $('#btn');

        $(btn).on('click', function() {
            if($(id).val() == "") {
                $(id).next('label').addClass('warning');
                setTimeout(function(){
                    $('label').removeClass('warning');
                },1500);
            }
            else if($(pw).val() == "") {
                $(pw).next('label').addClass('warning');
                setTimeout(function(){
                    $('label').removeClass('warning');
                },1500);
            }
        });
    </script>
</body>
</html>
