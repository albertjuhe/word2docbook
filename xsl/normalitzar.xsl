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

	<xsl:template match="authorgroup">
		<xsl:choose>
			<xsl:when test="count(child::*) &gt; 0">
				<xsl:copy>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
<!--
	<xsl:template match="preface">
		<preface>
			<title>preliminars</title>
			<xsl:apply-templates
				select="* except (info|sect1[title='Glossari' or title='Glosario'] | sect1[title='Bibliografia' or normalize-space(title)='Bibliografía'])"/>
			<xsl:apply-templates select="sect1[title='Glossari' or title='Glosario']"/>
			<xsl:apply-templates
				select="sect1[title='Bibliografia' or normalize-space(title)='Bibliografía']"/>
		</preface>
	</xsl:template>
-->
	<xsl:template match="chapter">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="concat('m',count(preceding-sibling::chapter))"/>
			</xsl:attribute>
			<xsl:apply-templates select="info"/>
			<xsl:copy-of select="para"/>
			<xsl:apply-templates
				select="* except (para | info | sect1[title='Glossari' or title='Glosario']|sect1[title='Bibliografia' or normalize-space(title)='Bibliografía'])"/>
			<xsl:apply-templates select="sect1[title='Glossari' or title='Glosario']"/>
			<xsl:apply-templates
				select="sect1[title='Bibliografia' or normalize-space(title)='Bibliografía']"/>
		</xsl:copy>


	</xsl:template>

	<xsl:template match="sect1[title='Objectius'] | sect1[title='Objetivos']">
		<sect1 label="objectives">
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(title)">
				<title role="temporal-title">objectius</title>
			</xsl:if>
			<xsl:call-template name="listitem-control"/>
		</sect1>
	</xsl:template>

	<xsl:template match="sect1[title='Objectius']/title | sect1[title='Objetivos']/title"/>

	<xsl:template match="sect1[title='Introducció']/title | sect1[title='Introducción']/title"/>

	<xsl:template match="sect1[title='Introducció'] | sect1[title='Introducción']">
		<sect1 label="preface">
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(title)">
				<title role="temporal-title">introducció</title>
			</xsl:if>
			<xsl:call-template name="listitem-control"/>
		</sect1>
	</xsl:template>

	<xsl:template match="sect1[title='Bibliografia' or normalize-space(title)='Bibliografía']">
		<bibliography>
			<bibliodiv>
				<xsl:copy-of select="@*"/>
				<title role="temporal-title">bibliography</title>
				<xsl:apply-templates select="* except title" mode="bibliografia"/>
			</bibliodiv>
		</bibliography>
	</xsl:template>

	<xsl:template match="para" mode="bibliografia">
		<biblioentry>
			<phrase>
				<xsl:apply-templates/>
			</phrase>
		</biblioentry>
	</xsl:template>

	<xsl:template match="sect1[title='Glossari' or title='Glosario']">
		<glossary>
			<xsl:copy-of select="@*"/>
			<xsl:call-template name="listitem-control"/>
		</glossary>
	</xsl:template>

	<xsl:template match="sect1[title='Annexos']">
		<sect1 label="annex">

			<xsl:copy-of select="@*"/>
			<xsl:if test="not(title)">
				<title role="temporal-title">Annex</title>
			</xsl:if>
			<xsl:call-template name="listitem-control"/>
		</sect1>
	</xsl:template>

	<xsl:template match="sect1[title='Índex' or title='Índice']"/>

	<xsl:template match="sect1[title='Resum'or title='Resumen']"/>

	<xsl:template match="info">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
			<xsl:for-each select="ancestor::chapter/sect1[title='Resum' or title='Resumen']">
				<abstract>
					<xsl:apply-templates select="* except title"/>
				</abstract>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="important | blockquote">
		<xsl:copy>
			<xsl:attribute name="xml:id" select="generate-id()"/>
			<para>
				<xsl:apply-templates/>
			</para>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="para">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="chapter/para | chapter/title"/>


	<xsl:template match="bibliorelation">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:value-of select="replace(ancestor::chapter/para[@role='code'],'/','_')"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="biblioid">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:value-of select="replace(ancestor::chapter/para[@role='code'],'/','_')"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="imagedata">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="fileref">
				<xsl:value-of select="substring-after(@fileref,'/')"/>
			</xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="sect1 | sect2 | sect3 | sect4">
		<xsl:copy>
			<xsl:call-template name="listitem-control"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="listitem-control">
		<xsl:for-each-group select="*" group-starting-with="title">
			<xsl:copy-of select="."/>
			<xsl:for-each-group select="current-group() except ."
				group-adjacent="boolean(self::listitem)">
				<xsl:choose>
					<xsl:when test="current-grouping-key()">
						<itemizedlist>
							<xsl:apply-templates select="current-group()"/>
						</itemizedlist>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="current-group()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>

		</xsl:for-each-group>
	</xsl:template>

	<xsl:template match="listitem">
		<listitem>
			<para>
				<xsl:apply-templates/>
			</para>
		</listitem>
	</xsl:template>

	<xsl:template match="footnote">
		<para>
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<para>
					<xsl:apply-templates/>
				</para>
			</xsl:copy>
		</para>

	</xsl:template>

	<xsl:template match="*" mode="#all">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
