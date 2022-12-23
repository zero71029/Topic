package com.jetec.topic.service;


import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.CollectBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.CollectRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CollectService {

    @Autowired
    CollectRepository cr;

    Logger logger = LoggerFactory.getLogger("CollectService");

    public String collect(MemberBean memberBean, String articleid) {

        CollectBean collectBean = cr.findByArticleidAndMemberid(articleid, memberBean.getMemberid()).orElse(null);
        if (collectBean == null) {
            collectBean = new CollectBean(ZeroTools.getUUID(), memberBean.getMemberid(), articleid);
            cr.save(collectBean);
            logger.info("收藏成功");
            return "收藏成功";
        }
        cr.delete(collectBean);
        logger.info("取消成功");
        return "取消成功";

    }

    public Page<CollectBean> findByMemberid(String memberid, Pageable p) {
        return  cr.findByMemberid(memberid,p);
    }

    public boolean hasCollect(String articleid, String memberid) {
        return cr.existsByArticleidAndMemberid(articleid,memberid);
    }
}
