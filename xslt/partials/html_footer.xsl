<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        <footer class="py-3">
            
            <div class="container text-center">
                <div class="pb-1">
                    <span class="fs-5">Kontakt</span>
                </div>
                <div class="row justify-content-md-center">
                    <div class="col col-lg-5">
                        <!-- <div>
                            <a href="https://www.oeaw.ac.at/acdh/acdh-ch-home">
                                <img class="footerlogo" src="./images/acdh-ch-logo-with-text.svg" alt="ACDH-CH"/>
                            </a>
                        </div> -->
                        <div class="text-center p-4">
                            ACDH-CH Austrian Centre for Digital Humanities and Cultural Heritage Österreichische
                                Akademie der Wissenschaften
                            <br />
                            <a href="https://www.oeaw.ac.at/acdh/acdh-ch-home">https://www.oeaw.ac.at/acdh/acdh-ch-home</a>
                            <br />
                            <a href="mailto:acdh-ch-helpdesk@oeaw.ac.at">acdh-ch-helpdesk@oeaw.ac.at</a>
                        </div>
                    </div>
                    <div class="col col-lg-2">
                    </div>
                    <div class="col col-lg-5">
                        <!-- <div>
                            <a href="https://www.evtheol.lmu.de/de/die-fakultaet/lehrstuehle/lehrstuhl-systematische-theologie-i/">
                                <img class="footerlogo" src="./images/uni-munic-logo.png" alt="Univeristät München, Systematische Theologie"/>
                            </a>
                        </div> -->
                        <div class="text-center p-4">
Verein zur Erforschung monastischer Gelehrsamkeit in der Frühen Neuzeit
                            <br />
                            <a href="http://vemg.at">http://vemg.at</a>
                            <br />
                            <a href="mailto:info@vemg.at">info@vemg.at</a>
                            
                        </div>
                    </div>
                </div>
            </div>
            
            
            
            <div class="text-center">
                <a href="{$github_url}">
                    <i aria-hidden="true" class="bi bi-github fs-2"></i>
                    <span class="visually-hidden">GitHub repo</span>
                </a>
            </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        
    </xsl:template>
</xsl:stylesheet>