package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.SystemCode;
import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.CollectBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.CollectService;
import com.jetec.topic.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    Logger logger = LoggerFactory.getLogger(MemberController.class);
    @Autowired
    MemberService ms;
    @Autowired
    ArticleService as;
    @Autowired
    CollectService cs;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的頁面
    @RequestMapping("/mypage")
    @ResponseBody
    public Map<String, Object> signout(HttpSession session) {
        logger.info("我的頁面  {}", ZeroTools.getMemberBean().getName());
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        //計算積分
        as.Integral(memberBean.getMemberid());
        Map<String, Object> result = new HashMap<>();

        result.put("code", SystemCode.ISOK);
        //回復文章數
        result.put("replyNum", as.countReplyByMemberid(memberBean.getMemberid()));
        //發表文章數
        result.put("articleNum", as.countByMemberid(memberBean.getMemberid()));
        result.put(MemberBean.SESSIONID, ms.getMemberById(memberBean.getMemberid()));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的文章
    @RequestMapping("/myArticle")
    @ResponseBody
    public Map<String, Object> myArticle(HttpSession session, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {
        logger.info("我的文章  {}", ZeroTools.getMemberBean().getName());
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        page--;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> pa = ms.myArticle(memberBean, p);
        Map<String, Object> result = new HashMap<>();

        //取 未看 回復數
        List<ArticleBean> list = pa.getContent();
        List<Map<String, Object>> a = new ArrayList<>();
        list.forEach(e -> {
            Map<String, Object> artlcle = new HashMap<>();
            Integer i = as.getWatchCount(memberBean.getMemberid(), e.getArticleid());
            e.setTotal(as.countReplyArticle(e.getArticleid()));
            artlcle.put("bean", e);
            artlcle.put("watch", i);
            a.add(artlcle);
        });

        //a = { "bean" : articleBean , "watch" : i }


        result.put("list", a);
        result.put("total", pa.getTotalElements());
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的回復
    @RequestMapping("/myReply")
    @ResponseBody
    public Map<String, Object> myReply(HttpSession session, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
        page--;
        logger.info("我的回復  {}", memberBean.getName());
        return ms.myReply(memberBean, page, size);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改我的資料
    @RequestMapping("/revise")
    @ResponseBody
    public Map<String, Object> revise(HttpSession session, MemberBean bean) {
        System.out.println("*****修改我的資料*****");
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean member = (MemberBean) sci.getAuthentication().getPrincipal();
        bean.setMemberid(member.getMemberid());
        bean.setEmail(member.getEmail());
        bean.setPassword(member.getPassword());
        bean.setCreatetime(member.getCreatetime());
        bean.setIntegral(member.getIntegral());
        MemberBean save = ms.save(bean);
        Map<String, Object> result = new HashMap<>();
        //回復文章數
        result.put("replyNum", as.countReplyByMemberid(member.getMemberid()));
        //發表文章數
        result.put("articleNum", as.countByMemberid(member.getMemberid()));
        result.put(MemberBean.SESSIONID, save);
        logger.info("修改我的資料 {}", bean.getName());
        return result;
    }


    @RequestMapping("/mycollect")
    @ResponseBody
    public Map<String, Object> mycollect(HttpSession session, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {


        MemberBean memberBean = ZeroTools.getMemberBean();
        logger.info("我的收藏  {}", memberBean.getName());




        page--;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<CollectBean> pa = cs.findByMemberid(memberBean.getMemberid(), p);
        Map<String, Object> result = new HashMap<>();

        //取 未看 回復數
        List<CollectBean> list = pa.getContent();
        List<Map<String, Object>> a = new ArrayList<>();
        list.forEach(e -> {
            Map<String, Object> artlcle = new HashMap<>();


            Integer i = as.getWatchCount(memberBean.getMemberid(), e.getArticleid());


            ArticleBean articleBean = as.findById( e.getArticleid());
            articleBean.setTotal(as.countReplyArticle(e.getArticleid()));

            artlcle.put("bean",     articleBean           );
            artlcle.put("watch", i);
            a.add(artlcle);
        });

        //a = { "bean" : articleBean , "watch" : i }


        result.put("list", a);
        result.put("total", pa.getTotalElements());
        return result;
    }
}
