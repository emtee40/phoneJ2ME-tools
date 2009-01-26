<?xml version="1.0" encoding="UTF-8"?>
<!--
        Copyright  1990-2009 Sun Microsystems, Inc. All Rights Reserved.
        DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
        
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License version
        2 only, as published by the Free Software Foundation.
        
        This program is distributed in the hope that it will be useful, but
        WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
        General Public License version 2 for more details (a copy is
        included at /legal/license.txt).
        
        You should have received a copy of the GNU General Public License
        version 2 along with this work; if not, write to the Free Software
        Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
        02110-1301 USA
        
        Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
        Clara, CA 95054 or visit www.sun.com if you need additional
        information or have any questions.
-->
<!--
    This stylesheet outputs C source file with functions definitions
    for getting/setting properties values during runtime. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:variable name="properties" select="/configuration/properties"/>
<xsl:call-template name="outputProperties">
<xsl:with-param name="properties" select="$properties"/>
</xsl:call-template> 
</xsl:template>

<xsl:template name="outputProperties">
<xsl:param name="properties"/>
<!-- all properties with Callout attribute -->
<xsl:variable name="calloutProps" select="$properties/property[boolean(@Callout)]"/>
<xsl:text>/*
 * Copyright  1990-2009 Sun Microsystems, Inc. All Rights Reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License version
 * 2 only, as published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License version 2 for more details (a copy is
 * included at /legal/license.txt).
 * 
 * You should have received a copy of the GNU General Public License
 * version 2 along with this work; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 * 
 * Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
 * Clara, CA 95054 or visit www.sun.com if you need additional
 * information or have any questions.
 *
 */

/*
 * This file is auto generated by Configurator. Do not edit.
 */
#ifndef __MIDP_PROPERTY_CALLOUTS_H
#define __MIDP_PROPERTY_CALLOUTS_H

static char* calloutKey[] = {
</xsl:text>
<!-- output array of callout keys -->
<xsl:call-template name="outputKeys">
<xsl:with-param name="nodes" select="$calloutProps"/>
</xsl:call-template>    NULL
};
<!-- output callout functions declarations -->
<xsl:for-each select="$calloutProps">
<xsl:text>extern char* </xsl:text><xsl:value-of select="@Callout"/><xsl:text>(void);</xsl:text>
<xsl:text>
</xsl:text>
</xsl:for-each>
<!-- output array of pointers to callout functions -->
typedef char* (*CALLOUTPTR)();
static CALLOUTPTR calloutFunction[] = {
<xsl:call-template name="outputCalloutFunctions">
<xsl:with-param name="nodes" select="$calloutProps"/>
</xsl:call-template>    NULL
};

#endif
</xsl:template>

<!-- output callout functions table -->
<xsl:template name="outputCalloutFunctions">
<!-- template parameter: properties with Callout attribute -->
<xsl:param name="nodes"/>
<xsl:for-each select="$nodes[@Key]">
<xsl:sort select="@Key"/>
<xsl:text>    </xsl:text>
<xsl:value-of select="@Callout"/>
<xsl:text>,
</xsl:text>
</xsl:for-each>
</xsl:template>

<!-- output properties keys, one key per line, separated by comma -->
<xsl:template name="outputKeys">
<xsl:param name="nodes"/>
<xsl:for-each select="$nodes[@Key]">
<xsl:sort select="@Key"/>
<xsl:text>    </xsl:text>
<xsl:text>"</xsl:text><xsl:value-of select="@Key"/><xsl:text>"</xsl:text>
<xsl:text>,
</xsl:text>
</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
