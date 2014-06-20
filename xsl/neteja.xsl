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

	<xsl:template match="info/title">
		<xsl:apply-templates select="//metadata/title"/>
	</xsl:template>

	<xsl:template match="info/authorgroup">
		<xsl:copy>
			<xsl:for-each select="//author">
				<author>
					<personname>
						<xsl:value-of select="."/>
					</personname>
					<xsl:if test="following-sibling::*[1][self::personblurb]">
						<personblurb>
							<para>
								<xsl:value-of select="following-sibling::*[1][self::personblurb]"/>
							</para>
							
						</personblurb>
					</xsl:if>
				</author>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="author | personblurb">
	</xsl:template>

	<xsl:template match="para">
		<xsl:choose>
			<xsl:when test="starts-with(.,'©')"/>
			<xsl:when test="contains(.,'.indd') and count(child::*)=0"/>
			<xsl:when test="contains(.,'.qxd') and count(child::*)=0"/>
			<xsl:when test="not(normalize-space()) and count(child::*)=0"/>
			<xsl:when test="@role='52'">
				<subtitle>
					<xsl:value-of select="."/>
				</subtitle>
			</xsl:when>
			<xsl:when test="normalize-space(.)='Introducció' or normalize-space(.)='Introducción'">
				<sect1>Introduccio</sect1>
			</xsl:when>
			<xsl:when test="normalize-space(.)='Objectius' or normalize-space(.)='Objectivos'">
				<sect1>Objectius</sect1>
			</xsl:when>
			<xsl:when test="normalize-space() or count(*) &gt; 0">
				<xsl:copy>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates/>
				</xsl:copy>
			</xsl:when>

			<xsl:otherwise/>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="emphasis">

		<xsl:if test="normalize-space()">
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<xsl:apply-templates/>
			</xsl:copy>
		</xsl:if>


	</xsl:template>

	<!-- 
	Metadata information.
	-->
	<xsl:template match="metadata"/>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
