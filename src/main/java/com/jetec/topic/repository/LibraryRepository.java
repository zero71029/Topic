package com.jetec.topic.repository;

import com.jetec.topic.model.LibraryBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LibraryRepository extends JpaRepository<LibraryBean,String> {
    List<LibraryBean> findByLibrarygroup(String group);
}
