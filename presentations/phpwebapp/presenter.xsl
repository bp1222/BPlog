<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2001/XInclude">
<xsl:output method="html" indent="yes"/>
<!-- xsl:strip-space elements="*" /-->

<xsl:template match="text()">
	<xsl:value-of select="normalize-space(.)" />
</xsl:template>

<xsl:template match="/slideshow">
	<html>
		<head>
			<xsl:apply-templates select="title" />
			<link rel="stylesheet" type="text/css" media="print" href="printview.css"/>
			<link rel="stylesheet" type="text/css" media="screen,projection" href="presenter.css"/>
			<script>
				<xsl:call-template name="generate-slidelist" />
			</script>
			<script src="js/jquery.js"/>
			<script src="js/presenter.js"/>
		</head>
		<body>
			<!-- Table of Contents pane -->
			<div id="slidelist-panel" style="display:none">
				<xsl:call-template name="generate-slidelist-table" />
			</div>
			<div id="slidelist-expander"></div>

			<div id="slide-container">
				<div id="progress" />
				<xsl:apply-templates select="slide" />
			</div>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript"> </script>
<script type="text/javascript">
_uacct = "UA-75959-6";
urchinTracker();
</script>

		</body>
	</html>
</xsl:template>

<!-- Copy the tree downward, we'll apply specific templates as necessary -->
<xsl:template match="/slideshow/slide/body//*[name() != 'code']">
   <xsl:copy>
      <xsl:for-each select="@*">
         <xsl:variable name="key" select="name()" />
         <xsl:attribute name="{$key}">
            <xsl:value-of select="normalize-space(.)" />
         </xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates />
   </xsl:copy>
</xsl:template>

<!-- Keep text as-is -->
<xsl:template match="/slideshow/slide/body//text()">
	<xsl:value-of select="." />
</xsl:template>

<!-- Special tag 'code' -->
<xsl:template match="/slideshow/slide/body//code">
	<pre class="code">
		<xsl:apply-templates />
	</pre>
</xsl:template>

<xsl:template match="/slideshow/title">
	<title><xsl:value-of select="." /></title>
</xsl:template>

<xsl:template match="slide">
<!--
	<xsl:variable name="slideid" select="generate-id(.)" />
	<xsl:variable name="nextslide" select="generate-id(following-sibling::*[1])" />
-->
	<xsl:variable name="slideid" select="position() - 1" />
	<xsl:variable name="visibility">
		<xsl:choose>
			<xsl:when test="count(preceding-sibling::slide) > 0">display: none;</xsl:when>
			<xsl:otherwise>display: block;</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="class">
		<xsl:choose>
			<xsl:when test="title">slide</xsl:when>
			<xsl:otherwise>slide_notitle</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div id="slide_{$slideid}" class="{$class}" style="{$visibility}">
		<!-- 
		Somehow apply this slide over whatever theme is selected 
		for this particular slide.
		XXX: Figure out some sort of theme coolness, perhaps
		     xinclude will be useful here?
		-->
		<div class="slide_content">
			<a name="slide_{$slideid}" />
			<xsl:if test="title">
				<h1 class="slide-title">
					<xsl:value-of select="title" />
				</h1>
			</xsl:if>
			<div class="slide-body">
			<xsl:apply-templates select="body"/>
			</div>
		</div>
	</div>
</xsl:template>

<!-- Generate the javascript containing the slides array definition -->
<xsl:template name="generate-slidelist">
	<xsl:text>var slides = new Array();</xsl:text>
	<xsl:for-each select="/slideshow/slide">
		slides.push("slide_<xsl:value-of select="position() - 1"/>");
	</xsl:for-each>
</xsl:template>

<!-- Generate the table of contents -->
<xsl:template name="generate-slidelist-table">
	<ul class="table-of-contents">
	<xsl:for-each select="/slideshow/slide">
		<li id="toc_slide_{position()-1}" onclick="showslide('slide_{position() - 1}'); return false"><xsl:value-of select="title" /></li>
	</xsl:for-each>
	</ul>
</xsl:template>


</xsl:stylesheet>
