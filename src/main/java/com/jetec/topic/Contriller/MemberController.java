package com.jetec.topic.Contriller;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    MemberService ms;

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
    public List<ArticleBean> myArticle(HttpSession session) {
        System.out.println("*****我的文章*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);

        return ms.myArticle(member);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的回復
    @RequestMapping("/myReply")
    @ResponseBody
    public List<ArticleBean> myReply(HttpSession session) {
        System.out.println("*****我的回復*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
        return ms.myReply(member);
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
