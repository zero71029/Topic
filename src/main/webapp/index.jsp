<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>久德討論版</title>
            <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->


            <!-- 引入 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>


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
                <!-- 中間主體 -->
                <div class="row app" v-cloak>
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                        <br>
                        <div class="row">
                            <div class="col-lg-10">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            熱門討論區</div>
                                        <table class="table">
                                            <tbody>
                                                <tr v-for="(s, index) in popular" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div style="width: 100%;height: 100px;background-color: blue;"></div>
                                    </div>
                                </div><br>
                                <div class="row">

                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            感測器</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in sensor" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span>
                                                            <a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}
                                                            </a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            儀器儀表</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in apparatus" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            網通裝置</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in Netcom" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            軟體配件</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in software" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            控制箱</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in controlbox" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-lg-6">
                                        <div
                                            style="width: 100%;background-color: #1c8cee;color: #FFF;font-size: 40px;line-height: 80px;padding-left: 20px;">
                                            應用</div>
                                        <table class="table" style="height: 450px;">
                                            <tbody>
                                                <tr v-for="(s, index) in application" :key="index">
                                                    <td>
                                                        <a class="tdname"
                                                            :href="'${pageContext.request.contextPath}/detail/'+s.articleid">{{s.name}}</a><br>
                                                        <span><a :href="'${pageContext.request.contextPath}/topiclist.jsp?nav='+s.articlegroup+'&pag=1'"
                                                                target="_blank">{{s.group}}</a>
                                                        </span>
                                                        <span
                                                            style="float: right;color: #888;line-height: 25px;">{{s.createtime}}</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <jsp:include page="/widget/advertise.jsp"></jsp:include>
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
        <script>
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        popular: [],
                        sensor: [],
                        apparatus: [],
                        Netcom: [],
                        software: [],
                        controlbox: [],
                        application: [],
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/init',
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.popular = response.popular;
                            this.sensor = response.sensor;
                            this.apparatus = response.apparatus;
                            this.Netcom = response.Netcom;
                            this.software = response.software;
                            this.controlbox = response.controlbox;
                            this.application = response.application;

                            this.popular.forEach(e => {
                                this.changGrop(e);
                            });
                            this.sensor.forEach(e => {
                                this.changGrop(e);
                            });
                            this.apparatus.forEach(e => {
                                this.changGrop(e);
                            });
                            this.Netcom.forEach(e => {
                                this.changGrop(e);
                            });
                            this.software.forEach(e => {
                                this.changGrop(e);
                            });
                            this.controlbox.forEach(e => {
                                this.changGrop(e);
                            });
                            this.application.forEach(e => {
                                this.changGrop(e);
                            });
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    changGrop(e) {
                        switch (e.articlegroup) {
                            case 'sensor':
                                e.group = "感測器";
                                break;
                            case 'apparatus':
                                e.group = "儀器儀表";
                                break;
                            case 'Netcom':
                                e.group = "網通裝置";
                                break;
                            case 'software':
                                e.group = "軟體配件";
                                break;
                            case 'controlbox':
                                e.group = "控制箱";
                                break;
                            case 'application':
                                e.group = "應用";
                                break;
                            case 'system':
                                e.group = "系統";
                                break;
                        }
                    },
                },
            })
        </script>
        <style>
            tr td a {
                text-decoration: none;
                line-height: 30px;
            }

            tr td a.tdname {
                color: #000;
            }

            [v-cloak] {
                display: none;
            }
        </style>

        </html>