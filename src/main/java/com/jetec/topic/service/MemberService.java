package com.jetec.topic.service;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.ArticleReplyRepository;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.ArticleThumbsupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
        List<ArticleBean> articleList = ar.findByMemberid(member.getMemberid());
        List<ArticleReplyBean> replyList = arr.findByMemberid(member.getMemberid());
        result.put("replyNum", replyList.size());//回復文章數
        result.put("articleNum", articleList.size());//發表文章數
        int integral = 0; //積分
        for (ArticleBean article : articleList) {
            integral = integral + 100;
            if (article.getThumbsuplist().size() > 10) {
                integral = integral + 100;
            } else {
                integral = integral + article.getThumbsuplist().size() * 10;
            }
        }
        integral = integral + replyList.size();
        result.put("integral", integral);//獲得積分
        return result;
    }
}
