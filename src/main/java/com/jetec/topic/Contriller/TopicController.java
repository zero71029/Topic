package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.*;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;


//不限定權限

@Controller
public class TopicController {

    @Autowired
    ArticleService as;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章列表
    @RequestMapping("/topiclist")
    @ResponseBody
    public Map<String, Object> topiclist(@RequestParam("nav") String nav, @RequestParam("pag") Integer pag, @RequestParam("size") Integer size, HttpSession session) {
        System.out.println("=====文章列表=====");
        pag--;
        Pageable pageable = PageRequest.of(pag, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> p = as.findByArticlegroup(nav, pageable);
        Map<String, Object> result = new HashMap<>();

        //取 未看 回復數
        List<ArticleBean> list = p.getContent();
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = null;
        if(sci != null ){
            memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        }
        
        List<Map<String, Object>> a = new ArrayList<>();
        for (ArticleBean e    :list ) {
            Map<String, Object> artlcle = new HashMap<>();
            if (memberBean != null) {
                Integer i = as.getWatchCount(memberBean.getMemberid(), e.getArticleid());
                artlcle.put("watch", i);
            }
            artlcle.put("bean", e);
            a.add(artlcle);
        } 
        //a = { "bean" : articleBean , "watch" : i }
        result.put("list", a);
        result.put("total", p.getTotalElements());
        result.put("totalPag", p.getTotalPages());
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //進入文章細節
    @RequestMapping("/detail/{articleid}")
    public String topicdetailt(@PathVariable("articleid") String articleid, Model model, HttpSession session) {
        System.out.println("=====進入文章細節=====");
        model.addAttribute(ArticleBean.SESSIONID, as.findById(articleid));
        model.addAttribute(ArticleContentBean.SESSIONID, as.findArticleContentByArticleid(articleid));
        //

        model.addAttribute(ArticleThumbsupBean.THUMBSUPID, as.findThumbsup(articleid));
        //存觀看時間
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean mBean = null;
        if(sci != null)mBean = (MemberBean) sci.getAuthentication().getPrincipal();
        MemberBean finalMBean = mBean;
        new Thread(() -> {
            if (finalMBean != null) {
                as.saveWatchTime(finalMBean, articleid);
            }
        }).start();
        return "/topicdetail";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改回復文章
    @RequestMapping("/revise-reply/{replyid}")
    public String reply(@PathVariable("replyid") String replyid, Model model, HttpSession session) {
        System.out.println("=====修改回復文章=====");
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        if (as.hasReply(replyid)) {
            model.addAttribute(ArticleBean.SESSIONID, as.findReplyById(replyid));
            return "/article/revisereply";
        }
        if (memberBean == null) {
            model.addAttribute("error", "未登入");
            return "/error/error";
        }
        model.addAttribute("error", "文章不存在");
        return "/error/error";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章回復
    @RequestMapping(path = {"/reply/{articleid}"})
    public String reply(HttpSession session, @PathVariable("articleid") String articleid, Model model) {
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        if (as.hasArticle(articleid)) {
            model.addAttribute(ArticleBean.SESSIONID, as.findById(articleid));
        } else {
            model.addAttribute("error", "文章不存在");
            return "/error/error";
        }
        if (memberBean == null) {
            model.addAttribute("error", "未登入");
            return "/error/error";
        }
        return "/article/reply";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //細節初始化
    @RequestMapping("/article/detailInit/{articleid}")
    @ResponseBody
    public Map<String, Object> detailInit(@PathVariable("articleid") String articleid, HttpSession session) {
        System.out.println("*****細節初始化*****");
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = null;
        if(sci != null)memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        Map<String, Object> result = new HashMap<>();
        result.put("replylist", as.getReplyList(articleid));//回復
        result.put("thumbsupNum", as.getThumbsupNum(articleid));//點讚數
        if (memberBean == null) {
            result.put("hasThumbsup", false);
        } else {
            result.put("hasThumbsup", as.hasThumbsup(articleid, memberBean.getMemberid()));//登入者是否點讚
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/article/search")
    @ResponseBody
    public Map<String, Object> search(@RequestParam("page") Integer page, @RequestParam("size") Integer size, @RequestParam("search") String search) {
        System.out.println("*****搜索*****");
        page--;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        return as.search(search, p);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/article/getContent/{articleid}")
    @ResponseBody
    public Map<String, Object> getContent(@PathVariable("articleid") String articleid) {
        Map<String, Object> result = new HashMap<>();
        result.put(ArticleBean.SESSIONID, as.findById(articleid));
        result.put(ArticleContentBean.SESSIONID, as.findArticleContentByArticleid(articleid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章回報
    @RequestMapping("/article/articleReturn/{articleid}")
    public String articleReturn(@PathVariable("articleid") String articleid, Model model) {
        System.out.println("*****文章回報*****");
        ArticleBean aBean = as.findById(articleid);
        model.addAttribute("article", aBean);
        model.addAttribute("articleid", aBean.getArticleid());
        model.addAttribute("replyid", aBean.getArticleid());
        return "/article/return";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //回復回報
    @RequestMapping("/article/replyReturn/{replyid}")
    public String replyReturn(@PathVariable("replyid") String replyid, Model model) {
        System.out.println("*****回復回報*****");
        Optional<ArticleReplyBean> op = as.getReplyByReplyid(replyid);
        op.ifPresent(e -> {
            ArticleBean aBean = as.findById(e.getArticleid());
            aBean.setMemberid(e.getMemberid());
            aBean.setMembername(e.getMembername());
            aBean.setCreatetime(e.getCreatetime());
            model.addAttribute("article", aBean);
            model.addAttribute("articleid", aBean.getArticleid());
            model.addAttribute("replyid", replyid);
        });
        return "/article/return";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存回報
    @RequestMapping("/article/saveReturn")
    public String saveReturn(ArticleReturnBean articleReturnBean, HttpSession session) {
        System.out.println("*****儲存回報*****");
        //將人轉成 舉報人
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        articleReturnBean.setState("未處裡");
        if (memberBean == null) {
            articleReturnBean.setMemberid("");
            articleReturnBean.setMembername("路人");
            as.saveArticleReturn(articleReturnBean);
            return "redirect:/article/returnSuccess.jsp";
        }

        articleReturnBean.setMemberid(memberBean.getMemberid());
        articleReturnBean.setMembername(memberBean.getName());
        as.saveArticleReturn(articleReturnBean);
        return "redirect:/article/returnSuccess.jsp";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //點讚
    @RequestMapping("/article/thumbsup/{articleid}")
    @ResponseBody
    public Boolean thumbsup(@PathVariable("articleid") String articleid, HttpSession session) {
        System.out.println("*****點讚*****");
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        Boolean result = as.thumbsup(articleid, memberBean.getMemberid());
        //計算積分
        new Thread(() -> {
            ArticleBean abean = as.findById(articleid);
            if(abean == null){
                ArticleReplyBean aReplyBean = as.findReplyById(articleid);
                as.Integral(as.findById(aReplyBean.getArticleid()).getMemberid());
            }else {
                as.Integral(abean.getMemberid());
            }
        }).start();
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/recaptcha")
    @ResponseBody
    public Boolean recaptcha(@RequestBody String toke) {
        System.out.println("*****機器人檢查*****");
        return ZeroTools.recaptcha(toke);
    }
}
