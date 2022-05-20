package com.jetec.topic.service;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.ArticleThumbsupBean;
import com.jetec.topic.repository.ArticleRepository;
import com.jetec.topic.repository.ArticleThumbsupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ArticleService {
    @Autowired
    ArticleRepository ar;
    @Autowired
    ArticleThumbsupRepository atr;

    public void save(ArticleBean articleBean) {
        ar.save(articleBean);
    }

    public Page<ArticleBean> findByArticlegroup(String nav, Pageable pageable) {
        return ar.findByArticlegroup(nav, pageable);

    }

    public ArticleBean findById(String articleid) {
        return ar.findById(articleid).get();
    }

    public Page<ArticleBean> findall(Pageable pageable) {
        return ar.findAll(pageable);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點讚
    public Boolean thumbsup(String articleid, String memberid) {
        if (atr.existsByArticleidAndMemberid(articleid, memberid)) {
            atr.deleteByArticleidAndMemberid(articleid, memberid);
            return false;
        } else {
            atr.save(new ArticleThumbsupBean(ZeroTools.getUUID(), articleid, memberid));
            return true;
        }

    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得點讚列表
    public List<ArticleThumbsupBean> findThumbsup(String articleid) {
        return atr.findByArticleid(articleid);

    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得點讚數
    public Integer getThumbsupNum(String articleid) {
        return atr.getThumbsupNum(articleid);
    }

    public boolean hasThumbsup(String articleid, String memberid) {
        return atr.existsByArticleidAndMemberid(articleid, memberid);
    }
}
