package com.jetec.topic.service;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.ArticleReplyRepository;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.ArticleThumbsupRepository;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
@Transactional
public class MemberService {

    @Autowired
    ArticleRepository ar;
    @Autowired
    ArticleReplyRepository arr;
    @Autowired
    ArticleThumbsupRepository atr;
    @Autowired
    MemberRepository mr;

    public Map<String, Object> init(MemberBean member) {
        Map<String, Object> result = new HashMap<>();
        result.put("replyNum", arr.countByMemberid(member.getMemberid()));//回復文章數
        result.put("articleNum", ar.countByMemberid(member.getMemberid()));//發表文章數
//        int integral = 0; //積分
//        for (ArticleBean article : articleList) {
//            integral = integral + 100;
//            if (article.getThumbsuplist().size() > 10) {
//                integral = integral + 100;
//            } else {
//                integral = integral + article.getThumbsuplist().size() * 10;
//            }
//        }
//        integral = integral + replyList.size();
        result.put("integral", member.getIntegral());//獲得積分
        return result;
    }

    public MemberBean save(MemberBean bean) {
        return mr.save(bean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的文章
    public Page<ArticleBean> myArticle(MemberBean member, Pageable p) {
        return ar.findByMemberid(member.getMemberid(), p);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的回復
    public Map<String, Object> myReply(MemberBean member,Integer page ,Integer size) {
        List<ArticleReplyBean> arList = arr.findByMemberid(member.getMemberid());
        List<ArticleBean> articleList = new ArrayList<>();
        //
        Set<String> articleidList = new HashSet<>();
        arList.forEach(e -> articleidList.add(e.getArticleid()) );
        //
        articleidList.forEach(e -> {
            Optional<ArticleBean> op = ar.findById(e);
            if (op.isPresent())
                articleList.add(op.get());
        });
        //
        List<ArticleBean> aaa = new ArrayList<>();
        AtomicInteger i = new AtomicInteger();
        articleList.forEach(e -> {
            if(page *size <= i.get() && i.get() < page*size +size ){
                aaa.add(e);
            }
            i.getAndIncrement();
        });
        //
        List<ArticleBean> list = aaa.stream()
                .sorted(Comparator
                        .comparing(ArticleBean::getCreatetime)
                        .reversed())
                .collect(Collectors.toCollection(ArrayList::new));
        Map<String, Object> result = new HashMap<>();
        result.put("list",list);
        result.put("total",articleList.size());
        return result;
    }
}
