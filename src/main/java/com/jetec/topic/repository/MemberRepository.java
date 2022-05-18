package com.jetec.topic.repository;


import com.jetec.topic.model.MemberBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<MemberBean,String> {
    MemberBean findByEmail(String email);

    boolean existsByName(String name);

    boolean existsByEmail(String email);
}
