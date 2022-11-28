<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>認證</title>
        <!-- 禁止SEO -->
        <meta name="robots" content="noindex">
    </head>

    <body>
        <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
        <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>認證</h1>
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
                <img style="padding: 0px;" src="${pageContext.request.contextPath}/images/register-02.svg"
                    alt="步驟2請前往查收認證信">
                <div class="col-lg-12 text-center">
                    <h1></h1>
                </div>
            </div>
            <div class="row" >
                <div class="col-lg-1 "></div>
                <div class="col-lg-4" style="margin-right: 75px;">
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div class="row" style="background-color: #fff;">
                        <div class="col-lg-2 "></div>
                        <div class="col-lg-10 ">
                            <img src="${pageContext.request.contextPath}/images/register-04.svg"
                                style="max-width: 100%; text-align: center;">
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6" style="background-color: #fff;">
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div>&nbsp;</div>
                    <div class="row" style="height: 70%;display: flex;align-items: center;">
                        <span style="font-size:90px;line-height: 90px;font-weight:bold">請前往查收認證信</span>
                        <hr style="border: 2px solid #000; opacity: 1;">
                        <span style="font-size:50px;line-height: 50px;"> 離成功就差一小步了</span>
                        <br>
                        <span style="font-size:50px;line-height: 50px;">趕快前往信箱確認認證信吧!</span>
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