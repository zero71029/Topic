function changGrop(e) {
    switch (e) {
        case 'sensor':
            return "感測器";
        case 'apparatus':
            return "儀器儀表";
        case 'Netcom':
            return "網通裝置";
        case 'software':
            return "軟體配件";
        case 'controlbox':
            return "控制箱";
        case 'application':
            return "應用";
        case 'system':
            return "系統";
    }
};
//麵包屑
const navname = document.getElementById("navname");
navname.textContent = changGrop(nav);
navname.href = contextPath+"/topiclist.jsp?nav=" + nav;
//按鈕顏色
if (nav != "system") {
    const e = document.getElementById(nav);
    e.style.background = "#7F7F7F";  
    e.style.borderRadius = "10px";
    document.querySelector("#"+nav+" a").style.color="#fff";  
}

//
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
            integral: integral,
            rigthAdvertise: [],
            level: contextPath + "/images/小青銅.svg",
        }
    },
    created() {

        this.currentPage = p;
        $.ajax({
            url: u,
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
            this.level = contextPath + '/images/小傳奇.svg';
        } else if (this.integral >= 30000) {
            this.level = contextPath + '/images/小鉑金.svg';
        } else if (this.integral >= 10000) {
            this.level = contextPath + '/images/小黃金.svg';
        } else if (this.integral >= 1000) {
            this.level = contextPath + '/images/小白銀.svg';
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
            reply.level = contextPath + '/images/小青銅.svg';
            if (reply.member.integral >= 90000) {
                reply.level = contextPath + '/images/小傳奇.svg';
            } else if (reply.member.integral >= 30000) {
                reply.level = contextPath + '/images/小鉑金.svg';
            } else if (reply.member.integral >= 10000) {
                reply.level = contextPath + '/images/小黃金.svg';
            } else if (reply.member.integral >= 1000) {
                reply.level = contextPath + '/images/小白銀.svg';
            }
        });
        if (this.hasThumbsup) {
            $(".main").css("color", "#0d6efd")
        }
        //廣告                        
        $.ajax({
            url: contextPath + '/topic/advertiseinit?location=右',
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
                location.href = contextPath + "/article/" + command;
            }
        },
        response(location, replyid) {
            $.ajax({
                url: contextPath + '/article/' + location + '/' + replyid,
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
            if (name == '') {
                window.open(contextPath + "/member/login.jsp");
            } else {
                $.ajax({
                    url: contextPath + '/article/thumbsup/' + replyBean.replyid,
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
            if (name == '') {
                window.open(contextPath + "/member/login.jsp");
            } else {
                $.ajax({
                    url: contextPath + '/article/thumbsup/' + id,
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
                data.append("membername", name);
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
                        if (e.memberid == memberid) {
                            reply.isthumbs = true;
                        }
                    })
                });
                this.$forceUpdate();
            }
        },
        clickReply() {
            if (name == '') {
                window.open(contextPath + "/member/login.jsp");
            } else {
                location.href = contextPath + '/reply/' + id;
            }
        },
        login() {
            let data = new FormData(document.querySelector("#loginform"));
            console.log(data);
            $.ajax({
                url: contextPath + '/login',
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
            location.href = contextPath + "/detail/" + id + "?p=" + val
        }

    },
})
if (permit.indexOf("1") < 0) {
    $(".message").hide();
    $(".reply").hide();
}
// SEO
var aaa = document.createElement("meta");
aaa.setAttribute("property", "og:type");
aaa.content = location.href;
document.head.appendChild(aaa);
var description = document.createElement("meta");
description.setAttribute("property", "og:description");
description.content = $("#content").text();
document.head.appendChild(description);