package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.MailTool;
import com.jetec.topic.Tools.ResultBean;
import com.jetec.topic.Tools.ZeroFactory;
import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleContentBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.CollectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;


//限定權限
@Controller
@PreAuthorize("hasAuthority('1') OR hasAuthority('2') OR hasAuthority('3')OR hasAuthority('4')OR hasAuthority('5')OR hasAuthority('6')OR hasAuthority('7')OR hasAuthority('8')OR hasAuthority('9')")
@RequestMapping("/article")
public class ArticleController {
    Logger logger = LoggerFactory.getLogger("ArticleController.class");
    @Autowired
    MailTool mail;

    @Autowired
    CollectService cs;

    final ArticleService as;

    public ArticleController(ArticleService as) {
        this.as = as;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //預覽
    @RequestMapping("/preview")
    public String Signout(Model model, ArticleBean articleBean, @RequestParam("content") String content) {
        System.out.println("*****預覽*****");
        articleBean.setCreatetime(ZeroTools.getTime(new Date()));
        model.addAttribute(ArticleBean.SESSIONID, articleBean);
        model.addAttribute(ArticleContentBean.SESSIONID, content);
        return "/article/preview";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //發布文章
    @RequestMapping("/save")
    public String save(ArticleBean articleBean, @RequestParam("content") String content) {
        MemberBean memberBean = ZeroTools.getMemberBean();
        logger.info("*****發布文章*****{}", memberBean.getName());
        //如果是新案件  插入基本資料
        if (articleBean.getArticleid() == null || articleBean.getArticleid().equals("")) {
            articleBean.setArticleid(ZeroTools.getUUID());
            articleBean.setCreatetime(ZeroTools.getTime(new Date()));
            articleBean.setMemberid(memberBean.getMemberid());
            articleBean.setMembername(memberBean.getName());
            articleBean.setState("未驗證");
            articleBean.setReplytime(articleBean.getCreatetime());
            //寄信
            new Thread(() -> {
                try {
//                    mail.sendSimpleMail("jeter.tony56@gmail.com", "久德討論版有新文章", "https://forum.jetec.com.tw/Backend/article/Detail?id=" + articleBean.getArticleid());
                } catch (Exception e) {
                    e.printStackTrace();
                    logger.info("發布文章  寄信失敗");
                }
            }).start();
            //計算積分
            new Thread(() -> as.Integral(memberBean.getMemberid())).start();
        }

        //預防基本XSS
        content = ZeroTools.xssEncode(content);


        //儲存
        ArticleBean save = as.save(articleBean);
        if (save != null) {
            ArticleContentBean acBean = new ArticleContentBean(save.getArticleid(), content);
            as.saveArticleContent(acBean);
        }
        return "redirect:/article/success.jsp";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//文章回復 儲存
    @RequestMapping(path = {"/saveReply"})
    public String saveReply(ArticleReplyBean arBean) {
        logger.info("文章回復 articleid:{}  name:{}", arBean.getArticleid(), ZeroTools.getMemberBean().getName());
        //新回復
        if (arBean.getReplyid() == null || arBean.getReplyid().isEmpty()) {
            arBean.setReplyid(ZeroTools.getUUID());
            arBean.setCreatetime(ZeroTools.getTime(new Date()));
            Integer floor = as.getArticleFloor(arBean.getArticleid());
            arBean.setFloor(floor + 2);
        }
        arBean.setState("未讀");
        ArticleReplyBean save = as.saveArticleReply(arBean);
        //計算積分
        new Thread(() -> as.Integral(save.getMemberid())).start();
        new Thread(() -> {
            ArticleBean abean = as.findById(save.getArticleid());
            as.Integral(abean.getMemberid());
            //寄送通知
            String content = """
                    文章回復 <br>
                    文章:   <a  href="https://forum.jetec.com.tw/Forum/detail/%s" target="_blank">
                            文章鏈接 </a><br>     
                    回復:   %S<br>
                    """.formatted(arBean.getArticleid(), arBean.getContent());
            try {
                mail.sendlineMail("jeter.tony56@gmail.com", "討論區文章回復", content);
            } catch (Exception e) {
                logger.info("文章回復 articleid:{}  name:{}  寄信失敗", arBean.getArticleid(), ZeroTools.getMemberBean().getName());
            }
        }).start();
        return "redirect:/detail/" + arBean.getArticleid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存留言
    @RequestMapping(path = {"/savemessage"})
    @ResponseBody
    public Map<String, Object> savemessage(ArticleReplyBean arBean, @RequestParam("article") String article, @RequestParam("p") Integer p) {
        p--;
        logger.info("儲存留言 articleid:{}  name:{}", article, ZeroTools.getMemberBean().getName());
        arBean.setReplyid(ZeroTools.getUUID());
        arBean.setCreatetime(ZeroTools.getTime(new Date()));
        as.saveArticleReply(arBean);
        ArticleReplyBean aBean = as.findReplyById(arBean.getArticleid());
        if (aBean != null) {
            aBean.setState("未讀");
            as.saveArticleReply(aBean);
            //寄送留言
            new Thread(() -> {
                String content = """
                        文章留言 <br>
                        文章:   <a  href="https://forum.jetec.com.tw/Forum/detail/%s" target="_blank">
                                文章鏈接 </a><br>     
                        留言:   %S<br>
                        """.formatted(aBean.getArticleid(), aBean.getContent());
                try {
                    mail.sendlineMail("jeter.tony56@gmail.com", "討論區文章留言", content);
                } catch (Exception e) {
                    logger.info("文章留言 articleid:{}  name:{}  寄信失敗", aBean.getArticleid(), ZeroTools.getMemberBean().getName());
                }

            }).start();
        }

        return as.getReplyList(article, p);
    }


    /**
     * 收集
     *
     * @param articleid 正如
     * @return {@link ResultBean}
     */
    @RequestMapping("/collect")
    @ResponseBody
    public ResultBean collect(@RequestParam("articleid") String articleid) {
        logger.info("{}  收藏   {}", ZeroTools.getMemberBean().getName(), articleid);
        return ZeroFactory.success(cs.collect(ZeroTools.getMemberBean(), articleid));
    }
}
