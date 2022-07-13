<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>我的頁面</title>
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">
            <!-- 引入 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="${pageContext.request.contextPath}/js/zh-TW.js"></script>
            <meta name="robots" content="noindex">
        </head>

        <body>
            <jsp:include page="/widget/umbrella.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>帳戶管理</h1>
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
                    <div class="col-lg-12 ">
                        <transition name="el-zoom-in-top">
                            <div class="row" v-show="show">
                                <div class="col-lg-3 "></div>
                                <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                                    <span style="color: #074F8F;font-size: 40px;">${SPRING_SECURITY_CONTEXT.authentication.principal.name}</span>
                                    <p>註冊日期 : ${SPRING_SECURITY_CONTEXT.authentication.principal.createtime}</p>
                                    <div class="row" style="border: 1px solid #444;">
                                        <div class="col-lg-3 " style="position:relative;">
                                            <a href="${pageContext.request.contextPath}/system/level.jsp">
                                                <img class="position-absolute top-50 start-50 translate-middle"
                                                    :src="level" alt="line" style="width: 100px;">
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center">
                                            <a href="${pageContext.request.contextPath}/member/myArticle.jsp">
                                                <i class="bi bi-file-earmark-text" style="font-size: 60px;"></i><br>
                                                <span>發表文章</span><br>
                                                <span style="font-size: 20px;"><b>{{articleNum}}</b></span>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center">
                                            <a href="${pageContext.request.contextPath}/member/myReply.jsp">
                                                <i class="bi bi-chat-text" style="font-size: 60px;"></i><br>
                                                <span>回復文章</span><br>
                                                <span style="font-size: 20px;"><b>{{replyNum}}</b></span>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center">
                                            <i class="bi bi-trophy" style="font-size: 60px;"></i><br>
                                            <span>獲得積分</span><br>
                                            <span style="font-size: 20px;"><b>{{integral}}</b></span>
                                        </div>
                                    </div>
                                    <br>
                                    <p
                                        style="font-size: 30px; border-left: 10px solid #555; border-bottom: 1px solid #555;">
                                        &nbsp; 個人資料</p>

                                    <form action="" method="post" id="reviseForm">
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">會員名稱</label>
                                            <input type="text" class="form-control" name="name" value="${SPRING_SECURITY_CONTEXT.authentication.principal.name}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">組資單位</label>
                                            <input type="text" class="form-control" name="company"
                                                value="${SPRING_SECURITY_CONTEXT.authentication.principal.company}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">Email</label>
                                            <input type="email" class="form-control" name="email"
                                                value="${SPRING_SECURITY_CONTEXT.authentication.principal.email}" disabled>
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">連絡電話</label>
                                            <input type="text" class="form-control" name="phone"
                                                value="${SPRING_SECURITY_CONTEXT.authentication.principal.phone}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">聯絡地址</label>
                                            <input type="text" class="form-control" name="address"
                                                value="${SPRING_SECURITY_CONTEXT.authentication.principal.address}">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">生日</label>
                                            <el-date-picker v-model="birthday" type="date" placeholder="選擇日期"
                                                format="yyyy 年 MM 月 dd 日" value-format="yyyy 年 MM 月 dd 日"
                                                name="birthday">
                                            </el-date-picker>
                                            <!-- 
                                            <input type="text" class="form-control" name="birthday"
                                                value="${SPRING_SECURITY_CONTEXT.authentication.principal.birthday}"> -->
                                        </div>
                                        <a href="${pageContext.request.contextPath}/member/reSend.jsp"
                                            id="reSend">重寄認證信</a>
                                        <button type="button" class="btn btn-primary" style="float: right;"
                                            @click="revise">修改</button>
                                    </form>
                                    <br><br>
                                </div>
                            </div>
                        </transition>
                    </div>
                </div>

            </div>
        </body>
        <script>
            const vm = new Vue({
                el: ".app",
                data() {
                    return {
                        replyNum: 0,//回復文章數
                        articleNum: 0,//發表文章數
                        integral: 0,//獲得積分
                        show: false,
                        birthday: "${SPRING_SECURITY_CONTEXT.authentication.principal.birthday}",
                        level: "${pageContext.request.contextPath}/images/青銅.png"
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/member/mypage',
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.articleNum = response.articleNum;
                            this.replyNum = response.replyNum;
                            this.integral = response.integral;
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });

                    if (this.integral >= 90000) {
                        this.level = '${pageContext.request.contextPath}/images/傳奇.png';
                    } else if (this.integral >= 30000) {
                        this.level = '${pageContext.request.contextPath}/images/鉑金.png';
                    } else if (this.integral >= 10000) {
                        this.level = '${pageContext.request.contextPath}/images/黃金.png';
                    } else if (this.integral >= 1000) {
                        this.level = '${pageContext.request.contextPath}/images/白銀.png';
                    }

                },
                mounted() {
                    this.show = true
                },
                methods: {
                    revise() {
                        var data = new FormData(document.getElementById("reviseForm"));
                        console.log(data.get("name"));
                        $.ajax({
                            url: '${pageContext.request.contextPath}/member/revise',
                            type: 'POST',
                            data: data,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: response => {
                                this.$message.success("修改成功");
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    }
                },
            })
            $("input[name='birthday']").addClass("form-control");
            if (permit.indexOf("1") > 0) {
                $("#reSend").hide();
            } 
        </script>
        <style>
            .el-date-editor.el-input {
                width: 100%;
            }

            a {
                text-decoration: none;
            }
        </style>

        </html>