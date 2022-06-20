package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleContentBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleContentRepository extends JpaRepository<ArticleContentBean,String> {
}
