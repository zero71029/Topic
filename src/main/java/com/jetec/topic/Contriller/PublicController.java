package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
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

        System.out.println("首頁");
        Map<String , Object> result = as.init();
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//首頁
    @RequestMapping( path = {"/articleList", "/memberList","/article/Detail","/memberDetail","/Backstage","/b","advertiseList"})
    public String articleList() {  return "/Backstage/index";    }
}
