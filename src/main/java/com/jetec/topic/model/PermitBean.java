package com.jetec.topic.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "permit")
public class PermitBean {

    @Id
    @Column(columnDefinition="CHAR(32)")
    private String permitid;
    @Column(columnDefinition="CHAR(32)")
    private String memberid;
    private String level;
    private String createtime;

    public PermitBean() {
    }

    public PermitBean(String permitid, String memberid, String level, String createtime) {
        this.permitid = permitid;
        this.memberid = memberid;
        this.level = level;
        this.createtime = createtime;
    }

    public String getPermitid() {
        return permitid;
    }

    public void setPermitid(String permitid) {
        this.permitid = permitid;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "PermitBean{" +
                "permitid='" + permitid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", level='" + level + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}


