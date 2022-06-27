package com.jetec.topic.security;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.model.PermitBean;
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
import java.util.List;
import java.util.Optional;


@Service
public class UserService implements UserDetailsService {
    @Autowired
    MemberRepository mr;
    @Autowired
    HttpServletRequest request;

    @Override
    public UserDetails loadUserByUsername(String username) throws AuthenticationException {
        System.out.println(request);
        String response = request.getParameter("g-recaptcha-response");
        if (ZeroTools.recaptcha(response)) {
            Optional<MemberBean> op = mr.findByEmail(username);
            if (op.isPresent()) {
                MemberBean mBean = op.get();
                List<PermitBean> permitList = mBean.getPermitList();
                StringBuffer permit = new StringBuffer();
                permitList.forEach(e-> {
                    permit.append(e.getLevel());
                    permit.append(" ,");
                });
                permit.append("11");
                return new User(username, op.get().getPassword(), AuthorityUtils.commaSeparatedStringToAuthorityList(permit.toString()));
            }
        } else {
            request.setAttribute("recaptcha", "認證錯誤");
        }
//        return null;
        return new User("null","null",AuthorityUtils.commaSeparatedStringToAuthorityList(""));
    }
}
