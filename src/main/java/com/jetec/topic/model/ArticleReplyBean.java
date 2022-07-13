package com.jetec.topic.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "article_reply")
public class ArticleReplyBean {


    @Id
    @Column(columnDefinition = "CHAR(32)")
    private String replyid;
    @Column(columnDefinition = "CHAR(32)")
    private String articleid;
    @Column(columnDefinition = "CHAR(32)")
    private String memberid;
    private String membername;
    @Type(type = "text")
    private String content;
    private String createtime;
    private Integer num;
    private String state;
    private Integer floor;


    @OneToMany(targetEntity = ArticleThumbsupBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "replyid", insertable = false, updatable = false)
    private List<ArticleThumbsupBean> thumbsuplist;


    @OneToMany(targetEntity = ArticleReplyBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "articleid", referencedColumnName = "replyid", insertable = false, updatable = false)
    @OrderBy("createtime ASC")
    private List<ArticleReplyBean> replylist;

    @OneToOne(targetEntity = MemberBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "memberid", referencedColumnName = "memberid", insertable = false, updatable = false)
    private MemberBean member;

    public ArticleReplyBean(String replyid, String articleid, String memberid, String membername, String content, String createtime) {
        this.replyid = replyid;
        this.articleid = articleid;
        this.memberid = memberid;
        this.membername = membername;
        this.content = content;
        this.createtime = createtime;
    }

    public ArticleReplyBean() {

    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

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

    public String getReplyid() {
        return replyid;
    }

    public void setReplyid(String replyid) {
        this.replyid = replyid;
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

    public String getMembername() {
        return membername;
    }

    public void setMembername(String membername) {
        this.membername = membername;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public MemberBean getMember() {
        return member;
    }

    public void setMember(MemberBean member) {
        this.member = member;
    }

    @Override
    public String toString() {
        return "ArticleReplyBean{" +
                "replyid='" + replyid + '\'' +
                ", articleid='" + articleid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", membername='" + membername + '\'' +
                ", createtime='" + createtime + '\'' +
                ", thumbsuplist=" + thumbsuplist +
                '}';
    }
}
