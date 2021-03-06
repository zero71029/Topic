package com.jetec.topic.Tools;

import com.jetec.topic.model.LoginIpBean;

public class ZeroFactory {

    public static ResultBean buildResultBean(Integer code) {
        return new ResultBean(code);
    }

    public static ResultBean buildResultBean(Integer code, String message) {
        return new ResultBean(code, message);
    }

    public static ResultBean buildResultBean(Integer code, String message, Object data) {
        return new ResultBean(code, message, data);
    }

    public static LoginIpBean buildLoginIp(String memberid ,String ip) {
        return new LoginIpBean(memberid,ip);
    }




}
