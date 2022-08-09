package com.jetec.topic.Contriller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;

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
    void topiclist() {
    }

    @Test
    void topicdetailt() {
    }

    @Test
    void reply() {
    }

    @Test
    void testReply() {
    }

    @Test
    void detailInit() {
    }

    @Test
    void search() {
    }

    @Test
    void getContent() {
    }

    @Test
    void articleReturn() {
    }

    @Test
    void replyReturn() {
    }

    @Test
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