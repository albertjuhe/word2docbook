<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:relation="http://schemas.openxmlformats.org/package/2006/relationships"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
    xmlns:w10="urn:schemas-microsoft-com:office:word"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
    xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
    xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns="http://docbook.org/ns/docbook" exclude-result-prefixes="#all" version="2.0">

    <xsl:template name="info"> 
        <xsl:param name="context" select="."/>

        <info>
            <title><xsl:value-of select="$titol"/></title>
            <revhistory>
                <revision>
                    <date><xsl:value-of select="current-dateTime()"/></date>
                    <authorinitials>Company</authorinitials>
                    <revremark>XML to docbook Conversion</revremark>
                </revision>
            </revhistory>
            <publisher role="organization">
                <publishername>COMPANY</publishername>
            </publisher>
            <publisher>
                <publishername>COMPANY</publishername>
                <address>Address</address>
            </publisher>
            <pubdate><xsl:value-of select="current-date()"/></pubdate>
            <edition>1</edition>
            <authorgroup>
            </authorgroup>
            <legalnotice>
                <para>COMPANY</para>
            </legalnotice>
            <biblioid class="isbn"><xsl:value-of select="$codi"/></biblioid>
            <biblioid class="other" otherclass="dl"><xsl:value-of select="$codi"/></biblioid>
            <biblioid class="other" otherclass="UOCXML"><xsl:value-of select="$codi"/></biblioid>
            <bibliorelation class="other" otherclass="UOCWEB" type="hasformat"><xsl:value-of select="$codi"/></bibliorelation>
            <bibliorelation class="other" otherclass="UOCPDF" type="hasformat"><xsl:value-of select="$codi"/></bibliorelation>
        </info>
    </xsl:template>


</xsl:stylesheet>
