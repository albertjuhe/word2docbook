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
    xmlns="http://docbook.org/ns/docbook" exclude-result-prefixes="#all" version="2.0">


    <!-- 
        w:hyperlink: Vincle
    -->
    <xsl:template match="w:hyperlink">
        <xsl:choose>
            <xsl:when test="@w:anchor">
                <link linkend="{@w:anchor}">
                    <xsl:value-of select=".//w:t"/>
                </link>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="path.rels"
                    select="concat($path.unzip.word,'/word/_rels/document.xml.rels')"/>
                <link xmlns:xlink="http://www.w3.org/1999/xlink">
                    <xsl:if test="@r:id">
                        <xsl:variable name="identificador-link" select="@r:id"/>
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of
                                select="document($path.rels)/relation:Relationships/relation:Relationship[@Id=$identificador-link]/@Target"
                            />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="w:bookmarkStart">
    <!--    <anchor xml:id="{@w:name}"/> -->
    </xsl:template>
</xsl:stylesheet>
