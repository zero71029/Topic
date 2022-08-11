<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <% String url=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath(); %>
            <!DOCTYPE html>
            <html lang="zh-TW">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${article.name}</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/init.css">
                <!-- 引入 vue-->
                <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
                <!-- 引入element-ui样式 -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
                <!-- 引入element-ui组件库 -->
                <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
                <script src="${pageContext.request.contextPath}/js/zh-TW.js"></script>
                <!-- 廣告 -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/advertise.css">
                <meta property="og:locale" content="zh_TW">
                <meta property="og:type" content="website" />
                <meta property="og:title" content="${article.name}" />
                <meta property="og:image" content="${pageContext.request.contextPath}/images/share-banner.png" />


            </head>

            <body>
                <style>
                    [v-cloak] {
                        display: none;
                    }

                    span a {
                        color: #000;
                        text-decoration: none;
                    }

                    span .icon:hover,
                    span a .icon:hover {
                        cursor: pointer;
                        color: #0d6efd;

                    }

                    .thumbsup {
                        color: #0d6efd;
                    }

                    @media (max-width:990px) {
                        .scenery {
                            display: none;
                        }
                    }
                </style>
                <div class="container-fluid ">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <h1>久德討論版</h1>
                        </div>
                    </div>
                    <div class="row">
                        <!-- <%-- 傘型特效--%> -->
                        <jsp:include page="/widget/umbrella.jsp"></jsp:include>
                        <!-- <%-- 插入抬頭分類 JQ--%> -->
                        <!-- <%-- 插入抬頭分類 JQ--%> -->
                        <jsp:include page="/widget/menu.jsp"></jsp:include>
                        <!-- <%-- 右邊工具列--%> -->
                        <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                    </div>
                    <div class="row app">
                        <!-- 彈窗 -->
                        <el-dialog title="分享" :visible.sync="dialogVisible" width="30%" v-cloak>
                            <a href="https://social-plugins.line.me/lineit/share?url=<%=url%>/detail/${article.articleid}"
                                target="_blank">
                                <img src="${pageContext.request.contextPath}/images/lint-small.png" alt="line">
                            </a>
                            &nbsp;
                            <a href="https://www.facebook.com/sharer.php?u=<%=url%>/detail/${article.articleid}&quote=${article.name}"
                                target="_blank">
                                <img src="${pageContext.request.contextPath}/images/FB.png" />
                            </a>&nbsp;
                            <a href="mailto:?subject:${article.name}＆body=<a href='<%=url%>/detail/${article.articleid}'>${article.name}</a>"
                                target="_blank">
                                <img src="${pageContext.request.contextPath}/images/Mail.png" />
                            </a>&nbsp;
                            <a href
                                onclick="event.preventDefault();navigator.clipboard.writeText(window.location.href).then(() => alert('複製網址'));"
                                target="_blank">
                                <div class="text-center"
                                    style="vertical-align: middle;display:inline-block ;   border-radius: 50px; height: 59px;width: 59px; background-color: #816b5b;font-size:40px;line-height: 59px;color: #fff;">
                                    <i class="bi bi-link-45deg"></i>
                                </div>
                            </a>
                            <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="dialogVisible = false">取 消</el-button>
                            </span>
                        </el-dialog>
                        <!--  -->
                        <div class="col-lg-12 " v-cloak>
                            <div class="row">
                                <div class="col-lg-2 scenery">
                                </div>
                                <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                                    <br><br>
                                    <div class="row ">
                                        <!-- 中間主體 -->
                                        <div class="col-lg-10">
                                            <div class="row ">
                                                <c:if
                                                    test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                                                    <p style="text-align: right;"> <button type="button"
                                                            class="btn btn-success reply"
                                                            @click="clickReply">回覆</button>
                                                    </p>
                                                </c:if>
                                                <div class="col-lg-3 text-center">
                                                    <span
                                                        style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">樓主</span><br>
                                                    <span style="color: #379cf4;">${article.membername} </span><br>
                                                    積分:${article.member.integral}
                                                    <br>
                                                    <!-- <div class="fb-share-button"
                                                        data-href="https://www.your-domain.com/your-page.html"
                                                        data-layout="button_count">
                                                    </div> -->
                                                    <img :src="level" style="width: 60px;">

                                                </div>
                                                <!-- 主文 -->
                                                <div class="col-lg-9 ">
                                                    <div class="row">
                                                        <div class="col-lg-12 text-break">
                                                            <h3 id="articlename">${article.name}</h3>
                                                            <p>${article.createtime}
                                                                <span style="float: right;">
                                                                    <c:if
                                                                        test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                                                                        <i class="bi bi-hand-thumbs-up icon  main"
                                                                            @click="clickThumbsup">讚
                                                                            {{thumbsupNum}}
                                                                        </i>
                                                                        &nbsp; | &nbsp;

                                                                    </c:if>
                                                                    <c:if
                                                                        test="${article.memberid == SPRING_SECURITY_CONTEXT.authentication.principal.memberid}">
                                                                        <a
                                                                            href="${pageContext.request.contextPath}/article/publish.jsp?nav=${article.articlegroup}&id=${article.articleid}"><i
                                                                                class="bi bi-pencil-square">修改</i></a>
                                                                        &nbsp;|
                                                                    </c:if>
                                                                    &nbsp;
                                                                    <el-dropdown @command="handleCommand">
                                                                        <span class="el-dropdown-link">
                                                                            <!-- 下拉 -->
                                                                            <i class="el-icon-s-tools"
                                                                                style="font-size: 18px;"></i>
                                                                        </span>
                                                                        <el-dropdown-menu slot="dropdown">
                                                                            <el-dropdown-item command='a'>
                                                                                <i
                                                                                    class="bi bi-share icon share">&nbsp;分享</i>
                                                                            </el-dropdown-item>
                                                                            <el-dropdown-item
                                                                                command="articleReturn/${article.articleid}">
                                                                                <i
                                                                                    class="bi bi-exclamation-circle">&nbsp;回報</i>
                                                                            </el-dropdown-item>
                                                                        </el-dropdown-menu>
                                                                    </el-dropdown>
                                                                </span>
                                                            </p>
                                                            <hr>
                                                            <div id="content" style="min-height: 150px;">
                                                                ${article_content.content}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 回覆 -->
                                            <div v-for="(s, index) in replylist" :key="index">
                                                <div class="row">
                                                    <div class="col-lg-12 text-center">
                                                        <hr>
                                                    </div>
                                                </div>
                                                <div class="row ">
                                                    <div class="col-lg-3 text-center">
                                                        <span
                                                            style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">{{s.floor}}樓</span><br>
                                                        <span style="color: #379cf4;">{{s.membername}}</span><br>
                                                        積分:{{s.member.integral}} <br>

                                                        <img :src="s.level" style="width: 60px;">

                                                    </div>
                                                    <div class="col-lg-9 ">
                                                        <div class="row" :id="s.replyid">
                                                            <div class="col-lg-12 text-break" v-html="s.content"
                                                                style="min-height: 100px;"></div>

                                                            <p>{{s.createtime}}<span style="float: right;">
                                                                    <c:if
                                                                        test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                                                                        <i :class="[handthumbs,{thumbsup:s.isthumbs},s.replyid]"
                                                                            @click="replyClickThumbsup(s)">讚
                                                                            {{s.thumbsupNum}}</i>
                                                                        &nbsp; | &nbsp;
                                                                        <i @click="message(s)"
                                                                            class="bi bi-chat-text icon message">留言</i>
                                                                        <span class="message">&nbsp; | &nbsp;</span>

                                                                    </c:if>

                                                                    <a v-show="'${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}' == s.memberid"
                                                                        :href="'${pageContext.request.contextPath}/revise-reply/'+s.replyid"><i
                                                                            class="bi bi-pencil-square">修改</i></a>
                                                                    <span
                                                                        v-show="'${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}' == s.memberid">
                                                                        &nbsp; |
                                                                    </span>

                                                                    &nbsp;
                                                                    <el-dropdown @command="handleCommand">
                                                                        <span class="el-dropdown-link">
                                                                            <!-- 下拉 -->
                                                                            <i class="el-icon-s-tools"
                                                                                style="font-size: 18px;"></i>
                                                                        </span>
                                                                        <el-dropdown-menu slot="dropdown">
                                                                            <el-dropdown-item command='a'>
                                                                                <i class="bi bi-share icon share">
                                                                                    &nbsp;分享
                                                                                </i>
                                                                            </el-dropdown-item>
                                                                            <el-dropdown-item
                                                                                :command="'replyReturn/'+s.replyid">
                                                                                <i class="bi bi-exclamation-circle">
                                                                                    回報
                                                                                </i>
                                                                            </el-dropdown-item>
                                                                        </el-dropdown-menu>
                                                                    </el-dropdown>
                                                                </span>
                                                            </p>
                                                        </div>
                                                        <div class="row align-items-center" style="height: 50px;"
                                                            v-show="s.see">
                                                            <div class="col-lg-10" style="padding: 0px;">
                                                                <el-input type="text" placeholder="請輸入内容"
                                                                    maxlength="100" v-model="text" show-word-limit>
                                                                </el-input>
                                                            </div>
                                                            <div class="col-lg-2" style="padding: 0px;">
                                                                <button type="button" style="width: 100%;"
                                                                    @click="savemessage(s)" class="btn btn-secondary">留言
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <div class="row" v-for="(r, index) in s.replylist" :key="index">
                                                            <div class="col-lg-2 ">
                                                                {{r.membername}}
                                                            </div>
                                                            <div class="col-lg-7 text-break">
                                                                {{r.content}}
                                                            </div>
                                                            <div class="col-lg-3 text-end">{{r.createtime}}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${not empty SPRING_SECURITY_CONTEXT.authentication.principal}">
                                                <p style="text-align: right;"> <button type="button"
                                                        class="btn btn-success reply" @click="clickReply">回覆</button>
                                                </p>
                                            </c:if>
                                            <!-- 分頁 -->
                                            <p style="text-align: center;">

                                                <el-pagination @current-change="handleCurrentChange"
                                                    :current-page="currentPage" page-size="10"
                                                    layout="  prev, pager, next, jumper" :total="total">
                                                </el-pagination>
                                            </p>
                                        </div>
                                        <!-- 右邊廣告 -->
                                        <div class="col-lg-2">
                                            <jsp:include page="/widget/advertise.jsp"></jsp:include>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-2 scenery">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
            <script>
                // SEO
                var aaa = document.createElement("meta");
                aaa.setAttribute("property", "og:type");
                aaa.content = location.href;
                document.head.appendChild(aaa);
                var description = document.createElement("meta");
                description.setAttribute("property", "og:description");
                description.content = $("#content").text();
                document.head.appendChild(description);
            </script>

            </html>


            <script>
                console.log("user","${SPRING_SECURITY_CONTEXT.authentication.principal.name}");
                var id = '${article.articleid}';
                var vm = new Vue({
                    el: ".app",
                    data() {
                        return {
                            currentPage: 1,
                            total: 15,

                            dialogVisible: false,
                            thumbsupNum: 0,
                            hasThumbsup: false,
                            reply: [],
                            replylist: [],
                            handthumbs: "bi bi-hand-thumbs-up icon",
                            text: "",
                            integral: '${article.member.integral}',
                            rigthAdvertise: [],

                            level: "${pageContext.request.contextPath}/images/小青銅.svg",
                        }
                    },
                    created() {
                        const url = new URL(location.href);
                        var p = url.searchParams.get("p");
                        if (p == null) p = 1;
                        this.currentPage = p;
                        $.ajax({
                            url: '${pageContext.request.contextPath}/article/detailInit/${article.articleid}?p=' + p,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.thumbsupNum = response.thumbsupNum;
                                this.hasThumbsup = response.hasThumbsup;
                                this.replylist = response.replylist;
                                this.total = response.total;
                                this.total++;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });


                        if (this.integral >= 90000) {
                            this.level = '${pageContext.request.contextPath}/images/小傳奇.svg';
                        } else if (this.integral >= 30000) {
                            this.level = '${pageContext.request.contextPath}/images/小鉑金.svg';
                        } else if (this.integral >= 10000) {
                            this.level = '${pageContext.request.contextPath}/images/小黃金.svg';
                        } else if (this.integral >= 1000) {
                            this.level = '${pageContext.request.contextPath}/images/小白銀.svg';
                        }

                        //判斷 瀏覽者是否點讚(回覆)
                        this.replylist.forEach(reply => {
                            if (reply.state == "封鎖") {
                                reply.content = "因違反版規，此條回覆已被封鎖";
                                reply.replylist = [];
                            }
                            reply.thumbsupNum = reply.thumbsuplist.length;
                            reply.see = false;
                            reply.thumbsuplist.forEach(e => {
                                if (e.memberid == '${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}') {
                                    reply.isthumbs = true;
                                }
                            })
                            reply.level = '${pageContext.request.contextPath}/images/小青銅.svg';
                            if (reply.member.integral >= 90000) {
                                reply.level = '${pageContext.request.contextPath}/images/小傳奇.svg';
                            } else if (reply.member.integral >= 30000) {
                                reply.level = '${pageContext.request.contextPath}/images/小鉑金.svg';
                            } else if (reply.member.integral >= 10000) {
                                reply.level = '${pageContext.request.contextPath}/images/小黃金.svg';
                            } else if (reply.member.integral >= 1000) {
                                reply.level = '${pageContext.request.contextPath}/images/小白銀.svg';
                            }
                        });
                        if (this.hasThumbsup) {
                            $(".main").css("color", "#0d6efd")
                        }
                        $.ajax({
                            url: '${pageContext.request.contextPath}/topic/advertiseinit?location=右',
                            type: 'get',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.rigthAdvertise = response;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }, mounted() {

                    },
                    methods: {
                        //下拉工具
                        handleCommand(command) {
                            this.$message('click on item ' + command);
                            if (command == "a") {
                                this.dialogVisible = true
                            } else {
                                location.href = "${pageContext.request.contextPath}/article/" + command;
                            }
                        },

                        response(location, replyid) {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/article/' + location + '/' + replyid,
                                type: 'POST',
                                success: (boo) => {
                                    if (boo) {
                                        replyBean.isthumbs = true;
                                        replyBean.thumbsupNum++;
                                        this.$forceUpdate();
                                    } else {
                                        replyBean.isthumbs = false;
                                        replyBean.thumbsupNum--;
                                        this.$forceUpdate();
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        },
                        //回覆文章點讚
                        replyClickThumbsup(replyBean) {
                            if ('${SPRING_SECURITY_CONTEXT.authentication.principal.name}' == '') {
                                window.open("${pageContext.request.contextPath}/member/login.jsp");
                            } else {
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/article/thumbsup/' + replyBean.replyid,
                                    type: 'POST',
                                    success: (boo) => {
                                        if (boo) {
                                            replyBean.isthumbs = true;
                                            replyBean.thumbsupNum++;
                                            this.$forceUpdate();
                                        } else {
                                            replyBean.isthumbs = false;
                                            replyBean.thumbsupNum--;
                                            this.$forceUpdate();
                                        }
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
                            }
                        },
                        //主文章點讚
                        clickThumbsup() {
                            if ('${SPRING_SECURITY_CONTEXT.authentication.principal.name}' == '') {
                                window.open("${pageContext.request.contextPath}/member/login.jsp");
                            } else {
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/article/thumbsup/' + id,
                                    type: 'POST',
                                    success: (boo) => {
                                        if (boo) {
                                            $(".main").css("color", "#0d6efd");
                                            this.$message('點讚成功');
                                            this.thumbsupNum++;
                                        } else {
                                            $(".main").css("color", "black");
                                            this.$message('取消點讚');
                                            this.thumbsupNum--;
                                        }
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
                            }
                        },
                        //點留言
                        message(reply) {
                            this.text = "";
                            const b = reply.see;
                            this.replylist.forEach(e => {
                                e.see = false;
                            })
                            if (b) {
                                reply.see = false;
                            } else {
                                reply.see = true;
                            }
                            this.$forceUpdate();
                        },
                        savemessage(reply) {
                            if (this.text.trim() != "") {
                                var data = new FormData();
                                data.append("articleid", reply.replyid);
                                data.append("memberid", "${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}");
                                data.append("membername", "${SPRING_SECURITY_CONTEXT.authentication.principal.name}");
                                data.append("content", this.text);
                                data.append("article", id);
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/article/savemessage?p=' + this.currentPage,
                                    type: 'POST',
                                    data: data,
                                    async: false,
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    success: (response) => {
                                        console.log(response);
                                        this.replylist = response.list;
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
                                //判斷 瀏覽者是否點讚
                                this.replylist.forEach(reply => {
                                    reply.thumbsupNum = reply.thumbsuplist.length;
                                    reply.see = false;
                                    reply.thumbsuplist.forEach(e => {
                                        if (e.memberid == '${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}') {
                                            reply.isthumbs = true;
                                        }
                                    })
                                });
                                this.$forceUpdate();
                            }
                        },
                        clickReply() {
                            if ('${SPRING_SECURITY_CONTEXT.authentication.principal.name}' == '') {
                                window.open("${pageContext.request.contextPath}/member/login.jsp");
                            } else {
                                location.href = '${pageContext.request.contextPath}/reply/${article.articleid}';
                            }
                        },
                        login() {
                            let data = new FormData(document.querySelector("#loginform"));
                            console.log(data);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/login',
                                type: 'POST',
                                data: data,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: (response) => {
                                    location.reload()
                                },
                                error: (returndata) => {
                                    this.$message.error('電子郵件或密碼錯誤');
                                }
                            });
                        },
                        //分頁
                        handleCurrentChange(val) {
                            location.href = "${pageContext.request.contextPath}/detail/${article.articleid}?p=" + val
                        }
                    },
                })
                if (permit.indexOf("1") < 0) {
                    $(".message").hide();
                    $(".reply").hide();
                } 
            </script>