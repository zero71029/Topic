package com.jetec.topic.Contriller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class MemberControllerTest {
    @Autowired
    private MockMvc mockMvc;

    HttpSession session;

    @BeforeEach
    void setUp() throws Exception {
        assertEquals(1,1);
        session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")

                )
                .andReturn()
                .getRequest()
                .getSession();
    }

    @Test
    @DisplayName("我的頁面")
    void mypage() throws Exception {
        mockMvc
                .perform(post("/member/mypage")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.articleNum").isNumber())
                .andExpect(jsonPath("$.replyNum").isNumber())
                .andExpect(jsonPath("$.member").isMap())
                .andExpect(jsonPath("$.member.memberid").value("609eb996f31c4442b586a3c3430ba53f"))
                .andExpect(jsonPath("$.member.email").value("AAA@AAA.com"))
                .andExpect(jsonPath("$.member.name").value("AAA"))
                .andExpect(jsonPath("$.member.company").value("AAA"));

    }

    @Test
    @DisplayName("我的文章")
    void myArticle() throws Exception {
        mockMvc
                .perform(post("/member/myArticle")
                        .session((MockHttpSession) session)
                        .param("page", "1")
                        .param("size", "10")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.list").isArray());
    }

    @Test
    @DisplayName("我的回復")
    void myReply() throws Exception {
        mockMvc
                .perform(post("/member/myReply")
                        .session((MockHttpSession) session)
                        .param("page", "1")
                        .param("size", "10")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.list").isArray());
    }

    @Test
    @DisplayName("修改我的資料   未測")
    @Transactional
    @Rollback
    void revise() throws Exception {
        mockMvc
                .perform(post("/member/revise")
                        .session((MockHttpSession) session)

                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.articleNum").isNumber())
                .andExpect(jsonPath("$.replyNum").isNumber())
                .andExpect(jsonPath("$.member").isMap());
    }
}