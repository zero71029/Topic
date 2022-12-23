<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>我的文章</title>
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="${pageContext.request.contextPath}/js/zh-TW.js"></script>
            <script>
                ELEMENT.locale(ELEMENT.lang.zhTW)
            </script>
        </head>

        <body>
            <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>我的文章</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>
                <!-- 中間主體 -->
                <div class="row app">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8" style="background-color: white; --bs-bg-opacity: 1;">
                        <table class="table ">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">主題</th>
                                <th scope="col">發布時間</th>
                                <th scope="col">最後回覆</th>
                                <th scope="col">回覆數</th>
                                <th scope="col">狀態</th>
                            </tr>
                            <tr v-for="(s, index) in list" :key="index">
                                <th scope="row">{{index + 1}}</th>
                                <td>
                                    <a :href="'${pageContext.request.contextPath}/detail/'+s.bean.articleid">
                                        <div style="width: 100%;height: 80%;">{{s.bean.name}} </div>
                                    </a>
                                </td>
                                <td>{{s.bean.createtime}}</td>
                                <td>{{s.bean.replytime}}</td>
                                <td>{{s.bean.total}}
                                    <el-tag v-if="s.watch > 0" type="danger" effect="dark" size="mini">
                                        NEW {{s.watch}}
                                    </el-tag>
                                </td>
                                <td :class="s.allow">{{s.bean.state}}</td>
                            </tr>
                        </table>
                        <p style="text-align: center;">
                            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                                :current-page="currentPage" :page-sizes="[1,2,3,10, 20, 30, 40,100]"
                                :page-size="pageSize" layout=" sizes, prev, pager, next, jumper" :total="total">
                            </el-pagination>
                        </p>
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
            const contextPath = "${pageContext.request.contextPath}";
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        list: [],
                        currentPage: 1,
                        pageSize: 20,
                        total: 100,
                    }
                },
                created() {
                    $.ajax({
                        url: contextPath + '/member/mycollect?page=1&size=20',
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.list = response.list;
                            this.total = response.total;
                            this.list.forEach(e => {
                                if (e.bean.state == "允許") {
                                    e.allow = "blue";
                                } else {
                                    e.allow = "red";
                                }
                            });
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }                     


                    });
                    console.log(this.list);
                },
                methods: {
                    handleSizeChange(val) {
                        this.pageSize = val;
                        $.ajax({
                            url: contextPath + '/member/mycollect?page=' + this.currentPage + '&size=' + val,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.list = response.list;
                                this.total = response.total;
                                this.list.forEach(e => {
                                    if (e.bean.state == "允許") {
                                        e.allow = "blue";
                                    } else {
                                        e.allow = "red";
                                    }
                                });
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    handleCurrentChange(val) {
                        this.currentPage = val;
                        $.ajax({
                            url: contextPath + '/member/mycollect?page=' + val + '&size=' + this.pageSize,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.list = response.list;
                                this.total = response.total;
                                this.list.forEach(e => {
                                    if (e.bean.state == "允許") {
                                        e.allow = "blue";
                                    } else {
                                        e.allow = "red";
                                    }
                                });
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                },
            })

        </script>

        <style>
            tr td a {
                text-decoration: none;
                color: black;
            }

            .red {
                color: red;
            }

            .blue {
                color: blue;
            }
        </style>

        </html>