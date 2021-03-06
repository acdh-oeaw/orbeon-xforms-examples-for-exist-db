<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright (C) 2004 Orbeon, Inc.

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<p:config xmlns:saxon="http://saxon.sf.net/" xmlns:p="http://www.orbeon.com/oxf/pipeline" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:oxf="http://www.orbeon.com/oxf/processors">

    <p:param name="instance" type="input"/>
    <p:param name="data" type="output"/>

    <!-- Parse input document -->
    <p:processor name="oxf:xslt">
        <p:input name="data" href="#instance#xpointer(/*/*[1])"/>
        <p:input name="config">
            <xsl:stylesheet version="2.0">
                <xsl:template match="/">
                    <xsl:for-each select="saxon:parse(string(/))/*">
                        <xsl:copy>
                            <!-- Add namespace declaration for xs if not there already -->
                            <xsl:if test="not(in-scope-prefixes(.) = 'xs')">
                                <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
                            </xsl:if>
                            <xsl:copy-of select="@* | node()"/>
                        </xsl:copy>
                    </xsl:for-each>
                </xsl:template>
            </xsl:stylesheet>
        </p:input>
        <p:output name="data" id="input-parsed"/>
    </p:processor>

    <!-- Execute XPath expression-->
    <p:processor name="oxf:xslt">
        <p:input name="data" href="#input-parsed"/>
        <p:input name="xpath" href="#instance#xpointer(/*/*[2])"/>
        <p:input name="config">
            <xsl:stylesheet version="2.0">
                <xsl:template match="/">
                    <root>
                        <xsl:copy-of select="saxon:eval(saxon:expression(string(doc('input:xpath')), /*))"/>
                    </root>
                </xsl:template>
            </xsl:stylesheet>
        </p:input>
        <p:output name="data" id="output"/>
    </p:processor>

    <!-- Format output -->
    <p:processor name="oxf:pipeline">
        <p:input name="data" href="#output"/>
        <p:input name="config" href="oxf:/ops/utils/formatting/format-multiple.xpl"/>
        <p:output name="data" ref="data"/>
    </p:processor>

</p:config>