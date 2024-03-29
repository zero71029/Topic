<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>積分說明</title>
            <style>
                @media (min-width : 992px) {
                    .explain {
                        height: 152px;
                    }
                    .explainImg{
                        line-height: 152px;
                    }
                }
            </style>
        </head>

        <body>
            <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>積分說明</h1>
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
                        &nbsp;
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 "></div>
                    <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                        <div class="card col-lg-12 explain">
                            <div class="row g-0 ">
                                <div class="col-lg-2 explainImg">
                                    <img src="${pageContext.request.contextPath}/images/share-banner.png"
                                        class="img-fluid rounded-start ">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">說明</h5>
                                        <p class="card-text">
                                            1.發表文章 50 積分 <br>
                                            2.發表的文章被點讚10積分,最多100積分<br>

                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div><br>
                        <div class="card col-lg-12">
                            <div class="row g-0">
                                <div class="col-lg-2">
                                    <img src="${pageContext.request.contextPath}/images/青銅.png"
                                        class="img-fluid rounded-start">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">青銅</h5>
                                        <p class="card-text">
                                            初出茅廬
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="card col-lg-12">
                            <div class="row g-0">
                                <div class="col-lg-2">
                                    <img src="${pageContext.request.contextPath}/images/白銀.png"
                                        class="img-fluid rounded-start">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">白銀</h5>
                                        <p class="card-text">積分1000
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div><br>
                        <div class="card col-lg-12">
                            <div class="row g-0">
                                <div class="col-lg-2">
                                    <img src="${pageContext.request.contextPath}/images/黃金.png"
                                        class="img-fluid rounded-start">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">黃金</h5>
                                        <p class="card-text">積分10000
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div><br>
                        <div class="card col-lg-12">
                            <div class="row g-0">
                                <div class="col-lg-2">
                                    <img src="${pageContext.request.contextPath}/images/鉑金.png"
                                        class="img-fluid rounded-start">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">鉑金</h5>
                                        <p class="card-text">積分30000
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div><br>
                        <div class="card col-lg-12">
                            <div class="row g-0">
                                <div class="col-lg-2">
                                    <img src="${pageContext.request.contextPath}/images/傳奇.png"
                                        class="img-fluid rounded-start">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">傳奇</h5>
                                        <p class="card-text">積分90000
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div><br>
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