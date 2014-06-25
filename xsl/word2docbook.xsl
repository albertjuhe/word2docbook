<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
    xmlns:w10="urn:schemas-microsoft-com:office:word"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns="http://docbook.org/ns/docbook"
    exclude-result-prefixes="#all" version="2.0">

    <xsl:include href="match/blocs.xsl"/>
    <xsl:include href="match/inline.xsl"/>
    <xsl:include href="match/table.xsl"/>
    <xsl:include href="match/links.xsl"/>
    <xsl:include href="match/info.xsl"/>
    <xsl:include href="match/media.xsl"/>
    <xsl:include href="OMML2MML.XSL"/>
 
    <xsl:param name="path.unzip.word" select="'C:/word2docbook_github/word2docbook/tmp'"/>
    <xsl:param name="template.estils" select="'C:/word2docbook_github/word2docbook/templates/template.xml'"/>
    <xsl:param name="codi"/>
    <xsl:param name="titol"/>
    <xsl:param name="path-images" select="'media/'"/>

    
    <xsl:key name="busca-estil" match="w:style" use="@w:styleId"/>
    
    <xsl:output indent="no" omit-xml-declaration="no" standalone="yes" media-type="xml"
        encoding="UTF-8"/>

    <xsl:strip-space elements="* except emphasis"/>

    <xsl:template match="/">
        <book xmlns="http://docbook.org/ns/docbook" version="5.0">
            <xsl:call-template name="info">
                <xsl:with-param name="context" select="w:document/w:body"/>
            </xsl:call-template>
            <xsl:apply-templates/>
        </book>
    </xsl:template>

    <xsl:template match="w:document">
        <xsl:apply-templates select="w:body"/>
    </xsl:template>

    <xsl:template match="w:body">
        <!-- Extraxt document title -->
        <xsl:variable name="document-metadades" select="concat($path.unzip.word,'/docProps/core.xml')"></xsl:variable>
        <xsl:variable name="document-title">
            <xsl:if test="doc-available($document-metadades)">
                <xsl:value-of select="document($document-metadades)//dc:title"/>
            </xsl:if>
        </xsl:variable>
            
        
        <xsl:variable name="title">
            <xsl:choose>
                <xsl:when test="normalize-space($document-title)"><xsl:value-of select="$document-title"></xsl:value-of> </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="w:p[descendant::w:t][1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <content>
            <xsl:apply-templates/>
        </content>
        <footnotes>
            <!-- Extraxt document title -->
            <xsl:variable name="document-footnotes" select="concat($path.unzip.word,'/word/footnotes.xml')"></xsl:variable>
            <xsl:if test="doc-available($document-footnotes)">
                <xsl:for-each select="document($document-footnotes)//w:footnote">
                    <footnote xml:id="ft{@w:id}">
                        <xsl:apply-templates/>
                    </footnote>
                </xsl:for-each>
            </xsl:if>
        </footnotes>
    </xsl:template>

    <xsl:template match="*"/>



</xsl:stylesheet>
