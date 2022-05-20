package com.jetec.topic.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="file")
public class FileBean {

    @Id
    private String fileid;
    private String memberid;
    private String name;
    private String createtime;

    public FileBean() {
    }

    public FileBean(String fileid, String memberid, String name, String createtime) {
        this.fileid = fileid;
        this.memberid = memberid;
        this.name = name;
        this.createtime = createtime;
    }

    public String getFileid() {
        return fileid;
    }

    public void setFileid(String fileid) {
        this.fileid = fileid;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "FileBean{" +
                "fileid='" + fileid + '\'' +
                ", memberid='" + memberid + '\'' +
                ", name='" + name + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
