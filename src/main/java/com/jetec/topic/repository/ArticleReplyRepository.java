package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReplyBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface ArticleReplyRepository extends JpaRepository<ArticleReplyBean, String> {

    Page<ArticleReplyBean> findByArticleid(String articleid, Pageable pageable);

    List<ArticleReplyBean> findByMemberid(String memberid);


    //計算

    Integer countByMemberid(String memberid);

    Integer countByArticleidAndCreatetimeGreaterThan(String articleid, String time);

    Integer countByArticleid(String articleid);

    Integer countByMemberidAndStateNot(String memberid, String state);

    @Query(value = "select * from article_reply where articleid = ?1 order by create_time  limit 0,9 ",nativeQuery = true)
    List<ArticleReplyBean> findByArticleidAndPageZero(String articleid);

    @Query(value = "select * from article_reply where articleid = ?1 order by create_time  limit ?2,?3",nativeQuery = true)
    List<ArticleReplyBean> findByArticleidAndPage(String articleid, Integer p,Integer size);


    @Query(value = "    select\n" +
            "        articleid\n" +
            "    from\n" +
            "        article_reply \n" +
            "    where\n" +
            "        create_time  BETWEEN ?1 AND ?2" +
            "    GROUP BY\n" +
            "        articleid  \n" +
            "      having count(articleid) \n" +
            "    order by\n" +
            "        count(articleid)  Desc limit 10;  ",nativeQuery = true)
    List<String> countArticleidByCreateBetween(LocalDateTime start, LocalDateTime end);
}
