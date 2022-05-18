<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>討論區列表</title>
            
            <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->

            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/icons/bootstrap-icons.css">
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
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
            <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>討論區</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                </div>
                <!-- 中間主體 -->
                <div class="row app">

                    <div class="col-lg-2 ">
                    </div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">

                        <div class="row ">
                            <div class="col-lg-12">hellow world ${member}</div>
                        </div>

                        <div class="row ">
                            <div class="col-lg-12 text-end">
                                <button type="button" class="btn btn-primary"
                                    onclick="window.open('${pageContext.request.contextPath}/publish.jsp')">發布文章</button>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-10">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">主題</th>
                                            <th scope="col">發布時間</th>
                                            <th scope="col">最後回覆</th>
                                            <th scope="col">回復數</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td>Markdasankdwkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk</td>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>

                                        </tr>
                                        <tr>
                                            <td>@mdo</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <td>@mdo</td>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
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
                    <!-- 右邊廣告 -->
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
            var vm = new Vue({
                el: ".app",
                data() {
                    return {

                    }
                },
            })
        </script>



        </html>