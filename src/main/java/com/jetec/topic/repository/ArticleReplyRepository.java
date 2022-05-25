package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReplyBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleReplyRepository extends JpaRepository<ArticleReplyBean,String> {
    List<ArticleReplyBean> findByArticleid(String articleid);
}
