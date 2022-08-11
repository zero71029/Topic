package com.jetec.topic;


import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.repository.ArticleRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;


public class test {

    @Autowired
    ArticleRepository ar;


    @Test
    public void logtest() {
        Logger logger = LoggerFactory.getLogger(test.class);
        logger.info("*****讀取潛在客戶列表*****");
        logger.error("logback 成功了");
        logger.debug("logback 成功了");
    }


    @Test
    void test2() {
        int[] nums = {1, 1, 2, 2, 3, 4, 5, 5, 6};





    }


    @Test
    @DisplayName("花費時間測試")
    void test1() {
        Pageable pageable = PageRequest.of(0, 20, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> list = null;


        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
            for (int i = 0; i < 1000; i++) {

            }
            System.out.println("=======================================");
            System.out.println("總共幾筆 : " + list.getContent().size() + " 筆");
            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }
}
