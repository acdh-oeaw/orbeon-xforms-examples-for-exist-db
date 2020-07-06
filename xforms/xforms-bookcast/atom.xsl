<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright (C) 2007 Orbeon, Inc.

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xsl:version="2.0">

    <title>Orbeon Forms Bookcast</title>
    <subtitle>An Orbeon Forms tutorial example</subtitle>
    <updated>
        <xsl:value-of select="current-dateTime()"/>
    </updated>
    <id>http://www.orbeon.com/ops/xforms-bookcast/</id>
    <link href="http://www.orbeon.com/"/>
    <generator uri="http://demo.orbeon.com/orbeon/xforms-bookcast/" version="1.0">Orbeon Forms Bookcast</generator>

    <xsl:for-each select="/books/book">
        <entry>
            <title>
                <xsl:value-of select="concat(author, ' - ', title)"/>
            </title>
            <id>http://www.orbeon.com/ops/xforms-bookcast/<xsl:value-of select="concat(author, ' - ', title)"/>"/&gt;</id>
            <updated>
                <xsl:value-of select="current-dateTime()"/>
            </updated>
            <content type="xhtml" xml:lang="en">
                <div xmlns="http://www.w3.org/1999/xhtml">
                    <p>
                        Book information:
                    </p>
                    <table>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Title</th>
                            <td>
                                <xsl:value-of select="title"/>
                            </td>
                        </xh:tr>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Author</th>
                            <td>
                                <xsl:value-of select="author"/>
                            </td>
                        </xh:tr>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Language</th>
                            <td>
                                <xsl:value-of select="language"/>
                            </td>
                        </xh:tr>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Link</th>
                            <td>
                                <a href="{link}">
                                    <xsl:value-of select="link"/>
                                </a>
                            </td>
                        </xh:tr>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Rating</th>
                            <xsl:variable name="rating" select="if (rating castable as xs:integer) then xs:integer(rating) else 0" as="xs:integer"/>
                            <td>
                                <xsl:value-of select="string-join(for $i in (1 to $rating) return '*', '')"/>
                            </td>
                        </xh:tr>
                        <xh:tr xmlns:xh="http://www.w3.org/1999/xhtml">
                            <th>Notes</th>
                            <td>
                                <xsl:for-each select="tokenize(notes, '&#xA;')">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() lt last()">
                                        <xh:br/>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </xh:tr>
                    </table>
                </div>
            </content>
        </entry>
    </xsl:for-each>
</feed>