package com.jetec.topic.repository;

import com.jetec.topic.model.ArticleBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleRepository extends JpaRepository<ArticleBean,String> {

    Integer countByMemberid(String memberid);

    List<ArticleBean> findByState(String state);

    Page<ArticleBean> findByStateNot(String state, Pageable p);

    Page<ArticleBean> findByArticlegroupAndState(String nav, Pageable pageable, String state);

    Page<ArticleBean> findByState(String state, Pageable p);

    List<ArticleBean> findByMemberidAndState(String memberid, String state);

    Page<ArticleBean> findByMemberid(String memberid, Pageable createtime);

    Page<ArticleBean> findByNameLikeIgnoreCase(String s, Pageable p);
}
