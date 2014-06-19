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

	<xsl:strip-space elements="*"/>

	<xsl:template match="book">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="sect1/title | sect2/title | sect3/title | sect4/title">
		<xsl:copy>
			<xsl:value-of select="normalize-space(replace(., &quot;\d*\.\d*\.*&quot;,&quot;&quot;))"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:value-of select="replace(., &quot;- &quot;,&quot;&quot;)"/>
	</xsl:template>
	
	<!--xsl:template match="para[@role=18]"/-->

	<xsl:template match="sect1">

		<xsl:if test="count(child::*) &gt; 0">
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<xsl:apply-templates/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="para">
		<xsl:choose>
			<xsl:when test="parent::para">
				<xsl:apply-templates/>
				<literallayout role="linebreak"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:copy-of select="@*"/>
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
