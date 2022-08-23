const vm = new Vue({
    el: ".app",
    data() {
        return {
            bean:{},
            replyNum: 0,//回覆文章數
            articleNum: 0,//發表文章數
            integral: 0,//獲得積分
            show: false,
            birthday: birthday ,
            level: contextPath+"/images/青銅.png"
        }
    },
    created() {
        $.ajax({
            url: contextPath+'/member/mypage',
            type: 'POST',
            async: false,//同步請求
            cache: false,//不快取頁面
            success: response => {
                this.bean = response.member;
                this.articleNum = response.articleNum;
                this.replyNum = response.replyNum;
                this.integral = this.bean.integral;
            },
            error: function (returndata) {
                console.log(returndata);
            }
        });

        if (this.integral >= 90000) {
            this.level = contextPath+'/images/傳奇.png';
        } else if (this.integral >= 30000) {
            this.level = contextPath+'/images/鉑金.png';
        } else if (this.integral >= 10000) {
            this.level = contextPath+'/images/黃金.png';
        } else if (this.integral >= 1000) {
            this.level = contextPath+'/images/白銀.png';
        }

    },
    mounted() {
        this.show = true
    },
    methods: {
        //修改個人資料
        revise() {
            var data = new FormData(document.getElementById("reviseForm"));
            console.log(data.get("name"));
            $.ajax({
                url: contextPath+'/member/revise',
                type: 'POST',
                data: data,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: response => {
                    this.$message.success("修改成功");
                },
                error: function (returndata) {
                    console.log(returndata);
                }
            });
        }
    },
})
$("input[name='birthday']").addClass("form-control");
if (permit.indexOf("1") > 0) {
    $("#reSend").hide();
} 