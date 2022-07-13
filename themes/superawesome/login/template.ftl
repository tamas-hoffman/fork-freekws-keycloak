<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title><#nested "title"></title>
    <link rel="shortcut icon" href="${url.resourcesPath}/img/sa-favicon.png"/>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!} template">
<div id="container">
    <div id="centered-container">
        <div id="white-box">
            <div id="left-container">
                <div id="logo">
                    <img src="${url.resourcesPath}/img/SuperAwesome_red.png" alt="SA Logo"/>
                </div>
                <div id="asset" class="m-b">
                    <img src="${url.resourcesPath}/img/asset.png" alt="Infographie"/>

                </div>
            </div>
            <div id="right-container">
              <#if displayMessage && message?has_content>
                    <div class="${properties.kcFeedbackAreaClass!}">
                        <div class="alert alert-${message.type}">
                            <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                            <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                            <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                            <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                            <span class="kc-feedback-text">${message.summary?no_esc}</span>
                        </div>
                    </div>
              </#if>
              <#if displayInfo>
                   <div id="kc-info" class="${properties.kcInfoAreaClass!}">
                       <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                        <#nested "info">
                       </div>
                   </div>
              </#if>
                <div id="kc-form" class="${properties.kcFormAreaClass!}">
                    <div id="kc-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">
                                    <#nested "form">
                    </div>
                </div>

            </div>
            <div class="clearboth">
            </div>
        </div>
        <div id="footer">
            <div id="footer-left">
                <a href="https://www.superawesome.tv/terms-of-use">Terms of Use</a>
                <a class="m-l-s" href="https://www.superawesome.tv/awesomeads-privacy-policy">Privacy
                    Policy</a>
            </div>
            <div id="footer-right"><a href="https://www.esrb.org/confirm/superawesome-confirmation.aspx"
                                  target="_blank">
                <img
                        class="footer-img"
                        alt="SuperAwesome Ad Platform (AwesomeAds) is ESRB-certified."
                        src="${url.resourcesPath}/img/esrb_global.png">
            </a>
                <a href="http://www.kidsafeseal.com/certifiedproducts/superawesome_ads.html"
                   target="_blank">
                    <img
                            class="footer-img m-l-s"
                            alt="SuperAwesome Ad Platform (AwesomeAds) is certified by the kidSAFE Seal Program."
                            src="https://www.kidsafeseal.com/sealimage/20514916241307214700/
superawesome_ads_small_darktm.png">
                </a></div>
            <div class="clearboth"></div>
        </div>
    </div>
</div>
</body>
</html>
</#macro>
