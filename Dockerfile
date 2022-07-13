FROM jboss/keycloak:13.0.1

# Custom plugins for FreeKWS:
ADD keycloak-eos-ear-13.0.1.ear /opt/jboss/keycloak/standalone/deployments/
ADD keycloak-extended-token-13.0.1.jar /opt/jboss/keycloak/standalone/deployments/

# Recaptcha Login support:
# Discovery is at https://superawesomeltd.atlassian.net/wiki/spaces/CLOUD/pages/4438720825/Discovery+Keycloak+Login+with+Recaptcha
#
# To solve "On login form, if you give wrong credentials it presents with the form again WITHOUT the recaptcha. After that, login fails with #3 cause recaptcha can’t be possibly be checked" we use https://github.com/SuperAwesomeLTD/keycloak-login-recaptcha a fork of https://github.com/raptor-group/keycloak-login-recaptcha to solve https://superawesomeltd.atlassian.net/browse/COS-2881 with the right fix.
ADD recaptcha-login.jar /opt/jboss/keycloak/standalone/deployments/

# Metrics

# add keycloak-metrics-spi support - see https://github.com/aerogear/keycloak-metrics-spi#install-and-setup
ADD keycloak-metrics-spi-2.4.0.jar /opt/jboss/keycloak/standalone/deployments/
RUN cd /opt/jboss/keycloak/standalone/deployments/ && touch keycloak-metrics-spi-2.4.0.jar.dodeploy

# FreeKWS requires OAuth Token Exchange flows, which requires admin_fine_grained_auth, see: https://www.keycloak.org/docs/latest/securing_apps/#_token-exchange
CMD ["-Dkeycloak.profile.feature.token_exchange=enabled", "-Dkeycloak.profile.feature.admin_fine_grained_authz=enabled", "-b", "0.0.0.0"]
