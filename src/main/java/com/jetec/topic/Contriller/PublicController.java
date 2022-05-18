package com.jetec.topic.Contriller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class PublicController {


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//登入
    @RequestMapping(path = {"/", "/index"})
    public String index( HttpSession session) {
        return "/topiclist";
    }
}
