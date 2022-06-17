<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>積分說明</title>
            <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->

            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
            <!-- <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script> -->
            <!-- 引入样式 vue-->
            <!-- <script src="${pageContext.request.contextPath}/js/vue.min.js"></script> -->
            <!-- 引入element-ui样式 -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css"> -->
            <!-- 引入element-ui组件库 -->
            <!-- <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/zh-TW.js"></script>
    <script>
        ELEMENT.locale(ELEMENT.lang.zhTW)
    </script> -->
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
                        <div class="card col-lg-12" style="height: 152px;">
                            <div class="row g-0">
                                <div class="col-lg-2 position-relative">
                                    <img src="${pageContext.request.contextPath}/images/share-banner.png"
                                        class="img-fluid rounded-start position-absolute top-50 start-50 translate-middle">
                                </div>
                                <div class="col-lg-10">
                                    <div class="card-body">
                                        <h5 class="card-title">說明</h5>
                                        <p class="card-text">
                                            1.發表文章 100 積分 <br>
                                            2.發表的文章被點讚10積分,最多100積分<br>
                                            3.回復文章 10 積分<br>
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
        <script>
    // var vm = new Vue({
    //     el: ".app",
    //     data() {
    //         return {

    //         }
    //     },
    //     created() {
    //         $.ajax({
    //             url: '${pageContext.request.contextPath}/article/detailInit/${article.articleid}',
    //             type: 'POST',
    //             async: false,//同步請求
    //             cache: false,//不快取頁面
    //             success: response => {
    //                 this.thumbsupNum = response.thumbsupNum;
    //                 this.hasThumbsup = response.hasThumbsup;
    //                 this.replylist = response.replylist;
    //             },
    //             error: function (returndata) {
    //                 console.log(returndata);
    //             }
    //         });
    //     },
    //     methods: {

    //     },
    // })
        </script>

        </html>