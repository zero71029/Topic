package com.jetec.topic.Contriller;



import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
class TopicControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("文章列表")
    void topiclist() throws Exception {
        HttpSession session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andReturn()
                .getRequest()
                .getSession();
        mockMvc
                .perform(post("/topiclist")
                        .param("pag", "1")
                        .param("size", "10")
                        .param("nav", "sensor")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("文章列表"))
                .andExpect(jsonPath("$.data.total").isNumber())
                .andExpect(jsonPath("$.data.totalPag").isNumber())
                .andExpect(jsonPath("$.data.list").isArray());
    }

    @Test
    @DisplayName("進入文章細節")
    void topicdetailt() throws Exception {
        HttpSession session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andReturn()
                .getRequest()
                .getSession();
        System.out.println("成功");
        mockMvc
                .perform(post("/detail/1ed13c2c3b55654d97609b3bbb212374")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attributeExists("article", "thumbsup", "article_content"))
                .andExpect(MockMvcResultMatchers.view().name("/topicdetail"));
        System.out.println("id錯誤");
        mockMvc
                .perform(post("/detail/1ed13c2c3b5565")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("message", "找不到文章"))
                .andExpect(MockMvcResultMatchers.view().name("error/error500"));
    }

    @Test
    @DisplayName("進入 修改回復文章")
    void reply() throws Exception {
        System.out.println("未登入");
        mockMvc
                .perform(post("/revise-reply/1ed1942acb0467fa89b66948c41e2e99").session(new MockHttpSession()))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("error", "未登入"))
                .andExpect(MockMvcResultMatchers.view().name("/error/error"));

//
        HttpSession session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andReturn()
                .getRequest()
                .getSession();
        System.out.println("成功");
        mockMvc
                .perform(post("/revise-reply/1ed1942acb0467fa89b66948c41e2e99")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attributeExists("article"))
                .andExpect(MockMvcResultMatchers.view().name("/article/revisereply"));
        System.out.println("id錯誤");
        mockMvc
                .perform(post("/revise-reply/1ed1942acb0467fa8")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("message", "文章不存在"))
                .andExpect(MockMvcResultMatchers.view().name("/error/error500"));
    }

    @Test
    @DisplayName("進入 文章回復")
    void testReply() throws Exception {
        System.out.println("未登入");
        mockMvc
                .perform(post("/reply/1ed13c2c3b55654d97609b3bbb212374").session(new MockHttpSession()))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("error", "未登入"))
                .andExpect(MockMvcResultMatchers.view().name("/error/error"));

//
        HttpSession session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andReturn()
                .getRequest()
                .getSession();
        System.out.println("成功");
        mockMvc
                .perform(post("/reply/1ed13c2c3b55654d97609b3bbb212374")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attributeExists("article"))
                .andExpect(MockMvcResultMatchers.view().name("/article/reply"));
        System.out.println("id錯誤");
        mockMvc
                .perform(post("/reply/1ed13c2c3b55654d97609")
                        .session((MockHttpSession) session)
                )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.model().attribute("message", "文章不存在"))
                .andExpect(MockMvcResultMatchers.view().name("/error/error500"));
    }

    @Test
    @DisplayName("文章細節初始化")
    void detailInit() throws Exception {
        System.out.println("未登入");
        mockMvc
                .perform(post("/article/detailInit/1ed13c2c3b55654d97609b3bbb212374")
                        .session(new MockHttpSession())
                        .param("p", "1")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.thumbsupNum").isNumber())
                .andExpect(jsonPath("$.replylist").isArray())
                .andExpect(jsonPath("$.hasThumbsup").isBoolean());
//
        HttpSession session = mockMvc.perform(post("/login")
                        .param("username", "AAA@AAA.com")
                        .param("password", "AAA")
                        .param("g-recaptcha-response", "AAA")
                )
                .andReturn()
                .getRequest()
                .getSession();
        System.out.println("成功");
        mockMvc
                .perform(post("/article/detailInit/1ed13c2c3b55654d97609b3bbb212374")
                        .session((MockHttpSession) session)
                        .param("p", "1")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.thumbsupNum").isNumber())
                .andExpect(jsonPath("$.replylist").isArray())
                .andExpect(jsonPath("$.hasThumbsup").isBoolean());
    }

    @Test
    void search() throws Exception {
        mockMvc
                .perform(post("/article/search")
                        .param("page", "1")
                        .param("size", "10")
                        .param("search", "流量計")
                )
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.total").isNumber())
                .andExpect(jsonPath("$.list").isArray());
    }

    @Test
    void getContent() throws Exception {
        mockMvc
                .perform(post("/article/getContent/1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.article_content.articleid").value("1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(jsonPath("$.article.articleid").value("1ed13c2c3b55654d97609b3bbb212374"));

    }

    @Test
    void articleReturn() throws Exception {
        mockMvc
                .perform(post("/article/articleReturn/1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.view().name("/article/return"))
                .andExpect(MockMvcResultMatchers.model().attributeExists("article"))
                .andExpect(MockMvcResultMatchers.model().attribute("articleid","1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(MockMvcResultMatchers.model().attribute("replyid","1ed13c2c3b55654d97609b3bbb212374"));
    }

    @Test
    void replyReturn() throws Exception {
        mockMvc
                .perform(post("/article/articleReturn/1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.view().name("/article/return"))
                .andExpect(MockMvcResultMatchers.model().attributeExists("article"))
                .andExpect(MockMvcResultMatchers.model().attribute("articleid","1ed13c2c3b55654d97609b3bbb212374"))
                .andExpect(MockMvcResultMatchers.model().attribute("replyid","1ed13c2c3b55654d97609b3bbb212374")).andDo(print());
    }

    @Test
    @Transactional
    @Rollback
    @DisplayName("儲存回報")
    void saveReturn() {




    }

    @Test
    void thumbsup() {
    }

    @Test
    void recaptcha() {
    }

    @Test
    void advertiseinit() {
    }

    @Test
    void getOption() throws Exception {
        mockMvc
                .perform(post("/topic/getOption/apparatus"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("code").value(200))
                .andExpect(jsonPath("message").value("取得選項成功"))
                .andExpect(jsonPath("data").isArray())
                .andDo(print());
    }
}