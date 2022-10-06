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
                                        <div class="col-lg-3 text-center" style="padding-top: 13px;">
                                            <a href="${pageContext.request.contextPath}/system/level.jsp">
                                                <img 
                                                    :src="level" alt="line" style="width: 100px;">
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center" style="padding-top: 13px;">
                                            <a href="${pageContext.request.contextPath}/member/myArticle.jsp">
                                                <img src="${pageContext.request.contextPath}/images/myArticle.svg" style="width: 80px; margin-bottom: 10px;">

                                                
                                               <br>
                                                <span style="font-size: 20px;">發表文章</span><br>
                                                <span style="font-size: 20px;"><b>{{articleNum}}</b></span>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center" style="padding-top: 13px;">
                                            <a href="${pageContext.request.contextPath}/member/myReply.jsp">
                                                <img src="${pageContext.request.contextPath}/images/myReply.svg" style="width: 80px;margin-bottom: 10px;">
                                               <br>
                                                <span style="font-size: 20px;">回覆文章</span><br>
                                                <span style="font-size: 20px;"><b>{{replyNum}}</b></span>
                                            </a>
                                        </div>
                                        <div class="col-lg-3 text-center" style="padding-top: 13px;">
                                            <img src="${pageContext.request.contextPath}/images/trophy.svg" style="width: 80px;margin-bottom: 10px;">
                                            
                                            <br>
                                            <span style="font-size: 20px;">獲得積分</span><br>
                                            <span style="font-size: 20px;"><b>{{bean.integral}}</b></span>
                                        </div>
                                    </div>
                                    <br>
                                    <p
                                        style="font-size: 30px; border-left: 10px solid #555; border-bottom: 1px solid #555;">
                                        &nbsp; 個人資料</p>

                                    <form action="" method="post" id="reviseForm">
                                        
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label" >暱稱</label>
                                            <input type="text" class="form-control" name="name" v-model="bean.name" disabled>
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">組資單位</label>
                                            <input type="text" class="form-control" name="company"
                                                v-model.trim="bean.company">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">Email</label>
                                            <input type="email" class="form-control" name="email"
                                                v-model="bean.email" disabled>
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">連絡電話</label>
                                            <input type="text" class="form-control" name="phone"
                                                v-model.trim="bean.phone">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">聯絡地址</label>
                                            <input type="text" class="form-control" name="address"
                                                v-model.trim="bean.address">
                                        </div>
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">生日</label>
                                            <el-date-picker v-model="birthday" type="date" placeholder="選擇日期"
                                                format="yyyy 年 MM 月 dd 日" value-format="yyyy 年 MM 月 dd 日"
                                                name="birthday">
                                            </el-date-picker>
                                            <!-- 
                                            <input type="text" class="form-control" name="birthday"
                                                v-model="bean.birthday}"> -->
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
            const contextPath = "${pageContext.request.contextPath}";
            const birthday ="${SPRING_SECURITY_CONTEXT.authentication.principal.birthday}";        
        </script>
        <script src="${pageContext.request.contextPath}/js/member/mypage.js"></script>
        <style>
            .el-date-editor.el-input {
                width: 100%;
            }
            a {
                text-decoration: none;
            }
        </style>

        </html>