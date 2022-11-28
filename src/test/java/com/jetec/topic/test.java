package com.jetec.topic;


import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.repository.ArticleRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.platform.commons.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import javax.swing.text.html.parser.Entity;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;


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
        Long l = Long.valueOf("1667452832962");

        int[] nums = {1, 5, 9, 9, 5, 3, 33, 33, 33, 65, 65};
        String[] sss = {"E", "A", "D", "H"};

        Map<Integer, String> ddd = new HashMap<>();
        ddd.put(1, "E");
        ddd.put(2, "A");
        ddd.put(3, "D");
        ddd.put(4, "H");


        List<Map.Entry<Integer, String>> aaa = new ArrayList<>(ddd.entrySet());
        aaa.sort(Map.Entry.comparingByValue());
        System.out.println(aaa);

        List<Map.Entry<Integer, String>> list = new ArrayList<>(ddd.entrySet());
        list.sort(Map.Entry.comparingByValue());


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(sdf.format(new Date(l)));
        LocalDateTime ldt = LocalDateTime.ofEpochSecond(l / 1000, 0, ZoneOffset.ofHours(8));
        System.out.println(ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    public int no2(int a, int b) {
        int t;
        while (a % b != 0) {
            t = a % b;
            a = b;
            b = t;
        }
        System.out.println(b);

        return b;
    }


    public int[] no1(int[] nums) {
        List re = new ArrayList<>();
        for (int num : nums) {
            if (!re.contains(num)) {
                re.add(num);
            }
        }
        System.out.println(re);
        Set re2 = new HashSet<>();
        for (int num : nums) {
            re2.add(num);
        }
        System.out.println(re2);
        re2.toArray();


        return Arrays.stream(nums).distinct().toArray();
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

    @Test
    void ttt() {

        String s = "This is a book";
        char[] sss = s.toCharArray();
        int left = 0;
        int right = sss.length-1;
        while (left < right){
            char t = sss[right];
            sss[right] = sss[left];
            sss[left] = t;
            left++;
            right--;
        }
        String  re = new String(sss);
        System.out.println(re);



        int[] nums = {5, 3, 6, 9, 8, 7, 4, 1, 2};
        containsDuplicate(nums);
    }


    public boolean containsDuplicate(int[] nums) {

        Arrays.sort(nums);

        Long timeap = Long.valueOf("1235698745811");
        SimpleDateFormat sff = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println(sff.format(new Date(timeap)));
        LocalDateTime ldt = LocalDateTime.ofEpochSecond(timeap / 1000, 0, ZoneOffset.ofHours(8));
        System.out.println(ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));


//        System.out.println(list);

        for (int i = 0; i < nums.length; i++) {

            System.out.print(nums[i] + "   ");
        }
        return false;
    }


}
