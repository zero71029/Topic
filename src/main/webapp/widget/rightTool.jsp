<%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <style>
            /* 侧边小部件 */
            .side-widget-container {
                width: 60px;
                margin-top: 10px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 6px #e3e3e3;
                cursor: pointer;
                position: fixed;
                bottom: 100px;
                right: 0;
                z-index: 999;
            }

            .side-widget-item .widget-icon {

                width: 32px;
                height: 32px;
                background: url(${pageContext.request.contextPath}/images/side-widget.png) no-repeat 0 0/700% 200%;
            }

            .side-widget-item {
                border-radius: 8px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                box-sizing: border-box;
                width: 60px;
                height: 60px;
                font-size: 12px;
                transition: color, background-color 0.24s ease;
            }

            .side-widget-item:hover {
                color: #fff;
                background-color: #0b5ed7;
            }

            .side-widget-item:hover .widget-icon {
                background-position-y: -32px;
            }

            /*  侧边小部件 結束  */
        </style>
        <!-- 侧边小部件 -->
        <div class="side-widget" style="bottom: 100px;">
            <div class="side-widget-container">
                <div class="side-widget-item backtop" data-visibility="50" style="display: flex;">
                    <div class="widget-icon"></div>
                </div>
            </div>
        </div>
        <!-- 侧边小部件 結束 -->
        <script src="${pageContext.request.contextPath}/js/toolbar.js"></script>