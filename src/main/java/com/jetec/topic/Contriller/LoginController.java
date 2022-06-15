package com.jetec.topic.Contriller;

import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {
    @Autowired
    LoginService ls;
    @Autowired
    ArticleService as;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入
    @RequestMapping("/home")
    public String login(HttpSession session) {
        System.out.println("*****登入成功*****");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
        String Username;
        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            Username = userDetails.getUsername();
        } else {
            Username = principal.toString();
        }
        System.out.println(Username);
        MemberBean mBean = ls.findByEmail(Username);
        session.setAttribute(mBean.SESSIONID, mBean);

        //計算積分
        new Thread(() -> {
            as.Integral(mBean.getMemberid());
        }).start();
        return "redirect:/index";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登出
    @RequestMapping(path = {"/Signout"})
    public String Signout(HttpSession session) {
        System.out.println("*****登出*****");
        session.invalidate();
        return "redirect:/index";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新註冊
    @RequestMapping("/register")
    public String SaveAdmin(MemberBean bean, Model model) {
        System.out.println("*****新註冊*****");
//        boolean recaptcha = zTools.recaptcha(token);// 機器人判斷
        //使有輸入的資料能返回
        model.addAttribute("email", bean.getEmail());
        model.addAttribute("name", bean.getName());
        model.addAttribute("password", bean.getPassword());
        model.addAttribute("phone", bean.getPhone());
        model.addAttribute("company", bean.getCompany());
        model.addAttribute("check",true);
        // 接收資料
        // 轉換資料
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);

        // 機器人判斷
//        if (!recaptcha) {
//            System.out.println("errors.put(recaptcha, 需要驗證)");
//            errors.put("recaptcha", "需要驗證");
//        }

        if (ls.existsMemberByName(bean.getName())) errors.put("username", "暱稱被使用過");
        if (ls.existsMemberByEnail(bean.getEmail())) errors.put("email", "Email被使用過");

        if (errors.isEmpty()) {
            ls.saveMember(bean);
            return "redirect:/member/registerSuccess.jsp";
        }
        System.out.println("發生錯誤,返回");
        return "/member/register";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    @ResponseBody
    @RequestMapping(path = {"/UserAuthorize"})
    public boolean UserAuthorize(Authentication authentication, HttpSession session) {
        System.out.println("*****登入驗證*****");
        // 驗證 補session user
        if (authentication != null) {
            System.out.println("有authentication");
            MemberBean mBean =   ls.getMemberByEmail(authentication.getName());
            if(mBean == null){
                return false;
            }else {
                session.setAttribute(mBean.SESSIONID,mBean);
                return true;
            }
        } else {
            System.out.println("沒有authentication");
        }
        return false;
    }

}
