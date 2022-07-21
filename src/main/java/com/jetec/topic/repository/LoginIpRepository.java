package com.jetec.topic.repository;

import com.jetec.topic.model.LoginIpBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoginIpRepository extends JpaRepository<LoginIpBean, Long> {
}
