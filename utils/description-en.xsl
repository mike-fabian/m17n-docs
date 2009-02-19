<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:mdb="http://www.m17n.org/mdb"
		xmlns:mim="http://www.m17n.org/MIM">
 <xsl:output method="text" omit-xml-declaration="yes" version="4.0"/>
 <xsl:strip-space elements="*"/>

<xsl:template match="/">
<xsl:text>/*** </xsl:text>
<xsl:if test="mdb:database/mdb:doxygen/mdb:page">
<xsl:text>@page </xsl:text>
<xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/@id"/>
<xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/mdb:brief"/>
<xsl:value-of select="mdb:database/mdb:doxygen/mdb:page/text()"/>
&lt;ul&gt;
<xsl:for-each select="mdb:database/mdb:doxygen/mdb:page/mdb:section">
      &lt;li&gt;<xsl:text>@ref </xsl:text><xsl:value-of select="attribute::id"/><xsl:text>-list </xsl:text>&lt;/li&gt; </xsl:for-each>
&lt;/ul&gt;

<xsl:for-each select="mdb:database/mdb:doxygen/mdb:page/mdb:section">
  <xsl:variable name="sectionname" select="attribute::id"/>
<xsl:text>@section </xsl:text> <xsl:value-of select="$sectionname"/>-list <xsl:value-of select="mdb:brief"/>
<xsl:value-of select="text()"/>
 &lt;ul&gt;  
    <xsl:for-each select="//mdb:item">
      <xsl:if test="attribute::sectionid=$sectionname">
	<xsl:for-each select="mdb:source/mdb:filename">
	  <xsl:choose>
	    <xsl:when test="ancestor::mdb:item/attribute::sectionid='mim'">
&lt;li&gt;<xsl:value-of select="."/><xsl:text> (langauge:</xsl:text>
   <xsl:value-of select="following-sibling::mim:input-method[1]/mim:tags/mim:language"/>
   <xsl:text> name:</xsl:text>
   <xsl:value-of select="following-sibling::mim:input-method[1]/mim:tags/mim:name"/>
   <xsl:text>@htmlonly title:</xsl:text>
   <xsl:value-of select="following-sibling::mim:input-method[1]/mim:title"/>
   <xsl:text> icon:&lt;img src="</xsl:text>
   <xsl:value-of select="substring-before(., '.mimx')"/><xsl:text>.png" border="1" style="vertical-align:middle;"&gt; @endhtmlonly)@verbatim</xsl:text>
   <xsl:value-of select="following-sibling::mim:input-method[1]/mim:description"/>
   <xsl:text> @endverbatim</xsl:text>
&lt;/li&gt;
	    </xsl:when>
	    <xsl:otherwise>
&lt;li&gt;   <xsl:value-of select="."/><xsl:text></xsl:text>
   <xsl:value-of select="parent::mdb:source/parent::mdb:item/mdb:description"/>
&lt;/li&gt;
	      </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </xsl:if>
    </xsl:for-each>
    &lt;/ul&gt;
  </xsl:for-each>

</xsl:if>
<xsl:text>*/ </xsl:text>

</xsl:template>
</xsl:stylesheet>


