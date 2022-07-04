package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReturnBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleReturnRepository extends JpaRepository<ArticleReturnBean,Long> {
    Page<ArticleReturnBean> findByState(String state, Pageable p);
}
