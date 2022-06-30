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
                        <form action="${pageContext.request.contextPath}/article/saveReturn" method="post" style="font-size: 20px;">
                            <input type="hidden" name="articleid" value="${article.articleid}">
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
                                <div style="display: table-cell;">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox1" name="returntype"
                                            value="其他事項">
                                        <label class="form-check-label" for="inlineCheckbox1">其他事項
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox2" name="returntype"
                                            value="內容重複">
                                        <label class="form-check-label" for="inlineCheckbox2">內容重複</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="inlineCheckbox3" name="returntype"
                                            value="文章違規">
                                        <label class="form-check-label" for="inlineCheckbox3">文章違規</label>
                                    </div>
                                </div>
                            </div><br>
                            <div>
                                <label 
                                    style="display: table-cell; width: 150px;text-align: right; padding: 9px 20px 9px 0;">
                                    回報訊息</label>
                                <div style="display: table-cell;">
                                    <textarea class="form-control" name="content"
                                        style="width: 500px;height: 200px;" maxlength="900"></textarea>
                                </div>
                            </div><br>
                            <div style="text-align: right;">
                                <button type="submit" class="btn btn-primary btn-lg">送出</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </body>


        </html>