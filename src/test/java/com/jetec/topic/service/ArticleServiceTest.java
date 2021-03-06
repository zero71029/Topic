package com.jetec.topic.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest
@AutoConfigureMockMvc
class ArticleServiceTest {
    @Autowired
    MockMvc mockMvc;

    @Test
    void save() throws Exception {
    }

    @Test
    void findByArticlegroup() {
    }

    @Test
    void findById() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post("/findById"))
                .andExpect(status().isOk())
                .andDo(print())
//                .andExpect(content().string("hello"))
                .andExpect(status().isCreated());
//                .andExpect(jsonPath("$.id").hasJsonPath())
//                .andExpect(jsonPath("$.name").value(request.getString("name")))
//                .andExpect(jsonPath("$.price").value(request.getInt("price")))
//                .andExpect(header().exists(HttpHeaders.LOCATION))
//                .andExpect(header().string(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE));
    }

    @Test
    void thumbsup() {

    }

    @Test
    void findThumbsup() {
    }
}