package com.jetec.topic.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "watch")
public class WatchBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(columnDefinition="CHAR(32)")
    private String memberid;
    @Column(columnDefinition="CHAR(32)")
    private String articleid;
    private LocalDateTime watchtime;

    public WatchBean() {
    }

    public WatchBean(String memberid, String articleid, LocalDateTime watchtime) {
        this.memberid = memberid;
        this.articleid = articleid;
        this.watchtime = watchtime;
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

    public LocalDateTime getWatchtime() {
        return watchtime;
    }

    public void setWatchtime(LocalDateTime watchtime) {
        this.watchtime = watchtime;
    }

    @Override
    public String toString() {
        return "watchBean{" +
                "memberid='" + memberid + '\'' +
                ", articleid='" + articleid + '\'' +
                ", watchtime=" + watchtime +
                '}';
    }
}
