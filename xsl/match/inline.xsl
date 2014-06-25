<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:relation="http://schemas.openxmlformats.org/package/2006/relationships"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:v="urn:schemas-microsoft-com:vml"
    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
    xmlns:w10="urn:schemas-microsoft-com:office:word"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
    xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
    xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns="http://docbook.org/ns/docbook" exclude-result-prefixes="#all" version="2.0">

    <xsl:param name="NEGRETA" select="'negreta#'"/>
    <xsl:param name="CURSIVA" select="'cursiva#'"/>
    <xsl:param name="UNDERLINE" select="'underline#'"/>

    <!-- 
        w:r similar to span
        si té un estil propi es marca amb w:rStyle
    -->
    <xsl:template match="w:r">
        <xsl:choose>
            <!--
            <xsl:when test="not(descendant::w:br) and not(descendant::w:t)"/>
            -->
            <xsl:when test=".//w:vertAlign[@w:val='superscript']">
                <!--
                    <w:r w:rsidRPr="002400C1">
                       <w:rPr>
                          <w:vertAlign w:val="superscript"/>
                        </w:rPr>
                        <w:t>29</w:t>
                    </w:r>
                -->
                <xsl:if test="normalize-space(w:t)">
                    <superscript>
                        <xsl:value-of select="w:t"/>
                    </superscript>
                </xsl:if>
            </xsl:when>
            <xsl:when test=".//w:vertAlign[@w:val='subscript']">
                <xsl:if test="normalize-space(w:t)">
                    <subscript>
                        <xsl:value-of select="w:t"/>
                    </subscript>
                </xsl:if>
            </xsl:when>
            <xsl:when test=".//w:position[@w:val &lt; 0]">
                <xsl:if test="normalize-space(w:t)">
                    <subscript>
                        <xsl:value-of select="w:t"/>
                    </subscript>
                </xsl:if>
            </xsl:when>
            <xsl:when test="descendant::w:br and not(descendant::w:t)">
                <literallayout role="linebreak"/>
            </xsl:when>
            <xsl:when test="w:rPr">
                <xsl:choose>
                    <xsl:when test="count(w:rPr/*)=count(w:rPr/w:lang)">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="mc:AlternateContent//mc:Choice[@Requires='wps']">
                        <xsl:apply-templates
                            select="mc:AlternateContent//mc:Choice[@Requires='wps']//w:p"/>
                    </xsl:when>

                    <xsl:otherwise>
                        <!--
                            <xsl:for-each select="w:rPr">
                                <xsl:if test="w:rStyle">
                                    <xsl:attribute name="role">
                                        <xsl:value-of select="w:rStyle/@w:val"/>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:for-each>
                            -->
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- footnote references, the footnotes text are in the footnotes.xml -->
    <xsl:template match="w:footnoteReference">
        <footnoteref linkend='ft{@w:id}'/>
    </xsl:template>

    <xsl:template match="w:br">
        <literallayout role="linebreak"/>
    </xsl:template>

    <xsl:template match="mc:AlternateContent">
        <xsl:apply-templates select=".//mc:Choice//w:drawing[.//a:blip[@r:embed]][1]"/>

    </xsl:template>



    <!--
    <xsl:template match="w:drawing">
        <xsl:variable name="imatge" select=".//a:blip/@r:embed"/>
        <xsl:variable name="path.rels"
            select="concat($path.unzip.word,'/word/_rels/document.xml.rels')"/>

        <xsl:variable name="imatge-nom"
            select="document($path.rels)/relation:Relationships/relation:Relationship[@Id=$imatge]/@Target"/>
        <inlinemediaobject xml:id="{generate-id()}">
            <imageobject>
                <imagedata fileref="{$imatge-nom}"> </imagedata>
            </imageobject>
        </inlinemediaobject>
    </xsl:template>
-->
    <!-- 
        Avans de posar el text em de comprovar si te negretes o italiques associades
    -->
    <xsl:template match="w:t">
        <!-- abans d'escriure hem de mirar si té nedretes o el que sigui -->
        <xsl:variable name="document-estils" select="concat($path.unzip.word,'/word/styles.xml')"/>
        <xsl:variable name="estils-text" select="document($document-estils)"/>
        <!-- estils: mirem si te NEGRETA w:b, SUBRATLLAT w:u, ITALICA w:i -->
        <xsl:variable name="estil-r" select="parent::w:r/w:rPr/w:rStyle/@w:val"/>
        <xsl:variable name="index-estil-r" select="$estils-text//w:style[@w:styleId=$estil-r]"/>

        <xsl:variable name="estil-p" select="parent::w:p/w:pPr/w:pStyle/@w:val"/>
        <xsl:variable name="index-estil-p" select="$estils-text//w:style[@w:styleId=$estil-p]"/>

        <xsl:variable name="estil-ins-r" select="parent::w:r/w:rPr"/>
        <xsl:variable name="estil-ins-p" select="parent::w:p/w:pPr"/>

        <!-- 
            El problema esta en identar b i i alhora, per això avans de posar-ho analitzem
            cada text quin estil té associat i li associem un text            
        -->
        <xsl:variable name="estils-aplicats-text">
            <xsl:if
                test="$estil-ins-r//w:b | $index-estil-r//w:b | $index-estil-p//w:b | $estil-ins-p//w:b">
                <xsl:value-of select="$NEGRETA"/>
            </xsl:if>
            <xsl:if
                test="$estil-ins-r//w:i | $index-estil-r//w:i | $index-estil-p//w:i | $estil-ins-p//w:i">
                <xsl:value-of select="$CURSIVA"/>
            </xsl:if>
            <xsl:if
                test="$estil-ins-r//w:u | $index-estil-r//w:u | $index-estil-p//w:u | $estil-ins-p//w:u">
                <xsl:value-of select="$UNDERLINE"/>
            </xsl:if>
        </xsl:variable>

        <xsl:call-template name="posa-estils-inline">
            <xsl:with-param name="texte" select="."/>
            <xsl:with-param name="estils" select="$estils-aplicats-text"/>
        </xsl:call-template>

    </xsl:template>

    <!-- 
        Es molt important l'ordre en que ens arriven els estils sempre ha de ser
        negreta#cursiva#underline#
    -->
    <xsl:template name="posa-estils-inline">
        <xsl:param name="texte"/>
        <xsl:param name="estils"/>

        <xsl:choose>
            <xsl:when test="contains($estils,$NEGRETA)">
                <emphasis role="bold">
                    <xsl:call-template name="posa-estils-inline">
                        <xsl:with-param name="texte" select="$texte"/>
                        <xsl:with-param name="estils" select="substring-after($estils,$NEGRETA)"/>
                    </xsl:call-template>
                </emphasis>
            </xsl:when>
            <xsl:when test="contains($estils,$CURSIVA)">
                <emphasis role="italica">
                    <xsl:call-template name="posa-estils-inline">
                        <xsl:with-param name="texte" select="$texte"/>
                        <xsl:with-param name="estils" select="substring-after($estils,$CURSIVA)"/>
                    </xsl:call-template>
                </emphasis>
            </xsl:when>
            <xsl:when test="contains($estils,$UNDERLINE)">
                <emphasis role="underline">
                    <xsl:call-template name="posa-estils-inline">
                        <xsl:with-param name="texte" select="$texte"/>
                        <xsl:with-param name="estils" select="substring-after($estils,$UNDERLINE)"/>
                    </xsl:call-template>
                </emphasis>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
