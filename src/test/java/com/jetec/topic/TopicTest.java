package com.jetec.topic;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class TopicTest {

    @Test
    void test1() throws InterruptedException {

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //配置
        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
        ChromeDriver driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
        driver.get("http://localhost:8080/topic/");
//        driver.get("http://192.168.11.100:8080/CRM");
        WebDriver.Options op = driver.manage();
        op.window().maximize();//全屏
        Thread.sleep(500);
        //登入
        driver.findElementByLinkText("登入").click();
//        driver.findElementById("username").sendKeys("AAA@AAA.com");
//        driver.findElementById("password").sendKeys("AAA");
        driver.findElement(By.xpath("/html/body/div/div[3]/div[2]/form/div[4]/div/button")).click();


        driver.findElementByLinkText("感測器").click();
        Thread.sleep(500);
        System.out.println("感測器有 " + driver.findElementsByClassName("article").size() + " 筆");
        driver.findElementByLinkText("儀器儀表").click();
        Thread.sleep(500);
        System.out.println("儀器儀表有 " + driver.findElementsByClassName("article").size() + " 筆");
        driver.findElementByLinkText("網通裝置").click();
        Thread.sleep(500);
        System.out.println("網通裝置有 " + driver.findElementsByClassName("article").size() + " 筆");
        driver.findElementByLinkText("軟體配件").click();
        Thread.sleep(500);
        System.out.println("軟體配件有 " + driver.findElementsByClassName("article").size() + " 筆");
        driver.findElementByLinkText("控制箱").click();
        Thread.sleep(500);
        System.out.println("控制箱有 " + driver.findElementsByClassName("article").size() + " 筆");
        driver.findElementByLinkText("應用").click();
        Thread.sleep(500);
        System.out.println("應用有 " + driver.findElementsByClassName("article").size() + " 筆");


        // x
        System.out.println("=============================================");
        driver.findElementByLinkText("感測器").click();
        driver.findElementsByClassName("article").get(0).click();
        Thread.sleep(500);
        System.out.println("主題 : "+driver.findElementById("articlename").getText());
        System.out.println("內容 "+driver.findElementById("content").getText()  +"字" );


        //
        System.out.println("=============================================");
        driver.findElementByLinkText("感測器").click();
        driver.findElementById("publish").click();
        //彈窗
        Set wh = driver.getWindowHandles();
        Iterator<Object> it = wh.iterator();
        String p1 = (String) it.next();
        String p2 = (String) it.next();
        driver.switchTo().window(p2);
        Thread.sleep(500);
        driver.findElementById("name").sendKeys("網管測試");
        driver.executeScript("tinymce.activeEditor.execCommand('mceInsertContent', false,'網管測試網管測試網管測試\\n網管測試網管測試網管測試\\n網管測試網管測試網管測試\\n')");
        driver.executeScript("vm.bean.agree= true");
        driver.executeScript("vm.submitForm()");

        //
        System.out.println("=============================================");
        driver.get("http://localhost:8080/topic/Backstage");
        driver.findElementByXPath("//*[@id=\"app\"]/section/aside/ul/li[2]").click();
        driver.findElementByLinkText("網管測試").click();
        driver.findElementByXPath("//*[@id=\"app\"]/section/section/main/div/div/div/div/div[2]/div/div[2]/div/div/div[3]/div/button[1]").click();

        driver.switchTo().window(p1);
        driver.navigate().refresh();
        Thread.sleep(500);
        driver.findElementsByClassName("article").get(0).click();
        Thread.sleep(500);
        System.out.println("主題 : "+driver.findElementById("articlename").getText());

        driver.switchTo().window(p2);
        driver.navigate().refresh();
        driver.findElementByXPath("//*[@id=\"app\"]/section/section/main/div/div/div/div/div[2]/div/div[2]/div/div/div[3]/div/button[2]").click();
    }

}
