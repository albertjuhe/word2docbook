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
	
	<xsl:template match="sect1 | sect2 | sect3 | sect4 ">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:choose>
				<xsl:when test="blockquote">
					<xsl:for-each-group select="*" group-adjacent="boolean(self::blockquote)">
						<xsl:choose>
							<xsl:when test="current-grouping-key()">
								<blockquote>
									<xsl:if test="@role">
										<xsl:copy-of select="@role"/>
									</xsl:if>
									<xsl:apply-templates select="current-group()/node()"/>
									<xsl:text> </xsl:text>
								</blockquote>
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
