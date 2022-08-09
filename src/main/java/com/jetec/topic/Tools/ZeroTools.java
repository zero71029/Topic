package com.jetec.topic.Tools;

import com.github.f4b6a3.uuid.UuidCreator;
import com.jetec.topic.model.MemberBean;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

    // 機器人判斷
    public static boolean recaptcha(String toke) {
        String secret = "";
        // 取得token
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
        String s = UuidCreator.getTimeOrderedWithRandom().toString();
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
    //////////////////////////////////////////////////////////////////////////////
    // 取得登入者
    public static MemberBean getMemberBean(){
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            return (MemberBean) authentication.getPrincipal();
        }catch (Exception e){
            MemberBean memberBean = new MemberBean();
            memberBean.setName("未登入");
            memberBean.setMemberid("");
            return new MemberBean();
        }

    }
}


