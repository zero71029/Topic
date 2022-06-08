package com.jetec.topic.service;

import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class BackstageService {

    @Autowired
    MemberRepository mr;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化
    public Map<String, Object> init(Integer page) {
        Map<String, Object> result = new HashMap<>();
        Pageable p = PageRequest.of(page, 5, Sort.Direction.DESC,"createtime");

        result.put("member",mr.findAll(p).getContent());

        return result;
    }
}
