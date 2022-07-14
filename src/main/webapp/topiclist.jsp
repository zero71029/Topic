<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>討論區列表</title>
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
                            <div class="col-lg-10">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">主題</th>
                                            <th scope="col" style="width: 150px;">發布時間</th>
                                            <th scope="col" style="width: 150px;">最後回覆</th>
                                            <th scope="col" style="width: 90px;">回復數</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(s, index) in list" :key="index" class="article">
                                            <td>
                                                <a
                                                    :href="'${pageContext.request.contextPath}/detail/'+s.bean.articleid">{{s.bean.name}}
                                                </a>
                                            </td>
                                            <td>{{s.bean.createtime}}</td>
                                            <td>{{s.bean.replytime}}</td>
                                            <td>{{s.bean.replylist.length}}
                                                <el-tag v-if="s.watch > 0" type="danger" effect="dark" size="mini">
                                                    NEW {{ s.watch }}
                                                </el-tag>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <p style="text-align: center;">
                                    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                                        :current-page="currentPage" :page-sizes="[1,2,3,10, 20, 30, 40,100]"
                                        :page-size="pageSize" layout=" sizes, prev, pager, next, jumper" :total="total">
                                    </el-pagination>
                                </p>

                            </div>
                            <!-- 右邊廣告 -->
                            <div class="col-lg-2">
                                <div class="advertise">
                                    <el-carousel trigger="click" height="500px" :interval="15000">
                                        <el-carousel-item v-for="( s, index) in rigthAdvertise" :key="index">
                                            <a :href="s.url" target="_blank"><img
                                                    :src="'${pageContext.request.contextPath}/file/'+s.img"
                                                    :alt="s.name"></a>
                                        </el-carousel-item>
                                    </el-carousel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        <script>
            const url = new URL(location.href);
            const nav = url.searchParams.get("nav");
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        currentPage: 1,
                        pageSize: 20,
                        total: 400,
                        list: [],
                        rigthAdvertise: [],
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/topiclist?nav=' + nav + '&pag=' + this.currentPage + '&size=' + this.pageSize,
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.list = response.list;
                            this.total = response.total;
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                    $.ajax({
                        url: '${pageContext.request.contextPath}/backstage/advertiseinit?location=右',
                        type: 'get',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.rigthAdvertise = response;

                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    handleSizeChange(val) {
                        this.pageSize = val;
                        $.ajax({
                            url: '${pageContext.request.contextPath}/topiclist?nav=' + nav + '&pag=' + this.currentPage + '&size=' + val,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.list = response.list;
                                this.total = response.total;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    handleCurrentChange(val) {
                        this.currentPage = val;
                        $.ajax({
                            url: '${pageContext.request.contextPath}/topiclist?nav=' + nav + '&pag=' + val + '&size=' + this.pageSize,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.list = response.list;
                                this.total = response.total;
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

        </html>