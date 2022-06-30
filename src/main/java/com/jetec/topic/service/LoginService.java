package com.jetec.topic.service;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.AuthorizeBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.model.PermitBean;
import com.jetec.topic.repository.AuthorizeRepository;
import com.jetec.topic.repository.MemberRepository;
import com.jetec.topic.repository.PermitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class LoginService {
    @Autowired
    MemberRepository mr;
    @Autowired
    AuthorizeRepository authorizeRepository;
    @Autowired
    PermitRepository pr;

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
    public MemberBean saveMember(MemberBean bean) {
        System.out.println("註冊沒有錯誤,儲存會員");
        if (bean.getMemberid() == null) {
            bean.setMemberid(ZeroTools.getUUID());
            bean.setCreatetime(ZeroTools.getTime(new Date()));
        }
        bean.setPassword(passwordEncoder.encode(bean.getPassword()));
        System.out.println("=======================================================");
        System.out.println(bean);
        System.out.println("=======================================================");
        return mr.save(bean);
    }


    public Optional<MemberBean> getMemberByEmail(String email) {
        return mr.findByEmail(email);
    }

    // 儲存認證碼
    public void saveAuthorize(String uuid, String memberid) {
        authorizeRepository.save(new AuthorizeBean(uuid, memberid));
    }

    public String checkAithorize(String id) {
        Optional<AuthorizeBean> op = authorizeRepository.findById(id);
        if (op.isPresent()) {
            AuthorizeBean auth = op.get();
            LocalDateTime now = LocalDateTime.now();
            Duration duration = Duration.between(auth.getCreate(), now);
            if (duration.toDays() > 1) {
                authorizeRepository.delete(auth);
                return "時效過期";
            }
            authorizeRepository.delete(auth);
            return auth.getMemberid();
        }
        return "錯誤";
    }

    public Optional<MemberBean> getMemberById(String id) {
        return mr.findById(id);
    }

    public void savePermit(String uuid, String memberid, int i) {
        if (!pr.existsByMemberidAndLevel(memberid, i)) {
            pr.save(new PermitBean(uuid, memberid, i));
        }

    }
    //判斷有無權限
    public boolean existsPermetByEmailAndLevel(String email, int i) {
        Optional<MemberBean> op = mr.findByEmail(email);
        if(op.isPresent()){
            MemberBean mBean = op.get();
            return pr.existsByMemberidAndLevel(mBean.getMemberid(), i);
        }
        return false;
    }
    //刪除過期Permit
    public void delAuthorize() {
        LocalDateTime now = LocalDateTime.now();
        List<AuthorizeBean> list = authorizeRepository.findAll();
        list.forEach(e->{
            if(Duration.between(e.getCreate(),now).toDays()>1){
                authorizeRepository.delete(e);
            }
        });
    }

    public MemberBean findMemberById(String auth) {
        return mr.getById(auth);
    }
}
