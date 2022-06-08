package com.jetec.topic.Contriller;

import com.jetec.topic.service.BackstageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/backstage")
public class BackstageController {
    @Autowired
    BackstageService BS;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化
    @RequestMapping("/init")
    @ResponseBody
    public Map<String , Object> init(@RequestParam("page")Integer page) {
        page--;
        System.out.println("初始化");
        Map<String , Object> result = BS.init(page);
        return result;
    }

}
