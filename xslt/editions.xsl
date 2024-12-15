<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar" version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>

    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>


    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"
        />
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>


    <xsl:template match="/">
        <html class="h-100" lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb"
                        class="ps-5 p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html">
                                    <xsl:value-of select="$html_title"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="toc.html">Alle Dokumente</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <xsl:value-of select=".//tei:classCode/text()"/>
                            </li>
                        </ol>
                    </nav>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12 text-start">
                                <xsl:if test="ends-with($prev, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-left"
                                            title="Zurück zum vorigen Dokument"
                                            visually-hidden="true">
                                            <span class="visually-hidden">Zurück zum vorigen
                                                Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12 text-center">
                                <h1>
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <div>
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download fs-2" title="Zum TEI/XML Dokument"
                                            visually-hidden="true">
                                            <span class="visually-hidden">Zum TEI/XML
                                                Dokument</span>
                                        </i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12 text-end">
                                <xsl:if test="ends-with($next, '.html')">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fs-2 bi bi-chevron-right"
                                            title="Weiter zum nächsten Dokument"
                                            visually-hidden="true">
                                            <span class="visually-hidden">Weiter zum nächsten
                                                Dokument</span>
                                        </i>
                                    </a>
                                </xsl:if>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-7">
                                <h2 class="text-center">Faksimiles</h2>
                            </div>
                            <div class="col-md-5">
                                <h2 class="text-center">Über das Dokument</h2>
                                <dl>
                                    <dt>Signatur</dt>
                                    <dd>
                                        <xsl:value-of
                                            select="string-join(.//tei:msIdentifier/tei:*/text(), ', ')"
                                        />
                                    </dd>

                                    <dt>Datierung</dt>
                                    <dd>
                                        <xsl:value-of select=".//tei:origin/tei:date/text()"/>
                                    </dd>

                                    <dt>Folierung</dt>
                                    <dd>
                                        <xsl:for-each select=".//tei:foliation">
                                            <xsl:apply-templates/>
                                        </xsl:for-each>
                                    </dd>
                                    
                                    <dt>Urheber</dt>
                                    <xsl:for-each select=".//tei:person[@role='urheber']">
                                        <dd>
                                            <a><xsl:value-of select="/tei:persName/text()"/></a></dd>
                                    </xsl:for-each>
                                    

                                    <dt>Inhalt</dt>
                                    <dd>
                                        <xsl:for-each select=".//tei:summary">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                    </dd>
                                    
                                    <dt>Literatur</dt>
                                    <dd>
                                        <xsl:for-each select=".//tei:listBibl/tei:bibl">
                                            <p><xsl:apply-templates/></p>
                                        </xsl:for-each>
                                    </dd>


                                </dl>
                            </div>
                        </div>


                    </div>

                </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:rs[@type='bibl']">
        <br /><cite><xsl:value-of select="."/></cite>
    </xsl:template>
</xsl:stylesheet>
