#!/bin/sh

environment="PRODUCTION"
diffOnly=true

echo "Note: it must be run from ./swap-ingress-auth2-to-auth directory"

if [ "$diffOnly" = true ] ; then
  echo "DIFF only! Set diffOnly=false to do the actual swap!"
fi

if [ "$environment" = "PRODUCTION" ] ; then
  environment_replace=""
else
  environment_replace="\.${environment}"
fi

# choose the right cluster
kubectx "${environment}_corporate_v2_eu-west-1_0"

# sa-keycloak-11

echo "\n********************************************\n"
echo "sa-keycloak-11: Moving auth2${environment_replace}.superawesome.tv ==> auth${environment_replace}.superawesome.tv"

VALUES_FILE_11="./sa-keycloak-11-${environment}-values.yaml"

if [ -f $VALUES_FILE_11 ]; then
  echo "$VALUES_FILE_11 exists - using it!"
else
  helm get values sa-keycloak-11 --namespace sa-keycloak-11 --all > ./temp11.yml
  sed "s/auth2${environment_replace}\./auth${environment_replace}\./" ./temp11.yml > ./temp11-2.yml
  sed "/USER-SUPPLIED VALUES:/d" ./temp11-2.yml > $VALUES_FILE_11
  rm ./temp11.yml ./temp11-2.yml # @todo: is there a better way for these temp files?
fi

if [ "$diffOnly" = true ] ; then
  helm diff -C 2 upgrade sa-keycloak-11 ../helm --namespace sa-keycloak-11 --values $VALUES_FILE_11
else
  helm upgrade sa-keycloak-11 ../helm --namespace sa-keycloak-11 --values $VALUES_FILE_11
fi

echo "Check sa-keycloak-11 ingress (must have become 'auth${environment_replace}.superawesome.tv')"
# kubectl get ingress

# sa-keycloak

echo "\n********************************************\n"
echo "sa-keycloak: Moving auth${environment_replace}.superawesome.tv ==> auth2${environment_replace}.superawesome.tv"

VALUES_FILE="./sa-keycloak-${environment}-values.yaml"

if [ -f $VALUES_FILE ]; then
  echo "$VALUES_FILE exists - using it!"
else
  helm get values --namespace sa-keycloak sa-keycloak --all > ./temp.yml
  sed "s/auth${environment_replace}\./auth2${environment_replace}\./" ./temp.yml > ./temp2.yml
  sed "/USER-SUPPLIED VALUES:/d" ./temp2.yml > $VALUES_FILE
  rm ./temp.yml ./temp2.yml
fi

if [ "$diffOnly" = true ] ; then
  helm diff -C 2 upgrade sa-keycloak superawesome/sa-keycloak --namespace sa-keycloak --values $VALUES_FILE --version 0.2.2
else
  helm upgrade sa-keycloak superawesome/sa-keycloak --namespace sa-keycloak --values $VALUES_FILE --version 0.2.2
fi

echo "Check sa-keycloak ingress (must have become 'auth2${environment_replace}.superawesome.tv')"
# kubectl get ingress
