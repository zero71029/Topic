<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <!-- bootstrap的CSS、JS樣式放這裡 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/icons/bootstrap-icons.css">
        <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
        <style>
            .mask {
                position: fixed;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                overflow: auto;
                margin: 0;
                z-index: 2001;
                background-color: rgba(0, 0, 0, 0.3);
                width: 200vh;
                height: 100vh;
                visibility: hidden;
            }
            .el-dialog {
                position: relative;
                margin: 20vh auto 50px;
                border-radius: 5px;
                -webkit-box-shadow: 0 1px 3px rgb(0 0 0 / 30%);
                box-shadow: 0 1px 3px rgb(0 0 0 / 30%);
                box-sizing: border-box;
                width: 25%;
                min-height: 230px;

            }
        </style>
        <div class="mask">
            <div class="el-dialog row text-center">
                <div style="position: absolute; right: 10px;width: 20px;font-size: 20px;cursor: pointer;"
                    onclick="closeMask()">X</div>

                <p></p>
                <div class="col-lg-12" style="margin-bottom: -20px;">
                    <p style="font-size: 24px;color: #094c88">
                        <img src="${pageContext.request.contextPath}/images/exclamation-03.svg" style="width: 35px;">
                        <strong>尚未登入</strong>
                    </p>
                    <p style="font-size: 24px; color: #8e8e8e;">請先登入久德會員帳號</p>
                </div>

                <div class="col-lg-12">
                    <button
                        style="background-color: #094c88;color: #FFF; border: 0;margin :5%;width: 100px; font-size: 24px;"
                        onclick="javascript:location.href='${pageContext.request.contextPath}/member/login.jsp'">登入</button>
                    <button
                        style="background-color: #3ca767;color: #FFF;border: 0;margin: 5%;width: 100px; font-size: 24px;"
                        onclick="javascript:location.href='${pageContext.request.contextPath}/member/register.jsp'">註冊</button>
                </div>


            </div>
        </div>
        <script>
            function closeMask() {
                document.getElementsByClassName("mask")[0].style.visibility = 'hidden';
            }
            function showMask() {
                document.getElementsByClassName("mask")[0].style.visibility = 'visible';
            }
        </script>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid " style="position: relative;">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">首頁</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item" id="sensor">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=sensor">感測器</a>
                        </li>
                        <li class="nav-item" id="apparatus">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=apparatus">儀器儀表</a>
                        </li>
                        <li class="nav-item" id="Netcom">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=Netcom">網通裝置</a>
                        </li>
                        <li class="nav-item" id="software">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=software">軟體配件</a>
                        </li>
                        <li class="nav-item" id="controlbox">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=controlbox">控制箱</a>
                        </li>
                        <li class="nav-item" id="application">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=application">應用</a>
                        </li>&nbsp;&nbsp;&nbsp;
                        <!-- 有登入 -->
                        <c:if test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                            <li class="nav-item" style="background-color: #074F8F;border-radius: 4px;" id="publish">
                                <a class="nav-link" style="color: white;" rel="nofollow"
                                    href="${pageContext.request.contextPath}/article/publish.jsp?nav=${empty param.nav ?'sensor':param.nav}">
                                    發布文章
                                </a>
                            </li>
                        </c:if>
                        <!-- 沒登入 -->
                        <c:if test='${pageContext.request.requestURI != "/Forum/member/register.jsp"}'>
                            <c:if test="${ empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                                <li class="nav-item" style="background-color: #074F8F;border-radius: 4px;" id="publish">
                                    <a class="nav-link" style="color: white;" rel="nofollow"
                                        href="javascript:showMask()">
                                        發布文章
                                    </a>
                                </li>
                            </c:if>
                        </c:if>

                    </ul>
                    <form class="d-flex" method="get" action="${pageContext.request.contextPath}/search.jsp">
                        <input class="form-control me-2" type="search" placeholder="Search" name="q" maxlength="20">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                    &nbsp;&nbsp;&nbsp;
                    <c:if test="${empty SPRING_SECURITY_CONTEXT.authentication.principal }">
                        <a rel="nofollow" href="${pageContext.request.contextPath}/member/register.jsp">註冊</a>/ <a
                            rel="nofollow" href="${pageContext.request.contextPath}/member/login.jsp">登入</a>
                    </c:if>
                    <c:if test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false"><i class="bi bi-person-circle" style="font-size: 28px;"></i></a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" rel="nofollow"
                                        href="${pageContext.request.contextPath}/member/mypage.jsp">我的頁面</a></li>
                                <li><a rel="nofollow" class="dropdown-item"
                                        href="${pageContext.request.contextPath}/logout">登出</a>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </nav>
        <c:if test='${not empty SPRING_SECURITY_CONTEXT.authentication.principal}'>
            <script>
                var permit = '${SPRING_SECURITY_CONTEXT.authentication.principal.authorities}'
                if (permit.indexOf("1") < 0) {
                    $("#publish").hide();
                }
            </script>
        </c:if>
        <c:if test='${ empty SPRING_SECURITY_CONTEXT.authentication.principal}'>
            <script>
                var permit = '';
            </script>
        </c:if>
        <!-- Google tag (gtag.js) -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-ZWB7Z5GDK3"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() { dataLayer.push(arguments); }
            gtag('js', new Date());

            gtag('config', 'G-ZWB7Z5GDK3');
        </script>