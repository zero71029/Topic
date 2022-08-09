<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>

            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>發布文章</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/init.css">
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">
            <!-- 我不是機器人 -->
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="//unpkg.com/element-ui/lib/umd/locale/zh-TW.js"></script>
            <!-- 廣告 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/advertise.css">
            <!-- tinymce -->
            <script src="${pageContext.request.contextPath}/tinymce/js/tinymce.min.js"></script>
            <script>
                ELEMENT.locale(ELEMENT.lang.zhTW)
            </script>

        </head>

        <body>
            <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>發布文章</h1>
                    </div>
                </div>
                <div class="row">
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>
                <!-- 中間主體 -->
                <div class="row app">
                    <div class="col-lg-2 scenery">
                    </div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">
                        <div class="row ">
                            <div class="col-lg-10">
                                <form action="${pageContext.request.contextPath}/article/save" method="post"
                                    id="articleform">
                                    <input type="hidden" name="memberid"
                                        value="${SPRING_SECURITY_CONTEXT.authentication.principal.memberid}">
                                    <input type="hidden" name="articleid" v-model="bean.articleid">
                                    <input type="hidden" name="createtime" v-model="bean.createtime">
                                    <input type="hidden" name="membername" v-model="bean.membername">
                                    <input type="hidden" name="replytime" v-model="bean.replytime">
                                    <input type="hidden" name="state" value="未驗證">
                                    <div class="mb-3">
                                        <label class="form-label"> 主題 <span style="color: red;">*</span><span
                                                style="color: red;">${errors.username}</span>
                                        </label>
                                        <input type="text" class="form-control" name="name" id="name"
                                            v-model="bean.name">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label"> 群組 <span style="color: red;">*</span><span
                                                style="color: red;">${errors.username}</span>
                                        </label>
                                        <select class="form-select" name="articlegroup" v-model="bean.articlegroup"
                                            @change="changeGroup">
                                            <option value="sensor">感測器</option>
                                            <option value="apparatus">儀器儀表</option>
                                            <option value="Netcom">網通裝置</option>
                                            <option value="software">軟體配件</option>
                                            <option value="controlbox">控制箱</option>
                                            <option value="application">應用</option>
                                        </select>
                                    </div>
                                    <div style="padding: 5px;">
                                        分類<span style="color: red;">*</span> <br>
                                        <el-radio-group v-model="inOptin" size="medium">
                                            <el-radio-button :label="s.libraryoption" v-for="(s, index) in option"
                                                :key="index" name="articleoption"></el-radio-button>
                                        </el-radio-group>
                                    </div>




                                    <div class="mb-3">
                                        <label for="exampleFormControlTextarea1" class="form-label">內容</label>
                                        <textarea class="form-control" id="exampleFormControlTextarea1" name="content"
                                            v-model="bean.content"></textarea>
                                    </div>
                                    <br>
                                    <div class="form-check checkbox">
                                        <input class="form-check-input" type="checkbox" id="flexCheckDefault"
                                            v-model="bean.agree">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            我已經閱讀並同意遵守 <a
                                                href="${pageContext.request.contextPath}/detail/22302ed22b7642708a397063ce0f1010"
                                                target="_blank">討論區規則</a> 與<a
                                                href="${pageContext.request.contextPath}/detail/162a4c5c62b646639af82accdf25527f"
                                                target="_blank">本站服務條款</a>
                                        </label>
                                    </div>
                                    <br>

                                    <div class="g-recaptcha " style="width: 304px; display: inline-block;"
                                        data-sitekey="6Ldhf4kgAAAAAN2ExQc-EBZROSpa2xoA69Z2TPrJ"></div>
                                    <div class="mb-3 text-end">
                                        <button type="button" class="btn btn-primary" @click="preview">預覽</button>
                                        <button type="button" class="btn btn-primary" @click="submitForm"
                                            id="sub">提交</button>
                                    </div>
                                </form>
                            </div>
                            <!-- 右邊廣告 -->
                            <div class="col-lg-2">
                                <jsp:include page="/widget/advertise.jsp"></jsp:include>
                            </div>
                        </div>
                        <!-- 上傳彈窗 -->
                        <el-dialog title="上傳" :visible.sync="imgVisible" width="30%">
                            <el-upload class="upload-demo" drag action="${pageContext.request.contextPath}/upfile"
                                multiple :on-success="upSuccess" :before-upload="beforeAvatarUpload">
                                <i class="el-icon-upload"></i>
                                <div class="el-upload__text">將文件拖到此處，或<em>點擊上傳</em></div>
                                <div class="el-upload__tip" slot="tip">只能上傳jpg/png文件，且不超過2MB</div>
                            </el-upload>
                        </el-dialog>
                        <div class="row ">
                            <div class="col-lg-6">
                                &nbsp;
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 scenery">
                    </div>
                </div>
            </div>

        </body>

        <script>
            tinymce.init({
                selector: 'textarea',  // change this value according to your HTML
                plugins: ["autosave preview code link media hr charmap emoticons"],
                toolbar: 'undo redo |  bold italic fontsizeselect | forecolor backcolor charmap emoticons| alignleft aligncenter alignright alignjustify hr | outdent indent   | link unlink selectiveDateButton media |   preview code',

                language: 'zh_TW',
                height: '800',
                //自訂義按鈕
                setup: (editor) => {
                    //定義新icon
                    editor.ui.registry.addIcon('triangleUp', `<i class="bi bi-image"></i>`);
                    //設定功能
                    editor.ui.registry.addButton('selectiveDateButton', {
                        icon: 'triangleUp',
                        tooltip: 'Insert Image',
                        onAction: (_) => {
                            vm.imgVisible = true;
                        },
                    });
                }
            });
        </script>

        <script>
            const url = new URL(location.href);
            const id = url.searchParams.get("id");
            const nav = url.searchParams.get("nav");
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        inOptin: "",
                        option: [],
                        nav: nav,
                        imgVisible: false,
                        bean: {
                            name: "",
                            content: "",
                            agree: false,
                            articlegroup: "",
                        },
                    }
                },
                created() {
                    this.bean.articlegroup = nav;
                    console.log(id);
                    if (id == null || id == "") {
                    } else {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/article/getContent/' + id,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                this.bean = response.article;
                                this.bean.content = response.article_content.content;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    }
                    //廣告
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
                    //option
                    $.ajax({
                        url: '${pageContext.request.contextPath}/topic/getOption/' + this.bean.articlegroup,
                        type: 'get',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            console.log(response)
                            if (response.code == 400) {
                                location.href = "${pageContext.request.contextPath}/article/publish.jsp?nav=sensor";
                            }
                            if (response.code == 200) {
                                console.log("option", response.data)
                                this.option = response.data;
                            }
                            this.inOptin = this.option[0].libraryoption;
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    //上傳成功
                    upSuccess(response, file, fileList) {
                        console.log(response);
                        const img = `<p><img src="${pageContext.request.contextPath}/file/` + response + `"  style="max-width: 100%; height: auto; width: 50%;" ></p><p>&nbsp;</p>`;
                        console.log(img);
                        this.imgVisible = false;
                        tinymce.activeEditor.execCommand('mceInsertContent', false, img);

                    },
                    //上傳檢查
                    beforeAvatarUpload(file) {
                        const isJPG = file.type === 'image/jpeg';
                        const isLt2M = file.size / 1024 / 1024 < 2;
                        if (!(file.type == 'image/jpeg' || file.type == 'image/png')) {
                            this.$message.error('上傳圖片只能是 JPG/PNG 格式!');
                            return false;
                        }
                        if (!isLt2M) {
                            this.$message.error('上傳圖片大小不能超過 2MB!');
                            return false;
                        }
                        return true;
                    },
                    //預覽
                    preview() {
                        $("#articleform").attr("target", "_blank");
                        $("#articleform").attr("action", "${pageContext.request.contextPath}/article/preview");
                        $("#articleform").submit();
                    },
                    submitForm() {
                        let isok = true;
                        if (!this.bean.agree) {
                            isok = false
                            this.$message.error('須同意條款');
                            $(".checkbox").css("border", "1px red solid");
                        } else {
                            $(".checkbox").css("border", "0px ");
                        }
                        if (this.bean.name.length <= 0) {
                            isok = false
                            this.$message.error('沒有主題');
                            $("#name").css("border", "1px red solid");
                        } else {
                            $("#name").css("border", "1px solid #ced4da");
                        }
                        if (tinyMCE.activeEditor.getContent().length <= 0) {
                            isok = false
                            this.$message.error('沒有內容');
                            $(".tox-tinymce").css("border", "1px red solid");
                        } else {
                            $(".tox-tinymce").css("border", "1px solid #ced4da");
                        }


                        const formData = new FormData(document.getElementById("articleform"));
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
                                        $("#articleform").attr("target", "");
                                        $("#articleform").attr("action", "${pageContext.request.contextPath}/article/save");
                                        $("#articleform").submit();

                                    } else {
                                        this.$message.error('檢查錯誤');
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }
                    },
                    changeGroup() {
                        //option
                        $.ajax({
                            url: '${pageContext.request.contextPath}/topic/getOption/' + this.bean.articlegroup,
                            type: 'get',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                console.log(response)
                                if (response.code == 400) {
                                    location.href = "${pageContext.request.contextPath}/article/publish.jsp?nav=sensor";
                                }
                                if (response.code == 200) {
                                    console.log("option", response.data)
                                    this.option = response.data;
                                }
                                this.inOptin = this.option[0].libraryoption;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    },
                },
            })
        </script>
        <style>
            .el-upload {
                width: 100%;
            }

            .el-upload-dragger {
                width: auto;
            }

            .img-fluid {
                max-width: 100px;
                height: auto;

            }

            .el-radio-button__inner {
                border-left: 1px solid #DCDFE6;
            }

            @media (max-width : 920px) {
                .scenery {
                    display: none;
                }
            }
        </style>


        </html>