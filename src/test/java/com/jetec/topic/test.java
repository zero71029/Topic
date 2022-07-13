package com.jetec.topic;


import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.service.ArticleService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

@SpringBootTest
public class test {

    @Autowired
    ArticleService as;

    @Test
    void test1()  {
        Pageable pageable = PageRequest.of(0,20, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> list = null;


        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
            for (int i = 0; i < 1000; i++) {
                list = as.findByArticlegroup("sensor",pageable);
            }
            System.out.println("=======================================");
            System.out.println("總共幾筆 : " + list.getContent().size() + " 筆");
            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }
}
