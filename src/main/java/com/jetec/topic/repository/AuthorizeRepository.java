package com.jetec.topic.repository;

import com.jetec.topic.model.AuthorizeBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorizeRepository extends JpaRepository<AuthorizeBean,String> {
}
