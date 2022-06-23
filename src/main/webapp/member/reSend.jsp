<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>重寄認證信</title>
        <!-- 禁止SEO -->
        <meta name="robots" content="noindex">
        <!-- 我不是機器人 -->
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>

    <body>
        <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
        <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>重寄認證信</h1>
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
                <div class="col-lg-3 "></div>
                <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                    <br>
                    <form action="${pageContext.request.contextPath}/reSend" method="post">
                        <div class="mb-3">
                            <label for="exampleFormControlInput1"
                                class='form-label ${empty error.email  ? "":"red" }'>電子郵件 <span
                                    style="color: red;">${errors.email}
                                </span> </label>
                            <input type="email" class="form-control ${empty errors.email  ? '':' is-error' }"
                                id="username" name="email" value="${email}">
                        </div>
                        <p style="color: #AAA;">*請填寫您申請帳號時所用的電子郵件,我們會重寄認證信到該信箱</p>
                        <br><br>
                        <div style="position: relative;">
                            <div class="g-recaptcha " style="width: 304px;display: inline-block;  "
                                data-sitekey="6Ldhf4kgAAAAAN2ExQc-EBZROSpa2xoA69Z2TPrJ"></div>
                            <button style="position: absolute;bottom: 0%; right: 0%;"
                                class="btn btn-primary   ">登入</button>
                        </div>
                        <p style="color: red;">${errors.recaptcha}</p>
                        <p style="color: red;">${errors.level}</p>
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