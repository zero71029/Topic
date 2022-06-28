package com.jetec.topic.repository;

import com.jetec.topic.model.AdvertiseBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdvertiseRepository extends JpaRepository<AdvertiseBean,String> {
}
