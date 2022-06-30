package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleReturnBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleReturnRepository extends JpaRepository<ArticleReturnBean,Integer> {
}
