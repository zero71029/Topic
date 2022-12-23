package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.CollectBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CollectRepository extends JpaRepository<CollectBean,String> {
      Optional<CollectBean>  findByArticleidAndMemberid(String articleid, String memberid);

      Page<CollectBean> findByMemberid(String memberid, Pageable p);

      boolean existsByArticleidAndMemberid(String articleid, String memberid);
}
