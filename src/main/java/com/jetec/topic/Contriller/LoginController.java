package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.MailTool;
import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.ArticleService;
import com.jetec.topic.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
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
//        Object principal = authentication.getPrincipal();
//        String Username;
//        if (principal instanceof UserDetails userDetails) {
//            Username = userDetails.getUsername();
//        } else {
//            Username = principal.toString();
//        }
//        System.out.println(Username);
//        MemberBean mBean = ls.findByEmail(Username);
//        session.setAttribute(MemberBean.SESSIONID, mBean);
//        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean memberBean = (MemberBean) authentication.getPrincipal();
        //計算積分
        new Thread(() -> as.Integral(memberBean.getMemberid())).start();
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
    public String SaveAdmin(MemberBean bean, Model model, @RequestParam("g-recaptcha-response") String token) {
        System.out.println("*****新註冊*****");
        //使有輸入的資料能返回
        model.addAttribute("email", bean.getEmail());
        model.addAttribute("name", bean.getName());
        model.addAttribute("password", bean.getPassword());
        model.addAttribute("phone", bean.getPhone());
        model.addAttribute("company", bean.getCompany());
        model.addAttribute("check", true);

        // 錯誤輸出
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);

        // 機器人判斷
        if (!ZeroTools.recaptcha(token)) {
            errors.put("recaptcha", "需要驗證");
        }

        if (ls.existsMemberByName(bean.getName())) errors.put("username", "暱稱被使用過");
        if (ls.existsMemberByEnail(bean.getEmail())) errors.put("email", "Email被使用過");
        //沒有錯誤, 儲存資料 ,存權限 ,寄認證信
        if (errors.isEmpty()) {
            String uuid = ZeroTools.getUUID();
            //寄認證信
            String text = """
                    <html><body>
                      <div id="root" style="width: 700px; position: relative; margin: auto;font-weight: 900;">
                        <p style="text-align: center;"> <img src="https://www.jetec.com.tw/sites/default/files/LOGO1126_1.png"
                            style="width: 300px;"></p>
                        <p>%s 您好</p>
                        <p>請點擊下面按鈕來驗證您的電子信箱 <span style="color: #0d6efd;">%s</span> ，已開通久德討論版的會員帳號，發表新文和個性化內容。</p>
                        <a %s href="http://192.168.11.100:8080/Forum/CertificationOrder?id=%s" target="_blank">
                        驗證您的Email並訂閱久德最新消息 </a>
                        <p style="text-align: center;"><a href="http://192.168.11.100:8080/Forum/Certification?id=%s">驗證您的Email</a></p>
                        <br><br><br>
                        <p>謝謝您</p>
                        <p>久德電子有限公司敬上</p><br>
                        <p>注意：該封郵件是由系統自動寄送的通知信，請不要直接回覆此信。
                          若您需要其他協助，歡迎您透過<a href="https://www.jetec.com.tw/Contact-us">聯絡我們</a>與久德客服團隊聯繫。</p>
                      </div>
                    </body></html>
                    """.formatted(bean.getName(), bean.getEmail(), "style='width: 100%;height: 40px;background-color: #0d6efd;color: #fff;border-radius: 5px;border-color: #0d6efd;display: block; text-decoration: none;text-align:center;line-height: 40px;'", uuid, uuid);
            String Subject = "請在久德討論版認證您的Email";// 主題
            try {
                mailTool.sendlineMail(bean.getEmail(), Subject, text);
                //存會員
                MemberBean save = ls.saveMember(bean);
                //存認證
                ls.saveAuthorize(uuid, save.getMemberid());
                //存權限
                ls.savePermit(uuid, save.getMemberid(), 0);


            } catch (Exception e) {
                e.printStackTrace();
                return "redirect:/error/error500.jsp";
            }

            return "redirect:/member/registerSuccess.jsp";
        }
        return "/member/register";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //登入驗證
//    @ResponseBody
//    @RequestMapping(path = {"/UserAuthorize"})
//    public boolean UserAuthorize(Authentication authentication, HttpSession session) {
//        System.out.println("*****登入驗證*****");
//        // 驗證 補session user
//        if (authentication != null) {
//            System.out.println("有authentication");
//            Optional<MemberBean> op = ls.getMemberByEmail(authentication.getName());
//            if (op.isPresent()) {
//                session.setAttribute(MemberBean.SESSIONID, op.get());
//                return true;
//            } else {
//                return false;
//
//            }
//        } else {
//            System.out.println("沒有authentication");
//        }
//        return false;
//    }

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
            Optional<MemberBean> op = ls.getMemberByEmail(email);
            if (op.isPresent()) {
                MemberBean bean = op.get();
                String uuid = ZeroTools.getUUID();
                // 郵件格式判斷
                if (bean.getEmail() == null || bean.getEmail().length() == 0) {
                    errors.put("email", "Email錯誤");
                }
                if (!bean.getEmail().contains("@")) errors.put("email", "Email錯誤");
                if (!errors.isEmpty()) return "/member/forget";

                // 儲存認證碼?
                ls.saveAuthorize(uuid, bean.getMemberid());

                // 寄發郵件


                String text = """
                          <html><body>
                            <div id="root" style="width: 700px; position: relative; margin: auto;font-weight: 900;">
                              <p style="text-align: center;"> <img src="https://www.jetec.com.tw/sites/default/files/LOGO1126_1.png"
                                  style="width: 300px;"></p>
                              <p>%s 您好</p>
                              <p>這是管理者介面重設密碼通知信，要求變更久德討論版中 帳號 的管理者密碼，若不是您本人申請，請忽略此封信件。</p><br>
                              <p>如果您有重置密碼需求，請於申請後24小時內點選下方連結，並輸入新的密碼完成變更。
                                若超過時間請重新申請重複申請以最新的信件為準。</p>
                              <p style="text-align: center;"> <a href="http://192.168.11.100:8080/Forum/member/reset.jsp?id=%s" target="_blank">
                                  重置密碼</a></p>
                              <br><br><br>
                              <p>謝謝您</p>
                              <p>久德電子有限公司敬上</p><br>
                              <p>注意：該封郵件是由系統自動寄送的通知信，請不要直接回覆此信。
                                若您需要其他協助，歡迎您透過<a href="https://www.jetec.com.tw/Contact-us">聯絡我們</a>與久德客服團隊聯繫。</p>
                            </div>
                          </body></html>
                        """.formatted(bean.getName(), uuid);
                System.out.println(text);
                String Subject = "久德討論版重置密碼申請";// 主題
                try {
                    mailTool.sendlineMail(bean.getEmail(), Subject, text);
                } catch (Exception e) {
                    e.printStackTrace();
                }
//            zTools.mail(bean.getEmail(), text, Subject, maillist);
                return "redirect:/member/forgetSend.jsp";
            }
            errors.put("email", "查不到這個Email");
        }
        errors.put("recaptcha", "認證未過");
        return "/member/forget";
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //密碼重置
    @RequestMapping(path = {"/reset"})
    @ResponseBody
    public String reset(@RequestParam("id") String id, @RequestParam("password") String passwoed) {
        System.out.println("*****密碼重置*****");
        //檢查認證碼
        String auth = ls.checkAithorize(id);
        if (Objects.equals(auth, "時效過期") || Objects.equals(auth, "錯誤")) {
            return "認證碼" + auth + ",請重新申請";
        }
        //取出member  後儲存
        Optional<MemberBean> op = ls.getMemberById(auth);
        if (op.isPresent()) {
            MemberBean mBean = op.get();
            mBean.setPassword(passwoed);
            ls.saveMember(mBean);
            return "修改成功,請用新密碼登入";
        }
        return "錯誤,請重新申請";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //點認證信
    @RequestMapping(path = {"/Certification"})
    public String certification(@RequestParam("id") String id, Model model) {
        System.out.println("*****點認證信*****");
        //檢查認證碼
        String auth = ls.checkAithorize(id);
        if (Objects.equals(auth, "時效過期") || Objects.equals(auth, "錯誤")) {
            model.addAttribute("error", "認證碼" + auth + ",請重新申請 ");
            return "/member/certification";
        }
        //取出member  新增權限
        ls.savePermit(ZeroTools.getUUID(), auth, 1);
        model.addAttribute("message", "認證成功,歡迎您的加入");
        return "/member/certification";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //認證 and 訂閱Email
    @RequestMapping(path = {"/CertificationOrder"})
    public String CertificationOrder(@RequestParam("id") String id, Model model) {
        System.out.println("*****認證 and 訂閱Email*****");
        //檢查認證碼
        String auth = ls.checkAithorize(id);
        if (Objects.equals(auth, "時效過期") || Objects.equals(auth, "錯誤")) {
            model.addAttribute("error", "認證碼" + auth + ",請重新申請 ");
            return "/member/certification";
        }
        //取出member  新增權限
        ls.savePermit(ZeroTools.getUUID(), auth, 1);
        model.addAttribute("message", "認證成功,歡迎您的加入");
        MemberBean mBean = ls.findMemberById(auth);

        String Subject = "訂閱Email";
        String text = """
                訂閱Email by 討論版<br>
                <br>
                會員資料<br>
                ==========================<br>
                暱稱 : %s<br>
                Email : %s<br>
                公司-組織 : %s<br>
                連絡電話 : %s<br>                                
                """.formatted(mBean.getName(), mBean.getEmail(), mBean.getCompany(), mBean.getPhone());
        try {
            String[] address = new String[3];

            address[0] = "jeter.tony56@gmail.com";
            address[1] = "marketing@mail-jetec.com.tw";
            address[2] = "jetec.co@msa.hinet.net";

            mailTool.sendlineMail(address, Subject, text);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/member/certification";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //重寄認證信
    @RequestMapping(path = {"/reSend"})
    public String reSend(@RequestParam("email") String email, Model model, @RequestParam("g-recaptcha-response") String token) {
        System.out.println("*****重寄認證信*****");
        //使有輸入的資料能返回
        model.addAttribute("email", email);
        // 錯誤輸出
        Map<String, String> errors = new HashMap<>();
        model.addAttribute("errors", errors);
        // 機器人判斷
        if (!ZeroTools.recaptcha(token)) {
            errors.put("recaptcha", "需要驗證");
        }
        if (!ls.existsMemberByEnail(email)) errors.put("email", "未找到Email");
        if (ls.existsPermetByEmailAndLevel(email, 1)) errors.put("level", "已經通過認證");
        //沒有錯誤, 儲存資料 ,存權限 ,寄認證信
        if (errors.isEmpty()) {
            String uuid = ZeroTools.getUUID();
            MemberBean mbean = ls.findByEmail(email);
            //存認證
            ls.saveAuthorize(uuid, mbean.getMemberid());
            //寄認證信


            String text = """
                        <html><body>
                          <div id="root" style="width: 700px; position: relative; margin: auto;font-weight: 900;">
                            <p style="text-align: center;"> <img src="https://www.jetec.com.tw/sites/default/files/LOGO1126_1.png"
                                style="width: 300px;"></p>
                            <p>%s 您好</p>
                            <p>請點擊下面按鈕來驗證您的電子信箱 <span style="color: #0d6efd;">%s</span> ，已開通久德討論版的會員帳號，發表新文和個性化內容。</p>
                            <a %s href="http://192.168.11.100:8080/Forum/CertificationOrder?id=%s" target="_blank">
                            驗證您的Email並訂閱久德最新消息 </a>
                            <p style="text-align: center;"><a href="http://192.168.11.100:8080/Forum/Certification?id=%s">驗證您的Email</a></p>
                            <br><br><br>
                            <p>謝謝您</p>
                            <p>久德電子有限公司敬上</p><br>
                            <p>注意：該封郵件是由系統自動寄送的通知信，請不要直接回覆此信。
                              若您需要其他協助，歡迎您透過<a href="https://www.jetec.com.tw/Contact-us">聯絡我們</a>與久德客服團隊聯繫。</p>
                          </div>
                        </body>
                    <style></html>
                        """.formatted(mbean.getName(), mbean.getEmail(), "style='width: 100%;height: 40px;background-color: #0d6efd;color: #fff;border-radius: 5px;border-color: #0d6efd;display: block; text-decoration: none;text-align:center;line-height: 40px;'", uuid, uuid);

            String Subject = "請在久德討論版認證您的Email";// 主題
            try {
                mailTool.sendlineMail(mbean.getEmail(), Subject, text);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return "redirect:/member/registerSuccess.jsp";
        }
        return "/member/reSend";
    }
}
