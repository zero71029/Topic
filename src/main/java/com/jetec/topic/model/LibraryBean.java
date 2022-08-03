package com.jetec.topic.model;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="library")
@DynamicInsert
@DynamicUpdate
public class LibraryBean {

    @Id
    @Column(columnDefinition="CHAR(32)")
    private String libraryid;
    private String librarygroup;
    private String libraryoption;
    private String remark;

    public LibraryBean() {
    }

    public LibraryBean(String librarygroup, String libraryoption, String remark) {
        this.librarygroup = librarygroup;
        this.libraryoption = libraryoption;
        this.remark = remark;
    }

    public String getLibrarygroup() {
        return librarygroup;
    }

    public void setLibrarygroup(String librarygroup) {
        this.librarygroup = librarygroup;
    }

    public String getLibraryoption() {
        return libraryoption;
    }

    public void setLibraryoption(String libraryoption) {
        this.libraryoption = libraryoption;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "LibraryBean{" +
                "libraryid='" + libraryid + '\'' +
                ", librarygroup='" + librarygroup + '\'' +
                ", libraryoption='" + libraryoption + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
