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
                                        <label class="form-label"> 暱稱 <span style="color: red;">*</span><span
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
                                            <div class="o-formDesc"><span>請仔細閱讀完版規、服務條款，並勾選【我已經閱讀】</span></div>

                                            <div class="l-articleReply rule_wrap" id="forum_rule_wrap">
                                                久德電子討論區規則，並同時適用於會員名稱、會員個人頭像、會員個人簽名檔及私人訊息<br>
                                                本站對會員發布的文字、圖片或檔案保有片面修改或移除的權利。當會員使用本網站服務時，代表會員已經詳細閱讀並完全了解，並同意配合下述規定：<br>
                                                1. 請勿一文多貼或是大意內容相同/類似的文章重覆刊登。<br>
                                                2. 請勿在久德電子討論區公開 您的個人Line ID、電子信箱、聯絡電話...等任何可能被搜尋到的個人資訊。<br>
                                                3. 發表及回應文章，請不要文不對題，故意離題或語意不明，選字要正確。<br>
                                                4. 除久德電子外，任何人不得發起團購與問卷調查行為，包括公開發表文章與使用私人訊息。<br>
                                                5. 尊重智慧財產權，嚴禁發文要求提供或討論破解軟體、註冊碼、音樂、影片、軟體複製...等文章。<br>
                                                6. 發言涉及攻擊、侮辱、影射或其他有違社會善良風俗、社會正義、國家安全、政府法令之內容，文章會進行處理。<br>
                                                7. 請勿以發文、回文、私人訊息或簽名檔等方式，進行商業廣告、騷擾網友...等違反版規行為。<br>
                                                8. 除了久德電子或指定廣告版面外，請勿在討論區發表商業性質廣告或是為特定網站宣傳。<br>
                                                9. 發表抱怨文章或維修相關文章未附實體照片或維修單據，文章會進行處理。<br>
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
                                            </div><br>
                                            <div class="u-gapNextV--lg">
                                                <div class="l-heading">
                                                    <div class="l-heading__title">
                                                        服務條款
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="l-articleReply rule_wrap" id="tos_wrap">
                                                <div class="u-gapNextV--lg">
                                                    <div class="l-panel">
                                                        <ul class="c-panel">
                                                            認知與接受條款<br>
                                                            「久德電子有限公司」係依據本服務條款提供「久德討論版」服務。當您使用「久德討論版」時，即表示您已閱讀、瞭解並同意接受本約定書之所有內容。「久德電子有限公司」有權於任何時間修改或變更本約定書之內容，建議您隨時注意該等修改或變更。您於任何修改或變更後繼續使用「久德討論版」，視為您已閱讀、瞭解並同意接受該等修改或變更。<br>
                                                            <br>
                                                            若您為未滿十八歲，除應符合上述規定外，並應於您的家長（或監護人）閱讀、瞭解並同意本約定書之所有內容及其後修改變更後，方得使用或繼續使用「久德討論版」。當您使用或繼續使用「久德討論版」時，即表示您的家長（或監護人）已閱讀、瞭解並同意接受本約定書之所有內容及其後修改變更。<br>
                                                            您的註冊義務<br>
                                                            為了能使用本服務，您同意以下事項：<br>
                                                            依本服務註冊表之提示提供您本人正確、最新及完整的資料。<br>
                                                            維持並更新您個人資料，確保其為正確、最新及完整。若您提供任何錯誤或不實的資料，「久德電子有限公司」有權暫停或終止您的帳號，並拒絕您使用本服務之全部或一部。<br>
                                                            會員帳號、密碼及安全<br>
                                                            完成本服務的登記程序之後，您將收到一個密碼及帳號。維持密碼及帳號及身份的機密安全，是您的責任。<br>
                                                            利用該密碼及帳號及身份所進行的一切行動，您將負完全的責任。您並同意以下事項：<br>
                                                            您的密碼或帳號遭到盜用或有其他任何安全問題發生時，您將立即通知「久德電子有限公司」。<br>
                                                            每次連線完畢，均結束您的帳號使用。<br>
                                                            您承諾絕不為任何非法目的或以任何非法方式使用此「久德討論版」，並承諾遵守中華民國相關法規及一切使用網際網路之國際慣例。<br>
                                                            您若係中華民國以外之使用者，並同意遵守所屬國家或地域之法令。您同意並保證不得利用本服務從事侵害他人權益或違法之行為，包括但不限於：<br>
                                                            公布或傳送任何誹謗、侮辱、具威脅性、攻擊性、不雅、猥褻、不實、違反公共秩序或善良風俗或其他不法之文字、圖片或任何形式的檔案<br>
                                                            侵害他人名譽、隱私權、營業秘密、商標權、著作權、專利權、其他智慧財產權及其他權利<br>
                                                            違反依法律或契約所應負之保密義務<br>
                                                            冒用他人名義使用本服務<br>
                                                            傳輸或散佈電腦病毒<br>
                                                            濫發廣告郵件<br>
                                                            其他「久德電子有限公司」有正當理由認為不適當之行為得依實際執行情形，增加、修改或終止相關活動，並選擇最適方式告知會員。<br>
                                                            發生下列情形之一時，「久德電子有限公司」有權可以停止、中斷提供服務<br>
                                                            「久德電子有限公司」網站電子通信設備進行必要之保養及施工時發生突發性之電子通信設備故障時<br>
                                                            「久德電子有限公司」網站申請之電子通信服務被停止，無法提供服務時<br>
                                                            由於天災等不可抗力之因素致使「久德電子有限公司」網站無法提供服務時<br>
                                                            廣告<br>
                                                            您在「久德討論版」上瀏覽到的所有廣告內容、文字與圖片之說明、展示樣品或其他銷售資訊，均由各該廣告商、產品與服務的供應商所設計與提出。您對於廣告之正確性與可信度應自行斟酌與判斷。「久德電子有限公司」僅接受委託予以刊登，不對前述廣告負擔保責任。<br>
                                                            智慧財產權的保護<br>
                                                            「久德討論版」所使用之軟體或程式、網站上所有內容，包括但不限於著作、圖片、檔案、資訊、資料、網站架構、網站畫面的安排、網頁設計，<br>
                                                            均由「久德電子有限公司」或其他權利人依法擁有其智慧財產權，包括但不限於商標權、專利權、著作權、營業秘密與專有技術等。任何人不得逕自使用、<br>
                                                            修改、重製、公開播送、改作、散布、發行、公開發表、進行還原工程、解編或反向組譯。若您欲引用或轉載前述軟體、程式或網站內容，<br>
                                                            必須依法取得「久德電子有限公司」或其他權利人的事前書面同意。尊重智慧財產權是您應盡的義務，如有違反，您應對「久德電子有限公司」負損害賠償責任<br>
                                                            （包括但不限於訴訟費用及律師費用等）。<br>
                                                            您對「久德電子有限公司」之授權<br>
                                                            會員同意授權「久德電子有限公司」，得為提供服務及贈獎之目的，提供必需之會員資料給合作夥伴(第三者)做約定範圍內之妥善使用，倘若會員不同意將其資料列於合作夥伴(第三者)產品或服務名單內，可以通知「久德電子有限公司」，於名單中刪除其資料，同時放棄其「久德討論版」中的優惠或獲獎權利。<br>
                                                            <br>
                                                            對於會員所登錄或留存之個人資料，會員同意「久德討論版」網站得於合理之範圍內蒐集、處理、保存、傳遞及使用該等資料，以提供使用者其他資訊或服務、或作成會員統計資料、或進行關於網路行為之調查或研究，或為任何之合法使用。<br>
                                                            <br>
                                                            若您無合法權利得授權他人使用、修改、重製、公開播送、改作、散布、發行、公開發表某資料，並將前述權利轉授權第三人，請勿擅自將該資料上載、傳送、輸入或提供至「久德討論版」。任何資料一經您上載、傳送、輸入或提供至「久德討論版」時，視為您已允許「久德討論版」無條件使用、修改、重製、公開播送、改作、散布、發行、公開發表該等資料，並得將前述權利轉授權他人，您對此絕無異議。您並應保證「久德討論版」使用、修改、重製、公開播送、改作、散布、發行、公開發表、轉授權該等資料，不致侵害任何第三人之智慧財產權，否則應對「久德電子有限公司」負損害賠償責任（包括但不限於訴訟費用及律師費用等）。<br>
                                                            拒絕或終止您的使用<br>
                                                            您同意「久德電子有限公司」得基於維護交易安全之考量，因任何理由，包含但不限於缺乏使用，或違反本服務條款的明文規定及精神，終止您的密碼、帳號（或其任何部分）或本服務之使用，並將本服務內任何「會員內容」加以移除並刪除，亦得已通知之情形下，隨時終止本服務或任何部分。此外，您同意若本服務之使用被終止，「久德電子有限公司」對您或任何第三人均不承擔責任。<br>
                                                            準據法與管轄法院<br>
                                                            本約定書之解釋與適用，以及與本約定書有關的爭議，均應依照中華民國法律予以處理。<br>
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
                                                            <span>我已經閱讀 服務條款並且同意註冊為會員</span>
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
                                            <div class="g-recaptcha "
                                                style='width: 304px;display: inline-block; ${empty errors.recaptcha?"":"border: 1px red solid;"}'
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
                        if (Math.round(scrollTop + windowHeight) >= scrollHeight * 0.9) {
                            $('#tos').attr('disabled', false);
                        }
                    });
                    $('#forum_rule_wrap').scroll(function () {
                        var scrollTop = $(this).scrollTop();
                        var scrollHeight = $(this).prop("scrollHeight");
                        var windowHeight = $(this).innerHeight();
                        if (Math.round(scrollTop + windowHeight) >= scrollHeight * 0.9) {
                            $('#forum_rule').attr('disabled', false);
                        }
                    });
                })

            </script>

        </body>

        </html>