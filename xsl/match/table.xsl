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
    xmlns="http://docbook.org/ns/docbook" exclude-result-prefixes="#all" version="2.0">

    <xsl:template match="w:tbl">
        <para role="table">
        <informaltable>
            <tgroup cols="{count(./w:tblGrid/w:gridCol)}">
                <xsl:for-each select="./w:tblGrid/w:gridCol">
                    <colspec colname="{concat('c',position())}"/>
                </xsl:for-each>
                <tbody>
                    <xsl:apply-templates/>
                </tbody>
            </tgroup>
        </informaltable>
        </para>
    </xsl:template>

    <xsl:template match="w:tr">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>

    <xsl:template match="w:tc">
        <entry>
            <xsl:apply-templates/>
        </entry>
    </xsl:template>


</xsl:stylesheet>
