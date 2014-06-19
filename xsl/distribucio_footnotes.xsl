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

	<xsl:template match="sect1 | sect2 | sect3 | sect4">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
			<para>
				<xsl:for-each select="para/footnote">
					<xsl:copy>
						<xsl:copy-of select="@*"/>
						<xsl:apply-templates/>
					</xsl:copy>
				</xsl:for-each>
			</para>

		</xsl:copy>
	</xsl:template>

	<xsl:template match="para">
		<xsl:choose>
			<xsl:when test="footnote"/>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates/>
				</xsl:copy>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="footnote"/>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
