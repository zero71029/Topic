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
            <!-- 廣告 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/advertise.css">
            <script>
                ELEMENT.locale(ELEMENT.lang.zhTW)
            </script>
            <style>
                [v-cloak] {
                    display: none;
                }
            </style>
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
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;" v-cloak>
                        <div class="row ">
                            <div class="col-lg-12">&nbsp;</div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-12">
                                <el-breadcrumb separator="/">
                                    <el-breadcrumb-item><a href="#">首頁</a></el-breadcrumb-item>
                                    <el-breadcrumb-item id="navname"> </el-breadcrumb-item>

                                </el-breadcrumb>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-12">&nbsp;</div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-9">
                                <div class="row text-center" id="caption">
                                    <div class="col-lg-6">主題</div>
                                    <div class="col-lg-2">發布時間</div>
                                    <div class="col-lg-2">最後回覆</div>
                                    <div class="col-lg-2">回覆數</div>
                                </div>
                                <hr style="color: #000;">
                                <div class="row article" v-for="(s, index) in list" :key="index" style="line-height: 40px;"
                                    >
                                    <div class="col-lg-6"> <a
                                            :href="'${pageContext.request.contextPath}/detail/'+s.bean.articleid"
                                            style="text-decoration: none;">{{s.bean.name}}
                                        </a></div>
                                    <div class="col-lg-2"><span class="caption2">發布時間 </span>{{s.bean.createtime}}</div>
                                    <div class="col-lg-2"><span class="caption2">最後回覆 </span>{{s.bean.replytime}}</div>
                                    <div class="col-lg-2"><span class="caption2">回覆數 </span>{{s.bean.total}}
                                        <el-tag v-if="s.watch > 0" type="danger" effect="dark" size="mini">
                                            NEW {{ s.watch }}
                                        </el-tag>
                                    </div>
                                </div>
                                <!-- 分頁 -->
                                <p style="text-align: center;">

                                    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                                        :current-page="currentPage" :page-sizes="[1,2,3,10, 20, 30, 40,100]"
                                        :page-size="pageSize" layout=" sizes, prev, pager, next, jumper" :total="total">
                                    </el-pagination>
                                </p>
                            </div>

                            <!-- 右邊廣告 -->
                            <div class="col-lg-2">
                                <!-- 右邊廣告 -->
                                <jsp:include page="/widget/advertise.jsp"></jsp:include>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            </div>
        </body>

        <script>
            function changGrop(e) {
                switch (e) {
                    case 'sensor':
                        return "感測器";
                    case 'apparatus':
                        return "儀器儀表";
                    case 'Netcom':
                        return "網通裝置";
                    case 'software':
                        return "軟體配件";
                    case 'controlbox':
                        return "控制箱";
                    case 'application':
                        return "應用";
                    case 'system':
                        return "系統";
                }
            };
            //按鈕顏色
            const url = new URL(location.href);
            const nav = url.searchParams.get("nav");
            if (nav != "system") {
                const e = document.getElementById(nav);
                e.style.background = "#7F7F7F";
                e.style.borderRadius = "4px";
                document.querySelector("#" + nav + " a").style.color = "#fff";
                console.log(document.getElementsByTagName('h1')[0].innerText);
                document.getElementsByTagName('h1')[0].innerText=changGrop(nav)+"討論區";
                document.getElementsByTagName('title')[0].innerText=changGrop(nav)+"討論區";
            }
            //
            const navname = document.getElementById("navname");
            navname.textContent = changGrop(nav);
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
                            if (response.code == 200) {
                                this.list = response.data.list;
                                this.total = response.data.total;
                            }
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                    $.ajax({
                        url: '${pageContext.request.contextPath}/topic/advertiseinit?location=右',
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
                mounted() {
                    const direct = document.getElementById("")
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
                                this.list = response.data.list;
                                this.total = response.data.total;
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
                                this.list = response.data.list;
                                this.total = response.data.total;
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
            .article:hover {
                background-color: #E9F9FF;
            }
            .article a:hover {
                color: #1C77AF
            }
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

            @media (max-width:996px) {
                #caption {
                    display: none;
                }

                .caption2 {
                    display: initial;
                }
            }

            @media (min-width:996px) {
                .caption2 {
                    display: none;
                }
            }
        </style>

        </html>