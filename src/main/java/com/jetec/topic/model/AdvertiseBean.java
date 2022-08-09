package com.jetec.topic.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "advertise")
public class AdvertiseBean {
    @Id
    @Column(columnDefinition = "CHAR(32)")
    private String advertiseid;
    private String name;
    private String url;
    private String img;
    @Column(columnDefinition = "CHAR(1)")
    private String location;
    @Column(columnDefinition = "CHAR(10)")
    private String createtime;

    @Column(columnDefinition = "tinyint")
    private Integer sortable;

    public AdvertiseBean() {
    }


    public AdvertiseBean(String advertiseid, String name, String url, String location, String createtime) {
        this.advertiseid = advertiseid;
        this.name = name;
        this.url = url;
        this.location = location;
        this.createtime = createtime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }


    public Integer getSortable() {
        return sortable;
    }

    public void setSortable(Integer sortable) {
        this.sortable = sortable;
    }

    public String getAdvertiseid() {
        return advertiseid;
    }

    public void setAdvertiseid(String advertiseid) {
        this.advertiseid = advertiseid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "AdvertiseBean{" +
                "advertiseid='" + advertiseid + '\'' +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", img='" + img + '\'' +
                ", location='" + location + '\'' +
                ", createtime='" + createtime + '\'' +
                '}';
    }
}
