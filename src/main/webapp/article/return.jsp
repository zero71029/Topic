<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>會員登入</title>
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
                        <h1>登入頁面</h1>
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
                    <div class="col-lg-2 "></div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                        <h2>文章回報</h2>
                        <form action="${pageContext.request.contextPath}/article/saveReturn" method="post"
                            id="returnform" style="font-size: 20px;">
                            <input type="hidden" name="articleid" value="${articleid}">
                            <input type="hidden" name="replyid" value="${replyid}">
                            <input type="hidden" name="memberid" value="${article.memberid}">
                            <input type="hidden" name="membername" value="${article.membername}">
                            <div>
                                <label
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    文章標題</label>
                                <div style="display: table-cell;">${article.name}</div>
                            </div><br>
                            <div>
                                <label
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    文章作者</label>
                                <div style="display: table-cell;">${article.membername}</div>
                            </div><br>
                            <div>
                                <label
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    文章時間</label>
                                <div style="display: table-cell;">${article.createtime}</div>
                            </div><br>
                            <div>
                                <label
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    回報類型</label>
                                <div style="display: table-cell;" id="returntype">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox1"
                                            name="returntype" value="其他事項">
                                        <label class="form-check-label" for="inlineCheckbox1">其他事項
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox2"
                                            name="returntype" value="內容重複">
                                        <label class="form-check-label" for="inlineCheckbox2">內容重複</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox3"
                                            name="returntype" value="文章違規">
                                        <label class="form-check-label" for="inlineCheckbox3">文章違規</label>
                                    </div>
                                </div>
                            </div><br>
                            <div>
                                <label
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    回報訊息</label>
                                <div style="display: table-cell;">
                                    <textarea class="form-control" name="content" style="width: 500px;height: 200px;"
                                        maxlength="900"></textarea>
                                </div>
                            </div><br>
                            <div>
                                <div class="g-recaptcha " style="width: 304px; display: inline-block;"
                                    data-sitekey="6Ldhf4kgAAAAAN2ExQc-EBZROSpa2xoA69Z2TPrJ"></div>
                                <button type="button" class="btn btn-primary btn-lg" style="float: right;"
                                    onclick="submitReturn()">送出</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </body>
        <script>
            function submitReturn() {
                isok = true;
                console.log("ddddddddddddddddddddddddddddddddddddd");
                console.log($("input[name='returntype']:checked").val());
                if (typeof ($("input[name='returntype']:checked").val()) == "undefined") {
                    isok = false;
                    $("#returntype").css("border", "red 1px solid");
                } else {
                    $("#returntype").css("#000", "red 0px solid");
                }


                const formData = new FormData(document.getElementById("returnform"));
                const recap = formData.get("g-recaptcha-response");
                if (recap.length > 0) {
                    $(".g-recaptcha").css("border", "1px solid #ced4da");
                } else {
                    isok = false;
                    $(".g-recaptcha").css("border", "1px red solid");
                }

                if (isok) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/recaptcha',
                        type: 'post',
                        data: recap,
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            if (response) {
                                $("#returnform").submit();

                            } else {
                                this.$message.error('檢查錯誤');
                            }
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                } else {
                    alert("類型需填選")
                }



            }






        </script>

        </html>