<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>認證</title>
        <!-- 禁止SEO -->
        <meta name="robots" content="noindex">
    </head>

    <body>
        <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
        <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>認證</h1>
                </div>
            </div>
            <!-- 抬頭分類 -->
            <div class="row">
                <!-- <%-- 插入抬頭分類 JQ--%> -->
                <jsp:include page="/widget/menu.jsp"></jsp:include>
                <!-- <%-- 右邊工具列--%> -->
                <jsp:include page="/widget/rightTool.jsp"></jsp:include>
            </div>
            <!-- 中間主體 -->
            <div class="row">
                <div class="col-lg-12 " style="background-color: white; --bs-bg-opacity: 1;">
                    <c:if test="${empty var1}"></c:if>
                    <c:if test="${not empty message}">
                        <!-- 成功畫面 -->
                        <div class="row ">
                            <div class="col-lg-2 "></div>
                            <div class="col-lg-4 ">
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div class="row ">
                                    <div class="col-lg-2 "></div>
                                    <div class="col-lg-10 ">
                                        <img src="${pageContext.request.contextPath}/images/page-08.png"
                                            style="max-width: 100%; text-align: center;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <img src="${pageContext.request.contextPath}/images/page-09.png"
                                    style="max-width: 90%;"><br><br>
                                <div class="row" style="font-size:35px;line-height: 50px;font-weight:bold">${message}
                                </div>

                                <div style="font-size: 18px;color: #333;line-height:40px">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/index" tabindex="-1">首頁</a></li>
                                        <li><a href="${pageContext.request.contextPath}/topiclist.jsp?nav=sensor" tabindex="-1">感測器</a></li>
                                        <li><a href="${pageContext.request.contextPath}/topiclist.jsp?nav=apparatus" tabindex="-1">儀器儀表</a></li>
                                        <li><a href="${pageContext.request.contextPath}/topiclist.jsp?nav=Netcom" tabindex="-1">網通裝置</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <!-- 失敗畫面 -->
                        <div class="row ">
                            <div class="col-lg-1 "></div>
                            <div class="col-lg-5 ">
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div class="row ">
                                    <div class="col-lg-3 "></div>
                                    <div class="col-lg-8 ">
                                        <img src="${pageContext.request.contextPath}/images/page-04.png"
                                            style="max-width: 100%; text-align: center;">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5">
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <div>&nbsp;</div>
                                <img src="${pageContext.request.contextPath}/images/page-03.png"
                                    style="width:  400px;"><br><br>
                                <div class="row" style="font-size:35px;line-height: 50px;font-weight:bold">${error}
                                </div>
                                <div class="row" style="font-size: 20px;color: #333;line-height:40px">
                                    <p>下面的連結可能對你有幫助:</p>
                                </div>
                                <div style="font-size: 18px;color: #333;line-height:40px">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/member/reSend.jsp"
                                                tabindex="-1">重寄認證信</a></li>
                                        <li><a href="${pageContext.request.contextPath}/index" tabindex="-1">首頁</a></li>
                                        <li><a href="${pageContext.request.contextPath}/member/login.jsp"
                                                tabindex="-1">登入</a></li>
                                        <li><a href="${pageContext.request.contextPath}/member/register.jsp"
                                                tabindex="-1">註冊</a></li>

                                    </ul>
                                </div>
                            </div>
                        </div>

                    </c:if>


                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1></h1>
                </div>
            </div>
        </div>
    </body>

    </html>