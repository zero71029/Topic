package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleContentBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/article")
public class ArticleController {
    final
    ArticleService as;

    public ArticleController(ArticleService as) {
        this.as = as;
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//預覽
    @RequestMapping("/preview")
    public String Signout(Model model, ArticleBean articleBean,@RequestParam("content")String content) {
        System.out.println("*****預覽*****");
        articleBean.setCreatetime(ZeroTools.getTime(new Date()));
        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        model.addAttribute(ArticleContentBean.SESSIONID, content);
        return "/article/preview";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//發布文章
    @RequestMapping("/save")
    public String save(Model model, ArticleBean articleBean,@RequestParam("content")String content , HttpSession session) {
        System.out.println("*****發布文章*****");

        if (articleBean.getArticleid() == null || articleBean.getArticleid().equals("")) {
            articleBean.setArticleid(ZeroTools.getUUID());
            articleBean.setCreatetime(ZeroTools.getTime(new Date()));
            MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
            articleBean.setMemberid(memberBean.getMemberid());
            articleBean.setMembername(memberBean.getName());
            articleBean.setState("未驗證");
            articleBean.setReplytime(articleBean.getCreatetime());
            new Thread(() -> as.Integral(memberBean.getMemberid())).start();
        }
       ArticleBean save =    as.save(articleBean);

        if(save != null){
            ArticleContentBean acBean = new ArticleContentBean(save.getArticleid(),content);
            as.saveArticleContent(acBean) ;
        }


        model.addAttribute(ArticleBean.SESSIONID, articleBean);

        return "redirect:/article/success.jsp";
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點讚
    @RequestMapping("/thumbsup/{articleid}")
    @ResponseBody
    public Boolean thumbsup(@PathVariable("articleid")String articleid, HttpSession session) {
        System.out.println("*****點讚*****");
        MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        Boolean result = as.thumbsup(articleid,memberBean.getMemberid());

        //計算積分
        new Thread(() -> {
            ArticleBean abean = as.findById(articleid);
            as.Integral(abean.getMemberid());
        }).start();
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//細節初始化
    @RequestMapping("/detailInit/{articleid}")
    @ResponseBody
    public Map<String,Object> detailInit(@PathVariable("articleid")String articleid, HttpSession session) {
        System.out.println("*****細節初始化*****");
        MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        Map<String,Object> result = new HashMap<>();
        result.put("replylist",as.getReplyList(articleid));//回復
        result.put("thumbsupNum",as.getThumbsupNum(articleid));//點讚數
        if(memberBean == null){
            result.put("hasThumbsup",false);
        }else {
            result.put("hasThumbsup",as.hasThumbsup(articleid,memberBean.getMemberid()));//登入者是否點讚
        }
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
        ArticleReplyBean save = as.saveArticleReply(arBean);
        new Thread(() -> as.Integral(save.getMemberid())).start();
        new Thread(() -> {
            ArticleBean abean = as.findById(save.getArticleid());
            as.Integral(abean.getMemberid());
        }).start();
        return "redirect:/detail/"+arBean.getArticleid();
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
        return as.getReplyList(article);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/search")
    @ResponseBody
    public Map<String, Object> search( @RequestParam("page")Integer page , @RequestParam("size")Integer size, @RequestParam("search")String search) {
        System.out.println("*****搜索*****");
        page--;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");

        return  as.search(search ,p);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    @RequestMapping("/getContent/{articleid}")
    @ResponseBody
    public Map<String, Object> getContent( @PathVariable("articleid")String articleid ) {
        Map<String, Object> result = new HashMap<>();
        result.put(ArticleBean.SESSIONID,as.findById(articleid));
        result.put(ArticleContentBean.SESSIONID,as.findArticleContentByArticleid(articleid));
        return  result;
    }

}
