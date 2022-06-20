package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReplyBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleReplyRepository extends JpaRepository<ArticleReplyBean,String> {

    List<ArticleReplyBean> findByArticleid(String articleid, Sort num);


    @Query( value = "SELECT  count(*)  from article_reply where articleid = ?1 ", nativeQuery = true)
    Integer getArticleNum(String articleid);

    Integer countByMemberid(String memberid);

    List<ArticleReplyBean> findByMemberid(String memberid);

    Integer countByMemberidAndState(String memberid, String state);
}
