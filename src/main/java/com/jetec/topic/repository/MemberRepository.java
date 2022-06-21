package com.jetec.topic.repository;


import com.jetec.topic.model.ArticleBean;
import com.jetec.topic.model.MemberBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemberRepository extends JpaRepository<MemberBean,String> {
    MemberBean findByEmail(String email);

    boolean existsByName(String name);

    boolean existsByEmail(String email);

    List<MemberBean> findByNameLikeIgnoreCase(String s, Sort createtime);

    List<MemberBean> findByEmailLikeIgnoreCase(String s, Sort createtime);
}
