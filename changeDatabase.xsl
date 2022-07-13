<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wtf="urn:jboss:domain:5.0"
                xmlns:ds="urn:jboss:domain:datasources:5.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template
            match="//ds:subsystem/ds:datasources/ds:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']">
        <ds:datasource jndi-name="java:jboss/datasources/KeycloakDS" enabled="true"
                       use-java-context="true" pool-name="KeycloakDS" use-ccm="true">
            <ds:connection-url>
                jdbc:postgresql://${env.KEYCLOAK_POSTGRES_HOST:postgres}:${env.KEYCLOAK_POSTGRES_PORT:5432}/${env.KEYCLOAK_POSTGRES_DATABASE:keycloak}?${env.KEYCLOAK_JDBC_PARAMS:__nothing=1}
            </ds:connection-url>
            <ds:driver>postgresql</ds:driver>
            <ds:security>
                <ds:user-name>${env.KEYCLOAK_POSTGRES_USER:keycloak}</ds:user-name>
                <ds:password>${env.KEYCLOAK_POSTGRES_PASSWORD:password}</ds:password>
            </ds:security>
            <ds:validation>
                <ds:check-valid-connection-sql>SELECT 1</ds:check-valid-connection-sql>
                <ds:background-validation>true</ds:background-validation>
                <ds:background-validation-millis>60000</ds:background-validation-millis>
            </ds:validation>
            <ds:pool>
                <ds:flush-strategy>IdleConnections</ds:flush-strategy>
                <ds:min-pool-size>${env.DB_MIN_POOL_SIZE:100}</ds:min-pool-size>
                <ds:max-pool-size>${env.DB_MAX_POOL_SIZE:200}</ds:max-pool-size>
                <ds:initial-pool-size>${env.DB_INITIAL_POOL_SIZE:100}</ds:initial-pool-size>
                <ds:statistics-enabled>${env.STATISTICS_ENABLED:false}</ds:statistics-enabled>
            </ds:pool>
        </ds:datasource>
    </xsl:template>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:drivers">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <ds:driver name="postgresql" module="org.postgresql.jdbc">
                <ds:xa-datasource-class>org.postgresql.xa.PGXADataSource</ds:xa-datasource-class>
            </ds:driver>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//*[local-name()='socket-binding-group']">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <wtf:socket-binding name="proxy-https" port="443"/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="//*[local-name()='server' and @name='default-server']/*[local-name()='http-listener' and @name='default']">
        <wtf:http-listener name="default" socket-binding="http"
                           proxy-address-forwarding="true" redirect-socket="proxy-https"/>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
