package com.jetec.topic.model;

import org.hibernate.annotations.Type;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "article_content")
public class ArticleContentBean {

    public static final String SESSIONID = "article_content";

    @Id
    @Column(columnDefinition="CHAR(32)")
    private String articleid;
    //    @Column(length = 16777215, columnDefinition = "mediumtext")
    //    @Column(length = 65535, columnDefinition = "text")
    @Type(type = "text")
    private String content;

    public String getArticleid() {
        return articleid;
    }

    public void setArticleid(String articleid) {
        this.articleid = articleid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    @Override
    public String toString() {
        return "ArticleContentBean{" +
                "articleid='" + articleid + '\'' +
                ", content='" + content + '\'' +
                '}';
    }

    public ArticleContentBean() {
    }

    public ArticleContentBean(String articleid, String content) {
        this.articleid = articleid;
        this.content = content;
    }
}
