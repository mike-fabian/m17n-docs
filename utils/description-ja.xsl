<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:mdb="http://www.m17n.org/mdb"
		xmlns:mim="http://www.m17n.org/MIM">
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>
  <xsl:strip-space elements="*"/>

<xsl:template match="/">
  <xsl:text>/*** </xsl:text>
  <xsl:if test="mdb:database/mdb:doxygen/mdb:page">
    <xsl:text>@page </xsl:text>
    <xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/@id"/><xsl:text> </xsl:text>
    <xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/mdb:brief"/>
    <xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/text()"/>
    <xsl:text> </xsl:text>
    <ul>
    <xsl:for-each select="mdb:database/mdb:doxygen/mdb:page/mdb:section">
      <li><xsl:text>@ref </xsl:text><xsl:value-of select="attribute::id"/><xsl:text>-list </xsl:text></li>
      <xsl:text></xsl:text>
    </xsl:for-each>
    </ul>

  <xsl:for-each select="mdb:database/mdb:doxygen/mdb:page/mdb:section">
    <xsl:variable name="sectionname" select="attribute::id"/>
@section <xsl:value-of select="$sectionname"/>-list <xsl:value-of select="mdb:brief"/>
    <xsl:value-of select="text()"/>
     <xsl:text></xsl:text>
    <ul>
    <xsl:for-each select="//mdb:item">
      <xsl:if test="attribute::sectionid=$sectionname">
	<xsl:for-each select="mdb:source/mdb:filename">
	  <xsl:choose>
	    <xsl:when test="ancestor::mdb:item/attribute::sectionid='mim'">
	      <li><xsl:value-of select="."/><xsl:text> (langauge:</xsl:text>
	          <xsl:value-of select="following-sibling::mim:input-method[1]/mim:tags/mim:language"/>
		  <xsl:text> name:</xsl:text>
		  <xsl:value-of select="following-sibling::mim:input-method[1]/mim:tags/mim:name"/>
		  <xsl:text>)@verbatim</xsl:text>
		  <xsl:value-of select="following-sibling::mim:input-method[1]/mim:description"/>
		  <xsl:value-of select="following-sibling::mim:input-method[1]/comment()"/>
		  <xsl:text> @endverbatim</xsl:text>
	      </li>
	    </xsl:when>
	    <xsl:otherwise>
	      <li><xsl:value-of select="."/><xsl:text></xsl:text>
		<xsl:value-of select="parent::mdb:source/parent::mdb:item/mdb:description"/>
	      </li>
	      </xsl:otherwise>
	  </xsl:choose>
	<xsl:text></xsl:text>
	</xsl:for-each>
      </xsl:if>
    </xsl:for-each>
    </ul>
  </xsl:for-each>

</xsl:if>
<xsl:text>*/ </xsl:text>

</xsl:template>

</xsl:stylesheet>


