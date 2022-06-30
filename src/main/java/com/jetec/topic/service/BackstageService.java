package com.jetec.topic.service;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.*;
import com.jetec.topic.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

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
    @Autowired
    PermitRepository pr;
    @Autowired
    AdvertiseRepository adr;
    @Autowired
    WatchRepository wr;

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

    public Map<String, Object> articleList(Integer page, Integer size) {
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> a = new ArrayList();
        //先取未驗證
        List<ArticleBean> list = ar.findByState("未驗證", Sort.by(Sort.Direction.DESC, "createtime"));
        list.forEach(e -> {
            Map<String, Object> artlcle = new HashMap<>();
            artlcle.put("watch", 0);
            artlcle.put("bean", e);
            a.add(artlcle);
        });


        Pageable p = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<ArticleBean> mp = ar.findByStateNot("未驗證", p);
        //取 未看 回復數
        List<ArticleBean> ArticleBeanList = mp.getContent();
        ArticleBeanList.forEach(e -> {
            Map<String, Object> artlcle = new HashMap<>();
            Integer i = 0;
            Optional<WatchBean> op = wr.findByMemberidAndArticleid("system", e.getArticleid());
            if (op.isPresent()) {
                WatchBean wBean = op.get();
                i = arr.countByArticleidAndCreatetimeGreaterThan(e.getArticleid(), wBean.getWatchtime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
            } else {
                i = arr.countByArticleid(e.getArticleid());
            }
            artlcle.put("watch", i);
            artlcle.put("bean", e);
            a.add(artlcle);
        });
        //a = { "bean" : articleBean , "watch" : i }


        list.addAll(mp.getContent());
        result.put("articleList", a);
        result.put("total", mp.getTotalElements());
        return result;
    }

    public ArticleBean getarticleDetail(String articleid) {
        return ar.findById(articleid).get();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    public boolean changeState(String articleid, String state) {
        Optional<ArticleBean> op = ar.findById(articleid);
        if (op.isPresent()) {
            ArticleBean aBean = op.get();
            aBean.setState(state);
            ar.save(aBean);
        }
        return true;
    }

    public ArticleReplyBean replyState(String replyid, String state) {
        Optional<ArticleReplyBean> op = arr.findById(replyid);
        ArticleReplyBean arBean = null;
        if (op.isPresent()) {
            ArticleReplyBean aBean = op.get();
            aBean.setState(state);
            arBean = arr.save(aBean);
        }
        return arBean;
    }

    public List<ArticleReplyBean> getArticleReplyList(String articleid) {
        return arr.findByArticleid(articleid, Sort.by(Sort.Direction.ASC, "createtime"));
    }

    public ArticleContentBean getArticleContent(String articleid) {
        return acr.getById(articleid);
    }

    public List<ArticleBean> search(String name) {

        return ar.findByNameLikeIgnoreCase("%" + name + "%", Sort.by(Sort.Direction.DESC, "createtime"));
    }

    public List<MemberBean> SearchMember(String select, String search) {

        if ("name".equals(select)) {
            return mr.findByNameLikeIgnoreCase("%" + search + "%", Sort.by(Sort.Direction.DESC, "create"));
        }
        if ("email".equals(select)) {
            return mr.findByEmailLikeIgnoreCase("%" + search + "%", Sort.by(Sort.Direction.DESC, "create"));
        }


        return null;
    }


    //插入權限
    public void insertPermit(String memberid, int i) {
        if (!(pr.existsByMemberidAndLevel(memberid, i))) {
            PermitBean pBean = new PermitBean(ZeroTools.getUUID(), memberid, i);
            pr.save(pBean);
        }
    }

    //刪除權限
    public void delPermit(String memberid, int i) {
        if (pr.existsByMemberidAndLevel(memberid, i)) {
            PermitBean pBean = pr.findByMemberidAndLevel(memberid, i);
            pr.delete(pBean);
        }
    }

    //新增廣告
    public AdvertiseBean save(AdvertiseBean adBean) {
        if (adBean.getAdvertiseid() == null) {
            adBean.setAdvertiseid(ZeroTools.getUUID());
        }
        adBean.setCreatetime(String.valueOf(LocalDate.now()));
        return adr.save(adBean);
    }

    public List<AdvertiseBean> findAll() {
        return adr.findAll();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除廣告
    public void deladvertise(AdvertiseBean adBean) {adr.delete(adBean);}

    //存觀看時間 system
    public void saveWatchTime(String memberid, String articleid) {
        Optional<WatchBean> op = wr.findByMemberidAndArticleid(memberid, articleid);
        op.ifPresentOrElse(e -> {
                    e.setWatchtime(LocalDateTime.now());
                    wr.save(e);
                },
                () -> {
                    wr.save(new WatchBean(memberid, articleid, LocalDateTime.now()));
                });

//        WatchBean wBean;
//        if (op.isPresent()) {
//            wBean = op.get();
//            wBean.setWatchtime(LocalDateTime.now());
//        } else {
//            wBean = new WatchBean(memberid, articleid, LocalDateTime.now());
//        }
//        wr.save(wBean);
    }

    public List<AdvertiseBean> findAdvertiseByLocation(String location) {
        return adr.findByLocation(location);
    }
}
