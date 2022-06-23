<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>會員註冊</title>
            <!-- 禁止SEO -->
            <meta name="robots" content="noindex">
            <!-- 我不是機器人 -->
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <style>
                /* 勾選框 */
                .rule_wrap {
                    width: 100%;
                    height: 150px;
                    padding: 15px;
                    overflow-y: scroll;
                    overflow-x: hidden;
                }

                .l-articleReply {
                    border: 1px solid #DADADA;
                }

                html,
                body {

                    height: 100%;
                    padding: 0;
                    margin: 0;
                    font-size: 16px;
                    line-height: 1.5;
                    color: #222;
                    font-family: Arial, "Microsoft JhengHei", Helvetica, sans-serif;
                }
            </style>

        </head>

        <body>
            <canvas id="canvas" style="position:fixed;z-index: -1;display: flex;"></canvas>
            <script src="${pageContext.request.contextPath}/js/umbrella.js"></script>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h1>會員註冊</h1>
                    </div>
                </div>
                <!-- 抬頭分類 -->
                <div class="row">
                    <!-- <%-- 插入抬頭分類 JQ--%> -->
                    <jsp:include page="/widget/menu.jsp"></jsp:include>
                    <!-- <%-- 右邊工具列--%> -->
                    <jsp:include page="/widget/rightTool.jsp"></jsp:include>
                </div>

                <!-- 中間主體 -->
                <div class="row">

                    <div class="col-lg-3 "></div>
                    <div class="col-lg-6 " style="background-color: white; --bs-bg-opacity: 1;">
                        <br><br>
                        <div class="row">
                            <div class="col-lg-11">
                                <form action="${pageContext.request.contextPath}/register" method="post"
                                    id="registerForm">
                                    <div class="mb-3">
                                        <label class="form-label"> 會員名稱 <span style="color: red;">*</span><span
                                                style="color: red;">${errors.username}</span>
                                        </label>
                                        <input type="text" class="form-control" name="name" id="name" value="${name}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">公司-組織</label>
                                        <input type="text" class="form-control" name="company" id="company"
                                            value="${company}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email <span style="color: red;">*</span><span
                                                style="color: red;">${errors.email}</span>
                                        </label>
                                        <input type="email" class="form-control" name="email" id="email"
                                            value="${email}">
                                    </div><br>
                                    <div class="mb-3">
                                        <label class="form-label">連絡電話 </label>
                                        <input type="text" class="form-control" name="phone" id="phone"
                                            value="${phone}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">登入密碼 <span style="color: red;">*</span> </label>
                                        <input type="password" class="form-control" name="password" id="password"
                                            value="${password}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">密碼驗證</label>
                                        <input type="password" class="form-control" name="repassword" id="repassword">
                                    </div>

                                    <br><br>
                                    <div class="l-formRow ">
                                        <label class="l-formRow__title l-formRow__title--lg">註冊確認</label>
                                        <div class="l-formRow__content ">
                                            <div class="o-formDesc"><span>請仔細閱讀完版規、服務條款及個人資料保護法，並勾選【我已經閱讀】</span></div>
                                            <div class="l-articleReply rule_wrap" id="mobile01_forum_rule_wrap">
                                                Mobile01 討論區規則，並同時適用於會員名稱、會員個人頭像、會員個人簽名檔及私人訊息<br>
                                                本站對會員發布的文字、圖片或檔案保有片面修改或移除的權利。當會員使用本網站服務時，代表會員已經詳細閱讀並完全了解，並同意配合下述規定：<br>
                                                1. 請勿一文多貼或是大意內容相同/類似的文章重覆刊登。<br>
                                                2. 請勿在Mobile01公開 您的個人Line ID、電子信箱、聯絡電話...等任何可能被搜尋到的個人資訊。<br>
                                                3. 發表及回應文章，請不要文不對題，故意離題或語意不明，選字要正確。<br>
                                                4. 除Mobile01外，任何人不得發起團購與問卷調查行為，包括公開發表文章與使用私人訊息。<br>
                                                5. 尊重智慧財產權，嚴禁發文要求提供或討論破解軟體、註冊碼、音樂、影片、軟體複製...等文章。<br>
                                                6. 發言涉及攻擊、侮辱、影射或其他有違社會善良風俗、社會正義、國家安全、政府法令之內容，文章會進行處理。<br>
                                                7. 刪除自己過往發言內容者，文章會進行處理。<br>
                                                8. 請勿以發文、回文、私人訊息或簽名檔等方式，進行商業廣告、騷擾網友...等違反版規行為。<br>
                                                9. 請勿在討論區發表商業性質廣告或是為特定網站宣傳。<br>
                                                10. 發表抱怨文章或維修相關文章未附實體照片或維修單據，文章會進行處理。<br>
                                            </div>
                                            <div class="l-input ">
                                                <div class="l-input__item">
                                                    <div class="c-checkbox1 ">
                                                        <input type="checkbox" name="forum_rule" value="1"
                                                            id="forum_rule" ${check?"checked":""} disabled
                                                            class="c-checkbox__input">
                                                        <label for="forum_rule" class="c-checkbox__original">
                                                            <span>我已經閱讀 討論區規則並且同意註冊為會員</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="o-formError"><span></span></div>
                                            </div>
                                            <div class="l-articleReply rule_wrap" id="tos_wrap">
                                                <div class="u-gapNextV--lg">
                                                    <div class="l-heading">
                                                        <div class="l-heading__title">
                                                            服務條款
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="u-gapNextV--lg">
                                                    <div class="l-panel">
                                                        <ul class="c-panel">
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        認知與接受條款
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    「詠勝科技有限公司」係依據本服務條款提供「Mobile01」（https://www.mobile01.com）服務。當您使用「Mobile01」時，即表示您已閱讀、瞭解並同意接受本約定書之所有內容。「Mobile01」公司有權於任何時間修改或變更本約定書之內容，建議您隨時注意該等修改或變更。您於任何修改或變更後繼續使用「Mobile01」，視為您已閱讀、瞭解並同意接受該等修改或變更。
                                                                    <br>
                                                                    <br>
                                                                    若您為未滿十八歲，除應符合上述規定外，並應於您的家長（或監護人）閱讀、瞭解並同意本約定書之所有內容及其後修改變更後，方得使用或繼續使用「Mobile01」。當您使用或繼續使用「Mobile01」時，即表示您的家長（或監護人）已閱讀、瞭解並同意接受本約定書之所有內容及其後修改變更。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        您的註冊義務
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    為了能使用本服務，您同意以下事項：
                                                                    <ul>
                                                                        <li>依本服務註冊表之提示提供您本人正確、最新及完整的資料。</li>
                                                                        <li>維持並更新您個人資料，確保其為正確、最新及完整。若您提供任何錯誤或不實的資料，「Mobile01」有權暫停或終止您的帳號，並拒絕您使用本服務之全部或一部。
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        會員帳號、密碼及安全
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    完成本服務的登記程序之後，您將收到一個密碼及帳號。維持密碼及帳號及身份證字號的機密安全，是您的責任。
                                                                    利用該密碼及帳號及身份證字號所進行的一切行動，您將負完全的責任。您並同意以下事項：
                                                                    <ul>
                                                                        <li>您的密碼或帳號遭到盜用或有其他任何安全問題發生時，您將立即通知「Mobile01」。
                                                                        </li>
                                                                        <li>每次連線完畢，均結束您的帳號使用。</li>
                                                                    </ul>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        兒童及青少年之保護
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    為確保兒童及青少年使用網路的安全，並避免隱私權受到侵犯，家長（或監護人）應盡到下列義務：未滿十二歲之兒童使用「Mobile01」線上購物時，應全程在旁陪伴，十二歲以上未滿十八歲之青少年上網前亦應斟酌是否給予同意。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        使用者的守法義務及承諾
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    您承諾絕不為任何非法目的或以任何非法方式使用「Mobile01」，並承諾遵守中華民國相關法規及一切使用網際網路之國際慣例。
                                                                    您若係中華民國以外之使用者，並同意遵守所屬國家或地域之法令。您同意並保證不得利用本服務從事侵害他人權益或違法之行為，包括但不限於：
                                                                    <ul>
                                                                        <li>公布或傳送任何誹謗、侮辱、具威脅性、攻擊性、不雅、猥褻、不實、違反公共秩序或善良風俗或其他不法之文字、圖片或任何形式的檔案
                                                                        </li>
                                                                        <li>侵害他人名譽、隱私權、營業秘密、商標權、著作權、專利權、其他智慧財產權及其他權利
                                                                        </li>
                                                                        <li>違反依法律或契約所應負之保密義務</li>
                                                                        <li>冒用他人名義使用本服務</li>
                                                                        <li>傳輸或散佈電腦病毒</li>
                                                                        <li>濫發廣告郵件</li>
                                                                        <li>其他「Mobile01」有正當理由認為不適當之行為</li>
                                                                    </ul>
                                                                    Mobile01」得依實際執行情形，增加、修改或終止相關活動，並選擇最適方式告知會員。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        發生下列情形之一時，「Mobile01」有權可以停止、中斷提供服務
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    <ul>
                                                                        <li>「Mobile01」網站電子通信設備進行必要之保養及施工時發生突發性之電子通信設備故障時
                                                                        </li>
                                                                        <li>「Mobile01」網站申請之電子通信服務被停止，無法提供服務時</li>
                                                                        <li>由於天災等不可抗力之因素致使「Mobile01」網站無法提供服務時</li>
                                                                    </ul>
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        交易行為
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    會員同意其訂購行為，以「Mobile01」網站所示之電子交易資料為準，如有糾紛，並以該電子交易資料為認定標準。會員於訂購後倘任意大量退換貨，因已造成「Mobile01」作業上之困擾與損害，「Mobile01」可視情況採取拒絕交易或永久取消其會員資格辦理。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        廣告
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    您在「Mobile01」上瀏覽到的所有廣告內容、文字與圖片之說明、展示樣品或其他銷售資訊，均由各該廣告商、產品與服務的供應商所設計與提出。您對於廣告之正確性與可信度應自行斟酌與判斷。「Mobile01」僅接受委託予以刊登，不對前述廣告負擔保責任。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        智慧財產權的保護
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    「Mobile01」所使用之軟體或程式、網站上所有內容，包括但不限於著作、圖片、檔案、資訊、資料、網站架構、網站畫面的安排、網頁設計，
                                                                    均由「Mobile01」或其他權利人依法擁有其智慧財產權，包括但不限於商標權、專利權、著作權、營業秘密與專有技術等。任何人不得逕自使用、
                                                                    修改、重製、公開播送、改作、散布、發行、公開發表、進行還原工程、解編或反向組譯。若您欲引用或轉載前述軟體、程式或網站內容，
                                                                    必須依法取得「Mobile01」或其他權利人的事前書面同意。尊重智慧財產權是您應盡的義務，如有違反，您應對「Mobile01」負損害賠償責任
                                                                    （包括但不限於訴訟費用及律師費用等）。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        您對「Mobile01」之授權
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    會員同意授權「Mobile01」，得為提供服務及贈獎之目的，提供必需之會員資料給合作夥伴(第三者)做約定範圍內之妥善使用，倘若會員不同意將其資料列於合作夥伴(第三者)產品或服務名單內，可以通知「Mobile01」，於名單中刪除其資料，同時放棄其「Mobile01」購物以外之優惠或獲獎權利。
                                                                    <br><br>
                                                                    對於會員所登錄或留存之個人資料，會員同意「Mobile01」網站得於合理之範圍內蒐集、處理、保存、傳遞及使用該等資料，以提供使用者其他資訊或服務、或作成會員統計資料、或進行關於網路行為之調查或研究，或為任何之合法使用。
                                                                    <br><br>
                                                                    若您無合法權利得授權他人使用、修改、重製、公開播送、改作、散布、發行、公開發表某資料，並將前述權利轉授權第三人，請勿擅自將該資料上載、傳送、輸入或提供至「Mobile01」。任何資料一經您上載、傳送、輸入或提供至「Mobile01」時，視為您已允許「Mobile01」無條件使用、修改、重製、公開播送、改作、散布、發行、公開發表該等資料，並得將前述權利轉授權他人，您對此絕無異議。您並應保證「Mobile01」使用、修改、重製、公開播送、改作、散布、發行、公開發表、轉授權該等資料，不致侵害任何第三人之智慧財產權，否則應對「Mobile01」負損害賠償責任（包括但不限於訴訟費用及律師費用等）。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        拒絕或終止您的使用
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    您同意「Mobile01」得基於維護交易安全之考量，因任何理由，包含但不限於缺乏使用，或違反本服務條款的明文規定及精神，終止您的密碼、帳號（或其任何部分）或本服務之使用，並將本服務內任何「會員內容」加以移除並刪除，亦得已通知之情形下，隨時終止本服務或任何部分。此外，您同意若本服務之使用被終止，「Mobile01」對您或任何第三人均不承擔責任。
                                                                </div>
                                                            </li>
                                                            <li>
                                                                <div class="l-heading">
                                                                    <div class="l-heading__title">
                                                                        準據法與管轄法院
                                                                    </div>
                                                                </div>
                                                                <div class="c-panel_content">
                                                                    本約定書之解釋與適用，以及與本約定書有關的爭議，均應依照中華民國法律予以處理，並以台灣台北地方法院為第一審管轄法院。
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="l-input ">
                                                <div class="l-input__item">
                                                    <div class="c-checkbox2 ">
                                                        <input type="checkbox" name="tos" value="1" id="tos"
                                                            ${check?"checked":""} class="c-checkbox__input" disabled>
                                                        <label for="tos" class="c-checkbox__original">
                                                            <span>我已經閱讀服務條款並且同意註冊為會員</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="o-formError"><span></span></div>
                                            </div>
                                            <div class="l-articleReply rule_wrap" id="personal_information_wrap">
                                                <div class="u-gapNextV--lg">
                                                    <div class="l-heading">
                                                        <div class="l-heading__title">
                                                            個人資料保護法
                                                        </div>
                                                    </div>
                                                    <ul class="c-panel">
                                                        <div class="l-heading">
                                                            <div class="l-heading__title">
                                                                第 一 章 總則
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 1 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                為規範個人資料之蒐集、處理及利用，以避免人格權受侵害，並促進個人
                                                                資料之合理利用，特制定本法。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 2 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                本法用詞，定義如下：<br>
                                                                一、個人資料：指自然人之姓名、出生年月日、國民身分證統一編號、護
                                                                照號碼、特徵、指紋、婚姻、家庭、教育、職業、病歷、醫療、基因
                                                                、性生活、健康檢查、犯罪前科、聯絡方式、財務情況、社會活動及
                                                                其他得以直接或間接方式識別該個人之資料。<br>
                                                                二、個人資料檔案：指依系統建立而得以自動化機器或其他非自動化方式
                                                                檢索、整理之個人資料之集合。<br>
                                                                三、蒐集：指以任何方式取得個人資料。<br>
                                                                四、處理：指為建立或利用個人資料檔案所為資料之記錄、輸入、儲存、
                                                                編輯、更正、複製、檢索、刪除、輸出、連結或內部傳送。<br>
                                                                五、利用：指將蒐集之個人資料為處理以外之使用。<br>
                                                                六、國際傳輸：指將個人資料作跨國（境）之處理或利用。<br>
                                                                七、公務機關：指依法行使公權力之中央或地方機關或行政法人。<br>
                                                                八、非公務機關：指前款以外之自然人、法人或其他團體。<br>
                                                                九、當事人：指個人資料之本人。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 3 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                當事人就其個人資料依本法規定行使之下列權利，不得預先拋棄或以特約
                                                                限制之：<br>
                                                                一、查詢或請求閱覽。<br>
                                                                二、請求製給複製本。<br>
                                                                三、請求補充或更正。<br>
                                                                四、請求停止蒐集、處理或利用。<br>
                                                                五、請求刪除。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 4 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                受公務機關或非公務機關委託蒐集、處理或利用個人資料者，於本法適用
                                                                範圍內，視同委託機關。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 5 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                個人資料之蒐集、處理或利用，應尊重當事人之權益，依誠實及信用方法
                                                                為之，不得逾越特定目的之必要範圍，並應與蒐集之目的具有正當合理之
                                                                關聯。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 6 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                有關病歷、醫療、基因、性生活、健康檢查及犯罪前科之個人資料，不得
                                                                蒐集、處理或利用。但有下列情形之一者，不在此限：<br>
                                                                一、法律明文規定。<br>
                                                                二、公務機關執行法定職務或非公務機關履行法定義務必要範圍內，且事
                                                                前或事後有適當安全維護措施。<br>
                                                                三、當事人自行公開或其他已合法公開之個人資料。<br>
                                                                四、公務機關或學術研究機構基於醫療、衛生或犯罪預防之目的，為統計
                                                                或學術研究而有必要，且資料經過提供者處理後或經蒐集者依其揭露
                                                                方式無從識別特定之當事人。<br>
                                                                五、為協助公務機關執行法定職務或非公務機關履行法定義務必要範圍內
                                                                ，且事前或事後有適當安全維護措施。<br>
                                                                六、經當事人書面同意。但逾越特定目的之必要範圍或其他法律另有限制
                                                                不得僅依當事人書面同意蒐集、處理或利用，或其同意違反其意願者
                                                                ，不在此限。<br>
                                                                依前項規定蒐集、處理或利用個人資料，準用第八條、第九條規定；其中
                                                                前項第六款之書面同意，準用第七條第一項、第二項及第四項規定，並以
                                                                書面為之。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 7 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                第十五條第二款及第十九條第一項第五款所稱同意，指當事人經蒐集者告
                                                                知本法所定應告知事項後，所為允許之意思表示。<br>
                                                                第十六條第七款、第二十條第一項第六款所稱同意，指當事人經蒐集者明
                                                                確告知特定目的外之其他利用目的、範圍及同意與否對其權益之影響後，
                                                                單獨所為之意思表示。<br>
                                                                公務機關或非公務機關明確告知當事人第八條第一項各款應告知事項時，
                                                                當事人如未表示拒絕，並已提供其個人資料者，推定當事人已依第十五條
                                                                第二款、第十九條第一項第五款之規定表示同意。<br>
                                                                蒐集者就本法所稱經當事人同意之事實，應負舉證責任。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 8 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關依第十五條或第十九條規定向當事人蒐集個人資料
                                                                時，應明確告知當事人下列事項：<br>
                                                                一、公務機關或非公務機關名稱。<br>
                                                                二、蒐集之目的。<br>
                                                                三、個人資料之類別。<br>
                                                                四、個人資料利用之期間、地區、對象及方式。<br>
                                                                五、當事人依第三條規定得行使之權利及方式。<br>
                                                                六、當事人得自由選擇提供個人資料時，不提供將對其權益之影響。
                                                                有下列情形之一者，得免為前項之告知：<br>
                                                                一、依法律規定得免告知。<br>
                                                                二、個人資料之蒐集係公務機關執行法定職務或非公務機關履行法定義務
                                                                所必要。<br>
                                                                三、告知將妨害公務機關執行法定職務。<br>
                                                                四、告知將妨害公共利益。<br>
                                                                五、當事人明知應告知之內容。<br>
                                                                六、個人資料之蒐集非基於營利之目的，且對當事人顯無不利之影響。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 9 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關依第十五條或第十九條規定蒐集非由當事人提供之
                                                                個人資料，應於處理或利用前，向當事人告知個人資料來源及前條第一項
                                                                第一款至第五款所列事項。<br>
                                                                有下列情形之一者，得免為前項之告知：<br>
                                                                一、有前條第二項所列各款情形之一。<br>
                                                                二、當事人自行公開或其他已合法公開之個人資料。<br>
                                                                三、不能向當事人或其法定代理人為告知。<br>
                                                                四、基於公共利益為統計或學術研究之目的而有必要，且該資料須經提供
                                                                者處理後或蒐集者依其揭露方式，無從識別特定當事人者為限。<br>
                                                                五、大眾傳播業者基於新聞報導之公益目的而蒐集個人資料。<br>
                                                                第一項之告知，得於首次對當事人為利用時併同為之。<br>
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 10 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關應依當事人之請求，就其蒐集之個人資料，答覆查
                                                                詢、提供閱覽或製給複製本。但有下列情形之一者，不在此限：<br>
                                                                一、妨害國家安全、外交及軍事機密、整體經濟利益或其他國家重大利益
                                                                。<br>
                                                                二、妨害公務機關執行法定職務。<br>
                                                                三、妨害該蒐集機關或第三人之重大利益。<br>
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 11 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關應維護個人資料之正確，並應主動或依當事人之請
                                                                求更正或補充之。<br>
                                                                個人資料正確性有爭議者，應主動或依當事人之請求停止處理或利用。但
                                                                因執行職務或業務所必須，或經當事人書面同意，並經註明其爭議者，不
                                                                在此限。<br>
                                                                個人資料蒐集之特定目的消失或期限屆滿時，應主動或依當事人之請求，
                                                                刪除、停止處理或利用該個人資料。但因執行職務或業務所必須或經當事
                                                                人書面同意者，不在此限。<br>
                                                                違反本法規定蒐集、處理或利用個人資料者，應主動或依當事人之請求，
                                                                刪除、停止蒐集、處理或利用該個人資料。<br>
                                                                因可歸責於公務機關或非公務機關之事由，未為更正或補充之個人資料，
                                                                應於更正或補充後，通知曾提供利用之對象。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 12 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關違反本法規定，致個人資料被竊取、洩漏、竄改或
                                                                其他侵害者，應查明後以適當方式通知當事人。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 13 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關或非公務機關受理當事人依第十條規定之請求，應於十五日內，
                                                                為准駁之決定；必要時，得予延長，延長之期間不得逾十五日，並應將其
                                                                原因以書面通知請求人。<br>
                                                                公務機關或非公務機關受理當事人依第十一條規定之請求，應於三十日內
                                                                ，為准駁之決定；必要時，得予延長，延長之期間不得逾三十日，並應將
                                                                其原因以書面通知請求人。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 14 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                查詢或請求閱覽個人資料或製給複製本者，公務機關或非公務機關得酌收
                                                                必要成本費用。
                                                            </div>
                                                        </li>
                                                        <div class="l-heading l-memberIntro__record">
                                                            <div class="l-heading__title">
                                                                第 二 章 公務機關對個人資料之蒐集、處理及利用
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 15 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關對個人資料之蒐集或處理，除第六條第一項所規定資料外，應有
                                                                特定目的，並符合下列情形之一者：<br>
                                                                一、執行法定職務必要範圍內。<br>
                                                                二、經當事人同意。<br>
                                                                三、對當事人權益無侵害。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 16 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關對個人資料之利用，除第六條第一項所規定資料外，應於執行法
                                                                定職務必要範圍內為之，並與蒐集之特定目的相符。但有下列情形之一者
                                                                ，得為特定目的外之利用：<br>
                                                                一、法律明文規定。<br>
                                                                二、為維護國家安全或增進公共利益所必要。<br>
                                                                三、為免除當事人之生命、身體、自由或財產上之危險。<br>
                                                                四、為防止他人權益之重大危害。<br>
                                                                五、公務機關或學術研究機構基於公共利益為統計或學術研究而有必要，
                                                                且資料經過提供者處理後或經蒐集者依其揭露方式無從識別特定之當
                                                                事人。<br>
                                                                六、有利於當事人權益。<br>
                                                                七、經當事人同意。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 17 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關應將下列事項公開於電腦網站，或以其他適當方式供公眾查閱；
                                                                其有變更者，亦同：<br>
                                                                一、個人資料檔案名稱。<br>
                                                                二、保有機關名稱及聯絡方式。<br>
                                                                三、個人資料檔案保有之依據及特定目的。<br>
                                                                四、個人資料之類別。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 18 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關保有個人資料檔案者，應指定專人辦理安全維護事項，防止個人
                                                                資料被竊取、竄改、毀損、滅失或洩漏。
                                                            </div>
                                                        </li>
                                                        <div class="l-heading l-memberIntro__record">
                                                            <div class="l-heading__title">
                                                                第 三 章 非公務機關對個人資料之蒐集、處理及利用
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 19 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關對個人資料之蒐集或處理，除第六條第一項所規定資料外，應
                                                                有特定目的，並符合下列情形之一者：<br>
                                                                一、法律明文規定。<br>
                                                                二、與當事人有契約或類似契約之關係，且已採取適當之安全措施。<br>
                                                                三、當事人自行公開或其他已合法公開之個人資料。<br>
                                                                四、學術研究機構基於公共利益為統計或學術研究而有必要，且資料經過
                                                                提供者處理後或經蒐集者依其揭露方式無從識別特定之當事人。<br>
                                                                五、經當事人同意。<br>
                                                                六、為增進公共利益所必要。<br>
                                                                七、個人資料取自於一般可得之來源。但當事人對該資料之禁止處理或利
                                                                用，顯有更值得保護之重大利益者，不在此限。<br>
                                                                八、對當事人權益無侵害。<br>
                                                                蒐集或處理者知悉或經當事人通知依前項第七款但書規定禁止對該資料之
                                                                處理或利用時，應主動或依當事人之請求，刪除、停止處理或利用該個人
                                                                資料。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 20 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關對個人資料之利用，除第六條第一項所規定資料外，應於蒐集
                                                                之特定目的必要範圍內為之。但有下列情形之一者，得為特定目的外之利
                                                                用：<br>
                                                                一、法律明文規定。<br>
                                                                二、為增進公共利益所必要。<br>
                                                                三、為免除當事人之生命、身體、自由或財產上之危險。<br>
                                                                四、為防止他人權益之重大危害。<br>
                                                                五、公務機關或學術研究機構基於公共利益為統計或學術研究而有必要，
                                                                且資料經過提供者處理後或經蒐集者依其揭露方式無從識別特定之當
                                                                事人。<br>
                                                                六、經當事人同意。<br>
                                                                七、有利於當事人權益。<br>
                                                                非公務機關依前項規定利用個人資料行銷者，當事人表示拒絕接受行銷時
                                                                ，應即停止利用其個人資料行銷。<br>
                                                                非公務機關於首次行銷時，應提供當事人表示拒絕接受行銷之方式，並支
                                                                付所需費用。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 21 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關為國際傳輸個人資料，而有下列情形之一者，中央目的事業主
                                                                管機關得限制之：<br>
                                                                一、涉及國家重大利益。<br>
                                                                二、國際條約或協定有特別規定。<br>
                                                                三、接受國對於個人資料之保護未有完善之法規，致有損當事人權益之虞
                                                                。<br>
                                                                四、以迂迴方法向第三國（地區）傳輸個人資料規避本法。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 22 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                中央目的事業主管機關或直轄市、縣（市）政府為執行資料檔案安全維護
                                                                、業務終止資料處理方法、國際傳輸限制或其他例行性業務檢查而認有必
                                                                要或有違反本法規定之虞時，得派員攜帶執行職務證明文件，進入檢查，
                                                                並得命相關人員為必要之說明、配合措施或提供相關證明資料。<br>
                                                                中央目的事業主管機關或直轄市、縣（市）政府為前項檢查時，對於得沒
                                                                入或可為證據之個人資料或其檔案，得扣留或複製之。對於應扣留或複製
                                                                之物，得要求其所有人、持有人或保管人提出或交付；無正當理由拒絕提
                                                                出、交付或抗拒扣留或複製者，得採取對該非公務機關權益損害最少之方
                                                                法強制為之。<br>
                                                                中央目的事業主管機關或直轄市、縣（市）政府為第一項檢查時，得率同
                                                                資訊、電信或法律等專業人員共同為之。<br>
                                                                對於第一項及第二項之進入、檢查或處分，非公務機關及其相關人員不得
                                                                規避、妨礙或拒絕。<br>
                                                                參與檢查之人員，因檢查而知悉他人資料者，負保密義務。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 23 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                對於前條第二項扣留物或複製物，應加封緘或其他標識，並為適當之處置
                                                                ；其不便搬運或保管者，得命人看守或交由所有人或其他適當之人保管。
                                                                扣留物或複製物已無留存之必要，或決定不予處罰或未為沒入之裁處者，
                                                                應發還之。但應沒入或為調查他案應留存者，不在此限。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 24 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關、物之所有人、持有人、保管人或利害關係人對前二條之要求
                                                                、強制、扣留或複製行為不服者，得向中央目的事業主管機關或直轄市、
                                                                縣（市）政府聲明異議。<br>
                                                                前項聲明異議，中央目的事業主管機關或直轄市、縣（市）政府認為有理
                                                                由者，應立即停止或變更其行為；認為無理由者，得繼續執行。經該聲明
                                                                異議之人請求時，應將聲明異議之理由製作紀錄交付之。<br>
                                                                對於中央目的事業主管機關或直轄市、縣（市）政府前項決定不服者，僅
                                                                得於對該案件之實體決定聲明不服時一併聲明之。但第一項之人依法不得
                                                                對該案件之實體決定聲明不服時，得單獨對第一項之行為逕行提起行政訴
                                                                訟。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 25 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關有違反本法規定之情事者，中央目的事業主管機關或直轄市、
                                                                縣（市）政府除依本法規定裁處罰鍰外，並得為下列處分：<br>
                                                                一、禁止蒐集、處理或利用個人資料。<br>
                                                                二、命令刪除經處理之個人資料檔案。<br>
                                                                三、沒入或命銷燬違法蒐集之個人資料。<br>
                                                                四、公布非公務機關之違法情形，及其姓名或名稱與負責人。<br>
                                                                中央目的事業主管機關或直轄市、縣（市）政府為前項處分時，應於防制
                                                                違反本法規定情事之必要範圍內，採取對該非公務機關權益損害最少之方
                                                                法為之。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 26 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                中央目的事業主管機關或直轄市、縣（市）政府依第二十二條規定檢查後
                                                                ，未發現有違反本法規定之情事者，經該非公務機關同意後，得公布檢查
                                                                結果。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 27 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關保有個人資料檔案者，應採行適當之安全措施，防止個人資料
                                                                被竊取、竄改、毀損、滅失或洩漏。<br>
                                                                中央目的事業主管機關得指定非公務機關訂定個人資料檔案安全維護計畫
                                                                或業務終止後個人資料處理方法。<br>
                                                                前項計畫及處理方法之標準等相關事項之辦法，由中央目的事業主管機關
                                                                定之。
                                                            </div>
                                                        </li>
                                                        <div class="l-heading l-memberIntro__record">
                                                            <div class="l-heading__title">
                                                                第 四 章 損害賠償及團體訴訟
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 28 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務機關違反本法規定，致個人資料遭不法蒐集、處理、利用或其他侵害
                                                                當事人權利者，負損害賠償責任。但損害因天災、事變或其他不可抗力所
                                                                致者，不在此限。<br>
                                                                被害人雖非財產上之損害，亦得請求賠償相當之金額；其名譽被侵害者，
                                                                並得請求為回復名譽之適當處分。<br>
                                                                依前二項情形，如被害人不易或不能證明其實際損害額時，得請求法院依
                                                                侵害情節，以每人每一事件新臺幣五百元以上二萬元以下計算。<br>
                                                                對於同一原因事實造成多數當事人權利受侵害之事件，經當事人請求損害
                                                                賠償者，其合計最高總額以新臺幣二億元為限。但因該原因事實所涉利益
                                                                超過新臺幣二億元者，以該所涉利益為限。<br>
                                                                同一原因事實造成之損害總額逾前項金額時，被害人所受賠償金額，不受
                                                                第三項所定每人每一事件最低賠償金額新臺幣五百元之限制。<br>
                                                                第二項請求權，不得讓與或繼承。但以金額賠償之請求權已依契約承諾或
                                                                已起訴者，不在此限。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 29 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關違反本法規定，致個人資料遭不法蒐集、處理、利用或其他侵
                                                                害當事人權利者，負損害賠償責任。但能證明其無故意或過失者，不在此
                                                                限。<br>
                                                                依前項規定請求賠償者，適用前條第二項至第六項規定。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 30 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                損害賠償請求權，自請求權人知有損害及賠償義務人時起，因二年間不行
                                                                使而消滅；自損害發生時起，逾五年者，亦同。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 31 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                損害賠償，除依本法規定外，公務機關適用國家賠償法之規定，非公務機
                                                                關適用民法之規定。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 32 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                依本章規定提起訴訟之財團法人或公益社團法人，應符合下列要件：<br>
                                                                一、財團法人之登記財產總額達新臺幣一千萬元或社團法人之社員人數達
                                                                一百人。<br>
                                                                二、保護個人資料事項於其章程所定目的範圍內。<br>
                                                                三、許可設立三年以上。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 33 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                依本法規定對於公務機關提起損害賠償訴訟者，專屬該機關所在地之地方
                                                                法院管轄。對於非公務機關提起者，專屬其主事務所、主營業所或住所地
                                                                之地方法院管轄。<br>
                                                                前項非公務機關為自然人，而其在中華民國現無住所或住所不明者，以其
                                                                在中華民國之居所，視為其住所；無居所或居所不明者，以其在中華民國
                                                                最後之住所，視為其住所；無最後住所者，專屬中央政府所在地之地方法
                                                                院管轄。<br>
                                                                第一項非公務機關為自然人以外之法人或其他團體，而其在中華民國現無
                                                                主事務所、主營業所或主事務所、主營業所不明者，專屬中央政府所在地
                                                                之地方法院管轄。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 34 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                對於同一原因事實造成多數當事人權利受侵害之事件，財團法人或公益社
                                                                團法人經受有損害之當事人二十人以上以書面授與訴訟實施權者，得以自
                                                                己之名義，提起損害賠償訴訟。當事人得於言詞辯論終結前以書面撤回訴
                                                                訟實施權之授與，並通知法院。<br>
                                                                前項訴訟，法院得依聲請或依職權公告曉示其他因同一原因事實受有損害
                                                                之當事人，得於一定期間內向前項起訴之財團法人或公益社團法人授與訴
                                                                訟實施權，由該財團法人或公益社團法人於第一審言詞辯論終結前，擴張
                                                                應受判決事項之聲明。<br>
                                                                其他因同一原因事實受有損害之當事人未依前項規定授與訴訟實施權者，
                                                                亦得於法院公告曉示之一定期間內起訴，由法院併案審理。<br>
                                                                其他因同一原因事實受有損害之當事人，亦得聲請法院為前項之公告。<br>
                                                                前二項公告，應揭示於法院公告處、資訊網路及其他適當處所；法院認為
                                                                必要時，並得命登載於公報或新聞紙，或用其他方法公告之，其費用由國
                                                                庫墊付。<br>
                                                                依第一項規定提起訴訟之財團法人或公益社團法人，其標的價額超過新臺
                                                                幣六十萬元者，超過部分暫免徵裁判費。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 35 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                當事人依前條第一項規定撤回訴訟實施權之授與者，該部分訴訟程序當然
                                                                停止，該當事人應即聲明承受訴訟，法院亦得依職權命該當事人承受訴訟
                                                                。<br>
                                                                財團法人或公益社團法人依前條規定起訴後，因部分當事人撤回訴訟實施
                                                                權之授與，致其餘部分不足二十人者，仍得就其餘部分繼續進行訴訟。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 36 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                各當事人於第三十四條第一項及第二項之損害賠償請求權，其時效應分別
                                                                計算。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 37 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                財團法人或公益社團法人就當事人授與訴訟實施權之事件，有為一切訴訟
                                                                行為之權。但當事人得限制其為捨棄、撤回或和解。<br>
                                                                前項當事人中一人所為之限制，其效力不及於其他當事人。<br>
                                                                第一項之限制，應於第三十四條第一項之文書內表明，或以書狀提出於法
                                                                院。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 38 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                當事人對於第三十四條訴訟之判決不服者，得於財團法人或公益社團法人
                                                                上訴期間屆滿前，撤回訴訟實施權之授與，依法提起上訴。<br>
                                                                財團法人或公益社團法人於收受判決書正本後，應即將其結果通知當事人
                                                                ，並應於七日內將是否提起上訴之意旨以書面通知當事人。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 39 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                財團法人或公益社團法人應將第三十四條訴訟結果所得之賠償，扣除訴訟
                                                                必要費用後，分別交付授與訴訟實施權之當事人。<br>
                                                                提起第三十四條第一項訴訟之財團法人或公益社團法人，均不得請求報酬
                                                                。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 40 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                依本章規定提起訴訟之財團法人或公益社團法人，應委任律師代理訴訟。
                                                            </div>
                                                        </li>
                                                        <div class="l-heading l-memberIntro__record">
                                                            <div class="l-heading__title">
                                                                第 五 章 罰則
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 41 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                意圖為自己或第三人不法之利益或損害他人之利益，而違反第六條第一項
                                                                、第十五條、第十六條、第十九條、第二十條第一項規定，或中央目的事
                                                                業主管機關依第二十一條限制國際傳輸之命令或處分，足生損害於他人者
                                                                ，處五年以下有期徒刑，得併科新臺幣一百萬元以下罰金。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 42 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                為規範個人資料之蒐集、處理及利用，以避免人格權受侵害，並促進個人
                                                                意圖為自己或第三人不法之利益或損害他人之利益，而對於個人資料檔案
                                                                為非法變更、刪除或以其他非法方法，致妨害個人資料檔案之正確而足生
                                                                損害於他人者，處五年以下有期徒刑、拘役或科或併科新臺幣一百萬元以
                                                                下罰金。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 43 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                中華民國人民在中華民國領域外對中華民國人民犯前二條之罪者，亦適用
                                                                之。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 44 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                公務員假借職務上之權力、機會或方法，犯本章之罪者，加重其刑至二分
                                                                之一。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 45 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                本章之罪，須告訴乃論。但犯第四十一條之罪者，或對公務機關犯第四十
                                                                二條之罪者，不在此限。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 46 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                犯本章之罪，其他法律有較重處罰規定者，從其規定。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 47 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關有下列情事之一者，由中央目的事業主管機關或直轄市、縣（
                                                                市）政府處新臺幣五萬元以上五十萬元以下罰鍰，並令限期改正，屆期未
                                                                改正者，按次處罰之：<br>
                                                                一、違反第六條第一項規定。<br>
                                                                二、違反第十九條規定。<br>
                                                                三、違反第二十條第一項規定。<br>
                                                                四、違反中央目的事業主管機關依第二十一條規定限制國際傳輸之命令或
                                                                處分。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 48 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關有下列情事之一者，由中央目的事業主管機關或直轄市、縣（
                                                                市）政府限期改正，屆期未改正者，按次處新臺幣二萬元以上二十萬元以
                                                                下罰鍰：<br>
                                                                一、違反第八條或第九條規定。<br>
                                                                二、違反第十條、第十一條、第十二條或第十三條規定。<br>
                                                                三、違反第二十條第二項或第三項規定。<br>
                                                                四、違反第二十七條第一項或未依第二項訂定個人資料檔案安全維護計畫
                                                                或業務終止後個人資料處理方法。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 49 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關無正當理由違反第二十二條第四項規定者，由中央目的事業主
                                                                管機關或直轄市、縣（市）政府處新臺幣二萬元以上二十萬元以下罰鍰。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 50 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                非公務機關之代表人、管理人或其他有代表權人，因該非公務機關依前三
                                                                條規定受罰鍰處罰時，除能證明已盡防止義務者外，應並受同一額度罰鍰
                                                                之處罰。
                                                            </div>
                                                        </li>
                                                        <div class="l-heading l-memberIntro__record">
                                                            <div class="l-heading__title">
                                                                第 六 章 附則
                                                            </div>
                                                        </div>
                                                        <li>
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 51 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                有下列情形之一者，不適用本法規定：
                                                                一、自然人為單純個人或家庭活動之目的，而蒐集、處理或利用個人資料
                                                                。<br>
                                                                二、於公開場所或公開活動中所蒐集、處理或利用之未與其他個人資料結
                                                                合之影音資料。<br>
                                                                公務機關及非公務機關，在中華民國領域外對中華民國人民個人資料蒐集
                                                                、處理或利用者，亦適用本法。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 52 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                第二十二條至第二十六條規定由中央目的事業主管機關或直轄市、縣（市
                                                                ）政府執行之權限，得委任所屬機關、委託其他機關或公益團體辦理；其
                                                                成員因執行委任或委託事務所知悉之資訊，負保密義務。<br>
                                                                前項之公益團體，不得依第三十四條第一項規定接受當事人授與訴訟實施
                                                                權，以自己之名義提起損害賠償訴訟。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 53 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                法務部應會同中央目的事業主管機關訂定特定目的及個人資料類別，提供
                                                                公務機關及非公務機關參考使用。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 54 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                本法中華民國九十九年五月二十六日修正公布之條文施行前，非由當事人
                                                                提供之個人資料，於本法一百零四年十二月十五日修正之條文施行後為處
                                                                理或利用者，應於處理或利用前，依第九條規定向當事人告知。<br>
                                                                前項之告知，得於本法中華民國一百零四年十二月十五日修正之條文施行
                                                                後首次利用時併同為之。<br>
                                                                未依前二項規定告知而利用者，以違反第九條規定論處。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 55 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                本法施行細則，由法務部定之。
                                                            </div>
                                                        </li>
                                                        <li class="l-memberIntro__record">
                                                            <div class="l-heading">
                                                                <div class="l-heading__title">
                                                                    第 56 條
                                                                </div>
                                                            </div>
                                                            <div class="c-panel_content">
                                                                本法施行日期，由行政院定之。<br>
                                                                現行條文第十九條至第二十二條及第四十三條之刪除，自公布日施行。
                                                                前項公布日於現行條文第四十三條第二項指定之事業、團體或個人應於指
                                                                定之日起六個月內辦理登記或許可之期間內者，該指定之事業、團體或個
                                                                人得申請終止辦理，目的事業主管機關於終止辦理時，應退還已繳規費。
                                                                已辦理完成者，亦得申請退費。<br>
                                                                前項退費，應自繳費義務人繳納之日起，至目的事業主管機關終止辦理之
                                                                日止，按退費額，依繳費之日郵政儲金之一年期定期存款利率，按日加計
                                                                利息，一併退還。已辦理完成者，其退費，應自繳費義務人繳納之日起，
                                                                至目的事業主管機關核准申請之日止，亦同。
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="l-input ">
                                                <div class="l-input__item">
                                                    <div class="c-checkbox3 ">
                                                        <input type="checkbox" name="personal_information" value="1"
                                                            ${check?"checked":""} id="personal_information"
                                                            class="c-checkbox__input" disabled>
                                                        <label for="personal_information" class="c-checkbox__original">
                                                            <span>我已經閱讀個人資料保護法並且同意註冊為會員</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="o-formError"><span></span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>

                                    <div class="row">
                                        <div class="col-lg-12 position-relative">
                                            <div class="g-recaptcha " style='width: 304px;display: inline-block; ${empty errors.recaptcha?"":"border: 1px red solid;"}'
                                                data-sitekey="6Ldhf4kgAAAAAN2ExQc-EBZROSpa2xoA69Z2TPrJ"></div>

                                            <button type="button"
                                                class="btn btn-primary position-absolute bottom-0 end-0"
                                                onclick="formSubmit()">開始註冊</button>
                                            <p style="color: red;">${errors.recaptcha}</p>
                                        </div>
                                    </div>

                                </form>
                            </div>
                            <div class="col-lg-1 ">

                            </div>

                        </div>



                    </div>
                    <div class="col-lg-3 "></div>
                </div>

            </div>

            <script>
                //提交檢查
                function formSubmit() {
                    var isok = true;
                    if ($("#name").val() == null || $("#name").val() == "") {
                        $("#name").css("border", "red 1px solid");
                        isok = false
                    } else {
                        $("#name").css("border", "1px solid #ced4da");
                    }

                    if ($("#email").val() == null || $("#email").val() == "") {
                        $("#email").css("border", "red 1px solid");
                        isok = false
                    } else {
                        $("#email").css("border", "1px solid #ced4da");
                    }
                    if ($("#password").val() != $("#repassword").val()) {
                        $("#password").css("border", "red 1px solid");
                        $("#repassword").css("border", "red 1px solid");
                        isok = false
                    } else {
                        $("#password").css("border", "1px solid #ced4da");
                        $("#repassword").css("border", "1px solid #ced4da");
                    }
                    if ($("#password").val() == null || $("#password").val() == "") {
                        $("#password").css("border", "red 1px solid");
                        isok = false
                    } else {
                        $("#password").css("border", "1px solid #ced4da");
                    }

                    //勾選框
                    if ($("#forum_rule").is(":checked")) {
                        $(".c-checkbox1 ").css("border", "red 0px solid");
                    } else {
                        isok = false;
                        $(".c-checkbox1 ").css("border", "red 1px solid");
                    }

                    if ($("#tos").is(":checked")) {
                        $(".c-checkbox2 ").css("border", "red 0px solid");
                    } else {
                        isok = false;
                        $(".c-checkbox2 ").css("border", "red 1px solid");
                    }
                    if ($("#personal_information").is(":checked")) {
                        $(".c-checkbox3 ").css("border", "red 0px solid");
                    } else {
                        isok = false;
                        $(".c-checkbox3 ").css("border", "red 1px solid");
                    }


                    if (isok) {
                        $("#registerForm").submit();
                    } else {
                        alert("紅框需輸入");
                    }
                }

                $(document).ready(function () {
                    //捲到底 才能勾選
                    $('#tos_wrap').scroll(function () {
                        var scrollTop = $(this).scrollTop();
                        var scrollHeight = $(this).prop("scrollHeight");
                        var windowHeight = $(this).innerHeight();
                        if (Math.round(scrollTop + windowHeight) >= scrollHeight) {
                            $('#tos').attr('disabled', false);
                        }
                    });
                    $('#mobile01_forum_rule_wrap').scroll(function () {
                        var scrollTop = $(this).scrollTop();
                        var scrollHeight = $(this).prop("scrollHeight");
                        var windowHeight = $(this).innerHeight();
                        if (Math.round(scrollTop + windowHeight) >= scrollHeight) {
                            $('#forum_rule').attr('disabled', false);
                        }
                    });
                    $('#personal_information_wrap').scroll(function () {
                        var scrollTop = Math.round($(this).scrollTop() + 1);
                        var scrollHeight = $(this).prop("scrollHeight");
                        var windowHeight = $(this).innerHeight();
                        if (Math.round(scrollTop + windowHeight) >= scrollHeight) {
                            $('#personal_information').attr('disabled', false);
                        }
                    });
                })

            </script>

        </body>

        </html>