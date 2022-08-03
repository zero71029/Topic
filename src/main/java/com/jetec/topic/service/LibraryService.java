package com.jetec.topic.service;

import com.jetec.topic.model.LibraryBean;
import com.jetec.topic.repository.LibraryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class LibraryService {
    @Autowired
    LibraryRepository lr;

    public List<LibraryBean> getOption(String group) {
      return   lr.findByLibrarygroup(group);
    }
}
