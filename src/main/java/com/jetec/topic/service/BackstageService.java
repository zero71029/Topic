package com.jetec.topic.service;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleContentBean;
import com.jetec.topic.model.ArticleReplyBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.ArticleContentRepository;
import com.jetec.topic.repository.ArticleReplyRepository;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class BackstageService {

    @Autowired
    MemberRepository mr;
    @Autowired
    ArticleRepository ar;
    @Autowired
    ArticleReplyRepository arr;
    @Autowired
    ArticleContentRepository acr;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化
    public Map<String, Object> init(Integer page, Integer size) {
        Map<String, Object> result = new HashMap<>();
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<MemberBean> mp = mr.findAll(p);
        result.put("member", mp.getContent());
        result.put("total", mp.getTotalElements());
        return result;
    }

    public MemberBean getMember(String memberid) {
        return mr.findById(memberid).get();
    }

    public Map<String, Object> articleLiat(Integer page, Integer size) {
        Map<String, Object> result = new HashMap<>();
        List <ArticleBean> list = ar.findByState("未驗證");
        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> mp = ar.findByStateNot("未驗證",p);
        list.addAll(mp.getContent());
        result.put("articleList", list);
        result.put("total", mp.getTotalElements());
        return result;
    }

    public ArticleBean getarticleDetail(String articleid) {
        return ar.findById(articleid).get();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    public boolean changeState(String articleid, String state) {
        Optional<ArticleBean> op =   ar.findById(articleid);
        if(op.isPresent()){
            ArticleBean aBean = op.get();
            aBean.setState(state);
            ar.save(aBean);
        }
        return true;
    }

    public ArticleReplyBean replyState(String replyid, String state) {
        Optional<ArticleReplyBean> op =   arr.findById(replyid);
        ArticleReplyBean arBean = null;
        if(op.isPresent()){
            ArticleReplyBean aBean = op.get();
            aBean.setState(state);
            arBean = arr.save(aBean);
        }
        return arBean;
    }

    public List<ArticleReplyBean> getArticleReplyList(String articleid) {
        return arr.findByArticleid(articleid,Sort.by(Sort.Direction.ASC,"createtime"));
    }

    public ArticleContentBean getArticleContent(String articleid) {
        return acr.getById(articleid);
    }
}
