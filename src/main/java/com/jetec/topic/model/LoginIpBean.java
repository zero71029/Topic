package com.jetec.topic.model;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name="login_ip")
@DynamicInsert
@DynamicUpdate
public class LoginIpBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(columnDefinition="CHAR(32)")
    private String memberid;
    private String ip;
    private LocalDateTime createtime;

    public LoginIpBean() {
    }

    public LoginIpBean(String memberid, String ip) {
        this.memberid = memberid;
        this.ip = ip;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public LocalDateTime getCreatetime() {
        return createtime;
    }

}
