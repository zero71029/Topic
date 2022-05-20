<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <!-- session 檢查-->
        <c:if test='${empty member}'>
            <script>
                console.log("未登入");
                $.ajax({
                    url: '${pageContext.request.contextPath}/UserAuthorize',
                    type: 'POST',
                    success: function (haveSession) {
                        if (haveSession) {
                            console.log("有登入");
                            location.reload();
                        } else {

                            console.log("沒有認證");
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            </script>
        </c:if>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">首頁</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active"
                                href="${pageContext.request.contextPath}/topiclist?nav=sensor&pag=1">感測器</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist?nav=apparatus&pag=1">儀器儀表</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist?nav=Netcom&pag=1">網通裝置</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist?nav=software&pag=1">軟體配件</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist?nav=controlbox&pag=1">控制箱</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/topiclist?nav=application&pag=1">應用</a>
                        </li>

                    </ul>
                    <form class="d-flex">
                        <input class="form-control me-2" type="search" placeholder="Search">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                    &nbsp;&nbsp;&nbsp;

                    <c:if test="${member == null}">
                        <a href="${pageContext.request.contextPath}/member/register.jsp">註冊</a>/ <a
                            href="${pageContext.request.contextPath}/member/login.jsp">登入</a>
                    </c:if>
                    <c:if test="${member != null}">
                        <a href=""><i class="bi bi-person-lines-fill"></i>${member.name}</a> / <a
                            href="${pageContext.request.contextPath}/logout">登出</a>
                    </c:if>

                </div>
            </div>
        </nav>