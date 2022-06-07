package com.jetec.topic.service;

import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.ArticleReplyRepository;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.ArticleThumbsupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class MemberService {

    @Autowired
    ArticleRepository ar;
    @Autowired
    ArticleReplyRepository arr;
    @Autowired
    ArticleThumbsupRepository atr;

    public Map<String, Object> init(MemberBean member) {
        Map<String, Object> result = new HashMap<>();
        result.put("replyNum",arr.countByMemberid(member.getMemberid()));//回復文章數
        result.put("articleNum",ar.countByMemberid(member.getMemberid()));//發表文章數

        return result;
    }
}
