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
    @Autowired
    ArticleService as;





    public MemberBean save(MemberBean bean) {
        return mr.save(bean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的文章
    public Page<ArticleBean> myArticle(MemberBean member, Pageable p) {
        return ar.findByMemberid(member.getMemberid(), p);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //我的回覆
    public Map<String, Object> myReply(MemberBean member, Integer page, Integer size) {
        List<ArticleReplyBean> arList = arr.findByMemberid(member.getMemberid());
        List<ArticleBean> articleList = new ArrayList<>();
        //取得回覆過的Articleid列表
        Set<String> articleidList = new HashSet<>();
        arList.forEach(e -> articleidList.add(e.getArticleid()));
        //用Articleid列表 取得文章列表
        articleidList.forEach(e -> {
            Optional<ArticleBean> op = ar.findById(e);
            op.ifPresent(articleList::add);
        });
        //分頁過濾
        List<ArticleBean> aaa = new ArrayList<>();
        AtomicInteger i = new AtomicInteger();
        articleList.forEach(e -> {
            if (page * size <= i.get() && i.get() < page * size + size) {
                aaa.add(e);
            }
            i.getAndIncrement();//i++
        });
        //排序
        List<ArticleBean> list = aaa.stream()
                .sorted(Comparator
                        .comparing(ArticleBean::getCreatetime)
                        .reversed())
                .collect(Collectors.toCollection(ArrayList::new));
        Map<String, Object> result = new HashMap<>();

        //取 未看 回覆數
        List<Map<String, Object>> a = new ArrayList();
        if (member != null) {
            list.forEach(e -> {
                Map<String, Object> artlcle = new HashMap<>();
                Integer n = as.getWatchCount(member.getMemberid(), e.getArticleid());
                artlcle.put("bean", e);
                artlcle.put("watch",n);
                a.add(artlcle);
            });
        }
        //a = { "bean" : articleBean , "watch" : i }
        result.put("list", a);
        result.put("total", articleList.size());
        return result;
    }
    //發表文章數
    public MemberBean getMemberById(String memberid) {
        return mr.findById(memberid).orElse(null);
    }
}
