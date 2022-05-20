<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${article.name}</title>
            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <!-- 引入 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
        </head>

        <body>
            <style>
                [v-cloak] {
                    display: none;
                }

                span a {
                    color: #000;
                    text-decoration: none;
                }

                span .icon:hover,
                span a .icon:hover {
                    cursor: pointer;
                    color: #0d6efd;
                    ;
                }
            </style>
            <div class="container-fluid ">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>久德討論版</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- <%-- 傘型特效--%> -->
                    <jsp:include page="/widget/umbrella.jsp"></jsp:include>
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>
                <div class="row app" v-cloak>
                    <div class="col-lg-12 ">
                        <div class="row">
                            <div class="col-lg-2 " style="background-color: #ccc;opacity: 0.1;    min-height: 900px;">
                            </div>
                            <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                                <br><br>
                                <div class="row ">
                                    <!-- 中間主體 -->
                                    <div class="col-lg-10">
                                        <div class="row ">
                                            <div class="col-lg-3 text-center">
                                                <span
                                                    style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">樓主</span><br>
                                                <span style="color: #379cf4;">${article.membername}</span><br>
                                            </div>
                                            <div class="col-lg-9 ">
                                                <h3>${article.name}</h3>
                                                <p>${article.createtime}<span style="float: right;">
                                                        <i class="bi bi-hand-thumbs-up icon  thumbsup"
                                                            @click="clickThumbsup">讚
                                                            {{thumbsupNum}}</i>
                                                        &nbsp;
                                                        |
                                                        &nbsp;<a href=""><i class="bi bi-chat-left-text">回復</i></a>
                                                        &nbsp; |&nbsp; <i class="bi bi-share icon share">分享</i></span>
                                                </p>
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
                            <div class="col-lg-2 " style="background-color: #ccc;opacity: 0.1;    min-height: 900px;">
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


        <script>
            const url = new URL(location.href);
            const id = url.searchParams.get("id");
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        thumbsupNum: 0,
                        hasThumbsup: false,
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/article/detailInit/' + id,
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: (response) => {
                            this.thumbsupNum = response.thumbsupNum,
                                this.hasThumbsup = response.hasThumbsup
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                    if (this.hasThumbsup) {
                        $(".thumbsup").css("color", "blue")
                    }
                },
                methods: {
                    clickThumbsup() {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/article/thumbsup/' + id,
                            type: 'POST',
                            success: (boo)=> {
                                if (boo) {
                                    $(".thumbsup").css("color", "blue");
                                    this.thumbsupNum++;
                                } else {
                                    $(".thumbsup").css("color", "black");
                                    this.thumbsupNum--;
                                }

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },

                },
            })
        </script>