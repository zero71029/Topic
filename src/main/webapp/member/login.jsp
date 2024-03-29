<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>會員登入</title>

            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">
            <!-- 我不是機器人 -->
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>

        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>登入頁面</h1>
                    </div>
                </div>
                <div class="row">
                    <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
                    <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
                    <!-- 抬頭分類 -->
                    <nav class="navbar navbar-expand-lg navbar-light bg-light">
                        <div class="container-fluid">
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/">首頁</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link active"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=sensor&pag=1">感測器</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=apparatus&pag=1">儀器儀表</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=Netcom&pag=1">網通裝置</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=software&pag=1">軟體配件</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=controlbox&pag=1">控制箱</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/topiclist.jsp?nav=application&pag=1">應用</a>
                                    </li>

                                </ul>
                                <form class="d-flex">
                                    <input class="form-control me-2" type="search" placeholder="Search">
                                    <button class="btn btn-outline-success" type="submit">Search</button>
                                </form>
                                &nbsp;&nbsp;&nbsp;
                                <a href="${pageContext.request.contextPath}/member/register.jsp">註冊</a>


                            </div>
                        </div>
                    </nav>
                </div>
                <br><br>
                <!-- 中間主體 -->
                <div class="row">
                    <div class="col-lg-3 "></div>
                    <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                            <input type="hidden" name="url" id="inURL" value="">
                            <div class="mb-3">
                                <label for="exampleFormControlInput1"
                                    class='form-label ${empty error.user  ? "":"red" }'>電子郵件 ${error.user} <span
                                        style="color: red;">${error.blockade}</span></label>
                                <input type="email" class="form-control ${empty error.user  ? '':' is-error' }"
                                    id="username" name="username" value="${username}">
                            </div><br>
                            <div class="mb-3">
                                <label for="exampleFormControlInput1"
                                    class='form-label ${empty  error.pass  ? "":"red" }'>登入密碼 ${error.pass}</label>
                                <input type="password" class="form-control ${empty error.pass  ? '':' is-error' }"
                                    id="password" name="password" value="${password}">
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <input class="form-check-input" type="checkbox" id="remember-me" name='remember-me'>
                                    <label class="form-check-label" for="remember-me">記住我</label>
                                    <a href="${pageContext.request.contextPath}/member/forget.jsp"
                                        style="float:right">忘記密碼</a>
                                </div>
                            </div>
                            <br><br>
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <span style="color: #AAA;">還不是會員嗎?</span>
                                    <a href="${pageContext.request.contextPath}/member/register.jsp">立刻註冊新帳號 </a>
                                    <br><br>
                                    <div style="position: relative;">
                                        <div class="g-recaptcha "
                                            style="width: 304px;display: inline-block;   ${empty recaptcha  ? '':'border: 1px solid #ef4f4f;' }"
                                            data-sitekey="6Ldhf4kgAAAAAN2ExQc-EBZROSpa2xoA69Z2TPrJ"></div>
                                        <button style="position: absolute;bottom: 0%; right: 0%;"
                                            class="btn btn-primary   ">登入</button>
                                    </div>
                                    <p style="color: red;">${recaptcha}</p>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-3 "></div>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1></h1>
                    </div>
                </div>
            </div>
        </body>
        <script>
            if (sessionStorage.getItem("url") != null) {
                let inURL = document.getElementById("inURL");
                inURL.value = sessionStorage.getItem("url");
            }
        </script>
        <style>
            .red {
                color: red;
            }

            .is-error {
                border: 1px solid #ef4f4f;
                background-color: #ffdbdb;
            }
        </style>

        </html>