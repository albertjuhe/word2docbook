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

	<xsl:template match="content">
		<xsl:copy>
			<xsl:for-each-group select="para" group-adjacent="@role">
				<para role="{@role}">
					<xsl:for-each select="current-group()">
						<xsl:choose>
							<xsl:when test="starts-with(.,'• ')">
								<li><xsl:apply-templates/></li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates/><xsl:text> </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						
					</xsl:for-each>
				</para>
			</xsl:for-each-group>
		</xsl:copy>
	</xsl:template>



	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
