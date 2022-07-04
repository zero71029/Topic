package com.jetec.topic.Contriller;

import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class PublicController {
    @Autowired
    ArticleService as;

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
    public Map<String , Object> init() {
        return as.init();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//首頁
    @RequestMapping( path = {"/articleList", "/memberList","/article/Detail","/memberDetail","/Backstage","/b","advertiseList"})
    public String articleList() {  return "/Backstage/index";    }
}
