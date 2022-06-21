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
    @Column(columnDefinition = "TINYINT(1)")
    private Integer level;


    public PermitBean() {
    }

    public PermitBean(String permitid, String memberid, Integer level) {
        this.permitid = permitid;
        this.memberid = memberid;
        this.level = level;
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

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "PermitBean{" +
                "permitid='" + permitid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", level='" + level + '\'' +
                '}';
    }
}


