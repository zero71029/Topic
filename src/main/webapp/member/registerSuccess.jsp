<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>註冊成功</title>
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
                    <h1>註冊成功</h1>
                </div>
            </div>
            <!-- 抬頭分類 -->
            <div class="row">
                <!-- <%-- 插入抬頭分類 JQ--%> -->
                <jsp:include page="/widget/menu.jsp"></jsp:include>
                <!-- <%-- 右邊工具列--%> -->
                <jsp:include page="/widget/rightTool.jsp"></jsp:include>
            </div>
            <!-- 中間主體 -->
            <div class="row">
                <div class="col-lg-12 text-center" style="background-color: white; --bs-bg-opacity: 1;">
                    <h1>註冊成功  我們已經寄了認證信給你,請查收你的郵箱</h1>
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