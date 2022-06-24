package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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

    @Autowired
    MemberService ms;
    @Autowired
    ArticleService as;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的頁面
    @RequestMapping("/mypage")
    @ResponseBody
    public Map<String, Object> Signout(HttpSession session) {
        System.out.println("*****我的頁面*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        Map<String, Object> result = ms.init(member);
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的文章
    @RequestMapping("/myArticle")
    @ResponseBody
    public Map<String, Object> myArticle(HttpSession session, @RequestParam("page")Integer page , @RequestParam("size")Integer size) {
        System.out.println("*****我的文章*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        page--;
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> pa =ms.myArticle(member,p);
        Map<String, Object> result = new HashMap<>();

        //取 未看 回復數
        List<ArticleBean> list = pa.getContent();
        List<Map<String, Object>> a = new ArrayList();
        if (member != null) {
            list.forEach(e -> {
                Map<String, Object> artlcle = new HashMap<>();
                Integer i = as.getWatchCount(member.getMemberid(), e.getArticleid());
                artlcle.put("bean", e);
                artlcle.put("watch", i);
                a.add(artlcle);
            });
        }
        //a = { "bean" : articleBean , "watch" : i }



        result.put("list",  a );
        result.put("total",  pa.getTotalElements()  );
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的回復
    @RequestMapping("/myReply")
    @ResponseBody
    public Map<String, Object> myReply(HttpSession session, @RequestParam("page")Integer page , @RequestParam("size")Integer size) {
        System.out.println("*****我的回復*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        page--;
        return ms.myReply(member,page,size);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改我的資料
    @RequestMapping("/revise")
    @ResponseBody
    public Map<String, Object> revise(HttpSession session,MemberBean bean) {
        System.out.println("*****修改我的資料*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        bean.setMemberid(member.getMemberid());
        bean.setEmail(member.getEmail());
        bean.setPassword(member.getPassword());
        bean.setCreatetime(member.getCreatetime());
        bean.setIntegral(member.getIntegral());
        MemberBean save = ms.save(bean);
        session.setAttribute(MemberBean.SESSIONID,save);
        Map<String, Object> result = ms.init(save);
        System.out.println(bean);
        return result;
    }
}
