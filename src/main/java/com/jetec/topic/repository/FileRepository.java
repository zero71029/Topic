package com.jetec.topic.repository;

import com.jetec.topic.model.FileBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FileRepository extends JpaRepository<FileBean,String> {
}
