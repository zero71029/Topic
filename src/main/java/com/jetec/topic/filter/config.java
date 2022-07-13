package com.jetec.topic.filter;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class config {


//    @Bean
//    public FilterRegistrationBean<LoginFilter> filterSystemnBean() {
//        FilterRegistrationBean<LoginFilter> registrationBean = new FilterRegistrationBean<LoginFilter>(new LoginFilter());
//        //过滤路径
//        registrationBean.addUrlPatterns("/login");
//        //添加不过滤路径
////        registrationBean.addInitParameter("noFilter", "/,/two");
//        registrationBean.setName("LoginFilter");
//        registrationBean.setOrder(1);
//        return registrationBean;
//    }
}
