<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>錯誤頁面</title>
</head>

<body>
    <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
    <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h1>&nbsp;</h1>
            </div>
        </div>
        <div class="row">
            <!-- <%-- 插入抬頭分類 JQ--%> -->
            <jsp:include page="/widget/menu.jsp"></jsp:include>
            <!-- <%-- 右邊工具列--%> -->
            <jsp:include page="/widget/rightTool.jsp"></jsp:include>
        </div>
        <!-- 中間主體 -->
        <div class="row ">
            <div class="col-lg-2 "></div>
            <div class="col-lg-4 ">
                <div>&nbsp;</div>
                <div>&nbsp;</div>
                <div>&nbsp;</div>
                <div class="row ">
                    <div class="col-lg-2 "></div>
                    <div class="col-lg-10 ">
                        <img src="${pageContext.request.contextPath}/images/page-10.png"
                            style="max-width: 100%; text-align: center;">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div>&nbsp;</div>
                <div>&nbsp;</div>
                <div>&nbsp;</div>
                <img src="${pageContext.request.contextPath}/images/page-05.png" style="max-width: 90%;"><br><br>
                <div class="row" style="font-size:35px;line-height: 50px;font-weight:bold">抱歉!發生了錯誤</div>
                <div class="row" style="font-size: 20px;color: #333;line-height:40px">
                    <p>下面的連結可能對你有幫助:</p>
                </div>
                <div   style="font-size: 18px;color: #333;line-height:40px">
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