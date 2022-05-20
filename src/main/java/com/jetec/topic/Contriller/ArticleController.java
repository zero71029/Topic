package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

@Controller
@RequestMapping("/article")
public class ArticleController {

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//預覽
    @RequestMapping("/preview")
    public String Signout(Model model, ArticleBean articleBean) {
        System.out.println("*****預覽*****");
        articleBean.setCreatetime(ZeroTools.getTime(new Date()));
        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        return "/article/preview";
    }


}
