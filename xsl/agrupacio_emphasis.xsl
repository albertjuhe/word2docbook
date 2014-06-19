<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://docbook.org/ns/docbook"
	xmlns:pref="http://www.w3.org/2002/Math/preference"
	xpath-default-namespace="http://docbook.org/ns/docbook" exclude-result-prefixes="#all">

	<!--
		epub to
		docbook.
		
		This xsl merge adjacent elements with the same emphasis and role.
		
	-->

	<xsl:output indent="yes" omit-xml-declaration="no" standalone="yes" media-type="xml"/>

	<xsl:template match="book">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="para">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:choose>
				<xsl:when test="emphasis">
					<xsl:for-each-group select="* | text()" group-adjacent="boolean(self::emphasis)">
						<xsl:choose>
							<xsl:when test="current-grouping-key()">
								<emphasis>
									<xsl:if test="@role">
										<xsl:copy-of select="@role"/>
									</xsl:if>
									<xsl:apply-templates select="current-group()/text()"/>
									<xsl:text> </xsl:text>
								</emphasis>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()"/>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:for-each-group>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>



	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
