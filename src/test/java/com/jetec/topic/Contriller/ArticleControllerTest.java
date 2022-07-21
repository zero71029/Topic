package com.jetec.topic.Contriller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;
import static org.junit.jupiter.api.Assertions.*;
import javax.persistence.Transient;
import javax.servlet.http.HttpSession;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;


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
//        SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
//        MemberBean mBean = (MemberBean) sci.getAuthentication().getPrincipal();
//        session.setAttribute(MemberBean.SESSIONID, mBean);
    }

    @Test
    void preview() throws Exception {
        System.out.println("=======================================================================================");
        MvcResult mvcResult = mockMvc
                .perform(post("/article/preview")
                        .session((MockHttpSession) session)
                        .param("content", "XXXXXX")
                )
                .andExpect(status().isOk())
                .andExpect(view().name("/article/preview"))
                .andExpect(model().attributeExists("articleBean"))
                .andDo(print()).andReturn();
          System.out.println(mvcResult.getModelAndView().getModel().get("article_content"));
          assertEquals(mvcResult.getModelAndView().getModel().get("article_content"),"XXXXXX");
    }

    @Test
    @Transient
    @Rollback
    void save() throws Exception {
        System.out.println("=======================================================================================");
        MvcResult mvcResult = mockMvc
                .perform(post("/article/save")
                        .session((MockHttpSession) session)
                        .param("content", "XXXXXX")
                        .param("articlegroup", "sensor")
                        .param("memberid", "609eb996f31c4442b586a3c3430ba53f")
                        .param("name", "網管測試")
                )
                .andExpect(status().is(302))
                .andExpect(redirectedUrl("/article/success.jsp"))
                .andDo(print()).andReturn();
        System.out.println(mvcResult.getModelAndView().getModel().get("article_content"));
    }

    @Test
    @Transactional
    @Rollback
    void saveReply() throws Exception {
        System.out.println("=======================================================================================");
        MvcResult mvcResult = mockMvc
                .perform(post("/article/saveReply")
                        .session((MockHttpSession) session)
                        .param("content", "網管測試")
                        .param("memberid", "609eb996f31c4442b586a3c3430ba53f")
                        .param("membername", "AAA")
                        .param("articleid", "6de3361d1b794c7384cc25393598fbf5")
                )
                .andExpect(status().is(302))
                .andExpect(redirectedUrl("/detail/6de3361d1b794c7384cc25393598fbf5"))
                .andDo(print()).andReturn();
        System.out.println(mvcResult.getModelAndView().getModel().get("article_content"));
    }

    @Test
    @Transactional
    @Rollback
    void savemessage() throws Exception {

        System.out.println("=======================================================================================");
        mockMvc
                .perform(post("/article/savemessage")
                        .session((MockHttpSession) session)
                        .param("article", "6de3361d1b794c7384cc25393598fbf5")
                        .param("memberid", "609eb996f31c4442b586a3c3430ba53f")
                        .param("p", "1")
                        .param("membername", "AAA")
                        .param("content", "網管測試")
                        .param("articleid", "25912434689348f4bd420f528ee961eb")//replyid
                )
                .andExpect(status().isOk())
                .andDo(print());
    }
}