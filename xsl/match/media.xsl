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

    <!-- Marquem les imatges 
      Exemple imatge
   
    <w:drawing>
        <wp:inline distT="0" distB="0" distL="0" distR="0">
            <wp:extent cx="4114800" cy="2235200"/>
            <wp:effectExtent l="0" t="0" r="0" b="0"/>
            <wp:docPr id="4272" name="Imagen 28"/>
            <wp:cNvGraphicFramePr>
                <a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
                    noChangeAspect="1"/>
            </wp:cNvGraphicFramePr>
            <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
                <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                    <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                        <pic:nvPicPr>
                            <pic:cNvPr id="0" name="Picture 28"/>
                            <pic:cNvPicPr>
                                <a:picLocks noChangeAspect="1" noChangeArrowheads="1"/>
                            </pic:cNvPicPr>
                        </pic:nvPicPr>
                        <pic:blipFill>
                            <a:blip r:embed="rId49">
                                <a:extLst>
                                    <a:ext uri="{28A0092B-C50C-407E-A947-70E740481C1C}">
                                        <a14:useLocalDpi
                                            xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main"
                                            val="0"/>
                                    </a:ext>
                                </a:extLst>
                            </a:blip>
                            <a:srcRect/>
                            <a:stretch>
                                <a:fillRect/>
                            </a:stretch>
                        </pic:blipFill>
                        <pic:spPr bwMode="auto">
                            <a:xfrm>
                                <a:off x="0" y="0"/>
                                <a:ext cx="4114800" cy="2235200"/>
                            </a:xfrm>
                            <a:prstGeom prst="rect">
                                <a:avLst/>
                            </a:prstGeom>
                            <a:noFill/>
                            <a:ln>
                                <a:noFill/>
                            </a:ln>
                        </pic:spPr>
                    </pic:pic>
                </a:graphicData>
            </a:graphic>
        </wp:inline>
    </w:drawing>
    -->

    <xsl:template match="w:drawing">

        <xsl:variable name="get-id-image"
            select="wp:inline/a:graphic/a:graphicData/pic:pic/pic:blipFill/a:blip/@r:embed | wp:anchor/a:graphic/a:graphicData/pic:pic/pic:blipFill/a:blip/@r:embed"/>
        <!-- Hem d'anar a buscar quina imatge es en el fitxer _rels/document.xml.rels -->
        <xsl:variable name="document-imatges"
            select="concat($path.unzip.word,'/word/_rels/document.xml.rels')"/>
        <xsl:variable name="image-document">
            <xsl:if test="doc-available($document-imatges)">
                <xsl:value-of
                    select="document($document-imatges)//relation:Relationship[@Id=$get-id-image]/@Target"
                />
            </xsl:if>
        </xsl:variable>
        <xsl:if test="normalize-space($image-document)">

            <!-- imatges docbook -->
            <!-- pot ser inline o crear un salt -->
            <xsl:variable name="image-position">
                <xsl:choose>
                    <xsl:when test="parent::w:r">inlinemediaobject</xsl:when>
                    <xsl:otherwise>mediaobject</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:element name="{$image-position}">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <imageobject>
                    <imagedata fileref="{$image-document}" format="img"/>
                </imageobject>
            </xsl:element>
        </xsl:if>

    </xsl:template>


</xsl:stylesheet>
