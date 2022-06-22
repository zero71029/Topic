package com.jetec.topic.security;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;


@Service
public class UserService implements UserDetailsService {


    @Autowired
    private PasswordEncoder encoder;

    @Autowired
	MemberRepository mr;

    @Autowired
    HttpServletRequest request;

    @Override
    public UserDetails loadUserByUsername(String username) throws AuthenticationException {

        System.out.println(request);
        String response = request.getParameter("g-recaptcha-response");

        if(ZeroTools.recaptcha(response)){
            MemberBean memberBean = mr.findByEmail(username);
            if (memberBean != null) {
                return new User(username, memberBean.getPassword(), AuthorityUtils.commaSeparatedStringToAuthorityList("認證名稱"));
            }
        }else {
            request.setAttribute("recaptcha" , "認證錯誤");
        }

        return null;

    }


}
