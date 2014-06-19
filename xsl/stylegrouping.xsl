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
    xmlns="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    exclude-result-prefixes="#all" version="2.0">

   
    <xsl:output indent="yes" omit-xml-declaration="no" standalone="yes" media-type="xml"
        encoding="UTF-8"/>

    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <styles>
            <xsl:apply-templates/> 
        </styles>            
    </xsl:template>

    <xsl:template match="w:document">
        <xsl:apply-templates select="w:body"/>
    </xsl:template>

    <xsl:template match="w:body">
        <xsl:for-each-group select=".//w:r/w:rPr" group-by="*">
            <style id="{generate-id()}">
                <xsl:copy-of select="*"/>
            </style>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="*"/>



</xsl:stylesheet>
