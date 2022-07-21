package com.jetec.topic.Contriller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class LoginControllerTest {

    @Autowired
    private MockMvc mockMvc;

    HttpSession session;

    @BeforeEach
    void setUp() throws Exception {
        session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().isOk())
                .andReturn()
                .getRequest()
                .getSession();
    }

    @Test
    @Transactional
    @Rollback
    void login() throws Exception {
        System.out.println("==================================================");
        System.out.println("機器人測試");
        mockMvc.perform(post("/Forum/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAjjA")
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.request().attribute("recaptcha", "驗證失敗!"))
                .andExpect(forwardedUrl("/member/login.jsp"));
        mockMvc.perform(post("/Forum/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "")
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.request().attribute("recaptcha", "沒有驗證!"))
                .andExpect(forwardedUrl("/member/login.jsp"));

        mockMvc.perform(post("/Forum/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().isNotFound())
                .andExpect(MockMvcResultMatchers.request().attribute("success", "驗證成功"));
        System.out.println("==================================================");
        System.out.println("帳號錯誤測試");
        MockHttpServletRequest req = mockMvc.perform(post("/login")
                        .param("username", "ABABA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/member/login.jsp"))
                .andReturn()
                .getRequest();
        Map<String, String> map = (Map<String, String>) req.getAttribute("error");
        assertThat(map.get("user")).isEqualTo("找不到使用者");
        System.out.println(req.getAttribute("error"));
        System.out.println("==================================================");
        System.out.println("密碼錯誤測試");
        req = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAAb")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/member/login.jsp"))
                .andReturn()
                .getRequest();
        map = (Map<String, String>) req.getAttribute("error");
//        assertThat(map.get("pass")).isEqualTo("密碼錯誤");
        System.out.println(req.getAttribute("error"));
        System.out.println("=======================================================================================");
        mockMvc
                .perform(post("/home")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().is3xxRedirection())
                .andExpect(MockMvcResultMatchers.redirectedUrl("/index"))  ;
    }
    @Test
    void signout() throws Exception {
        System.out.println("=======================================================================================");
        mockMvc
                .perform(post("/Signout")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().is3xxRedirection())
                .andExpect(MockMvcResultMatchers.redirectedUrl("/index"))
                .andExpect(MockMvcResultMatchers.request().sessionAttributeDoesNotExist("SPRING_SECURITY_CONTEXT")) ;
    }
    @Test
    @Transactional
    @Rollback
    void saveAdmin() throws Exception {
        System.out.println("=======================================================================================");
        System.out.println("認證碼錯誤");
        Map result = (Map) mockMvc
                .perform(post("/register")
                        .param("name", "灰灰")
                        .param("company", "XXXX")
                        .param("email", "AAA@AAA.com")
                        .param("phone", "sssss")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAjjA")

                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.forwardedUrl("//member/register.jsp"))
                .andReturn()
                .getRequest()
                .getAttribute("errors");
        assertThat(result.get("recaptcha")).isEqualTo("需要驗證");
        assertThat(result.get("username")).isEqualTo("暱稱被使用過");
        assertThat(result.get("email")).isEqualTo("Email被使用過");
        System.out.println("=======================================================================================");
        System.out.println("註冊成功");
        mockMvc
                .perform(post("/register")
                        .param("name", "灰灰2")
                        .param("company", "XXXX")
                        .param("email", "ssss@sss.com")
                        .param("phone", "sssss")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")

                )
                .andExpect(status().is3xxRedirection())
                .andExpect(MockMvcResultMatchers.redirectedUrl("/member/registerSuccess.jsp"));
        System.out.println("=======================================================================================");
        System.out.println("寄信錯誤");
        mockMvc
                .perform(post("/register")
                        .param("name", "灰灰52")
                        .param("company", "XXX5X")
                        .param("email", "sss5s")
                        .param("phone", "ss5sss")
                        .param("password", "AA5A")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().is3xxRedirection())
                .andExpect(MockMvcResultMatchers.redirectedUrl("/error/error500.jsp"));
    }
    @Test
    @Transactional
    @Rollback
    void forget() throws Exception {
        System.out.println("=======================================================================================");
        System.out.println("認證碼錯誤");
        Map result = (Map) mockMvc
                .perform(post("/forget")
                        .param("email", "AAAd@AAA.com")
                        .param("g-recaptcha-response", "AAjjA")

                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.forwardedUrl("//member/forget.jsp"))
                .andReturn()
                .getRequest()
                .getAttribute("errors");
        assertThat(result.get("recaptcha")).isEqualTo("認證未過");
        System.out.println(result);
        System.out.println("=======================================================================================");
        System.out.println("email錯誤");
        result = (Map) mockMvc
                .perform(post("/forget")
                        .param("email", "AAAd@AAA.com")
                        .param("g-recaptcha-response", "AAA")

                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.forwardedUrl("//member/forget.jsp"))
                .andReturn()
                .getRequest()
                .getAttribute("errors");
        assertThat(result.get("email")).isEqualTo("查不到這個Email");
        System.out.println(result);
        System.out.println("=======================================================================================");
        System.out.println("成功");
        mockMvc
                .perform(post("/forget")
                        .param("email", "AAA@AAA.com")
                        .param("g-recaptcha-response", "AAA")
                )
                .andExpect(status().is3xxRedirection())
                .andExpect(MockMvcResultMatchers.redirectedUrl("/member/forgetSend.jsp"));
    }

    @Test
    void reset() {
    }

    @Test
    void certification() {
    }

    @Test
    void certificationOrder() {
    }

    @Test
    void reSend() {
    }
}