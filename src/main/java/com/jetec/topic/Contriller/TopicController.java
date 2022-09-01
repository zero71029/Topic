package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ResultBean;
import com.jetec.topic.Tools.ZeroFactory;
import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.*;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.BackstageService;
import com.jetec.topic.service.LibraryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;


//不限定權限

@Controller
public class TopicController {
    Logger logger = LoggerFactory.getLogger(TopicController.class);
    @Autowired
    ArticleService as;
    @Autowired
    BackstageService BS;
    @Autowired
    LibraryService ls;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章列表
    @RequestMapping("/topiclist")
    @ResponseBody
    public ResultBean topiclist(@RequestParam("nav") String nav, @RequestParam("pag") Integer pag, @RequestParam("size") Integer size, HttpSession session) {
        System.out.println("=====文章列表=====");
        pag--;
        if (pag < 0) pag = 0;
        Pageable pageable = PageRequest.of(pag, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> p = as.findByArticlegroup(nav, pageable);
        Map<String, Object> result = new HashMap<>();

        //取 未看 回復數
        List<ArticleBean> list = p.getContent();
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = null;
        if (sci != null) {
            memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        }

        List<Map<String, Object>> a = new ArrayList<>();
        for (ArticleBean e : list) {
            Map<String, Object> artlcle = new HashMap<>();
            if (memberBean != null) {
                Integer i = as.getWatchCount(memberBean.getMemberid(), e.getArticleid());
                artlcle.put("watch", i);
            }
            e.setTotal(as.countReplyArticle(e.getArticleid()));
            artlcle.put("bean", e);
            a.add(artlcle);
        }
        //a = { "bean" : articleBean , "watch" : i }
        result.put("list", a);
        result.put("total", p.getTotalElements());
        result.put("totalPag", p.getTotalPages());
        return ZeroFactory.success("文章列表", result);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //進入文章細節
    @RequestMapping("/detail/{articleid}")
    public String topicdetailt(@PathVariable("articleid") String articleid, Model model, HttpSession session) {
        logger.info("進入文章細節 {}", articleid);
        ArticleBean articleBean = as.findById(articleid);


        if (articleBean == null) {
            model.addAttribute("message", "找不到文章");
            logger.info("找不到文章 {}", articleid);
            return "error/error500";
        }
        //
        List<PermitBean> permitBeanList = articleBean.getMember().getPermitList();
        for (PermitBean e : permitBeanList) {
            if(Objects.equals(e.getLevel(),9)){
                model.addAttribute("isManage",true);
                break;
            }
        }




        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        model.addAttribute(ArticleContentBean.SESSIONID, as.findArticleContentByArticleid(articleid));
        model.addAttribute(ArticleThumbsupBean.THUMBSUPID, as.findThumbsup(articleid));
        //存觀看時間
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean mBean = null;
        if (sci != null) mBean = (MemberBean) sci.getAuthentication().getPrincipal();
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
        logger.info("進入 修改回復文章  {}", replyid);
        try {
            SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
            MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
            System.out.println(memberBean);
        } catch (Exception e) {
            model.addAttribute("error", "未登入");
            logger.info("未登入");
            return "/error/error";
        }
        if (as.hasReply(replyid)) {
            model.addAttribute(ArticleBean.SESSIONID, as.findReplyById(replyid));
            return "/article/revisereply";
        }

        logger.info("文章不存在");
        model.addAttribute("message", "文章不存在");
        return "/error/error500";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章回復
    @RequestMapping(path = {"/reply/{articleid}"})
    public String reply(HttpSession session, @PathVariable("articleid") String articleid, Model model) {
        logger.info("進入 文章回復  {}", articleid);
        //登入檢查
        try {
            SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
            MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
            System.out.println(memberBean);
        } catch (Exception e) {
            model.addAttribute("error", "未登入");
            logger.info("未登入");
            return "/error/error";
        }

        //
        if (as.hasArticle(articleid)) {
            model.addAttribute(ArticleBean.SESSIONID, as.findById(articleid));
            return "/article/reply";
        }
        model.addAttribute("message", "文章不存在");
        logger.info("文章不存在");
        return "/error/error500";


    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //細節初始化
    @RequestMapping("/topic/detailInit/{articleid}")
    @ResponseBody
    public Map<String, Object> detailInit(@PathVariable("articleid") String articleid, HttpSession session, @RequestParam("p") Integer p) {
        p--;
        logger.info("文章細節初始化");
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = null;
        if (sci != null) memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        Map<String, Object> result = new HashMap<>();
        result.put("replylist", as.getReplyList(articleid, p).get("list"));//回復
        result.put("total", as.getReplyList(articleid, p).get("total"));//總數
        result.put("thumbsupNum", as.getThumbsupNum(articleid));//點讚數
        if (memberBean == null) {
            result.put("hasThumbsup", false);
        } else {
            result.put("hasThumbsup", as.hasThumbsup(articleid, memberBean.getMemberid()));//登入者是否點讚203
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/article/search")
    @ResponseBody
    public Map<String, Object> search(@RequestParam("page") Integer page, @RequestParam("size") Integer size, @RequestParam("search") String search) {
        logger.info("搜索  {}", search);
        page--;
        if(page < 0)page = 0 ;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        return as.search(search, p);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取文章內容
    @RequestMapping("/article/getContent/{articleid}")
    @ResponseBody
    public Map<String, Object> getContent(@PathVariable("articleid") String articleid) {
        Map<String, Object> result = new HashMap<>();
        result.put(ArticleBean.SESSIONID, as.findById(articleid));
        result.put(ArticleContentBean.SESSIONID, as.findArticleContentByArticleid(articleid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //進入文章回報
    @RequestMapping("/article/articleReturn/{articleid}")
    public String articleReturn(@PathVariable("articleid") String articleid, Model model) {
        System.out.println("*****進入文章回報*****");
        ArticleBean aBean = as.findById(articleid);
        if(aBean == null){
            logger.info("文章不存在 {}",articleid);
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if(authentication ==null ){
                logger.info("未登入");
            }else {
                MemberBean memberBean = (MemberBean) authentication.getPrincipal();
                logger.info("登入者 {}", memberBean.getName());
            }
            model.addAttribute("message","文章不存在");
            return "error/error500";
        }

        model.addAttribute("article", aBean);
        model.addAttribute("articleid", aBean.getArticleid());
        model.addAttribute("replyid", aBean.getArticleid());
        return "/article/return";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //進入回復回報
    @RequestMapping("/article/replyReturn/{replyid}")
    public String replyReturn(@PathVariable("replyid") String replyid, Model model) {
        System.out.println("*****進入回復回報*****");
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
        articleReturnBean.setState("未處裡");
        MemberBean memberBean;
        //將人轉成 舉報人
        //登入檢查
        try {
            SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
            memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        } catch (Exception e) {
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
            if (abean == null) {
                ArticleReplyBean aReplyBean = as.findReplyById(articleid);
                as.Integral(as.findById(aReplyBean.getArticleid()).getMemberid());
            } else {
                as.Integral(abean.getMemberid());
            }
        }).start();
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //機器人檢查
    @RequestMapping("/recaptcha")
    @ResponseBody
    public Boolean recaptcha(@RequestBody String toke) {
        System.out.println("*****機器人檢查*****");
        return ZeroTools.recaptcha(toke);
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //廣告初始化
    @RequestMapping("/topic/advertiseinit")
    @ResponseBody
    public List<AdvertiseBean> advertiseinit(@RequestParam("location") String location) {
        return BS.findAdvertiseByLocation(location);
    }

    //取得選項
    @RequestMapping("/topic/getOption/{group}")
    @ResponseBody
    public ResultBean getOption(@PathVariable("group") String group) {
        System.out.println("取得選項");
        switch (group) {
            case "apparatus":
                group = "儀器儀錶";
                break;
            case "sensor":
                group = "感測器";
                break;
            case "Netcom":
                group = "網通裝置";
                break;
            case "software":
                group = "軟體配件";
                break;
            case "controlbox":
                group = "控制箱";
                break;
            case "application":
                group = "應用";
                break;
            default:
                return ZeroFactory.buildResultBean(400, "輸入錯誤");
        }

        return ZeroFactory.buildResultBean(200, "取得選項成功", ls.getOption(group));
    }

}
