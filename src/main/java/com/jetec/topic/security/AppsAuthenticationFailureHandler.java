package com.jetec.topic.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.persistence.Access;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;


//登入錯誤 才會進來 反回訊息
@Component
public class AppsAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    MemberRepository mr;


    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        System.out.println("登入失敗");

        String username = request.getParameter("username"); // 取得登入帳號
        String password = request.getParameter("password");
        System.out.println(username);
        System.out.println(password);
        Optional<MemberBean> op = mr.findByEmail(username);
        MemberBean memberBean = op.get();
        Map<String, String> error = new HashMap<>();
        if (memberBean == null) {
            System.out.println("找不到使用者");
            error.put("user","找不到使用者") ;
        } else if ( !passwordEncoder .matches(password,memberBean.getPassword())){
            System.out.println("密碼錯誤");
            error.put("pass","密碼錯誤") ;

        }
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("error", error);
        request.getRequestDispatcher("/member/login.jsp").forward(request, response);

//        response.sendRedirect("/topic/member/login.jsp?error=" + error);


    }

}
