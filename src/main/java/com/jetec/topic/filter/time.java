package com.jetec.topic.filter;

import com.jetec.topic.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

@Configuration
public class time {

    @Autowired
    LoginService ls;

    @Scheduled(cron = "0 0 23 * * *")
    public void layoutSQL() {
        //刪除過期Permit
         ls.delAuthorize();

    }


}
