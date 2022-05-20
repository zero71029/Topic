package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
}
