package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReplyBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleReplyRepository extends JpaRepository<ArticleReplyBean, String> {

    List<ArticleReplyBean> findByArticleid(String articleid, Sort sort);

    List<ArticleReplyBean> findByMemberid(String memberid);

    //計算

    Integer countByMemberid(String memberid);

    Integer countByArticleidAndCreatetimeGreaterThan(String articleid, String time);

    Integer countByArticleid(String articleid);

    Integer countByMemberidAndStateNot(String memberid, String state);
}
