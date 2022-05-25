package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
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

import javax.servlet.http.HttpSession;

@Controller
public class PublicController {
    @Autowired
    ArticleService as;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入
    @RequestMapping(path = {"/", "/index"})
    public String index(HttpSession session, Model model) {
        Pageable pageable = PageRequest.of(0, 20, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> p = as.findall( pageable);
        model.addAttribute("list" , p.getContent());
        model.addAttribute("total",p.getTotalElements());
        model.addAttribute("totalPag",p.getTotalPages());
        return "/topiclist";
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






}
