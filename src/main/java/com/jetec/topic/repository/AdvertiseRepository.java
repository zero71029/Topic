package com.jetec.topic.repository;

import com.jetec.topic.model.AdvertiseBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdvertiseRepository extends JpaRepository<AdvertiseBean, String> {
    List<AdvertiseBean> findByLocation(String location, Sort sortable);
}
