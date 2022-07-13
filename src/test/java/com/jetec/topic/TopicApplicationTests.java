package com.jetec.topic;

import org.junit.jupiter.api.Test;

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


