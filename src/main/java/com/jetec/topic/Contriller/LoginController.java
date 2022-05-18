package com.jetec.topic.Contriller;

import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {
    @Autowired
    LoginService ls;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入
    @RequestMapping("/home")
    public String login( HttpSession session) {
        System.out.println("*****登入成功*****");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        Object principal =authentication.getPrincipal();
        String Username;
        if(principal instanceof UserDetails) {

            UserDetails userDetails = (UserDetails) principal;
             Username = userDetails.getUsername();

        }else {
            Username = principal.toString();

        }
        System.out.println(Username);
        MemberBean mBean = ls.findByEmail(Username);
        session.setAttribute(mBean.SESSIONID,mBean);
     return "redirect:/topiclist.jsp?pag=1";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登出
    @RequestMapping(path = {"/Signout"})
    public String Signout(HttpSession session) {
        System.out.println("*****登出*****");
        session.invalidate();
        return "redirect:/topiclist.jsp";
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新註冊
    @RequestMapping("/register")
    public String SaveAdmin(MemberBean bean, Model model) {
        System.out.println("*****新註冊*****");
//        boolean recaptcha = zTools.recaptcha(token);// 機器人判斷
        //使有輸入的資料能返回
        model.addAttribute("email", bean.getEmail());
        model.addAttribute("username", bean.getName());
        model.addAttribute("userpassword", bean.getPassword());
        model.addAttribute("userphone", bean.getPhone());
        model.addAttribute("company", bean.getCompany());
        // 接收資料
        // 轉換資料
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);

        // 機器人判斷
//        if (!recaptcha) {
//            System.out.println("errors.put(recaptcha, 需要驗證)");
//            errors.put("recaptcha", "需要驗證");
//        }

        if(ls.existsMemberByName(bean.getName()))errors.put("username", "暱稱被使用過");
        if(ls.existsMemberByEnail(bean.getEmail()))errors.put("email", "Email被使用過");


        if(errors.isEmpty()){
           ls.saveMember(bean);
        }










        return "/member/registerSuccess";

    }

}
