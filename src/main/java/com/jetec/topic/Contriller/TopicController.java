package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleContentBean;
import com.jetec.topic.model.ArticleThumbsupBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        MemberBean mBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        List<Map<String, Object>> a = new ArrayList();
        list.forEach(e -> {
            Map<String, Object> artlcle = new HashMap<>();
            if (mBean != null) {
                Integer i = as.getWatchCount(mBean.getMemberid(), e.getArticleid());
                artlcle.put("watch", i);
            }
            artlcle.put("bean", e);
            a.add(artlcle);
        });
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
        MemberBean mBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        new Thread(() -> {
            if (mBean != null) {
                as.saveWatchTime(mBean, articleid);
            }
        }).start();
        return "/topicdetail";
    }

}
