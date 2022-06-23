<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>寄件成功</title>
        <!-- 我不是機器人 -->
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">

    </head>

    <body>
        <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
        <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>寄件成功</h1>
                </div>
            </div>
            <div class="row">
                <!-- <%-- 插入抬頭分類 JQ--%> -->
                <jsp:include page="/widget/menu.jsp"></jsp:include>
                <!-- <%-- 右邊工具列--%> -->
                <jsp:include page="/widget/rightTool.jsp"></jsp:include>
            </div>
            <!-- 中間主體 -->
            <div class="row">
                <div class="col-lg-3 "></div>
                <div class="col-lg-6 text-center" style="background-color: white; --bs-bg-opacity: 1;">
                    <br>
                    <h1>我們已提供重置密碼相關設定到信箱,請檢察您的信箱</h1>
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