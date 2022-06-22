package com.jetec.topic.service;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.AuthorizeBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.AuthorizeRepository;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Optional;


@Service
@Transactional
public class LoginService {
    @Autowired
    MemberRepository mr;

    @Autowired
    AuthorizeRepository authorizeRepository;

    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public MemberBean findByEmail(String email) {
        Optional<MemberBean> op = mr.findByEmail(email);
        return op.orElse(null);
    }

    //判斷暱稱重複
    public boolean existsMemberByName(String name) {
        return mr.existsByName(name);
    }

    //判斷暱稱重複
    public boolean existsMemberByEnail(String email) {
        return mr.existsByEmail(email);
    }

    //註冊會員
    public void saveMember(MemberBean bean) {
        System.out.println("註冊沒有錯誤,儲存會員");
        bean.setMemberid(ZeroTools.getUUID());
        bean.setPassword(passwordEncoder.encode(bean.getPassword()));
        bean.setCreatetime(ZeroTools.getTime(new Date()));
        System.out.println("=======================================================");
        System.out.println(bean);
        System.out.println("=======================================================");
        mr.save(bean);
    }


    public Optional<MemberBean> getMemberByEmail(String email) {
        return mr.findByEmail(email);
    }

    // 儲存認證碼
    public void saveAuthorize(String uuid, String memberid) {
        authorizeRepository.save(new AuthorizeBean(uuid,memberid));
    }
}
