<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg" version="1.0" xmlns:rx="http://www.renderx.com/XSL/Extensions">


	<xsl:param name="monthDay" select="." />
	<xsl:param name="year" select="."/>

	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="cover-page" page-width="8.5in" page-height="11in">
					<fo:region-body margin="0in"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="covered_entity_letter" page-width="8.5in" page-height="11in">
					<fo:region-body margin="1in"/>
          <fo:region-after region-name="covered_entity_footer" extent="0.6in" display-align="before"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="covered_entity_report" page-width="13.41in" page-height="10.37in">
					<fo:region-body margin-left="0.2in" margin-top="0.5in" margin-right="0.2in" margin-bottom="0.6in"/>
          <fo:region-after region-name="ce_report_footer" extent="0.6in" display-align="before"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="manufacturer_contact_report" page-width="11in" page-height="8.5in">
					<fo:region-body margin-left="0.2in" margin-top="0.5in" margin-right="0.2in" margin-bottom="0.6in"/>
          <fo:region-after region-name="manufacturer_contact_footer" extent="0.6in" display-align="before"/>
				</fo:simple-page-master>


			</fo:layout-master-set>

			<xsl:for-each select="//coveredEntity">

				<fo:page-sequence master-reference="cover-page" force-page-count="no-force">
					<fo:flow flow-name="xsl-region-body">

			      <fo:block margin-top="0in">
				      <fo:external-graphic content-height="99%" content-width="99%" src="url('C:\GP\wags-man-settle\images\cover-page.pdf')"/>
				    </fo:block>

					</fo:flow>
				</fo:page-sequence>

				<fo:page-sequence master-reference="covered_entity_letter" force-page-count="no-force">
        	<fo:static-content flow-name="covered_entity_footer">
						<xsl:call-template name="covered_entity_footer"/>
   				</fo:static-content>						
   					
					<fo:flow flow-name="xsl-region-body">
			      <fo:block margin-top="0in">
				      <xsl:call-template name="cover_page_header"/>
				    </fo:block>
			      <fo:block margin-top="0in">
				      <xsl:call-template name="covered_entity_body"/>
				    </fo:block>

					</fo:flow>
				</fo:page-sequence>

				<fo:page-sequence master-reference="covered_entity_report" initial-page-number="1" force-page-count="no-force">
        	<fo:static-content flow-name="ce_report_footer">
						<xsl:call-template name="ce_report_footer"/>
   				</fo:static-content>					

					<fo:flow flow-name="xsl-region-body">
			      <fo:block margin-top="0in">
				      <xsl:call-template name="ce_report_header"/>
				    </fo:block>
			      <fo:block margin-top="0in">
				      <xsl:call-template name="ce_report_body"/>
				    </fo:block>
						<fo:block id="{tag/HRSA-ID}_ce_report"/>
					</fo:flow>
				</fo:page-sequence>				

				<fo:page-sequence master-reference="manufacturer_contact_report" initial-page-number="1" force-page-count="no-force">
        	<fo:static-content flow-name="manufacturer_contact_footer">
						<xsl:call-template name="manufacturer_contact_footer"/>
   				</fo:static-content>					

					<fo:flow flow-name="xsl-region-body">
			      <fo:block margin-top="0in" margin-left="0.3in">
				      <xsl:call-template name="manufacturer_info_header"/>
				    </fo:block>
			      <fo:block margin-top="0in" margin-left="0.3in">
				      <xsl:call-template name="manufacturer_contact_body"/>
				    </fo:block>
						<fo:block id="{tag/HRSA-ID}-manufacturer_contact"/>
					</fo:flow>
				</fo:page-sequence>					
				
				
			</xsl:for-each>



		</fo:root>
	</xsl:template>

	<xsl:template name="ce_report_header">
	    <fo:table font-size="8pt" >
	        <fo:table-column column-width="25%"/>
	        <fo:table-column column-width="8%"/>
	        <fo:table-column column-width="67%"/>
	        <fo:table-body>
	            <fo:table-row>
						    <fo:table-cell>
						        <fo:block margin-top="-0.2in">
						            <fo:external-graphic src="url('C:\GP\wags-man-settle\images\Walgreens_logo_red.jpg')"/>
						        </fo:block>
						    </fo:table-cell>
					      <fo:table-cell>
						        <fo:block>Covered Entity</fo:block>
						        <fo:block>Wholesaler</fo:block>
										<fo:block>Report Date</fo:block>
						    </fo:table-cell>
					      <fo:table-cell>
						        <fo:block><xsl:value-of select="tag/CoveredEntity"/>: <xsl:value-of select="tag/HRSA-ID"/></fo:block>
						        <fo:block><xsl:value-of select="tag/Wholesaler"/></fo:block>
						        <fo:block><xsl:value-of select="tag/DateRange"/></fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	        </fo:table-body>
	    </fo:table>
	</xsl:template>

	<xsl:template name="ce_report_body">
		<xsl:variable name="table-cell-style">0.5pt solid black</xsl:variable>
		<xsl:variable name="header-bg-color">gray</xsl:variable>
		<xsl:variable name="tbl-cell-padding">0.025in</xsl:variable>

	    <fo:table font-size="8pt" margin-top="0.2in">
	        <fo:table-column column-width="2.5in"/>
	        <fo:table-column column-width="0.75in"/>
	        <fo:table-column column-width="0.85in"/>
	        <fo:table-column column-width="3.25in"/>
	        <fo:table-column column-width="0.75in"/>
	        <fo:table-column column-width="3.25in"/>
	        <fo:table-column column-width="1in"/>
	        <fo:table-header>
	            <fo:table-row>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Covered Entity</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>HRSA ID</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>NDC</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Product Description</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Label Code</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Manufacturer Name</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Quantity</fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	        </fo:table-header>

	        <fo:table-body>
	        	<xsl:for-each select="tag">
        			<xsl:sort select="LabelCode"/>
	            <fo:table-row>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="position()"/>-<xsl:value-of select="CoveredEntity"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="HRSA-ID"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="NDC"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="ProductDescription"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="LabelCode"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="ManufacturerName"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block text-align="right">-<xsl:value-of select="Quantity"/></fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	          </xsl:for-each>
	        </fo:table-body>
	    </fo:table>		
	</xsl:template>
	
	<xsl:template name="ce_report_footer">
	    <fo:table font-size="8pt" >
	        <fo:table-column column-width="15%"/>
	        <fo:table-column column-width="70%"/>
	        <fo:table-column column-width="15%"/>
	        <fo:table-body>
	            <fo:table-row>
						    <fo:table-cell display-align="center">
						        <fo:block margin-left="0.5in">Covered Entity Report - <xsl:value-of select="tag/Seq"/></fo:block>
						    </fo:table-cell>
					      <fo:table-cell text-align="center" color="red">
						        <fo:block>Note: This document and the information contained herein are confidential and proprietary to Walgreen Co.</fo:block>
										<fo:block margin-top="0.1in">Do not copy, distribute or disclose without the express written Covered Entity Report consent of Walgreen Co.</fo:block>
						    </fo:table-cell>
					    	<fo:table-cell display-align="center">
<!--						  		<fo:block margin-right="0.5in" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="terminator"/></fo:block> -->
						  		<fo:block margin-right="0.5in" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="{tag/HRSA-ID}_ce_report"/></fo:block>
						   	</fo:table-cell>						    
	            </fo:table-row>
	        </fo:table-body>
	    </fo:table>		
	</xsl:template>
	

	<xsl:template name="cover_page_header">
	    <fo:table font-size="8pt" >
	        <fo:table-column column-width="60%"/>
	        <fo:table-column column-width="40%"/>
	        <fo:table-body>
	            <fo:table-row>
						    <fo:table-cell>
						        <fo:block>
						            <fo:external-graphic src="url('C:\GP\wags-man-settle\images\Walgreens_logo_red.jpg')"/>
						        </fo:block>
						    </fo:table-cell>
					      <fo:table-cell border-left=".5pt solid black" padding-left=".1in" text-align="left">
						        <fo:block>Walgreen Co.</fo:block>
						        <fo:block>Marion Lalich</fo:block>
										<fo:block>Director, 340B Inventory Compliance</fo:block>
										<fo:block>1415 Lake Cook Road, MS-L339</fo:block>
										<fo:block>Deerfield, IL 60015</fo:block>
										<fo:block>&#160;</fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	        </fo:table-body>
	    </fo:table>
	</xsl:template>

	<xsl:template name="covered_entity_body">
		<fo:block font="10pt ArialMT" margin-top="1in">
			<fo:block text-align="right"><xsl:value-of select="tag/LetterDate"/></fo:block>
			<fo:block margin-left="0.2in" margin-top="0.2in">Re: &#160;&#160;&#160; 340B Drug Pricing Program - Reconciliation</fo:block>
			<fo:block margin-top="0.2in">Dear <xsl:value-of select="tag/CoveredEntity"/>,</fo:block>
			<fo:block margin-top="0.2in">Walgreen Co. (“Walgreens”) is writing to confirm that Walgreens has reconciled all credits to your 340B program inventory accumulator that were not depleted by prescription claims as of March 31, 2017.</fo:block>
			<fo:block margin-top="0.2in">By way of background, Walgreens (in its capacity as your 340B program administrator) credits your 340B program inventory accumulator for drug products purchased by you at the 340B price and delivered to a Walgreens pharmacy. Credits that are not depleted by 340B prescription claims are reconciled by Walgreens (in its capacity as your 340B contract pharmacy) via (i) an invoice credit to you in the amount of the 340B drug cost; and (ii) a payment to the applicable manufacturer in the amount of the difference between Walgreens’ acquisition cost and the 340B drug cost. Please note that at the time that payment is made to a manufacturer, Walgreens Enclosures:manufacturer(s) that payment is being made as a result of the reconciliation of 340B drug inventory accumulator credits associated with your 340B program, and provides the manufacturer(s) with information regarding the drug products associated with the reconciled credits.</fo:block>
			<fo:block margin-top="0.2in">The payments outlined above make you and the applicable manufacturer(s) whole with respect to the reconciled drug products, and result in such products being acquired by Walgreens at its acquisition cost.</fo:block>
			<fo:block margin-top="0.2in">Should you have any questions, please feel free to reach out to 340bmfrcontact@walgreens.com.</fo:block>
			
			<fo:block margin-top="0.5in">Sincerely,</fo:block>

      <fo:block margin-top="0.2in">
          <fo:external-graphic src="url('C:\GP\wags-man-settle\images\MarionLalich.jpg')"/>
      </fo:block>

			<fo:block margin-top="0.25in">Marion Lalich</fo:block>

			<fo:block margin-top="0.5in">Enclosures:</fo:block>
			<fo:block margin-left="0.2in">Covered Entity Report</fo:block>
			<fo:block margin-left="0.2in">Manufacturer Contact Information</fo:block>


			
		</fo:block>
	</xsl:template>

	<xsl:template name="covered_entity_footer">
			<fo:block margin-left="0.5in" font-size="8pt"><xsl:value-of select="tag/Seq"/></fo:block>
	</xsl:template>


	<xsl:template name="manufacturer_info_header">
	    <fo:table font-size="12pt">
	        <fo:table-column column-width="50%"/>
	        <fo:table-column column-width="50%"/>
	        <fo:table-body>
	            <fo:table-row>
						    <fo:table-cell>
						        <fo:block>
						            <fo:external-graphic src="url('C:\GP\wags-man-settle\images\Walgreens_logo_red.jpg')"/>
						        </fo:block>
						    </fo:table-cell>
					      <fo:table-cell display-align="center">
						        <fo:block>Manufacturer Contact Information</fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	        </fo:table-body>
	    </fo:table>
	</xsl:template>

	<xsl:template name="manufacturer_contact_body">
		<xsl:variable name="table-cell-style">0.5pt solid black</xsl:variable>
		<xsl:variable name="header-bg-color">gray</xsl:variable>
		<xsl:variable name="tbl-cell-padding">0.025in</xsl:variable>

	    <fo:table font-size="8pt" margin-top="0.2in">
	        <fo:table-column column-width="1in"/>
	        <fo:table-column column-width="4.5in"/>
	        <fo:table-column column-width="3.5in"/>
	        <fo:table-column column-width="1in"/>
	        <fo:table-header>
	            <fo:table-row>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Label Code</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Manufacturer</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Contact Name</fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}" background-color="{$header-bg-color}">
						        <fo:block>Contact Number</fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	        </fo:table-header>

	        <fo:table-body>
<!--
	        	<xsl:for-each select="tag">  
						<xsl:for-each select="tag[not(preceding-sibling::tag)]">
	        	<xsl:for-each select="tag[not(../tag/LabelCode = .)]">
	        	<xsl:for-each select="tag[not(preceding-sibling::LabelCode = LabelCode)]">

-->
	        	<xsl:for-each select="tag[not(preceding-sibling::tag/LabelCode = LabelCode)]">
        			<xsl:sort select="LabelCode"/>
	            <fo:table-row>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="position()"/>-<xsl:value-of select="LabelCode"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="ManufacturerName"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="ContactName"/></fo:block>
						    </fo:table-cell>
						    <fo:table-cell border="{$table-cell-style}" padding="{$tbl-cell-padding}">
						        <fo:block><xsl:value-of select="ContactNumber"/></fo:block>
						    </fo:table-cell>
	            </fo:table-row>
	            <!-- <xsl:variable name="tmpLabelCode" select="LabelCode"/>  -->
	          </xsl:for-each>
	        </fo:table-body>
	    </fo:table>		
	</xsl:template>

	<xsl:template name="manufacturer_contact_footer">
	    <fo:table font-size="8pt" >
	        <fo:table-column column-width="45%"/>
	        <fo:table-column column-width="40%"/>
	        <fo:table-column column-width="15%"/>
	        <fo:table-body>
	            <fo:table-row>
						    <fo:table-cell text-align="left">
						        <fo:block margin-left="0.5in">Manufacturer Contact Information - <xsl:value-of select="tag/Seq"/></fo:block>
						    </fo:table-cell>
					      <fo:table-cell text-align="left">
										<fo:block ><xsl:value-of select="tag/URL"/></fo:block>
						    </fo:table-cell>
					    	<fo:table-cell text-align="right">
						  		<fo:block margin-right="0.5in" text-align="end">Page <fo:page-number/> of <fo:page-number-citation ref-id="{tag/HRSA-ID}-manufacturer_contact"/></fo:block>
						   	</fo:table-cell>						    
	            </fo:table-row>
	        </fo:table-body>
	    </fo:table>		
	</xsl:template>
	
	
</xsl:stylesheet>
