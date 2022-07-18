package com.jetec.topic.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "article")
public class ArticleBean {

    public static final String SESSIONID = "article";

    @Id
    @Column(columnDefinition = "CHAR(32)")
    private String articleid;
    @Column(columnDefinition = "CHAR(32)")
    private String memberid;
    @Column(columnDefinition = "CHAR(16)")
    private String createtime;
    private String name;
    @Column(columnDefinition = "CHAR(3)")
    private String state;
    private String replytime;
    private String articlegroup;
    private String membername;
    @Transient
    private Integer total;


    @OneToMany(targetEntity = ArticleReplyBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "articleid", insertable = false, updatable = false)
    @OrderBy("create DESC")
    private List<ArticleReplyBean> replylist;


    @OneToMany(targetEntity = ArticleThumbsupBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "articleid", insertable = false, updatable = false)
    private List<ArticleThumbsupBean> thumbsuplist;


    @ManyToOne(targetEntity = MemberBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "memberid", referencedColumnName = "memberid", insertable = false, updatable = false)
    private MemberBean member;


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

    public String getMembername() {
        return membername;
    }

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

    public MemberBean getMember() {
        return member;
    }

    public void setMember(MemberBean member) {
        this.member = member;
    }


    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "ArticleBean{" +
                "articleid='" + articleid + '\'' +
                ", name='" + name + '\'' +
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


