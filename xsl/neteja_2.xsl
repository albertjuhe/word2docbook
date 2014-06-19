<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://docbook.org/ns/docbook"
	xmlns:pref="http://www.w3.org/2002/Math/preference"
	xpath-default-namespace="http://docbook.org/ns/docbook" exclude-result-prefixes="#all">

	<!--
		epub to
		docbook 
		
	-->

	<xsl:output indent="yes" omit-xml-declaration="no" standalone="yes" media-type="xml"/>


	<xsl:template match="book">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
<!--
	<xsl:template match="para">
		<xsl:choose>
			<xsl:when test="number(.)">
			</xsl:when>
			<xsl:when test="child::literallayout and child::subscript">
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
-->
	<xsl:template match="sect1/para | sect2/para | sect3/para | sect4/para">
		<xsl:choose>
			<xsl:when test="following-sibling::para[1] and not(ends-with(.,'.'))">
				<xsl:comment>FUSIO PARA</xsl:comment>
				<xsl:copy>
					<xsl:apply-templates/>
					<xsl:apply-templates select="following-sibling::para[1]"/>
				</xsl:copy>
			</xsl:when>
			<!--
			<xsl:when test="not(ends-with(preceding-sibling::para,'.'))">
				<xsl:comment>FUSIO PARA</xsl:comment>
				<xsl:copy>
					<xsl:apply-templates/>
					<xsl:apply-templates select="following-sibling::para[1]"/>
				</xsl:copy>
			</xsl:when>
			-->
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
