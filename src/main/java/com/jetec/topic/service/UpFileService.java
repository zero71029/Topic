package com.jetec.topic.service;

import com.jetec.topic.model.FileBean;
import com.jetec.topic.repository.FileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UpFileService {
    @Autowired
    FileRepository fr;

    public FileBean save(FileBean fileBean) {
       return fr.save(fileBean);
    }
}
