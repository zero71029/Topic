package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleThumbsupBean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleThumbsupRepository extends JpaRepository<ArticleThumbsupBean,String> {
    boolean existsByArticleidAndMemberid(String articleid, String memberid);

    void deleteByArticleidAndMemberid(String articleid, String memberid);
    List<ArticleThumbsupBean> findByArticleid(String articleid);



    @Query( value = "SELECT  count(*)  from article_thumbsup where articleid = ?1 ", nativeQuery = true)
    Integer getThumbsupNum(String articleid);
}
