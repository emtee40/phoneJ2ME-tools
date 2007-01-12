<?xml version="1.0" encoding="UTF-8"?>
<!--
           

        Copyright 1990-2006 Sun Microsystems, Inc. All Rights Reserved.
        DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
-->
<!--
    This stylesheet generates Configurator XML file from 
    the list of constant=value pairs separated by delimeter
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<!-- stylesheet parameter: list of constant=value pairs separated by delimeter -->
<xsl:param name="constantsList"></xsl:param>

<!-- stylesheet parameter: list delimeter -->
<xsl:param name="listDelimeter">,</xsl:param>

<xsl:template match="/">
    <xsl:element name="configuration">
        <xsl:element name="constants">
            <xsl:element name="constant_class">
                <xsl:attribute name="Package">
                </xsl:attribute>
                <xsl:attribute name="Name">
                </xsl:attribute>

                <!-- process constantsList if it isn't empty -->
                <xsl:if test="boolean($constantsList)">
                    <xsl:call-template name="processList">
                        <xsl:with-param name="constantsList" select="$constantsList"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:element>        
</xsl:template>

<!-- process list of constant=value pairs -->
<xsl:template name="processList">
<!-- template parameter: list of constant=value pairs separated by delimeter -->
<xsl:param name="constantsList"/>
    <!-- get first file name from the list -->
    <xsl:variable name="nameValuePair">
        <xsl:choose>
            <!-- when there is more than one element in the list -->
            <xsl:when test="contains($constantsList, $listDelimeter)">
                <xsl:value-of select="substring-before($constantsList, $listDelimeter)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$constantsList"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- process it -->
    <xsl:call-template name="processPair">
        <xsl:with-param name="nameValuePair" select="$nameValuePair"/>
    </xsl:call-template>
    <!-- and call this template recursively to process rest of the pairs -->
    <xsl:if test="contains($constantsList, $listDelimeter)">
        <xsl:call-template name="processList">
            <xsl:with-param name="constantsList" 
                select="substring-after($constantsList, $listDelimeter)"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<!-- process constant=value pair -->
<xsl:template name="processPair">
<!-- template parameter: pair to process -->
<xsl:param name="nameValuePair"/>

    <!-- constant's name -->
    <xsl:variable name="constantName" 
        select="normalize-space(substring-before($nameValuePair, '='))"/>

    <!-- constant's value -->
    <xsl:variable name="constantValue" 
        select="normalize-space(substring-after($nameValuePair, '='))"/>
    
    <!-- output constant element -->
    <xsl:element name="constant">
        <!-- output constant's name attribute -->
        <xsl:attribute name="Name">
            <xsl:value-of select="$constantName"/>
        </xsl:attribute>
        <!-- output constant's value attribute -->
        <xsl:attribute name="Value">
            <xsl:value-of select="$constantValue"/>
        </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

