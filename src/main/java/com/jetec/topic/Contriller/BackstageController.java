package com.jetec.topic.Contriller;

import com.jetec.topic.Tools.ZeroTools;
import com.jetec.topic.model.*;
import com.jetec.topic.service.BackstageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/backstage")
//@PreAuthorize(" hasAuthority('9')")

public class BackstageController {
    @Autowired
    BackstageService BS;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化
    @RequestMapping("/init")
    @ResponseBody
    public Map<String, Object> init(@RequestParam("page") Integer page, @RequestParam("pageSize") Integer size) {
        page--;
        System.out.println("初始化");

        return BS.init(page, size);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //細節
    @RequestMapping("/detail/{id}")
    @ResponseBody
    public MemberBean detail(@PathVariable("id") String memberid) {
        System.out.println("客戶細節");
        return BS.getMember(memberid);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章列表初始化
    @RequestMapping("/articleList")
    @ResponseBody
    public Map<String, Object> articleLiat(@RequestParam("page") Integer page, @RequestParam("pageSize") Integer size, @RequestParam("state") String state) {
        page--;
        System.out.println("文章列表初始化");
        return BS.articleList(page, size,state);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //文章細節
    @RequestMapping("/articleDetail/{id}")
    @ResponseBody
    public Map<String, Object> articleDetail(@PathVariable("id") String articleid,@RequestParam("p")Integer p) {
        p--;
        System.out.println("文章細節");
        Map<String, Object> result = new HashMap<>();
        result.put(ArticleBean.SESSIONID, BS.getarticleDetail(articleid,p));
        result.put(ArticleContentBean.SESSIONID, BS.getArticleContent(articleid).getContent());
        //存觀看時間
        new Thread(() -> BS.saveWatchTime("system", articleid)).start();
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    @RequestMapping("/changeState/{state}/{articleid}")
    @ResponseBody
    public boolean changeState(@PathVariable("articleid") String articleid, @PathVariable("state") String state) {
        System.out.println("article修改狀態");
        return BS.changeState(articleid, state);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    @RequestMapping("/replyState/{state}/{replyid}")
    @ResponseBody
    public List<ArticleReplyBean> replyState(@PathVariable("replyid") String replyid, @PathVariable("state") String state) {
        System.out.println("reply修改狀態");
        ArticleReplyBean aBean = BS.replyState(replyid, state);
        return BS.getArticleReplyList(aBean.getArticleid());
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //修改狀態
    @RequestMapping("/changeReturnState")
    @ResponseBody
    public boolean changeReturnState(@RequestParam("id") Long id,@RequestParam("state")String state) {
        System.out.println("reply修改狀態");
        return BS.changeReturnState(id,state);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //後臺文章搜索
    @RequestMapping("/search")
    @ResponseBody
    public List<ArticleBean> search(@RequestParam("name") String name) {
        System.out.println("後臺文章搜索");
        return BS.search(name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //後臺客戶搜索
    @RequestMapping("/SearchMember")
    @ResponseBody
    public List<MemberBean> SearchMember(@RequestParam("select") String select, @RequestParam("search") String search) {
        System.out.println("後臺客戶搜索");
        return BS.SearchMember(select, search);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //權限修改
    @RequestMapping("/changePermit/{memberid}")
    @ResponseBody
    public List<MemberBean> changePermit(@PathVariable("memberid") String memberid, @RequestParam("VIP") Boolean VIP, @RequestParam("manage") Boolean manage) {
        System.out.println("權限修改");
        if (VIP) {
            BS.insertPermit(memberid, 8);
        } else {
            BS.delPermit(memberid, 8);
        }
        if (manage) {
            BS.insertPermit(memberid, 9);
        } else {
            BS.delPermit(memberid, 9);
        }
        return null;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //刪除廣告
    @RequestMapping("/deladvertise")
    @ResponseBody
    public List<AdvertiseBean> deladvertise(AdvertiseBean adBean) {
        System.out.println("刪除 廣告");
        System.out.println(adBean);
        BS.deladvertise(adBean);
        return BS.findAdvertiseByLocation(adBean.getLocation());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //新增廣告
    @RequestMapping("/addadvertise")
    @ResponseBody
    public List<AdvertiseBean> addadvertise(AdvertiseBean adBean) {
        System.out.println("新增/修改 廣告");

        System.out.println(adBean);
        BS.save(adBean);
        return BS.findAdvertiseByLocation(adBean.getLocation());
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //廣告初始化
    @RequestMapping("/advertiseinit")
    @ResponseBody
    public List<AdvertiseBean> advertiseinit(@RequestParam("location") String location) {
        return BS.findAdvertiseByLocation(location);
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//上傳附件
    @RequestMapping("/upfile")
    @ResponseBody
    public String upFile(MultipartHttpServletRequest multipartRequest, HttpSession session) {
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
                String lastname = fileMap.get("file").getOriginalFilename().substring(fileMap.get("file").getOriginalFilename().indexOf("."));
                System.out.println(lastname);

                //檔案輸出
                String path2 = "C:/CRMfile/" + uuid + lastname;
                System.out.println("檔案輸出到" + path2);
                fileMap.get("file").transferTo(new File(path2));
                System.out.println("輸出成功");
                //3. 儲存檔案名稱到資料庫
//                MemberBean memberBean = (MemberBean) session.getAttribute(MemberBean.SESSIONID);
//                FileBean fileBean = new FileBean(ZeroTools.getUUID(),memberBean.getMemberid(),uuid+lastname,ZeroTools.getTime(new Date()));
//                FileBean save =  ufs.save(fileBean);

                return uuid + lastname;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //回報列表
    @RequestMapping("/returnList")
    @ResponseBody
    public Map<String, Object> returnList(@RequestParam("page") Integer page, @RequestParam("size") Integer size,@RequestParam("state") String state) {
        System.out.println("回報列表");
        page--;
        Pageable Pageable = PageRequest.of(page, size, Sort.Direction.DESC, "createtime");
        Page<ArticleReturnBean> p = BS.findArticleReturn(Pageable,state);
        Map<String, Object> result = new HashMap<>();
        result.put("list", p.getContent());
        result.put("total", p.getTotalElements());
        return result;
    }

}
