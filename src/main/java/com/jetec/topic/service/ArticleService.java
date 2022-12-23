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

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
@Transactional
public class ArticleService {
    @Autowired
    ArticleRepository ar;
    @Autowired
    ArticleThumbsupRepository atr;
    @Autowired
    ArticleReplyRepository arr;
    @Autowired
    MemberRepository mr;
    @Autowired
    ArticleContentRepository acr;
    @Autowired
    WatchRepository wr;
    @Autowired
    PermitRepository pr;
    @Autowired
    ArticleReturnRepository articleReturnRepository;
    @Autowired
    LoginIpRepository lir;

    public ArticleBean save(ArticleBean articleBean) {
        return ar.save(articleBean);
    }

    public Page<ArticleBean> findByArticlegroup(String nav, Pageable pageable) {
        return ar.findByArticlegroupAndState(nav, pageable, "允許");
    }

    public ArticleBean findById(String articleid) {
        return ar.findById(articleid).orElse(null);
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

    public boolean hasArticle(String articleid) {
        return ar.existsById(articleid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//文章回覆 儲存
    public ArticleReplyBean saveArticleReply(ArticleReplyBean arBean) {
        return arr.save(arBean);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得文章回覆
    public Map<String, Object> getReplyList(String articleid, Integer p) {
        Map<String, Object> result = new HashMap<>();
//        limit N,M : 相当于 limit M offset N , 从第 N 条记录开始, 返回 M 条记录
        if (p == 0) {
//            String sql = "select * from article_reply where articleid = ?1 order by create_time limit 0,10";
            result.put("list", arr.findByArticleidAndPageZero(articleid));
            result.put("total", arr.countByArticleid(articleid));
            return result;
        }
//        String sql = "select * from article_reply where articleid = ?1 order by create_time  limit ?2,?3";
        result.put("list", arr.findByArticleidAndPage(articleid, p * 10 - 1, 10));
        result.put("total", arr.countByArticleid(articleid));
        return result;
    }

    //取得有幾筆回覆
    public Integer getArticleFloor(String articleid) {
        return arr.countByArticleid(articleid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //首頁初始化
    public Map<String, Object> init() {
        Map<String, Object> result = new HashMap<>();
        Pageable p = PageRequest.of(0, 5, Sort.Direction.DESC, "createtime");


        result.put("news", ar.findByState("允許", p).getContent());//新
        result.put("sensor", ar.findByArticlegroupAndState("sensor", p, "允許").getContent());//感測器
        result.put("apparatus", ar.findByArticlegroupAndState("apparatus", p, "允許").getContent());//儀器儀表
        result.put("Netcom", ar.findByArticlegroupAndState("Netcom", p, "允許").getContent());//網通裝置
        result.put("software", ar.findByArticlegroupAndState("software", p, "允許").getContent());//軟體配件
        result.put("controlbox", ar.findByArticlegroupAndState("controlbox", p, "允許").getContent());//控制箱
        result.put("application", ar.findByArticlegroupAndState("application", p, "允許").getContent());//應用


        LocalDateTime end = LocalDateTime.now();
        LocalDateTime start = end.minusDays(30);
        List<String> l = arr.countArticleidByCreateBetween(start, end);
        AtomicInteger index = new AtomicInteger();
        List<ArticleBean> a = l.stream()
                .map(e -> ar.findById(e).orElse(null))
                .filter(Objects::nonNull)
                .filter(articleBean -> Objects.equals("允許",articleBean.getState()))
                .filter(e->{
                    index.getAndIncrement();
                    return index.get() <= 5;
                })
                .collect(Collectors.toList());
        result.put("popular", a);//熱門
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //計算積分
    public void Integral(String memberid) {
        System.out.println("計算積分");
        MemberBean mbean = mr.getById(memberid);
        List<ArticleBean> articleList = ar.findByMemberidAndState(memberid, "允許");
        int integral = 0; //積分
        for (ArticleBean article : articleList) {
            //發表一個100分
            integral = integral + 50;
            //被點讚一個10分  最多100分
            if (article.getThumbsuplist().size() > 10) {
                integral = integral + 100;
            } else {
                integral = integral + article.getThumbsuplist().size() * 10;
            }
        }
        //插入結果
        mbean.setIntegral(integral);
        //儲存
        mr.save(mbean);

        //存權限
        int level = 0;
        if (integral > 1000) level = 2;
        if (integral > 10000) level = 3;
        if (integral > 30000) level = 4;
        if (integral > 90000) level = 5;
        if (!(pr.existsByMemberidAndLevel(memberid, level))) {
            pr.save(new PermitBean(ZeroTools.getUUID(), memberid, level));
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //搜索
    public Map<String, Object> search(String search, Pageable p) {
        Page<ArticleBean> page = ar.findByStateAndNameLikeIgnoreCase("允許", "%" + search + "%", p);
        Map<String, Object> result = new HashMap<>();
        result.put("list", page.getContent());
        result.put("total", page.getTotalElements());
        return result;
    }

    public ArticleContentBean findArticleContentByArticleid(String articleid) {
        return acr.getById(articleid);
    }

    //存文章內容
    public void saveArticleContent(ArticleContentBean acBean) {
        acr.save(acBean);
    }

    //存觀看時間
    public void saveWatchTime(MemberBean mBean, String articleid) {
        Optional<WatchBean> op = wr.findByMemberidAndArticleid(mBean.getMemberid(), articleid);
        WatchBean wBean;
        if (op.isPresent()) {
            wBean = op.get();
            wBean.setWatchtime(LocalDateTime.now());
        } else {
            wBean = new WatchBean(mBean.getMemberid(), articleid, LocalDateTime.now());
        }
        wr.save(wBean);
    }

    //取 未看 回覆數
    public Integer getWatchCount(String memberid, String articleid) {
        Optional<WatchBean> op = wr.findByMemberidAndArticleid(memberid, articleid);
        if (op.isPresent()) {
            WatchBean wBean = op.get();
            return arr.countByArticleidAndCreatetimeGreaterThan(articleid, wBean.getWatchtime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        } else {
            return 0;
        }
    }

    //取得回覆文章
    public Optional<ArticleReplyBean> getReplyByReplyid(String replyid) {
        return arr.findById(replyid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存回報
    public void saveArticleReturn(ArticleReturnBean articleReturnBean) {
        articleReturnRepository.save(articleReturnBean);
    }

    public boolean hasReply(String replyid) {
        return arr.existsById(replyid);
    }

    public ArticleReplyBean findReplyById(String replyid) {
        return arr.getById(replyid);
    }

    public Integer countByMemberid(String memberid) {
        return ar.countByMemberid(memberid);
    }

    //回覆文章數
    public Object countReplyByMemberid(String memberid) {
        return arr.countByMemberid(memberid);
    }

    public Integer countReplyArticle(String articleid) {
        return arr.countByArticleid(articleid);
    }

    public void saveLoginIp(LoginIpBean loginIpBean) {
         lir.save(loginIpBean);
    }


}