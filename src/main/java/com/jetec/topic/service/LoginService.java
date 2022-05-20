package com.jetec.topic.service;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;


@Service
@Transactional
public class LoginService {
    @Autowired
    MemberRepository mr;

    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public MemberBean findByEmail(String email) {


        return mr.findByEmail(email);
    }

    //判斷暱稱重複
    public boolean existsMemberByName(String name) {
        return mr.existsByName(name);
    }

    //判斷暱稱重複
    public boolean existsMemberByEnail(String email) {
        return mr.existsByEmail(email);
    }

    //儲存會員
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


    public MemberBean getMemberByEmail(String email) {
        if (mr.existsByEmail(email)) {
            return mr.findByEmail(email);
        }
        return null;
    }
}
