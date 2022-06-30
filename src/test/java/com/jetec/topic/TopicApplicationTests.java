package com.jetec.topic;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;


class TopicApplicationTests {
    @Test
    void test() {


        String query = """
               SELECT "EMP_ID", "LAST_NAME" FROM "EMPLOYEE_TB"
               WHERE "CITY" = '%s' AND author = '%s'
               ORDER BY "EMP_ID", "LAST_NAME";
               """;
        System.out.println(query.formatted("深圳", "棧長"));
        String text = """
                <html><body>
                  <div id="root" style="width: 700px; position: relative; margin: auto;font-weight: 900;">
                    <p style="text-align: center;"> <img src="https://www.jetec.com.tw/sites/default/files/LOGO1126_1.png"
                        style="width: 300px;"></p>
                    <p>%s 您好</p>
                    <p>請點擊下面按鈕來驗證您的電子信箱 <span style="color: #0d6efd;">jetecmarketing03@gmail.com</span> ，已開通久德討論版的會員帳號，發表新文和個性化內容。</p>
                    <button onclick="javascript:window.open('http://192.168.11.100:8080/topic/orderEmail?id=%s')"
                     %s >驗證您的Email並訂閱久德最新消息</button>
                    <p style="text-align: center;"><a href="http://192.168.11.100:8080/topic/Certification?id=%s">驗證您的Email</a></p>
                    <br><br><br>
                    <p>謝謝您</p>
                    <p>久德電子有限公司敬上</p><br>
                    <p>注意：該封郵件是由系統自動寄送的通知信，請不要直接回覆此信。
                      若您需要其他協助，歡迎您透過<a href="https://www.jetec.com.tw/Contact-us">聯絡我們</a>與久德客服團隊聯繫。</p>
                  </div>
                </body></html>
                """.formatted("灰灰","uuid" , "style='\"'width: 100%;height: 40px;background-color: #0d6efd;color: #fff;border-radius: 5px;border-color: #0d6efd;'\"'", "uuid");
        System.out.println(text);

    }

}
