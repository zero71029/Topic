package com.jetec.topic.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "article")
public class ArticleBean {

    public static final String SESSIONID = "article";

    @Id
    private String articleid;
    private String name;
    //    @Column(length = 16777215, columnDefinition = "mediumtext")
//    @Column(length = 65535, columnDefinition = "text")
    @Type(type = "text")
    private String content;
    private String state;
    private String replytime;
    private String createtime;
    private String memberid;
    private String articlegroup;
    private String membername;


    @OneToMany(targetEntity = ArticleReplyBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "articleid", insertable = false, updatable = false)
    @OrderBy("num DESC")
    private List<ArticleReplyBean> replylist;


    @OneToMany(targetEntity = ArticleThumbsupBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "articleid", insertable = false, updatable = false)
    private List<ArticleThumbsupBean> thumbsuplist;

    public List<ArticleReplyBean> getReplylist() {
        return replylist;
    }

    public void setReplylist(List<ArticleReplyBean> replylist) {
        this.replylist = replylist;
    }

    public List<ArticleThumbsupBean> getThumbsuplist() {
        return thumbsuplist;
    }

    public void setThumbsuplist(List<ArticleThumbsupBean> thumbsuplist) {
        this.thumbsuplist = thumbsuplist;
    }

    public String getMembername() { return membername;  }

    public void setMembername(String membername) {
        this.membername = membername;
    }

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getReplytime() {
        return replytime;
    }

    public void setReplytime(String replytime) {
        this.replytime = replytime;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getArticlegroup() {
        return articlegroup;
    }

    public void setArticlegroup(String articlegroup) {
        this.articlegroup = articlegroup;
    }

    @Override
    public String toString() {
        return "ArticleBean{" +
                "articleid='" + articleid + '\'' +
                ", name='" + name + '\'' +
                ", content='" + content + '\'' +
                ", state='" + state + '\'' +
                ", replytime='" + replytime + '\'' +
                ", createtime='" + createtime + '\'' +
                ", memberid='" + memberid + '\'' +
                ", articlegroup='" + articlegroup + '\'' +
                ", membername='" + membername + '\'' +
                ", replylist=" + replylist +
                '}';
    }
}


