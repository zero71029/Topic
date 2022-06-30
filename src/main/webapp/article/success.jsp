<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>發表成功</title>
        <!-- 禁止SEO -->
        <meta name="robots" content="noindex">
    </head>

    <body>
        <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
        <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>發表成功</h1>
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
                <div class="col-lg-12 text-center">
                    <h1></h1>
                </div>
            </div>
            <div class="row ">
                <div class="col-lg-2 "></div>
                <div class="col-lg-4 ">
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div class="row ">
                        <div class="col-lg-2 "></div>
                        <div class="col-lg-10 ">
                            <img src="${pageContext.request.contextPath}/images/page-08.png"
                                style="max-width: 100%; text-align: center;">
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <img src="${pageContext.request.contextPath}/images/page-09.png" style="max-width: 90%;"><br><br>
                    <div class="row" style="font-size:35px;line-height: 50px;font-weight:bold">發表成功,請稍等我們審核!</div>
                    <div class="row" style="font-size: 20px;color: #333;line-height:40px">
                        <p>你有以下選擇:</p>
                    </div>
                    <div style="font-size: 18px;color: #333;line-height:40px">
                        <ul>
                            <li><a href="/topic/index" tabindex="-1">首頁</a></li>
                            <li><a href="/topic/topiclist.jsp?nav=sensor" tabindex="-1">感測器</a></li>
                            <li><a href="/topic/topiclist.jsp?nav=apparatus" tabindex="-1">儀器儀表</a></li>
                            <li><a href="/topic/topiclist.jsp?nav=Netcom" tabindex="-1">網通裝置</a></li>
                        </ul>
                    </div>
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