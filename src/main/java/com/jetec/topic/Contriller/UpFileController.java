package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.FileBean;
import com.jetec.topic.model.MemberBean;
import com.jetec.topic.service.UpFileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.Map;

@Controller
public class UpFileController {
    Logger logger = LoggerFactory.getLogger(UpFileController.class);

    @Autowired
    UpFileService ufs;


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳附件
    @RequestMapping("/upfile")
    @ResponseBody
    public String upFile(MultipartHttpServletRequest multipartRequest, HttpSession session) {
        logger.info("上傳附件");
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
                String lastname = fileMap.get("file").getOriginalFilename().substring(fileMap.get("file").getOriginalFilename().indexOf("."));
                System.out.println(lastname);

                //檔案輸出
                String path2 = "c:/file/Forum/" + uuid + lastname;
                System.out.println("檔案輸出到" + path2);
                fileMap.get("file").transferTo(new File(path2));
                System.out.println("輸出成功");
                //3. 儲存檔案名稱到資料庫
                SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
                MemberBean memberBean = (MemberBean) sci.getAuthentication().getPrincipal();
                FileBean fileBean = new FileBean(ZeroTools.getUUID(),memberBean.getMemberid(),uuid+lastname,ZeroTools.getTime(new Date()));
                FileBean save =  ufs.save(fileBean);

                return save.getName();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }


}
