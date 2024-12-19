<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:person" name="person_detail">
        <dl>
            <xsl:if test="./tei:idno">
                <dt>Normdaten</dt>
                <xsl:for-each select="./tei:idno/text()">
                    <dd><a href="{.}"><xsl:value-of select="."/></a></dd>
                </xsl:for-each>
            </xsl:if>
        </dl>
        <h2 class="text-center pt-2">Verknüpfte Dokumente</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h3>Urheber von</h3>
                <ul>
                    <xsl:for-each select=".//tei:ptr[@type='urheber']">
                        <xsl:variable name="foo">
                            <xsl:value-of select="replace(tokenize(@target, '/')[last()], '.xml', '.html')"/>
                        </xsl:variable>
                        <li>
                            <a href="{$foo}"><xsl:value-of select="@n"/></a>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
            <div class="col-md-6">
                <h3>Erwähnt in</h3>
                <ul>
                    <xsl:for-each select=".//tei:ptr[@type='behandelte']">
                        <xsl:variable name="foo">
                            <xsl:value-of select="replace(tokenize(@target, '/')[last()], '.xml', '.html')"/>
                        </xsl:variable>
                        <li>
                            <a href="{$foo}"><xsl:value-of select="@n"/></a>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>