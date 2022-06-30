package com.jetec.topic.intercepotor;

import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.ErrorPageRegistrar;
import org.springframework.boot.web.server.ErrorPageRegistry;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

@Configuration
public class ErrorConfigurar implements ErrorPageRegistrar {



    @Override
    public void registerErrorPages(ErrorPageRegistry registry) {

        ErrorPage[] errorPages = new ErrorPage[3];
        errorPages[0] = new ErrorPage(HttpStatus.NOT_FOUND, "/error/error404.jsp");
        errorPages[1] = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/error500.jsp");
        errorPages[2] = new ErrorPage("/error/error500.jsp");
        registry.addErrorPages(errorPages);
    }
}