<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>密碼重置</title>
        <!-- 禁止SEO -->
        <meta name="robots" content="noindex">
        <!-- 引入样式 vue-->
        <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
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
                    <h1>密碼重置</h1>
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
                <div class="col-lg-3 "></div>
                <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                    <br>
                    <form id="resetform" action="${pageContext.request.contextPath}/reset" method="post"
                        style="position: relative;">
                        <input type="hidden" name="id" v-model="id">
                        <div class="mb-3">
                            <label class="form-label">登入密碼 <span style="color: red;">*</span> </label>
                            <input type="password" class="form-control" name="password" id="password"
                                v-model.trim="password" @input="inChange">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">密碼驗證</label>
                            <input type="password" class="form-control" :class="{ 'is-error':iserror} "
                                name="repassword" id="repassword" v-model.trim="rePassword" @input="inChange">
                        </div>
                        <span style="color: red;" v-text="msg"></span>
                        <button style="float: right;" class="btn btn-primary " :disabled="isDisabl" type="button"
                            @click="submitform">送出</button>
                    </form>
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
        const url = new URL(location.href);
        const id = url.searchParams.get("id");
        const vm = new Vue({
            el: ".app",
            data() {
                return {
                    password: "",
                    rePassword: "",
                    isDisabl: true,
                    msg: "",
                    iserror: false,
                    id: id,
                }
            },
            methods: {
                inChange() {
                    if (this.password != this.rePassword) {
                        this.isDisabl = true;
                        this.msg = "密碼需相同";
                        this.iserror = true;
                    } else {
                        this.isDisabl = false;
                        this.msg = "";
                        this.iserror = false;
                    }
                    if (this.rePassword == "") {
                        this.isDisabl = true;
                        this.iserror = true;
                    }
                },
                submitform() {
                    var formdata = new FormData(document.getElementById('resetform'));
                    $.ajax({
                        url: '${pageContext.request.contextPath}/reset',
                        type: 'POST',
                        data: formdata,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: response => {
                            alert(response);
                            location.href = '${pageContext.request.contextPath}/member/login.jsp'
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
        .red {
            color: red;
        }

        .is-error {
            border: 1px solid #ef4f4f;
            background-color: #ffdbdb;
        }
    </style>

    </html>