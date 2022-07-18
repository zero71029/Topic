package com.jetec.topic.Tools;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

@Component
public class ZeroTools {

    // 筆記
    ///////////////////////////////////////////
//	返回上一頁
//	window.history.back();location.reload();
////////////////////
// sql修改为不自动更新（只是插入是自动生成当前时间）
//alter table hello change uptime uptime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	
    //////////////////////////////////////
//	重置 MySQL 自增列 AUTO_INCREMENT 初時值
//	ALTER TABLE tbl AUTO_INCREMENT = 1;
//////////////////////////////////
//	一键复制至剪切板
//	url.select();
//    document.execCommand("Copy");
//////jpa排序
    // Sort sort = Sort.by(Direction.DESC,"marketid");
    // return mr.findAll( sort);
///////////////////////////////
    //更新application
//	HttpServletRequest sce
//	ServletContext app = sce.getServletContext();
//	app.setAttribute("billboardgroup", bgr.findAll());
//////////ajax
//	var formData = new FormData($(".uppdf")[0]);
//	$.ajax({
//        url: '${pageContext.request.contextPath}/CRM/selectContactByClientName/' + $("input[name='client']").val(),//接受請求的Servlet地址
//        type: 'POST',
//        // data: formData,
//        // async: false,//同步請求
//        // cache: false,//不快取頁面
//        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
//        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
//        success: function (json) {
//            $(".CCC").empty();
//
//            for (var j of json) {
//                console.log(j);
//
//                $(".CCC").append('<div class="row TTT" onclick="clickContact(`' + j.name + '`,`' + j.phone + '`,`' + j.moblie + '`)">' +
//                    '<div class="col-md-1"></div>' +
//                    '<div class="col-md-3">' + j.name + '</div>' +
//                    '<div class="col-md-3">' + j.phone + '</div>' +
//                    '<div class="col-md-3">' + j.moblie + '</div>' +
//                    '</div>');
//            }
//        },
//        error: function (returndata) {
//            console.log(returndata);
//        }
//    });

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//    // 機器人判斷
    public static boolean recaptcha(String toke) {

        String secret = "";

        // 取得token
        System.out.println(toke);
        System.out.println("*****recaptcha******");

//		JSONObject obj = new JSONObject();
//		obj.put("secret", "");
//		obj.put("response", body);
//		obj.put("remoteip", ip);
        try {
            // 編輯google需要文件
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + secret + "&response=" + toke;
            // 開啟網路發送
            HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
            http.setDoOutput(true);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            // 接收返回資料
            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            JSONObject json = new JSONObject(sb.toString());
            System.out.println(json);
            res.close();

            // 判斷成功存在session
            if ((boolean) json.get("success")) return true;

            return false;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

    /**
     * 獲得一個UUID
     *
     * @return String UUID
     */
    public static String getUUID() {
        String s = UUID.randomUUID().toString();
        // 去掉“-”符號
        return s.substring(0, 8) + s.substring(9, 13) + s.substring(14, 18) + s.substring(19, 23) + s.substring(24);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//時間格式畫
    public static String getTime(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(date);
    }

    //////////////////////////////////////////////////////////////////////////////
//    日期加幾天
    public String addDay(String day, int i) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(dateFormat.parse(day));
        } catch (ParseException e1) {

        }
        cal.add(Calendar.DATE, i);
        return dateFormat.format(cal.getTime());

    }
}


