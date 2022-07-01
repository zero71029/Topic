package com.jetec.topic.model;


import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "article_return")
@DynamicInsert
@DynamicUpdate
public class ArticleReturnBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(columnDefinition = "CHAR(32)")
    private String articleid;//文章id
    @Column(columnDefinition = "CHAR(32)")
    private String replyid;//回復id
    @Column(columnDefinition = "CHAR(32)")
    private String memberid;//回報人
    private String membername;
    @Column(columnDefinition = "CHAR(4)")
    private String returntype;
    private String content;
    @Column(columnDefinition = "CHAR(3)")
    private String state;
    private LocalDateTime createtime;

    public String getReplyid() {
        return replyid;
    }

    public void setReplyid(String replyid) {
        this.replyid = replyid;
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

    public String getReturntype() {
        return returntype;
    }

    public void setReturntype(String returntype) {
        this.returntype = returntype;
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

    public LocalDateTime getCreatetime() {
        return createtime;
    }

    public void setCreatetime(LocalDateTime createtime) {
        this.createtime = createtime;
    }

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    @Override
    public String toString() {
        return "ArticleReturnBean{" +
                "articleid='" + articleid + '\'' +
                ", replyid='" + replyid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", membername='" + membername + '\'' +
                ", returntype='" + returntype + '\'' +
                ", content='" + content + '\'' +
                ", state='" + state + '\'' +
                ", createtime=" + createtime +
                '}';
    }
}
