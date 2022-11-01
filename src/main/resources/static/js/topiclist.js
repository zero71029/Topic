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
}
const url = new URL(location.href);
const nav = url.searchParams.get("nav");

if (nav != "system") {
    const e = document.getElementById(nav);
    e.style.background = "#7F7F7F";
    e.style.borderRadius = "4px";
    document.querySelector("#" + nav + " a").style.color = "#fff";
    console.log(document.getElementsByTagName('h1')[0].innerText);
    document.getElementsByTagName('h1')[0].innerText = changGrop(nav) + "討論區";
    document.getElementsByTagName('title')[0].innerText = changGrop(nav) + "討論區"
}

const metaRobots = document.createElement('meta');
metaRobots.name = 'description';
metaRobots.content = '${article.name}';
document.head.appendChild(metaRobots);









const navname = document.getElementById("navname");
navname.textContent = changGrop(nav);
const vm = new Vue({
    el: ".app", data() {
        return { currentPage: 1, pageSize: 20, total: 400, list: [], rigthAdvertise: [], }
    }, created() {
        $.ajax({
            url: contextPath + '/topiclist?nav=' + nav + '&pag=' + this.currentPage + '&size=' + this.pageSize,
            type: 'POST',
            async: false,
            cache: false,
            success: response => {
                if (response.code == 200) {
                    this.list = response.data.list;
                    this.total = response.data.total
                }
            },
            error: function (returndata) {
                console.log(returndata)
            }
        });
        $.ajax({
            url: contextPath + '/topic/advertiseinit?location=右',
            type: 'get',
            async: false,
            cache: false,
            success: response => {
                this.rigthAdvertise = response
            },
            error: function (returndata) {
                console.log(returndata)
            }
        })
    }, mounted() {

    }, methods: {
        handleSizeChange(val) {
            this.pageSize = val;
            $.ajax({
                url: contextPath + '/topiclist?nav=' + nav + '&pag=' + this.currentPage + '&size=' + val,
                type: 'POST',
                async: false,
                cache: false,
                success: response => {
                    this.list = response.data.list;
                    this.total = response.data.total;
                },
                error: function (returndata) {
                    console.log(returndata)
                }
            })
        }, handleCurrentChange(val) {
            this.currentPage = val;
            $.ajax({
                url: contextPath + '/topiclist?nav=' + nav + '&pag=' + val + '&size=' + this.pageSize,
                type: 'POST',
                async: false,
                cache: false,
                success: response => {
                    this.list = response.data.list;
                    this.total = response.data.total;
                },
                error: function (returndata) {
                    console.log(returndata)
                }
            })
        }
    },
});

//SEO代碼.
var ga = document.createElement('script');
ga.type = 'application/ld+json';
ga.textContent = `{
"@context": "http://schema.org",
"@type": "BreadcrumbList",
"itemListElement":
[{
"@type": "ListItem",
"position": 1,
"item": {
  "@type": "WebPage",
  "@id": "https://www.jetec.com.tw/",
  "name": "傳感器的專家"
}
},
{
"@type": "ListItem",
"position": 2,
"item": {
  "@type": "WebPage",
  "@id": "https://forum.jetec.com.tw/Forum/",
  "name": "久德討論版"
}
},
{
"@type": "ListItem",
"position": 3,
"item": {
  "@type": "WebPage",
  "@id": "`+ location.href + `",
  "name": "`+ changGrop(nav) + `討論區"
}
}]
}`;
document.head.appendChild(ga);