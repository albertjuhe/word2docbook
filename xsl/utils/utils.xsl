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

    <xsl:key name="busca-estil" match="w:style" use="@w:styleId"/>
    
    <xsl:template name="aplica-estil">
        <xsl:param name="nom-estil"/>
        <xsl:param name="elements-estil"/>
        <xsl:param name="primera-entrada" select="false()"/>

        <xsl:variable name="estil" select="key('busca-estil',$nom-estil)"/>
        <xsl:choose>
            <xsl:when test="not(contains($elements-estil,'negreta'))">
                <xsl:choose>
                    <xsl:when test="$estil//w:b">
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                        <strong>
                            <xsl:call-template name="aplica-estil">
                                <xsl:with-param name="nom-estil" select="$nom-estil"/>
                                <xsl:with-param name="elements-estil"
                                    select="concat($elements-estil,'negreta#')"/>
                            </xsl:call-template>
                        </strong>
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="aplica-estil">
                            <xsl:with-param name="nom-estil" select="$nom-estil"/>
                            <xsl:with-param name="elements-estil"
                                select="concat($elements-estil,'negreta#')"/>
                            <xsl:with-param name="primera-entrada" select="$primera-entrada"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="not(contains($elements-estil,'subratllat'))">
                <xsl:choose>
                    <xsl:when test="$estil//w:u">
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                        <u>
                            <xsl:call-template name="aplica-estil">
                                <xsl:with-param name="nom-estil" select="$nom-estil"/>
                                <xsl:with-param name="elements-estil"
                                    select="concat($elements-estil,'subratllat#')"/>
                            </xsl:call-template>
                        </u>
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="aplica-estil">
                            <xsl:with-param name="nom-estil" select="$nom-estil"/>
                            <xsl:with-param name="elements-estil"
                                select="concat($elements-estil,'subratllat#')"/>
                            <xsl:with-param name="primera-entrada" select="$primera-entrada"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="not(contains($elements-estil,'cursiva'))">
                <xsl:choose>
                    <xsl:when test="$estil//w:i">
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                        <em>
                            <xsl:call-template name="aplica-estil">
                                <xsl:with-param name="nom-estil" select="$nom-estil"/>
                                <xsl:with-param name="elements-estil"
                                    select="concat($elements-estil,'cursiva#')"/>
                            </xsl:call-template>
                        </em>
                        <!-- Si és el primer tag, per si hi ha anidaments -->
                        <xsl:if test="$primera-entrada">
                            <xsl:text>&#xA0;</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="aplica-estil">
                            <xsl:with-param name="nom-estil" select="$nom-estil"/>
                            <xsl:with-param name="elements-estil"
                                select="concat($elements-estil,'cursiva#')"/>
                            <xsl:with-param name="primera-entrada" select="$primera-entrada"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
          
            <xsl:otherwise>
                <xsl:apply-templates mode="html"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
