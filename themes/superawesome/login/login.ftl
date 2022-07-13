<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
	<div class="title">
            ${msg("loginTitleHtml",(realm.displayNameHtml!''))}
        </div>
    <#elseif section = "form">
        <#if realm.password>
            <form id="kc-form-login" class="form ${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                <div class="username-container ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                    </div>

                    <div class="${properties.kcInputWrapperClass!}">
                        <#if usernameEditDisabled??>
                            <input id="username" class="form-control ${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                        <#else>
                            <input id="username" class="form-control ${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" />
                        </#if>
                    </div>
                </div>
                <div class="password-container ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    </div>

                    <div class="${properties.kcInputWrapperClass!}">
                        <input id="password" class="form-control ${properties.kcInputClass!}" name="password" type="password" autocomplete="off" />
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="checkbox remember-me-checkbox">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3" checked>&nbsp;&nbsp;${msg("rememberMe")}
                                        <#else>
                                            <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3">&nbsp;&nbsp;${msg("rememberMe")}
                                        </#if>
                                    </label>
                                </div>
                            </#if>
                    </div>
                </div>

                <#if recaptchaRequired??>
                  <div class="form-group">
                    <div class="\${properties.kcInputWrapperClass!}">
                      <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}">
                      </div>
                    </div>
                  </div>
                </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <div class="${properties.kcFormButtonsWrapperClass!}">
                            <input class="btn btn-primary btn-flat btn-block ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="${properties.kcFormGroupClass!} row">

                    <#if (realm.password && realm.registrationAllowed && !usernameEditDisabled??) || realm.resetPasswordAllowed>
                        <div>
                            <div class="${properties.kcFormOptionsWrapperClass!} col-xs-12 m-t-s center">
                                <#if realm.resetPasswordAllowed>
                                    <span><a href="${url.loginResetCredentialsUrl}">Forgot password?</a></span>
                                </#if>
                            </div>
                        </div>
                        <div>
                            <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
                                <div id="kc-registration" class="col-xs-12 m-t center">
                                    <span>Don't have an account? <a href="https://dashboard.superawesome.tv/en/register">Sign up</a></span>
                                </div>
                            </#if>
                        </div>
                    </#if>
                </div>
            </form>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers">
                <ul>
                    <#list social.providers as p>
                        <li><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span class="text">${p.displayName}</span></a></li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
