<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>後台控制</title>
            <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
            <!-- <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script> -->
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css"> -->

            <!-- bootstrap的CSS、JS樣式放這裡 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
            <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
            <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
            <!-- 引入 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>
            <script src="${pageContext.request.contextPath}/js/zh-TW.js"></script>


        </head>

        <body>
            <canvas id="canvas" style="position:fixed;height: 100vh;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
            <div class="container-fluid">
                <div class="row app">
                    <div class="col-lg-12">
                        <el-container style=" border: 1px solid #eee">
                            <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
                                <el-menu :default-openeds="['1', '3']">
                                    <el-submenu index="1">
                                        <template slot="title"><i class="el-icon-message"></i>客戶</template>
                                        <el-menu-item-group>
                                            <template slot="title">分组一</template>
                                            <el-menu-item index="1-1">选项1</el-menu-item>
                                            <el-menu-item index="1-2">选项2</el-menu-item>
                                        </el-menu-item-group>
                                        <el-menu-item-group title="分组2">
                                            <el-menu-item index="1-3">选项3</el-menu-item>
                                        </el-menu-item-group>
                                        <el-submenu index="1-4">
                                            <template slot="title">选项4</template>
                                            <el-menu-item index="1-4-1">选项4-1</el-menu-item>
                                        </el-submenu>
                                    </el-submenu>
                                    <el-submenu index="2">
                                        <template slot="title"><i class="el-icon-menu"></i>文章</template>
                                        <el-menu-item-group>
                                            <template slot="title">分组一</template>
                                            <el-menu-item index="2-1">选项1</el-menu-item>
                                            <el-menu-item index="2-2">选项2</el-menu-item>
                                        </el-menu-item-group>
                                        <el-menu-item-group title="分组2">
                                            <el-menu-item index="2-3">选项3</el-menu-item>
                                        </el-menu-item-group>
                                        <el-submenu index="2-4">
                                            <template slot="title">选项4</template>
                                            <el-menu-item index="2-4-1">选项4-1</el-menu-item>
                                        </el-submenu>
                                    </el-submenu>
                                    <el-submenu index="3">
                                        <template slot="title"><i class="el-icon-setting"></i>导航三</template>
                                        <el-menu-item-group>
                                            <template slot="title">分组一</template>
                                            <el-menu-item index="3-1">选项1</el-menu-item>
                                            <el-menu-item index="3-2">选项2</el-menu-item>
                                        </el-menu-item-group>
                                        <el-menu-item-group title="分组2">
                                            <el-menu-item index="3-3">选项3</el-menu-item>
                                        </el-menu-item-group>
                                        <el-submenu index="3-4">
                                            <template slot="title">选项4</template>
                                            <el-menu-item index="3-4-1">选项4-1</el-menu-item>
                                        </el-submenu>
                                    </el-submenu>
                                </el-menu>
                            </el-aside>

                            <el-container>
                                <el-header style="text-align: right; font-size: 12px">
                                    <el-dropdown>
                                        <i class="el-icon-setting" style="margin-right: 15px"></i>
                                        <el-dropdown-menu slot="dropdown">
                                            <el-dropdown-item>查看</el-dropdown-item>
                                            <el-dropdown-item>新增</el-dropdown-item>
                                            <el-dropdown-item>删除</el-dropdown-item>
                                        </el-dropdown-menu>
                                    </el-dropdown>
                                    <span>${member.name}</span>
                                </el-header>

                                <el-main>
                                    <el-table :data="memberList">
                                        <el-table-column prop="createtime" label="創建日期" width="140">
                                        </el-table-column>
                                        <el-table-column prop="name" label="姓名" width="120">
                                        </el-table-column>
                                        <el-table-column prop="email" label="Email">
                                        </el-table-column>
                                        <el-table-column prop="phone" label="電話">
                                        </el-table-column>
                                        <el-table-column prop="integral" label="積分">
                                        </el-table-column>
                                        <el-table-column prop="birthday" label="生日">
                                        </el-table-column>
                                    </el-table>
                                    <p class="text-center">
                                        <el-pagination @size-change="handleSizeChange"
                                            @current-change="handleCurrentChange" :current-page="currentPage"
                                            :page-sizes="[10, 20, 30, 40,50,60,70,80,90,100]" :page-size=pageSize
                                            layout="total, sizes, prev, pager, next, jumper" :total="total">
                                        </el-pagination>
                                    </p>
                                </el-main>
                            </el-container>
                        </el-container>
                    </div>
                </div>
            </div>
        </body>
        <script>
            ELEMENT.locale(ELEMENT.lang.zhTW);
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        memberList: [],//會員列表
                        currentPage: 1,//當前頁面
                        pageSize: 10,//每頁幾條
                        total: 40,//總共幾條
                    }
                },
                created() {
                    $.ajax({
                        url: 'http://localhost:8080/topic/backstage/init?page=1',
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            this.memberList = response.member;
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                    console.log(this.memberList)
                },
                methods: {
                    handleSizeChange(val) {
                        console.log(`每页 ${val} 条`);
                        this.pageSize = val;
                    },
                    handleCurrentChange(val) {
                        console.log(`当前页: ${val}`);
                        this.currentPage = val;
                    }
                },
            })
        </script>
        <style>
            .el-header {
                background-color: #B3C0D1;
                color: #333;
                line-height: 60px;
            }

            .el-aside {
                color: #333;
            }
        </style>

        </html>