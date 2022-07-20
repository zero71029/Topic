<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <!-- bootstrap的CSS、JS樣式放這裡 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/icons/bootstrap-icons.css">
        <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->



        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid " style="position: relative;">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">首頁</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=sensor">感測器</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=apparatus">儀器儀表</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=Netcom">網通裝置</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=software">軟體配件</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=controlbox">控制箱</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist.jsp?nav=application">應用</a>
                        </li>
                        <c:if test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                            <c:if test="${pageContext.request.requestURI == '/topic/topiclist.jsp'}">
                                <li class="nav-item" style="background-color: blue;border-radius: 4px;" id="publish">
                                    <a class="nav-link" style="color: white;"
                                        href="${pageContext.request.contextPath}/article/publish.jsp?nav=${param.nav}">
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
                        <a href="${pageContext.request.contextPath}/member/register.jsp">註冊</a>/ <a
                            href="${pageContext.request.contextPath}/member/login.jsp">登入</a>
                    </c:if>
                    <c:if test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-expanded="false"><i class="bi bi-person-circle" style="font-size: 28px;"></i></a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item"
                                        href="${pageContext.request.contextPath}/member/mypage.jsp">我的頁面</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">登出</a>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </nav>
        <c:if test='${not empty SPRING_SECURITY_CONTEXT.authentication.principal}'>
            <script>
                const permit ='${SPRING_SECURITY_CONTEXT.authentication.principal.authorities}' 
                if(permit.indexOf("1") < 0){                 
                    $("#publish").hide();
                }
            </script>
        </c:if>