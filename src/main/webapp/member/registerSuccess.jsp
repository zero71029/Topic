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



</head>

<body>
    <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
    <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h1>登入頁面</h1>
            </div>
        </div>
        <div class="row">
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
                            <input class="form-control me-2" type="search" placeholder="Search" >
                            <button class="btn btn-outline-success" type="submit">Search</button>
                        </form>
                        &nbsp;&nbsp;&nbsp;
                        <a href="">註冊</a>/ <a href="">登入</a>
                        


                    </div>
                </div>
            </nav>
        </div>
        <!-- 中間主體 -->
        <div class="row">
            <div class="col-lg-12 text-center"  style="background-color: white; --bs-bg-opacity: 1;">
                <h1>中間主體 </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <h1></h1>
            </div>
        </div>
    </div>
</body>

</html>