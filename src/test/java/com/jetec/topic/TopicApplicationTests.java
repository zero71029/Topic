package com.jetec.topic;

import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.util.Assert;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


class TopicApplicationTests {
    @Test
    void test() {
        List<Integer> list = Arrays.asList(1,2,3,4);
        Double result = list.stream().collect(Collectors.averagingDouble(d->d*2));
        System.out.println(result);



    }

}


