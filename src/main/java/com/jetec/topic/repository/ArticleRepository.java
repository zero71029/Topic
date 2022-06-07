package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleRepository extends JpaRepository<ArticleBean,String> {
    Page<ArticleBean> findByArticlegroup(String nav, Pageable pageable);

    Integer countByMemberid(String memberid);
}
