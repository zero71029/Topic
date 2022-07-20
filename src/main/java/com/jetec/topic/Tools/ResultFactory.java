package com.jetec.topic.Tools;

import java.sql.ResultSet;

public class ResultFactory {

    public static ResultBean buildResultBean(Integer code) {
        return new ResultBean(code);

    }

    public static ResultBean buildResultBean(Integer code, String message) {
        return new ResultBean(code, message);
    }

    public static ResultBean buildResultBean(Integer code, String message, Object data) {
        return new ResultBean(code, message, data);
    }


}
