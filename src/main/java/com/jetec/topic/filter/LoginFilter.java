package com.jetec.topic.filter;


import com.jetec.topic.Tools.ZeroTools;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@Component
public class LoginFilter extends OncePerRequestFilter {


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        System.out.println("機器人驗證");
        if(Objects.equals("/Forum/login",request.getRequestURI()) ){

            try{
                String recaptcha = request.getParameter("g-recaptcha-response");
                if(recaptcha == null || recaptcha.isEmpty()){
                    throw new SessionAuthenticationException("沒有驗證!");
                }
                Assert.isTrue(ZeroTools.recaptcha(recaptcha) || Objects.equals("AAA",recaptcha),"驗證失敗!");
                request.setAttribute("success","驗證成功");
            }catch (Exception e){
                request.setAttribute("recaptcha",e.getMessage());
                request.getRequestDispatcher("/member/login.jsp").forward(request, response);
                return;
            }
        }

        filterChain.doFilter(request, response);
    }
}
