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
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="//unpkg.com/element-ui/lib/umd/locale/zh-TW.js"></script>


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
                        <h1>回復文章</h1>
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
                                    <input type="hidden" name="memberid" value="${member.memberid}">
                                    <input type="hidden" name="membername" value="${member.name}">
                                    <input type="hidden" name="articleid" value="${article.articleid}">
                                    <p style="font-size: 18px;"><span
                                            style="width: 80px; display: inline-block;">討論區</span> {{group}}</p>
                                    <p style="font-size: 18px;"><span
                                            style="width: 80px; display: inline-block;">主題</span> ${article.name}</p>
                                    <div class="mb-3">
                                        <textarea class="form-control" name="content" v-model="bean.content"></textarea>
                                    </div>
                                    <br>
                                    <div class="form-check checkbox">
                                        <input class="form-check-input" type="checkbox" id="flexCheckDefault"
                                            v-model="bean.agree">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            我已經閱讀並同意遵守 <a href="" target="_blank">討論區規則</a> ,<a href=""
                                                target="_blank">本站服務條款</a>與<a href="" target="_blank">個人資料保護法</a>
                                        </label>
                                    </div>
                                    <br>

                                    <div class="mb-3 text-end">
                                        <button type="button" class="btn btn-primary" @click="preview">預覽</button>
                                        <button type="button" class="btn btn-primary" @click="submitForm">提交</button>
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
            <div class="row">
                <div class="col-lg-12 text-center">

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
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        imgVisible: false,
                        bean: {
                            name: "",
                            content: "",
                            agree: false,
                            articlegroup: '${article.articlegroup}',

                        },
                        group: ""
                    }
                },
                created() {

                    switch (this.bean.articlegroup) {
                        case 'controlbox':
                            this.group = "控制箱";
                            break;
                        case "sensor": this.group = "感測器";
                            break;
                        case "Netcom": this.group = "網通裝置";
                            break;
                        case "software": this.group = "軟體配件";
                            break;
                        case "application": this.group = "應用";
                            break;
                        case "apparatus": this.group = "儀器儀表";
                            break;
                    }
                    
                }, 
                methods: {
                    //上傳成功
                    upSuccess(response, file, fileList) {
                        console.log(response);
                        const img = `<p><img src="${pageContext.request.contextPath}/file/` + response + `"  style="max-width: 100%; height: auto;"></p><p>&nbsp;</p>`;
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

                        if (tinyMCE.activeEditor.getContent().length <= 0) {
                            isok = false
                            this.$message.error('沒有內容');
                            $(".tox-tinymce").css("border", "1px red solid");
                        } else {
                            $(".tox-tinymce").css("border", "1px solid #ced4da");
                        }
                        if (isok) {
                            $("#articleform").attr("target", "");
                            $("#articleform").attr("action", "${pageContext.request.contextPath}/article/saveReply");
                            $("#articleform").submit();
                        }
                    }
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
        </style>


        </html>