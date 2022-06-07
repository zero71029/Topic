package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleThumbsupBean;
import com.jetec.topic.service.ArticleService;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TopicController {

    @Autowired
    ArticleService as;

    @RequestMapping("/topiclist")
    public String topiclist(@RequestParam("nav") String nav, @RequestParam("pag") Integer pag, Model model) {
        System.out.println("=====文章列表=====");
        pag--;
        Pageable pageable = PageRequest.of(pag, 20, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> p = as.findByArticlegroup(nav ,pageable);
        model.addAttribute("list" , p.getContent());
        model.addAttribute("total",p.getTotalElements());
        model.addAttribute("totalPag",p.getTotalPages());
        return "/topiclist";
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點讚
    @RequestMapping("/detail/{articleid}")
    public String topicdetailt(@PathVariable("articleid") String articleid, Model model) {
        System.out.println("=====進入文章細節=====");
        model.addAttribute(ArticleBean.SESSIONID,as.findById(articleid));
        JSONArray a = new JSONArray(as.findThumbsup(articleid));
        model.addAttribute(ArticleThumbsupBean.THUMBSUPID,a);
        return "/topicdetail";
    }

}
