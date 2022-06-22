package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.MailTool;
import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class LoginController {
    @Autowired
    LoginService ls;
    @Autowired
    ArticleService as;
    @Autowired
    MailTool mailTool;

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
        session.setAttribute(MemberBean.SESSIONID, mBean);

        //計算積分
        new Thread(() -> as.Integral(mBean.getMemberid())).start();
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
        model.addAttribute("check", true);
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
            Optional<MemberBean> mBean = ls.getMemberByEmail(authentication.getName());
            if (mBean.isPresent()) {
                session.setAttribute(MemberBean.SESSIONID, mBean);
                return true;
            } else {
                return false;

            }
        } else {
            System.out.println("沒有authentication");
        }
        return false;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //忘記密碼
    @RequestMapping(path = {"/forget"})
    public String forget(@RequestParam("email") String email, Model model, @RequestParam("g-recaptcha-response") String recaptcha) {
        System.out.println("*****忘記密碼*****");
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);
        model.addAttribute("email", email);

        //我不是機器人檢查
        if (ZeroTools.recaptcha(recaptcha)) {
            System.out.println("任鄭成功");
            Optional<MemberBean> op = ls.getMemberByEmail(email);

            if (op.isPresent()) {
                MemberBean bean = op.get();
                System.out.println(bean);
                String uuid = ZeroTools.getUUID();


// 郵件格式判斷
                if (bean.getEmail() == null || bean.getEmail().length() == 0) {
                    errors.put("email", "Email錯誤");
                }
                if (!bean.getEmail().contains("@"))
                    errors.put("email", "Email錯誤");
                System.out.println("errors");
                System.out.println(errors);
                if (errors != null && !errors.isEmpty())
                    return "/member/forget";

                // 儲存認證碼?
                ls.saveAuthorize(uuid, bean.getMemberid());

// 寄發郵件
                String text = "<html><body><p><a href='http://192.168.11.100:8080/topic/member/reset.jsp?id=" + uuid + "'>從新設定密碼</a></p></body></html>";

                String Subject = "從新設定密碼";// 主題

                try {
                    mailTool.sendlineMail(bean.getEmail(), Subject, text);
                } catch (Exception e) {
                    e.printStackTrace();
                }
//            zTools.mail(bean.getEmail(), text, Subject, maillist);
                return "redirect:/member/forgetSend.jsp";
            }
            System.out.println("查不到這個Email");
            errors.put("email", "查不到這個Email");
        }
        System.out.println("XXXXXXXX");
        errors.put("recaptcha", "認證未過");
        System.out.println(errors);
        return "/member/forget";

    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //


}
