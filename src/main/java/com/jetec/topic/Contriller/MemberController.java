package com.jetec.topic.Contriller;

import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.ArticleReplyRepository;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.ArticleThumbsupRepository;
import com.jetec.topic.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    MemberService ms;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //預覽
    @RequestMapping("/mypage")
    @ResponseBody
    public Map<String, Object> Signout(HttpSession session) {
        System.out.println("*****我的頁面*****");
        MemberBean member = (MemberBean) session.getAttribute(MemberBean.SESSIONID);

        Map<String, Object> result = ms.init(member);

        return result;
    }


}
