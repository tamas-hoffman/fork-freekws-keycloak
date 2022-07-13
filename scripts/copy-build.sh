#!/bin/sh

# Note: this is only used for development convenience

cp ../sa-cloud-account-keycloak/federation/target/sa-cloud-account-keycloak-federation-12.0.4.jar .
cp ../keycloak-login-recaptcha/target/recaptcha-login.jar .
cp ../keycloak-eos/ear/target/keycloak-eos-ear-12.0.4.ear .
#cp ../keycloak-extended-token/dist/keycloak-extended-token-12.0.4.jar .

./scripts/build.sh
