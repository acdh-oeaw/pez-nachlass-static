<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>

    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>


    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select='"Pez-Nachlass"'/>
        </xsl:variable>
        <html class="h-100" lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <div class="container col-xxl-8 pt-3">
                       <div class="row flex-lg-row align-items-center g-5 py-5">
                          <div class="col-lg-6">
                              <h1 class="lh-base">
                                  <div class="display-6 text-center">Nachlass von</div>
                                  <div class="text-center display-4">Bernhard &amp; Hieronymus Pez</div>
                             </h1>
                            <p class="text-end">Herausgegeben von Thomas Wallnig, Irene Rabl und Abubakar Sidyk Bisayew.</p>
                            <p class="lead text-justify">Diese Website präsentiert Beschreibungen von etwa 800 Objekten, die im Archiv und in der <a href="https://www.stiftmelk.at/">Bibliothek des Stifts Melk</a> aufbewahrt werden, sowie etwa 50.000 Bilddateien dieser Dokumente. Diese Objekte - Briefe, Manuskripte, Abschriften, Notizen - dokumentieren die wissenschaftliche Arbeit der beiden benediktinischen <a href="https://de.wikipedia.org/wiki/Bernhard_Pez">Bernhard</a> und <a href="https://de.wikipedia.org/wiki/Hieronymus_Pez">Hieronymus Pez</a>.
                            </p>
                             <div class="d-grid gap-2 d-md-flex pt-3 justify-content-center">
                                 <a href="search.html" type="button" class="btn btn-primary btn-lg px-4 me-md-2">Volltextsuche</a>
                                 <a href="toc.html" type="button" class="btn btn-outline-primary btn-lg px-4">Tabellarische Übersicht</a>
                             </div>
                          </div>
                          <div class="col-10 col-sm-8 col-lg-6">
                             <figure class="figure">
                                 <img src="images/title-image.jpg" class="d-block mx-lg-auto img-fluid" alt="" width="400" height="600" loading="lazy"/>
                                 <figcaption class="pt-3 figure-caption">Bernhard Pez an seinem Schreibtisch. Kupferstich aus “Thesaurus anecdotorum novissimus” (1721)</figcaption>
                             </figure>
                          </div>
                       </div>
                    </div>
                 </main>
                <xsl:call-template name="html_footer"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>