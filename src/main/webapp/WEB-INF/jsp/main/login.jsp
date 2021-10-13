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

    <style>
        @media (min-width: 817px) {
            .body-login {
                width: 817px;
            }
        }
    </style>
</head>
<body class="bg-gradient body-login" style="box-shadow: none;">
    <div class="container">
        <div class="card o-hidden border-0">
            <div style="margin: auto;" class="card-body p-0">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="p-5" style="margin-top: 50px">
                            <div class="text-center">
                                <h1 class="h4 text-red-900 mb-4" style="color: red">NaTime</h1>
                                <h1 class="h3 text-red-900 mb-4" style="color: red">나타임</h1>
                            </div>
                            <form action="${pageContext.request.contextPath}/loginCk.do" novalidate="novalidate" method="post">
                                <fieldset>
                                    <div>
                                        <section>
                                            <div class="row input_size">
                                                <label class="label col col-4">아이디</label>
                                                <div class="col col-8">
                                                    <label class="input">
                                                        <input type="text" name="id" autocomplete="off" autofocus>
                                                    </label>
                                                </div>
                                            </div>
                                        </section>
                                        <section>
                                            <div class="row input_size">
                                                <label class="label col col-4">비밀번호</label>
                                                <div class="col col-8">
                                                    <label class="input">
                                                        <input type="password" name="pw" autocomplete="current-password">
                                                    </label>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </fieldset>
                                <button href="#" class="btn btn-user btn-block" style="color: white; background-color: red" type="submit">로그인</button>
                            </form>
                            <div class="note">
                                <a href="${pageContext.request.contextPath}/findUserPage.do" style="color: gray">아이디/비밀번호 찾기</a>
                                <a href="${pageContext.request.contextPath}/registration.do" style="color: gray">회원가입</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
