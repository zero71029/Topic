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
@Table(name="member_collect")
@DynamicInsert
@DynamicUpdate
public class CollectBean {


    @Id
    @Column(columnDefinition="CHAR(32)")
    private String collectid;
    @Column(columnDefinition="CHAR(32)")
    private String memberid;
    @Column(columnDefinition = "CHAR(32)")
    private String articleid;
    @Column(name = "create_time",updatable = false)
    private LocalDateTime createtime;


    public CollectBean() {
    }

    public CollectBean(String collectid, String memberid, String articleid) {
        this.collectid = collectid;
        this.memberid = memberid;
        this.articleid = articleid;
    }

    public String getCollectid() {
        return collectid;
    }

    public void setCollectid(String collectid) {
        this.collectid = collectid;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    @Override
    public String toString() {
        return "CollectBean{" +
                "collectid='" + collectid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", articleid='" + articleid + '\'' +
                '}';
    }
}
