<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${article.name}</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/init.css">
            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <!-- 引入 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="//unpkg.com/element-ui/lib/umd/locale/zh-TW.js"></script>
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

                .bi-chat-text {}
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
                <div class="row app" v-cloak>
                    <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
                        <span>这是一段信息</span>
                        <span slot="footer" class="dialog-footer">
                            <el-button @click="dialogVisible = false">取 消</el-button>
                            <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
                        </span>
                    </el-dialog>
                    <div class="col-lg-12 ">
                        <div class="row">
                            <div class="col-lg-2 scenery">
                            </div>
                            <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                                <br><br>
                                <div class="row ">
                                    <!-- 中間主體 -->
                                    <div class="col-lg-10">
                                        <div class="row ">
                                            <div class="col-lg-3 text-center">
                                                <span
                                                    style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">樓主</span><br>
                                                <span style="color: #379cf4;">${article.membername}</span><br>
                                            </div>
                                            <!-- 主文 -->
                                            <div class="col-lg-9 ">
                                                <div class="row">
                                                    <div class="col-lg-12 ">
                                                        <h3>${article.name}</h3>
                                                        <p>${article.createtime}<span style="float: right;">
                                                                <i class="bi bi-hand-thumbs-up icon  main"
                                                                    @click="clickThumbsup">讚
                                                                    {{thumbsupNum}}</i>
                                                                &nbsp;
                                                                |
                                                                &nbsp;<a
                                                                    href="${pageContext.request.contextPath}/reply/${article.articleid}"><i
                                                                        class="bi bi-chat-left-text">回復</i></a>
                                                                &nbsp; |&nbsp; <i class="bi bi-share icon share"
                                                                    @click="dialogVisible = true">分享</i></span>
                                                        </p>
                                                        <hr>
                                                        ${article.content}
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                        <!-- 回復 -->
                                        <div v-for="(s, index) in replylist" :key="index">
                                            <div class="row">
                                                <div class="col-lg-12 text-center">
                                                    <hr>

                                                </div>
                                            </div>
                                            <div class="row ">
                                                <div class="col-lg-3 text-center">
                                                    <span
                                                        style="margin-top: 5px; line-height: 25px; color: white;background-color: #379cf4; width: 80px;height: 25px;display: inline-block;border-radius: 20px;">{{s.num+1}}樓</span><br>
                                                    <span style="color: #379cf4;">{{s.membername}}</span><br>
                                                </div>
                                                <div class="col-lg-9 ">
                                                    <div class="row">
                                                        <div class="col-lg-12 text-break" v-html="s.content"></div>
                                                        <p>{{s.createtime}}<span style="float: right;">
                                                                <i :class="[handthumbs,{thumbsup:s.isthumbs},s.replyid]"
                                                                    @click="replyClickThumbsup(s)">讚
                                                                    {{s.thumbsupNum}}</i>
                                                                &nbsp; | &nbsp;<i @click="message(s)"
                                                                    class="bi bi-chat-text icon">留言</i>
                                                                &nbsp; |&nbsp; <i class="bi bi-share icon share"
                                                                    @click="dialogVisible = true">分享</i></span>
                                                        </p>
                                                    </div>
                                                    <!-- <div class="row">
                                                        <div class="col-lg-12 " >
                                                            {{s}}
                                                        </div>
                                                    </div> -->
                                                    <div class="row align-items-center" style="height: 50px;"
                                                        v-show="s.see">
                                                        <div class="col-lg-10" style="padding: 0px;">
                                                            <el-input type="text" placeholder="請輸入内容" maxlength="100"
                                                                v-model="text" show-word-limit></el-input>
                                                        </div>
                                                        <div class="col-lg-2" style="padding: 0px;">
                                                            <button type="button" style="width: 100%;"
                                                                @click="savemessage(s)"
                                                                class="btn btn-secondary">留言</button>
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
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <hr>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <hr>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <hr>
                    </div>
                </div>
            </div>
        </body>

        </html>


        <script>
            const url = new URL(location.href);
            const id = url.searchParams.get("id");
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        dialogVisible: false,
                        thumbsupNum: 0,
                        hasThumbsup: false,
                        replylist: [

                        ],
                        handthumbs: "bi bi-hand-thumbs-up icon",
                        text: "",
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/article/detailInit/' + id,
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.thumbsupNum = response.thumbsupNum;
                            this.hasThumbsup = response.hasThumbsup;
                            this.replylist = response.replylist;
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
                            if (e.memberid == '${member.memberid}') {
                                reply.isthumbs = true;
                            }
                        })
                    });
                    if (this.hasThumbsup) {
                        $(".main").css("color", "#0d6efd")
                    }



                }, mounted() {

                },
                methods: {
                    //回復文章點讚
                    replyClickThumbsup(replyBean) {
                        console.log(replyBean);
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

                    },
                    //主文章點讚
                    clickThumbsup() {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/article/thumbsup/' + id,
                            type: 'POST',
                            success: (boo) => {
                                if (boo) {
                                    $(".main").css("color", "#0d6efd");
                                    this.thumbsupNum++;
                                } else {
                                    $(".main").css("color", "black");
                                    this.thumbsupNum--;
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
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
                            data.append("memberid", "${member.memberid}");
                            data.append("membername", "${member.name}");
                            data.append("content", this.text);
                            data.append("article", id);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/article/savemessage',
                                type: 'POST',
                                data: data,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: (response) => {
                                    console.log(response);
                                    this.replylist = response;
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
                                    if (e.memberid == '${member.memberid}') {
                                        reply.isthumbs = true;
                                    }
                                })
                            });

                            this.$forceUpdate();




                        }



                    }

                },
            })
        </script>