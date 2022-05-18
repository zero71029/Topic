package com.jetec.topic.security;

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


@Service
public class UserService implements UserDetailsService {


    @Autowired
    private PasswordEncoder encoder;

    @Autowired
	MemberRepository mr;

    @Override
    public UserDetails loadUserByUsername(String username) throws AuthenticationException {

        MemberBean memberBean = mr.findByEmail(username);
        if (memberBean != null) {
            String password = encoder.encode(memberBean.getPassword());
            return new User(username, password, AuthorityUtils.commaSeparatedStringToAuthorityList("認證名稱"));
        }
        return null;

    }


}
