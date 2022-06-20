package com.jetec.topic.model;

import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_reply_content")
public class ArticleReplyContentBean {


    @Id
    @Column(columnDefinition = "CHAR(32)")
    private String replyid;
    @Type(type = "text")
    private String content;

}
