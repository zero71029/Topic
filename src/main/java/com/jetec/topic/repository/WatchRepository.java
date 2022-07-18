package com.jetec.topic.repository;

import com.jetec.topic.model.WatchBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface WatchRepository extends JpaRepository<WatchBean,String> {
    Optional<WatchBean> findByMemberidAndArticleid(String memberid, String articleid);
}
