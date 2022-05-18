// 侧边小部件
var $toolBar = $("#toolbar");
var $sideWidget = $('.side-widget');


// 返回顶部
var $backTop = $toolBar.find('.backtop');
if (!$backTop[0]) {
    $backTop = $sideWidget.find(".backtop");
}
$backTop.hide();
var backTop_visibilityHeight = $backTop.eq(0).data("visibility");	// 滚动高度达到此值才出现 BackTop
$(window).scroll(function () {
    if ($(this).scrollTop() > backTop_visibilityHeight) {
        $toolBar.css("bottom", 32);
        $sideWidget.css('bottom', 100);
        $backTop.show();
    } else {
        $toolBar.css("bottom", 100);
        $sideWidget.css('bottom', 160);
        $backTop.hide();
    }
})
$backTop.click(function () { $('html').animate({ scrollTop: 0 }) });
