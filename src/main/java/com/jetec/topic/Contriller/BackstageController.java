package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.BackstageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/backstage")
public class BackstageController {
    @Autowired
    BackstageService BS;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化
    @RequestMapping("/init")
    @ResponseBody
    public Map<String , Object> init(@RequestParam("page")Integer page,@RequestParam("pageSize")Integer size) {
        page--;
        System.out.println("初始化");
        Map<String , Object> result = BS.init(page,size);
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //細節
    @RequestMapping("/detail/{id}")
    @ResponseBody
    public MemberBean detail(@PathVariable("id")String memberid) {
        System.out.println("客戶細節");
        return BS.getMember(memberid);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章列表初始化
    @RequestMapping("/articleLiat")
    @ResponseBody
    public Map<String , Object> articleLiat(@RequestParam("page")Integer page,@RequestParam("pageSize")Integer size) {
        page--;
        System.out.println("文章列表初始化");
        Map<String , Object> result = BS.articleLiat(page,size);
        System.out.println("********************************************************");
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章細節
    @RequestMapping("/articleDetail/{id}")
    @ResponseBody
    public ArticleBean articleDetail(@PathVariable("id")String articleid) {
        System.out.println("文章細節");
        return BS.getarticleDetail(articleid);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    @RequestMapping("/changeState/{state}/{articleid}")
    @ResponseBody
    public boolean changeState(@PathVariable("articleid")String articleid,@PathVariable("state")String state) {
        System.out.println("article修改狀態");
        return BS.changeState(articleid,state);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    @RequestMapping("/replyState/{state}/{replyid}")
    @ResponseBody
    public List<ArticleReplyBean> replyState(@PathVariable("replyid")String replyid, @PathVariable("state")String state) {
        System.out.println("reply修改狀態");
        ArticleReplyBean aBean =  BS.replyState(replyid,state);
        List<ArticleReplyBean> result = BS.getArticleReplyList(aBean.getArticleid());
        return result;
    }
}
