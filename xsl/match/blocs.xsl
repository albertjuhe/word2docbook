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
    xmlns:t="http://www.omaonk.com/schema" xmlns="http://docbook.org/ns/docbook"
    exclude-result-prefixes="#all" version="2.0">
    <!--
    w:p es com
    un p si té un estil propi es marca amb w:pStyle 
    
    <w:p w:rsidR="003D16C2" w:rsidRPr="00F32D70" w:rsidRDefault="002D3C01" w:rsidP="002D3C01">
        <w:pPr>
            <w:tabs>
                <w:tab w:val="left" w:pos="465"/>
            </w:tabs>
            <w:jc w:val="center"/>
            <w:rPr>
                <w:rFonts w:ascii="Verdana" w:hAnsi="Verdana"/>
                <w:sz w:val="56"/>
                <w:szCs w:val="56"/>
            </w:rPr>
        </w:pPr>
        <w:r w:rsidRPr="00F4514F">
         <w:rPr>
            <w:rStyle w:val="TtuloCar"/>
         </w:rPr>
         <w:t>COM MARCAR DOCUMENTS AMB DOCBOOK</w:t>
        </w:r>
    </w:p>
    
    Aplicarem tota la logica d'etiquetatge basada en estils
    -->

    <xsl:template match="w:p">

        <xsl:choose>
            <!-- paragraf amb estils, tractament especial -->
            <xsl:when test="w:pPr/w:pStyle">

                <xsl:for-each select="w:pPr">

                    <xsl:variable name="estil-associat" select="w:pStyle/@w:val"/>

                    <!-- Logica d'estils: busquem el estil al que pertany w:name (nom internacional) style.xml-->
                    <xsl:variable name="element-type">
                        <xsl:call-template name="get-style">
                            <xsl:with-param name="estil-associat" select="$estil-associat"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <!-- te algun etag associat a l'estil? -->
                    <xsl:variable name="element-name">
                        <xsl:call-template name="template-tag">
                            <xsl:with-param name="element-type" select="$element-type"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <!-- Crea etiqueta -->
                    <xsl:comment><xsl:value-of select="concat($element-name,' ',$element-type)"></xsl:value-of></xsl:comment>
                    <xsl:call-template name="logica-tags">
                        <xsl:with-param name="element-name" select="$element-name"/>
                        <xsl:with-param name="element-type" select="$element-type"/>
                    </xsl:call-template>


                </xsl:for-each>
            </xsl:when>
            <xsl:when test="w:pPr/w:numPr">
                <listitem><para role="{w:pPr/w:rPr/w:sz/@w:val}">
                    <xsl:apply-templates/>
                </para></listitem>
            </xsl:when>
            <xsl:otherwise>
                <!-- No te estil, es un paragraf normal, hi posem la mida de la font -->
                <para role="{w:pPr/w:rPr/w:sz/@w:val}">
                    <xsl:apply-templates/>
                </para>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--
    Logica per la creacio d'etiquetes.
    -->
    <xsl:template name="logica-tags">
        <xsl:param name="element-name"/>
        <xsl:param name="element-type"/>

        <xsl:choose>
            <xsl:when
                test="$element-name='authorgroup' or $element-name='legalnotice' or $element-name='title'">
                <metadata>
                    <xsl:element name="{$element-name}">
                        <xsl:apply-templates select="parent::w:p/*"/>
                    </xsl:element>
                </metadata>
            </xsl:when>
            <xsl:when test="normalize-space($element-name)">
                <xsl:element name="{$element-name}">
                    <xsl:apply-templates select="parent::w:p/*"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$element-name"/>
                <para>
                    <xsl:attribute name="role">
                        <xsl:value-of select="$element-type"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="parent::w:p/*"/>
                </para>

            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- 
        Obtenim el nom de l'estil de la pagina d'estils, es el tag 
    -->
    <xsl:template name="get-style">
        <xsl:param name="estil-associat"/>

        <xsl:variable name="document-estils" select="concat($path.unzip.word,'/word/styles.xml')"/>

        <xsl:variable name="estil-trobat">
            <xsl:if test="doc-available($document-estils)">
                <xsl:for-each
                    select="document($document-estils)//w:style[@w:styleId=$estil-associat]">
                    <xsl:value-of select="w:name/@w:val"/>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
        
        <xsl:value-of select="if (normalize-space($estil-trobat)) then normalize-space($estil-trobat) else $estil-associat"/>

    </xsl:template>

    <!-- 
        Obtenim el nom de la  plantilla, si no en te ho posem com a parafgraf 
    -->
    <xsl:template name="template-tag">
        <xsl:param name="element-type"/>

        <!-- Amb l'estil mirem a les plantilles si s'ha de marcar d'alguna manera especial -->
        <xsl:variable name="document-templates" select="$template.estils"/>
        <xsl:if test="doc-available($document-templates)">
            <xsl:for-each
                select="document($document-templates)/t:template/t:style[@word=$element-type]">
                <xsl:value-of select="@tag"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
