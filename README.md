# freekws-keycloak

The purpose of this repo is to allow for the deployment of Keycloak across multiple regions into the freekws infrastructure using CircleCI.

Using this repo to deploy keycloak will result in the creation of keycloak cluster with an infinispan cluster that can be used as a replicated cache across multiple regions. 
If a situation arises where you need to recreate this resource you will need to take the following steps:
* Manually create a release in the namespace you want, in our case `sa-keycloak-multiregion-eu-west-1` and `sa-keycloak-multiregion-us-east-1`
* Update coredns using the associated template in `sa-infrastructure` to create the required nlb and ip dns routing
* Use CircleCi to ensure that the deployment occurs without issue

To better understand how Keycloak works in multiregion configuration it is recommended that you read the associated documentation in confluence
* [Keycloak](https://superawesomeltd.atlassian.net/wiki/spaces/KWS/pages/4962975885/Keycloak)
