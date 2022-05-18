package com.jetec.topic.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "member")
public class MemberBean {

    public static final String SESSIONID ="member";


    @Id
    private String memberid;
    private String email;
    private String name;
    private String password;
    private String company;
    private String phone;
    private String integral;
    private String address;
    private String birthday;
    private String createtime;


    @OneToMany(targetEntity = PermitBean.class, cascade = CascadeType.ALL)
    @JoinColumn(name = "memberid", referencedColumnName = "memberid", insertable = false, updatable = false)
    private List<PermitBean> permitList;


    public List<PermitBean> getPermitList() {
        return permitList;
    }

    public void setPermitList(List<PermitBean> permitList) {
        this.permitList = permitList;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getIntegral() {
        return integral;
    }

    public void setIntegral(String integral) {
        this.integral = integral;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "MemberBean{" +
                "memberid='" + memberid + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", company='" + company + '\'' +
                ", phone='" + phone + '\'' +
                ", integral='" + integral + '\'' +
                ", address='" + address + '\'' +
                ", birthday='" + birthday + '\'' +
                ", createtime='" + createtime + '\'' +
                ", permitList=" + permitList +
                '}';
    }
}
