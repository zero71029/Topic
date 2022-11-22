package com.jetec.topic.security;

import com.jetec.topic.model.MemberBean;
import com.jetec.topic.model.PermitBean;
import com.jetec.topic.repository.MemberRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


//登入錯誤 才會進來 反回訊息
@Component
public class AppsAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    MemberRepository mr;

    Logger logger = LoggerFactory.getLogger("AppsAuthenticationFailureHandler");
    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        System.out.println("登入失敗");
// 取得登入帳號
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        logger.info("{} 登入失敗", username);

        //讓資料能返回
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        Optional<MemberBean> op = mr.findByEmail(username);
        Map<String, String> error = new HashMap<>();


        op.ifPresentOrElse(bean -> {
            //權限檢查
            List<PermitBean> pList = bean.getPermitList();
            for (PermitBean permitBean : pList) {
                if (permitBean.getLevel() == 255) {
                    error.put("blockade", "該帳號被封鎖");
                    //得到来访者的IP地址
                    String ip = request.getRemoteAddr();







                    break;
                }
            }


            //密碼檢查
            if (!passwordEncoder.matches(password, bean.getPassword())) {
                System.out.println("密碼錯誤");
                error.put("pass", "密碼錯誤");
            }
        }, () -> {
            System.out.println("找不到使用者");
            error.put("user", "找不到使用者");
        });
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("error", error);
        request.getRequestDispatcher("/member/login.jsp").forward(request, response);

//        response.sendRedirect("/topic/member/login.jsp?error=" + error);


    }

}
