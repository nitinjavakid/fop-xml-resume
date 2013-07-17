<?xml version="1.0" ?>
<!DOCTYPE root SYSTEM "/media/Data_Disk/schemas/fo.dtd" >
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:dt="http://exslt.org/dates-and-times"
		extension-element-prefixes="dt">
  <xsl:output method="xml" />

<!-- 
Configuration values
-->
  <xsl:variable name="titlesize" select="'18pt'" />
  <xsl:variable name="addresssize" select="'12pt'" />
  <xsl:variable name="subheadsize" select="'11pt'" />
  <xsl:variable name="textsize" select="'10pt'" />

  <xsl:template match="/resume">
    <fo:root>
      <fo:layout-master-set>
	<fo:simple-page-master margin="25mm 25mm 25mm 25mm" master-name="page" page-width="210mm" page-height="297mm">
	  <fo:region-body region-name="xsl-region-body" margin="15mm 0mm 0mm 0mm"/>
	  <fo:region-before region-name="xsl-header" />
	  <fo:region-after region-name="xsl-footer" />
	</fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence initial-page-number="1" master-reference="page">
	<fo:title>Resume of <xsl:value-of select="firstname" /><xsl:text> </xsl:text><xsl:value-of select="lastname" /></fo:title>
	<fo:static-content flow-name="xsl-header">
	  <fo:block  border-bottom="solid" border-bottom-width="1pt" >
	    <fo:table table-layout="fixed">
	      <fo:table-body>
		<fo:table-row>
		  <fo:table-cell width="4cm">
		    <fo:block font-size="{$titlesize}" font-weight="bold">
	              <xsl:value-of select="firstname" />
		      <xsl:text> </xsl:text>
	              <xsl:value-of select="lastname" />
		    </fo:block>
		  </fo:table-cell>
		  <fo:table-cell font-size="{$addresssize}">
		    <fo:block text-align="right">
	              <xsl:value-of select="address" />
	            </fo:block>
	            <fo:block text-align="right">
	              <xsl:value-of select="phone" />  <xsl:text> (</xsl:text>
	              <fo:basic-link external-destination="http://an.andnit.in/"><xsl:value-of select="website" /></fo:basic-link><xsl:text>) </xsl:text>
	              <xsl:value-of select="email" />
	            </fo:block>
		  </fo:table-cell>
		</fo:table-row>
	      </fo:table-body>
	    </fo:table>
	  </fo:block>
	</fo:static-content>
	<fo:static-content flow-name="xsl-footer">
	  <fo:block border-top="solid" border-top-width="1pt" >
	    <fo:table table-layout="fixed">
	      <fo:table-body>
		<fo:table-row font-size="{$addresssize}">
		  <fo:table-cell>
		    <fo:block>
		      Resume of <xsl:value-of select="firstname" />
		      <xsl:text> </xsl:text>
		      <xsl:value-of select="lastname" />
		    </fo:block>
		  </fo:table-cell>
		  <fo:table-cell>
		    <fo:block text-align="center">		      
		      <xsl:value-of select="dt:day-in-month()" /><xsl:text> </xsl:text>
		      <xsl:value-of select="dt:month-abbreviation()" /><xsl:text> </xsl:text>
		      <xsl:value-of select="dt:year()" />
		    </fo:block>
		  </fo:table-cell>
		  <fo:table-cell>
		    <fo:block text-align="right">
		      Page <fo:page-number /> of <fo:page-number-citation ref-id="lastid" />
		    </fo:block>
		  </fo:table-cell>
		</fo:table-row>
	      </fo:table-body>
	    </fo:table>
	  </fo:block>
	</fo:static-content>
	
	<fo:flow flow-name="xsl-region-body">
	  <fo:block font-size="{$textsize}">
	    <fo:table table-layout="fixed">
	      <fo:table-body>
		<xsl:apply-templates />
	      </fo:table-body>
	    </fo:table>
	  </fo:block>
	  <fo:block id="lastid">
	  </fo:block>
	</fo:flow>
	
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="section">
    <fo:table-row>
      <fo:table-cell width="3cm" padding-bottom="10pt">
	<fo:block font-size="{$subheadsize}" font-weight="bold">
	  <xsl:value-of select="title" />
	</fo:block>
      </fo:table-cell>
      <fo:table-cell margin-left="5pt" padding-bottom="10pt">
	<fo:block text-align="justify">
	  <xsl:apply-templates select="description"/>
	</fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>


  <xsl:template match="description">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="technologies">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="hlist">
    <xsl:for-each select="entry">
      <xsl:value-of select="." />
      <xsl:if test="position() != last()">
	<xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="vlist">
    <xsl:for-each select="entry">
      <fo:block>
	<xsl:value-of select="." />
      </fo:block>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="nlist">
    <fo:list-block>
      <xsl:for-each select="entry">
	<fo:list-item>
	  <fo:list-item-label>
	    <fo:block>
	      <xsl:value-of select="position()" /><xsl:text>. </xsl:text>
	    </fo:block>
	  </fo:list-item-label>
	  <fo:list-item-body>
	    <fo:block margin-left="15pt">
	      <xsl:value-of select="." />
	    </fo:block>
	  </fo:list-item-body>
	</fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="hashtable">
    <fo:table table-layout="fixed">
      <fo:table-body>
	<xsl:apply-templates select="hash-entry" />
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="hash-entry">
    <fo:table-row>
      <fo:table-cell width="6cm" margin-left="0pt">
	<fo:block font-weight="bold">
	  <xsl:value-of select="key" /><xsl:text>:</xsl:text>
	</fo:block>
      </fo:table-cell>
      <fo:table-cell margin-left="5pt">
	<fo:block text-align="justify">
	  <xsl:apply-templates select="value" />
	</fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <xsl:template match="value">
    <xsl:value-of select="." />
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="experiences">
    <fo:table table-layout="fixed">
      <fo:table-body>
	<xsl:for-each select="company">
	  <xsl:for-each select="designation">
	    <xsl:sort select="@from" order="descending" />
	    <fo:table-row>
	      <fo:table-cell margin-left="0pt">
		<fo:block>
		  <xsl:value-of select="@name" /><xsl:text>, </xsl:text><xsl:value-of select="../@name" />
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell width="1.7cm">
		<fo:block>
		  <xsl:value-of select="dt:month-abbreviation(@from)" /><xsl:text> </xsl:text><xsl:value-of select="dt:year(@from)" />
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell  width="3cm">
		<fo:block>
		  <xsl:text> to </xsl:text>
		  <xsl:choose>
		    <xsl:when test="@to">
		      <xsl:value-of select="dt:month-abbreviation(@to)" />
		      <xsl:text> </xsl:text><xsl:value-of select="dt:year(@to)" />
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:text>Till date</xsl:text>
		    </xsl:otherwise>
		  </xsl:choose>
		</fo:block>
	      </fo:table-cell>
	    </fo:table-row>
	  </xsl:for-each>
	</xsl:for-each>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="qualifications">
    <fo:table table-layout="fixed">
      <fo:table-body>
	<xsl:for-each select="qualification">
	  <xsl:sort select="@year" order="descending" />
	  <fo:table-row>
	    <fo:table-cell margin-left="0pt">
	      <fo:block>
		<xsl:value-of select="@name" /><xsl:text>, </xsl:text><xsl:value-of select="@school" />
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell width="1cm">
	      <fo:block>
		<xsl:value-of select="@year" />
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell width="4cm">
	      <fo:block>
		(<xsl:value-of select="@comment" />)
	      </fo:block>
	    </fo:table-cell>
	  </fo:table-row>
	</xsl:for-each>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="projects">
    <xsl:for-each select="company">
      <xsl:sort select="@from" order="descending" />
      <fo:table-row>
	<fo:table-cell width="3cm" padding-bottom="10pt">
	  <fo:block font-size="{$subheadsize}" font-weight="bold">
	    <xsl:value-of select="@name" />
	  </fo:block>
	  <fo:block font-size="{$subheadsize}" font-weight="bold">
	    <xsl:value-of select="dt:month-abbreviation(@from)" /><xsl:text> </xsl:text>
	    <xsl:value-of select="dt:year(@from)" />
	    <xsl:text> - </xsl:text>
	    <xsl:choose>
	      <xsl:when test="@to">
		<xsl:value-of select="dt:month-abbreviation(@to)" /><xsl:text> </xsl:text>
		<xsl:value-of select="dt:year(@to)" />
	      </xsl:when>
	      <xsl:otherwise>
		Till date
	      </xsl:otherwise>
	    </xsl:choose>
	  </fo:block>
	</fo:table-cell>
	<fo:table-cell margin-left="5pt" padding-bottom="10pt">
	  <fo:block text-align="justify">
	    <fo:table table-layout="fixed">
	      <fo:table-body>
		<xsl:apply-templates select="project">
		  <xsl:sort select="@from" order="descending" />
		</xsl:apply-templates>
	      </fo:table-body>
	    </fo:table>
	  </fo:block>
	</fo:table-cell>
      </fo:table-row>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="project">
    <fo:table-row font-weight="bold">
      <fo:table-cell  margin-left="0pt">
	<fo:block>
	  <xsl:value-of select="@name" />
	</fo:block>
      </fo:table-cell>
      <fo:table-cell width="4cm">
	<fo:block text-align="right">
	  <xsl:value-of select="dt:month-abbreviation(@from)" />
	  <xsl:text> </xsl:text><xsl:value-of select="dt:year(@from)" />	  
	  <xsl:text> - </xsl:text>
	  <xsl:choose>
	    <xsl:when test="@to">
	      <xsl:value-of select="dt:month-abbreviation(@to)" />
	      <xsl:text> </xsl:text><xsl:value-of select="dt:year(@to)" />
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>Till date</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	</fo:block>
    </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
      <fo:table-cell padding-after="15pt" number-columns-spanned="2"  margin-left="0pt">
	<fo:block>
	  <fo:inline font-weight="bold">Description: </fo:inline><xsl:value-of select="description" />
	</fo:block>
	<fo:block>
	  <fo:inline font-weight="bold">Role: </fo:inline><xsl:value-of select="role" />
	</fo:block>
        <xsl:choose>
	<xsl:when test="technologies">
	<fo:block>
	  <fo:inline font-weight="bold">Technologies used: </fo:inline>
	  <xsl:apply-templates select="technologies" />
	</fo:block>
	</xsl:when>
        </xsl:choose>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <xsl:template match="*">
  </xsl:template>
</xsl:stylesheet>
