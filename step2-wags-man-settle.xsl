<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <all_tags>
<!--    	
		<footerField1><xsl:value-of select="all_tags/footerField1"/></footerField1>
		<footerField2><xsl:value-of select="all_tags/footerField2"/></footerField2>
		<footerCopyrightYear><xsl:value-of select="all_tags/footerCopyrightYear"/></footerCopyrightYear>
		<tableCountTable1><xsl:value-of select="all_tags/tableCountTable1"/></tableCountTable1>
		<tableCountTable2><xsl:value-of select="all_tags/tableCountTable2"/></tableCountTable2>
		<tableCountTable3><xsl:value-of select="all_tags/tableCountTable3"/></tableCountTable3>    	
-->    	
    	
<!--
      <xsl:for-each select="//uniqueHrsaId">
      <xsl:for-each select="//uniqueCoveredEntity">
-->
      <xsl:for-each select="//coveredEntity">
      	<xsl:sort data-type="number" order="ascending" select="//tag[CoveredEntity=current()]/Seq"/>
<!--
      	<xsl:sort data-type="number" order="ascending" select="//tag[CoveredEntity=current()]/Seq"/>
      	<xsl:sort data-type="number" order="ascending" select="//tag[HRSA-ID=current()]/Seq"/>
-->      	

<!--
      	<xsl:variable name="tmpHrsaId" select="."/>      	
-->


      	<xsl:variable name="tmpEntity" select="."/>      	
    	
<!--
        <uniqueHrsaId hrsa_id="{$tmpHrsaId}" count="{count(//tag[HRSA-ID=$tmpHrsaId])}">
        <coveredentity entity="{$tmpEntity}" count="{count(//tag[CoveredEntity=$tmpEntity])}">
-->
        <coveredEntity entity="{$tmpEntity}" count="{count(//tag[CoveredEntity=$tmpEntity])}">
      	<xsl:for-each select="//tag[CoveredEntity=$tmpEntity]">        	
<!--
      	<xsl:for-each select="//tag[HRSA-ID=$tmpHrsaId]">        	
      	<xsl:for-each select="//tag[CoveredEntity=$tmpEntity]">        	
-->
	<tag>
		<CoveredEntity><xsl:value-of select="CoveredEntity"/></CoveredEntity>
		<HRSA-ID><xsl:value-of select="HRSA-ID"/></HRSA-ID>
		<NDC><xsl:value-of select="NDC"/></NDC>
		<ProductDescription><xsl:value-of select="ProductDescription"/></ProductDescription>
		<LabelCode><xsl:value-of select="LabelCode"/></LabelCode>
		<ManufacturerName><xsl:value-of select="ManufacturerName"/></ManufacturerName>
		<Quantity><xsl:value-of select="Quantity"/></Quantity>
		<Wholesaler><xsl:value-of select="Wholesaler"/></Wholesaler>
		<DateRange><xsl:value-of select="DateRange"/></DateRange>
		<URL><xsl:value-of select="URL"/></URL>
		<Manufacturer><xsl:value-of select="Manufacturer"/></Manufacturer>
		<ContactName><xsl:value-of select="ContactName"/></ContactName>
		<ContactNumber><xsl:value-of select="ContactNumber"/></ContactNumber>
		<LetterDate><xsl:value-of select="LetterDate"/></LetterDate>
		<Seq><xsl:value-of select="Seq"/></Seq>		
	</tag>
      </xsl:for-each>

        </coveredEntity>
<!--
        </coveredentity>
        </uniqueHrsaId>
-->

      </xsl:for-each>
    </all_tags>
  </xsl:template>
</xsl:stylesheet>
