<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>預覽</title>
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
                        <h1>久德討論版</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>


                <div class="row">
                    <div class="col-lg-12 ">
                        <div class="row">
                            <div class="col-lg-2 "></div>
                            <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                                <br><br>
                                <div class="row ">
                                    <!-- 中間主體 -->
                                    <div class="col-lg-10">
                                        <div class="row ">
                                            <div class="col-lg-3 text-center">
                                                <span
                                                    style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">樓主</span><br>
                                                <span style="color: #379cf4;">${member.name}</span><br>


                                            </div>
                                            <div class="col-lg-9 ">
                                                <h3>${article.name}</h3>
                                                <p>${article.createtime}<span style="float: right;">讚5 | 回復 | 分享</span> </p>                                              
                                                <hr>
                                                ${article.content}
                                            </div>






                                        </div>
                                    </div>
                                    <!-- 右邊廣告 -->
                                    <div class="col-lg-2">
                                        <jsp:include page="/widget/advertise.jsp"></jsp:include>
                                    </div>
                                </div>
                            </div>
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