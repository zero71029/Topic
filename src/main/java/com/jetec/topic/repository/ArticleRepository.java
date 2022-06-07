package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleRepository extends JpaRepository<ArticleBean,String> {
    Page<ArticleBean> findByArticlegroup(String nav, Pageable pageable);

    Integer countByMemberid(String memberid);

    List<ArticleBean> findByMemberid(String memberid);
}
