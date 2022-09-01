package com.jetec.topic.Contriller;

import com.jetec.topic.service.ArticleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class PublicController {
    @Autowired
    ArticleService as;

    Logger logger = LoggerFactory.getLogger("PublicController");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//首頁
    @RequestMapping(path = {"/", "/index"})
    public String index() {
        return "/index";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //首頁
    @RequestMapping("/init")
    @ResponseBody
    public Map<String, Object> init(HttpServletRequest request) {
        String ip = request.getRemoteAddr();
        logger.info("{} 讀取首頁", ip);
        return as.init();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//後台首頁
    @RequestMapping(path = {"/articleList", "/memberList", "/article/Detail", "/memberDetail", "/Backend", "/b", "/advertiseList", "/returnList"})
    public String articleList() {
        return "/Backend/index";
    }
}
