package com.jetec.topic.Tools;

import com.jetec.topic.model.MemberBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class notes {
    // 筆記
    // TRACE < DEBUG < INFO < WARN < ERROR < FATAL

    ///////////////////////////////////////////
//	返回上一頁
//	window.history.back();location.reload();
////////////////////
// sql修改为不自动更新（只是插入是自动生成当前时间）
//alter table hello change uptime uptime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
    //////////////////////////////////////
//	重置 MySQL 自增列 AUTO_INCREMENT 初時值
//	ALTER TABLE tbl AUTO_INCREMENT = 1;
//////////////////////////////////
//	一键复制至剪切板
//	url.select();
//    document.execCommand("Copy");
//////jpa排序
    // Sort sort = Sort.by(Direction.DESC,"marketid");
    // return mr.findAll( sort);
///////////////////////////////
    //更新application
//	HttpServletRequest sce
//	ServletContext app = sce.getServletContext();
//	app.setAttribute("billboardgroup", bgr.findAll());
//////////ajax
//	var formData = new FormData($(".uppdf")[0]);
//	$.ajax({
//        url: '${pageContext.request.contextPath}/CRM/selectContactByClientName/' + $("input[name='client']").val(),//接受請求的Servlet地址
//        type: 'POST',
//        // data: formData,
//        // async: false,//同步請求
//        // cache: false,//不快取頁面
//        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
//        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
//        success: function (json) {
//            $(".CCC").empty();
//
//            for (var j of json) {
//                console.log(j);
//
//                $(".CCC").append('<div class="row TTT" onclick="clickContact(`' + j.name + '`,`' + j.phone + '`,`' + j.moblie + '`)">' +
//                    '<div class="col-md-1"></div>' +
//                    '<div class="col-md-3">' + j.name + '</div>' +
//                    '<div class="col-md-3">' + j.phone + '</div>' +
//                    '<div class="col-md-3">' + j.moblie + '</div>' +
//                    '</div>');
//            }
//        },
//        error: function (returndata) {
//            console.log(returndata);
//        }
//    });
    ////////////////////////////////////////////////////
    //redis
//<dependency>
//        <groupId>org.springframework.boot</groupId>
//        <artifactId>spring-boot-starter-data-redis-reactive</artifactId>
//</dependency>

//            # Redis資料庫索引（預設為0）
//    spring.redis.database=0
//            # Redis伺服器地址
//    spring.redis.host=localhost
//# Redis伺服器連接端口
//    spring.redis.port=6379
//            # Redis伺服器連接密碼（預設為空）
//    spring.redis.password=
//            # 連接池最大連接數（使用負值表示沒有限制）
//    spring.redis.jedis.pool.max-active=8
//            # 連接池最大阻塞等待時間（使用負值表示沒有限制）
//    spring.redis.jedis.pool.max-wait=-1
//            # 連接池中的最大空閒連接
//    spring.redis.jedis.pool.max-idle=8
//            # 連接池中的最小空閒連接
//    spring.redis.jedis.pool.min-idle=0
//            # 連接超時時間（毫秒）
//    spring.redis.timeout=1000

//@Autowired
//// 注入StringRedisTemplate類別，用來操作Redis
//        StringRedisTemplate stringRedisTemplate;

    //stringRedisTemplate.opsForHash()


    //      docker run -itd --name redis -p 6379:6379 redis

//    docker run --name tomcat -p 8888:8080 -v C:\Work\Docker\tomcat\webapps:/usr/local/tomcat/webapps -v C:\Work\Docker\tomcat\conf:/usr/local/tomcat/conf -d tomcat:9.0

   // docker run -d --name eureka8761 -p 8761:8761 springcloud/eureka

//    docker run --name tomcat -p 8888:8080 -v C:\Work\Docker\tomcat\webapps:/usr/local/tomcat/webapps    -d tomcat:jdk17

    //docker update --restart=always a39b1323202cff9eba0a3a63400ef327bd93e570b8df7e77f588cc32406a4635

    ////////////////////////////////////////////////////
    //Spring Boot Security 取得登入者
//    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//    MemberBean memberBean = (MemberBean) authentication.getPrincipal();
//
//    HttpSession session;
//    SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
//    memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
//    ${SPRING_SECURITY_CONTEXT.authentication.principal.name}

    ////////////////////////////////////////////////////
    //取得ip
//    HttpServletRequest request;
//    String ip = request.getRemoteAddr();//得到来访者的IP地址

//    　        　getRequestURL方法返回客户端发出请求时的完整URL。
//            　　getRequestURI方法返回请求行中的资源名部分。
//            　　getQueryString 方法返回请求行中的参数部分。
//            　　getPathInfo方法返回请求URL中的额外路径信息。额外路径信息是请求URL中的位于Servlet的路径之后和查询参数之前的内容，它以“/”开头。
//            　　getRemoteAddr方法返回发出请求的客户机的IP地址。
//            　　getRemoteHost方法返回发出请求的客户机的完整主机名。
//            　　getRemotePort方法返回客户机所使用的网络端口号。
//            　　getLocalAddr方法返回WEB服务器的IP地址。
//            　　getLocalName方法返回WEB服务器的主机名。


    //Security 讀取使用者
//    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//    AdminBean adminBean = (AdminBean) authentication.getPrincipal();

}
