<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員登入</title>
    <!-- <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script> -->
    <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->

    <!-- bootstrap的CSS、JS樣式放這裡 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <meta name="robots" content="noindex">

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
                                <a class="nav-link active" href="${pageContext.request.contextPath}/topiclist.jsp?nav=sensor&pag=1">感測器</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/topiclist.jsp?nav=apparatus&pag=1">儀器儀表</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/topiclist.jsp?nav=Netcom&pag=1">網通裝置</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/topiclist.jsp?nav=software&pag=1">軟體配件</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/topiclist.jsp?nav=controlbox&pag=1">控制箱</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/topiclist.jsp?nav=application&pag=1">應用</a>
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
            <div class="col-lg-6 "   style="background-color: white; --bs-bg-opacity: 1;">
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label" >電子郵件</label>
                        <input type="email" class="form-control" id="username" name="username" value="AAA@AAA.com">
                    </div><br>
                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label">登入密碼</label>
                        <input type="text" class="form-control" id="password" name="password" value="AAA">
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12 ">
                            <input class="form-check-input" type="checkbox"  id="remember-me" name='remember-me'>
                            <label class="form-check-label" for="remember-me" >記住我</label>
                            <a href="" style="float:right">忘記密碼</a>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="col-lg-12 ">
                            <span style="color: #AAA;">還不是會員嗎?</span>
                            <a href="" >立刻註冊新帳號</a>
                            <button style="float:right" class="btn btn-primary">登入</button>
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

</html>