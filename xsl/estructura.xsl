<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns="http://docbook.org/ns/docbook" 
	xpath-default-namespace="http://docbook.org/ns/docbook" 
	exclude-result-prefixes="#all">
	
	<!--
		epub to
		docbook 
		
	-->
	<xsl:param name="codi"/>
	<xsl:param name="titol"/>
	
	<xsl:key name="ptr-down" match="sect1" use="generate-id(preceding-sibling::chapter[1])"/>
	<xsl:key name="ptr-down" match="sect2" use="generate-id(preceding-sibling::sect1[1][not(@role)])"/>
	<xsl:key name="ptr-down" match="sect3" use="generate-id(preceding-sibling::sect2[1][not(@role)])"/>
	<xsl:key name="ptr-down" match="sect4" use="generate-id(preceding-sibling::sect3[1][not(@role)])"/>
	<xsl:key name="ptr-down" match="sect5" use="generate-id(preceding-sibling::sect4[1][not(@role)])"/>
	
	<xsl:key name="content"	match="node()[not(self::chapter or self::sect1 or self::sect2 or self::sect3 or self::sect4 or self::sect5)]" use="generate-id((parent::content | preceding-sibling::*[self::chapter or self::sect1 or self::sect2 or self::sect3 or self::sect4 or self::sect5][1])[last()])"/>
	
	<xsl:output indent="no" omit-xml-declaration="no" standalone="yes" media-type="xml"/>
	
	
	
	<xsl:template match="book">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<info>
				<xsl:for-each select="info | content/info">
					<xsl:apply-templates mode="copyall"/>
				</xsl:for-each>
			</info>
			<xsl:choose>
				<xsl:when test="//chapter">
					<xsl:apply-templates/>
				</xsl:when>
				<xsl:otherwise>
					<chapter>						
						<xsl:apply-templates mode="copyall"/>
					</chapter>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:copy>
	</xsl:template>
	

	
	<xsl:template match="*" mode="copyall">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="copyall"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="content">
			<xsl:copy-of select="key('content', generate-id(.))"/>
			<xsl:apply-templates select="chapter"/>
	</xsl:template>
	
	
	<xsl:template match="sect1|sect2|sect3|sect4|sect5">
		<xsl:copy>
			<title><xsl:value-of select="normalize-space(.)"/></title>
			<xsl:copy-of select="key('content', generate-id(.))"/>
			<xsl:apply-templates select="key('ptr-down',generate-id(.))"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="chapter">
		<xsl:copy>
			<title><xsl:value-of select="."/></title>
			<info>
				<title><xsl:value-of select="."/></title>
				<revhistory>
					<revision>
						<date><xsl:value-of select="current-dateTime()"/></date>
						<authorinitials>Company</authorinitials>
						<revremark>XML to docbook Conversion</revremark>
					</revision>
				</revhistory>
				<publisher role="organization">
					<publishername>Company</publishername>
				</publisher>
				<publisher>
					<publishername>Company</publishername>
					<address>Adress</address>
				</publisher>
				<pubdate><xsl:value-of select="current-date()"/></pubdate>
				<edition>1</edition>
				<authorgroup>
					
				</authorgroup>
				<legalnotice>
					<para>Company</para>
				</legalnotice>
				<biblioid class="isbn"><xsl:value-of select="$codi"/></biblioid>
				<biblioid class="other" otherclass="dl"><xsl:value-of select="$codi"/></biblioid>
				<biblioid class="other" otherclass="UOCXML"><xsl:value-of select="$codi"/></biblioid>
				<bibliorelation class="other" otherclass="UOCWEB" type="hasformat"><xsl:value-of select="$codi"/></bibliorelation>
				<bibliorelation class="other" otherclass="UOCPDF" type="hasformat"><xsl:value-of select="$codi"/></bibliorelation>
			</info>
			<xsl:copy-of select="preceding-sibling::sect1[1]"/>		
			<xsl:copy-of select="key('content', generate-id(.))"/>
			<xsl:apply-templates select="key('ptr-down',generate-id(.))"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="info | content/info"/>
	
	<xsl:template match="content" mode="copyall">
		<xsl:apply-templates mode="copyall"/>
	</xsl:template>
	
</xsl:stylesheet>
