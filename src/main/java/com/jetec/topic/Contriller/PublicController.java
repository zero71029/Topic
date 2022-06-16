package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
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
    //進入文章回復
    @RequestMapping(path = {"/reply/{articleid}"})
    public String reply(HttpSession session, @PathVariable("articleid")String articleid,Model model) {
        MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        if(as.hasArticle(articleid)){
            model.addAttribute(ArticleBean.SESSIONID,as.findById(articleid));
        }else {
            model.addAttribute("error","文章不存在");
            return "/error";
        }
        if(memberBean == null){
            model.addAttribute("error","未登入");
            return "/error";
        }
        return "/article/reply";
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
    @RequestMapping( path = {"/articleList", "/memberList","/article/Detail","/memberDetail"})
    public String articleList() {  return "/Backstage/index";    }
}
