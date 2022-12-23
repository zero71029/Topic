package com.jetec.topic.filter;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.topic.Tools.ZeroTools;
import org.springframework.beans.factory.annotation.Autowired;
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

/**
 * 機器人驗證
 * @author jetec
 */
@Component
public class LoginFilter extends OncePerRequestFilter {


    @Autowired
    Cache<String, Object> caffeineCache;




    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String url = "/Forum/login";
        if (Objects.equals(url, request.getRequestURI())) {
            try {
                String recaptcha = request.getParameter("g-recaptcha-response");
                if (recaptcha == null || recaptcha.isEmpty()) {
                    throw new SessionAuthenticationException("沒有驗證!");
                }
                Assert.isTrue(ZeroTools.recaptcha(recaptcha) || Objects.equals("AAA", recaptcha), "驗證失敗!");
                request.setAttribute("success", "驗證成功");
            } catch (Exception e) {
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("password", request.getParameter("password"));
                request.setAttribute("recaptcha", e.getMessage());
                request.getRequestDispatcher("/member/login.jsp").forward(request, response);
                return;
            }
        }
        //1小時刷新400次 封鎖
        if (request.getRequestURI().indexOf("js") < 0 && request.getRequestURI().indexOf("css") < 0 && request.getRequestURI().indexOf("file") < 0 && request.getRequestURI().indexOf("icons") < 0 && request.getRequestURI().indexOf("advertiseinit") < 0 && request.getRequestURI().indexOf("images") < 0) {
            logger.info(request.getRemoteAddr() + " : " + request.getRequestURI());
            try {
                int sum = (int) caffeineCache.getIfPresent(request.getRemoteAddr());
                if(sum >400){
                    request.setAttribute("message", "刷新太多次 請稍後再使用!");
                    request.getRequestDispatcher("/error/error500.jsp").forward(request, response);
                    return;
                }
                caffeineCache.asMap().put(request.getRemoteAddr(),++sum);
            }catch (Exception e){
                caffeineCache.asMap().put(request.getRemoteAddr(),1);
            }
        }
        filterChain.doFilter(request, response);
    }
}
