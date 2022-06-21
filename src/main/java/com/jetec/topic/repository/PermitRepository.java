package com.jetec.topic.repository;

import com.jetec.topic.model.PermitBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PermitRepository extends JpaRepository<PermitBean,String> {
    boolean existsByMemberidAndLevel(String memberid, int i);

    PermitBean findByMemberidAndLevel(String memberid, int i);
}
