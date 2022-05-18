package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.Map;

@Controller
public class UpFileController {


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳附件
    @RequestMapping("/upfile")
    @ResponseBody
    public String upFile(MultipartHttpServletRequest multipartRequest) {
        System.out.println("*****上傳附件*****");
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        String uuid = ZeroTools.getUUID();

        System.out.println("fileMap " + fileMap);//圖片儲存
        try {
            //2. 儲存圖片到資料夾
            if (fileMap.get("file") != null) {//讀取檔眳
                //讀取檔名
                System.out.println(fileMap.get("file").getOriginalFilename());
                String filename = fileMap.get("file").getOriginalFilename();

                //讀取副檔名
                String lastname = fileMap.get("file").getOriginalFilename()
                        .substring(fileMap.get("file").getOriginalFilename().indexOf("."));
                System.out.println(lastname);

                //檔案輸出
                String path2 = "C:/CRMfile/" + uuid + lastname;
                System.out.println("檔案輸出到" + path2);
                fileMap.get("file").transferTo(new File(path2));
                System.out.println("輸出成功");
                //3. 儲存檔案名稱到資料庫
//                MarketFileBean fileBean = new MarketFileBean(zTools.getUUID(), authorizeId, filename, authorizeId, filename);
//                MarketFileBean save = US.save(fileBean);
//                return save;

                return uuid  + lastname;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }


}
