<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>討論區列表</title>


            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/icons/bootstrap-icons.css">
            <!-- 引入样式 vue-->
            <!-- <script src="${pageContext.request.contextPath}/js/vue.min.js"></script> -->
            <!-- 引入element-ui样式 -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css"> -->
            <!-- 引入element-ui组件库 -->
            <!-- <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="//unpkg.com/element-ui/lib/umd/locale/zh-TW.js"></script>
            <script>
                ELEMENT.locale(ELEMENT.lang.zhTW)
            </script> -->

        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>討論區</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- 傘型特效 -->
                    <jsp:include page="/widget/umbrella.jsp"></jsp:include>
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>
                <!-- 中間主體 -->
                <div class="row app">

                    <div class="col-lg-2 ">
                    </div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">

                        <div class="row ">
                            <div class="col-lg-12">&nbsp;</div>
                        </div>

                        <div class="row ">
                            <div class="col-lg-12 text-end">
                                <c:if test="${not empty member}">
                                    <button type="button" class="btn btn-primary"
                                        onclick="window.open('${pageContext.request.contextPath}/article/publish.jsp?nav=${param.nav}')">發布文章</button>
                                </c:if>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-10">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">主題</th>
                                            <th scope="col" style="width: 150px;">發布時間</th>
                                            <th scope="col" style="width: 150px;">最後回覆</th>
                                            <th scope="col" style="width: 70px;">回復數</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach varStatus="loop" begin="0" end="${list.size()}" items="${list}"
                                            var="s">
                                            <tr>
                                                <td><a
                                                        href="${pageContext.request.contextPath}/detail/${s.articleid}">${s.name}</a>
                                                </td>
                                                <td ><a href="">${s.createtime}</a></td>
                                                <td >${s.replytime}</td>
                                                <td >0</td>
                                            </tr>
                                        </c:forEach>

                                        <style>
                                            tr td a {
                                                display: -webkit-box;
                                                max-height: 1.5em;
                                                -webkit-line-clamp: 1;
                                                -webkit-box-orient: vertical;
                                                overflow: hidden;
                                                -o-text-overflow: ellipsis;
                                                text-overflow: ellipsis;
                                                word-break: break-all;
                                                color: #111;
                                                text-decoration: none;
                                                outline: 0;
                                                background-color: transparent;
                                            }
                                        </style>

                                    </tbody>
                                </table>
                            </div>
                            <!-- 右邊廣告 -->
                            <div class="col-lg-2">
                                <a href="">
                                    <div style=" 
                                height: 700px;background-color: blue;    top: 47px;position: relative;">xxxxxxx</div>
                                </a>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-12"></div>
                        </div>
                    </div>
                    <div class="col-lg-2 ">

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

        <script>
            // var vm = new Vue({
            //     el: ".app",
            //     data() {
            //         return {

            //         }
            //     },
            //     created() {
            //     },
            //     methods: {

            //     },
            // })
        </script>



        </html>