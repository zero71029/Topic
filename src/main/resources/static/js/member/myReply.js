var vm = new Vue({
    el: ".app",
    data() {
        return {
            list: [],
            currentPage: 1,
            pageSize: 20,
            total: 100,
        }
    },
    created() {
        $.ajax({
            url: contextPath + '/member/myReply?page=1&size=20',
            type: 'POST',
            async: false,//同步請求
            cache: false,//不快取頁面
            success: response => {
                console.log(response);
                this.list = response.list;
                this.total = response.total;
                this.list.forEach(e => {
                    if (e.bean.state == "允許") {
                        e.allow = "blue";
                    } else {
                        e.allow = "red";
                    }
                });
            },
            error: function (returndata) {
                console.log(returndata);
            }
        });
    },
    methods: {
        handleSizeChange(val) {
            this.pageSize = val;
            $.ajax({
                url: contextPath + '/member/myReply?page=' + this.currentPage + '&size=' + val,
                type: 'POST',
                async: false,//同步請求
                cache: false,//不快取頁面
                success: response => {
                    console.log(response);
                    this.list = response.list;
                    this.total = response.total;
                    this.list.forEach(e => {
                        if (e.bean.state == "允許") {
                            e.allow = "blue";
                        } else {
                            e.allow = "red";
                        }
                    });
                },
                error: function (returndata) {
                    console.log(returndata);
                }
            });
        },
        handleCurrentChange(val) {
            this.currentPage = val;
            $.ajax({
                url: contextPath + '/member/myReply?page=' + val + '&size=' + this.pageSize,
                type: 'POST',
                async: false,//同步請求
                cache: false,//不快取頁面
                success: response => {
                    console.log(response);
                    this.list = response.list;
                    this.total = response.total;
                    this.list.forEach(e => {
                        if (e.state == "允許") {
                            e.allow = "blue";
                        } else {
                            e.allow = "red";
                        }
                    });
                },
                error: function (returndata) {
                    console.log(returndata);
                }
            });
        }

    },
})
