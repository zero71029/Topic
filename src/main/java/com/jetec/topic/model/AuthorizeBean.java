package com.jetec.topic.model;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name="authorize")
@DynamicInsert
@DynamicUpdate
public class AuthorizeBean {
    @Id
    @Column(columnDefinition="CHAR(32)")
    private String id;
    @Column(columnDefinition="CHAR(32)")
    private String  memberid;
    @Column(name = "create_time")

    private LocalDateTime create;


    public AuthorizeBean() {
    }

    public AuthorizeBean(String id, String memberid) {
        this.id = id;
        this.memberid = memberid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public LocalDateTime getCreate() {
        return create;
    }



    @Override
    public String toString() {
        return "AuthorizeBean{" +
                "id='" + id + '\'' +
                ", memberid='" + memberid + '\'' +
                ", create=" + create +
                '}';
    }
}
