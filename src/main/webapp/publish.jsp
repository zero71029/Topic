<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>發布文章</title>
            <!-- <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script> -->
            <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->

            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/icons/bootstrap-icons.css">
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
                        <h1>發布文章</h1>
                    </div>
                </div>
                <div class="row">
                    <hr>
                </div>
                <!-- 中間主體 -->
                <div class="row app">

                    <div class="col-lg-2 ">
                    </div>
                    <div class="col-lg-8 " style="background-color: white; --bs-bg-opacity: 1;">



                        <div class="row ">
                            <div class="col-lg-10">
                                <form action="" method="post">
                                    <div class="mb-3">
                                        <label for="exampleFormControlInput1" class="form-label"> 主題 <span
                                                style="color: red;">*</span><span
                                                style="color: red;">${errors.username}</span>
                                        </label>
                                        <input type="text" class="form-control" name="name" id="name">
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleFormControlTextarea1" class="form-label">內容</label>
                                        <textarea class="form-control" id="exampleFormControlTextarea1"
                                            rows="13"></textarea>
                                    </div>
                                    <br>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            我已經閱讀並同意遵守討論區規則,本站服務條款與個人資料保護法
                                        </label>
                                    </div>
                                    <br>

                                    <div class="mb-3 text-end">
                                        <button type="button" class="btn btn-primary">Primary</button>
                                    </div>





                                </form>
                            </div>
                            <div class="col-lg-2">
                                <a href="">
                                    <div style=" 
                                height: 700px;background-color: blue;    top: 47px;position: relative;">xxxxxxx</div>
                                </a>
                            </div>
                        </div>

                        <el-dialog title="上傳" :visible.sync="imgVisible" width="30%">
                            <el-upload class="upload-demo" drag action="https://jsonplaceholder.typicode.com/posts/" multiple :on-success="upSuccess">
                                <i class="el-icon-upload"></i>
                                <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
                                <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
                            </el-upload>
                        </el-dialog>








                        <div class="row ">
                            <div class="col-lg-6">

                                XX


                            </div>
                        </div>


                    </div>
                    <!-- 右邊廣告 -->
                    <div class="col-lg-2 ">

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
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        imgVisible: true,
                    }
                },
                methods: {
                    upSuccess(response, file, fileList){

                    },
                },
            })
        </script>


        <script>






            tinymce.init({
                selector: 'textarea',  // change this value according to your HTML
                toolbar: 'undo redo | styles | bold italic | alignleft aligncenter alignright alignjustify | outdent indent | basicDateButton selectiveDateButton',
                language: 'zh_TW',
                setup: (editor) => {
                    const toDateHtml = (date) => `<time datetime="` + date.toString() + `">` + date.toDateString() + `</time>`;

                    editor.ui.registry.addIcon('triangleUp', `<i class="bi bi-image"></i>`);//更換icon

                    editor.ui.registry.addButton('basicDateButton', {
                        text: 'Insert Date',
                        tooltip: 'Insert Current Date',
                        onAction: (_) => {
                            vm.imgVisible=true;
                            
                            console.log("dddddddd");
                        }
                    });
                    editor.ui.registry.addButton('selectiveDateButton', {
                        icon: 'triangleUp',
                        tooltip: 'Insert Current Date',
                        onAction: (_) => editor.insertContent(toDateHtml(new Date())),

                    });
                }
            });
        </script>
        <style>
            .el-upload {
                width: 100%;
            }
            .el-upload-dragger{
                width: auto;
            }
        </style>


        </html>