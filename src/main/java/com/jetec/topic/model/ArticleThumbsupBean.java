package com.jetec.topic.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="articlethumbsup")
public class ArticleThumbsupBean {

    public static final String THUMBSUPID = "thumbsup";
    @Id
    private String thumbsupid;
    private String articleid;
    private String  memberid;


    public ArticleThumbsupBean(String thumbsupid, String articleid, String memberid) {
        this.thumbsupid = thumbsupid;
        this.articleid = articleid;
        this.memberid = memberid;
    }

    public ArticleThumbsupBean() {

    }

    public String getThumbsupid() {
        return thumbsupid;
    }

    public void setThumbsupid(String thumbsupid) {
        this.thumbsupid = thumbsupid;
    }

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    @Override
    public String toString() {
        return "ArticleThumbsupBean{" +
                "thumbsupid='" + thumbsupid + '\'' +
                ", articleid='" + articleid + '\'' +
                ", memberid='" + memberid + '\'' +
                '}';
    }
}
