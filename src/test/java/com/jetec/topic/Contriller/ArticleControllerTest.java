package com.jetec.topic.Contriller;

import com.jetec.topic.model.MemberBean;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.test.web.servlet.MockMvc;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class ArticleControllerTest {

    @Autowired
    private MockMvc mockMvc;

    HttpSession session;

    @BeforeEach
    void setUp() throws Exception {
        System.out.println("session");
        session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                ).andDo(print())
                .andExpect(status().isOk())
                .andReturn()
                .getRequest()
                .getSession();
        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
        MemberBean mBean = (MemberBean) sci.getAuthentication().getPrincipal();
        session.setAttribute(MemberBean.SESSIONID, mBean);
    }

    @Test
    void signout() {
    }

    @Test
    void save() {
    }

    @Test
    void saveReply() {
    }

    @Test
    void savemessage() {
    }
}