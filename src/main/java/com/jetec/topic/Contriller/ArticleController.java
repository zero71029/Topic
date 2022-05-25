package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    ArticleService as;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//預覽
    @RequestMapping("/preview")
    public String Signout(Model model, ArticleBean articleBean) {
        System.out.println("*****預覽*****");
        articleBean.setCreatetime(ZeroTools.getTime(new Date()));
        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        return "/article/preview";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//發布文章
    @RequestMapping("/save")
    public String save(Model model, ArticleBean articleBean, HttpSession session) {
        System.out.println("*****發布文章*****");

        if (articleBean.getArticleid() == null || articleBean.getArticleid().equals("")) {
            articleBean.setArticleid(ZeroTools.getUUID());
            articleBean.setCreatetime(ZeroTools.getTime(new Date()));
            MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
            articleBean.setMemberid(memberBean.getMemberid());
            articleBean.setMembername(memberBean.getName());
            articleBean.setState("未認證");
            articleBean.setReplytime(articleBean.getCreatetime());
        }
        as.save(articleBean);
        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        return "/article/preview";
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點讚
    @RequestMapping("/thumbsup/{articleid}")
    @ResponseBody
    public Boolean thumbsup(@PathVariable("articleid")String articleid, HttpSession session) {
        System.out.println("*****點讚*****");
        MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        return as.thumbsup(articleid,memberBean.getMemberid());
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//細節初始化
    @RequestMapping("/detailInit/{articleid}")
    @ResponseBody
    public Map<String,Object> detailInit(@PathVariable("articleid")String articleid, HttpSession session) {
        System.out.println("*****細節初始化*****");
        MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        Map<String,Object> result = new HashMap<>();

        result.put("replylist",as.getReplyList(articleid));
        result.put("thumbsupNum",as.getThumbsupNum(articleid));
        result.put("hasThumbsup",as.hasThumbsup(articleid,memberBean.getMemberid()));
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//文章回復 儲存
    @RequestMapping(path = {"/saveReply"})
    public String saveReply(  ArticleReplyBean arBean) {
        System.out.println("*****文章回復儲存*****");
        arBean.setReplyid(ZeroTools.getUUID());
        arBean.setCreatetime(ZeroTools.getTime(new Date()));
        Integer num = as.getArticleNum(arBean.getArticleid());
        arBean.setNum(num+1);

        as.saveArticleReply(arBean);
        return "redirect:/topicdetail?id="+arBean.getArticleid();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存留言
    @RequestMapping(path = {"/savemessage"})
    @ResponseBody
    public List<ArticleReplyBean> savemessage(  ArticleReplyBean arBean,@RequestParam("article")String article) {
        System.out.println("*****儲存留言*****");
        arBean.setReplyid(ZeroTools.getUUID());
        arBean.setCreatetime(ZeroTools.getTime(new Date()));
        as.saveArticleReply(arBean);
        System.out.println(LocalDateTime.now());


        return as.getReplyList(article);
    }

}
