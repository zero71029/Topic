package com.jetec.topic;

import com.jetec.topic.Tools.MailTool;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class MailTest {
    @Autowired
    MailTool mailTool;
    @Autowired
    private JavaMailSender mailSender;

    @Test
    void sendToGmail() throws MessagingException {
        String text = """
                    <html><body>
                      <div id="root" style="width: 700px; position: relative; margin: auto;font-weight: 900;">
                        <p style="text-align: center;"> <img src="https://www.jetec.com.tw/sites/default/files/LOGO1126_1.png"
                            style="width: 300px;"></p>
                        <p>%s 您好</p>
                        <p>請點擊下面按鈕來驗證您的電子信箱 <span style="color: #0d6efd;">%s</span> ，已開通久德討論版的會員帳號，發表新文和個性化內容。</p>
                        <a %s href="http://192.168.11.100:8080/topic/CertificationOrder?id=%s" target="_blank">
                        驗證您的Email並訂閱久德最新消息 </a>
                        <p style="text-align: center;"><a href="http://192.168.11.100:8080/topic/Certification?id=%s">驗證您的Email</a></p>
                        <br><br><br>
                        <p>謝謝您</p>
                        <p>久德電子有限公司敬上</p><br>
                        <p>注意：該封郵件是由系統自動寄送的通知信，請不要直接回覆此信。
                          若您需要其他協助，歡迎您透過<a href="https://www.jetec.com.tw/Contact-us">聯絡我們</a>與久德客服團隊聯繫。</p>
                      </div>
                    </body>
                <style>
                  button{
                    cursor: pointer;
                  }
                </style></html>
                    """.formatted("mbean.getName()", "email",  "style='width: 100%;height: 40px;background-color: #0d6efd;color: #fff;border-radius: 5px;border-color: #0d6efd;display: block; text-decoration: none;text-align:center;line-height: 40px;'","uuid", "uuid");

        String Subject = "請在久德討論版認證您的Email";// 主題

        String[] s = new String[1];
        s[0] = "jeter.tony56@gmail.com";

        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setFrom("zero@mail-jetec.com.tw");
        helper.setTo(s);
        helper.setSubject(Subject);
        helper.setText(text, true);

        mailSender.send(mimeMessage);
    }

}
