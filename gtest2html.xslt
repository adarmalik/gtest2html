<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
	<html>
	<head>
		<title>Unit Test Results</title>
		<style type="text/css">
			td#passed {
				color: green;
				font-weight: bold;
			}
			td#failed {
				color: red;
				font-weight: bold;
			}
			<!-- borrowod from here http://red-team-design.com/practical-css3-tables-with-rounded-corners/ -->
			body {
				width: 80%;
				margin: 40px auto;
				font-family: 'trebuchet MS', 'Lucida sans', Arial;
				font-size: 14px;
				color: #444;
			}
			table {
				*border-collapse: collapse; /* IE7 and lower */
				border-spacing: 0;
				width: 100%;
			}
			.bordered {
				border: solid #ccc 1px;
				-moz-border-radius: 6px;
				-webkit-border-radius: 6px;
				border-radius: 6px;
				-webkit-box-shadow: 0 1px 1px #ccc; 
				-moz-box-shadow: 0 1px 1px #ccc; 
				box-shadow: 0 1px 1px #ccc;         
			}
			.bordered tr:hover {
				background: #fbf8e9;
				-o-transition: all 0.1s ease-in-out;
				-webkit-transition: all 0.1s ease-in-out;
				-moz-transition: all 0.1s ease-in-out;
				-ms-transition: all 0.1s ease-in-out;
				transition: all 0.1s ease-in-out;     
			}    
			.bordered td, .bordered th {
				border-left: 1px solid #ccc;
				border-top: 1px solid #ccc;
				padding: 10px;
				text-align: left;    
			}
			.bordered th {
				background-color: #dce9f9;
				background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
				background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
				background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
				background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
				background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
				background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
				-webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
				-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
				box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
				border-top: none;
				text-shadow: 0 1px 0 rgba(255,255,255,.5); 
			}
			.bordered td:first-child, .bordered th:first-child {
				border-left: none;
			}
			.bordered th:first-child {
				-moz-border-radius: 6px 0 0 0;
				-webkit-border-radius: 6px 0 0 0;
				border-radius: 6px 0 0 0;
			}
			.bordered th:last-child {
				-moz-border-radius: 0 6px 0 0;
				-webkit-border-radius: 0 6px 0 0;
				border-radius: 0 6px 0 0;
			}
			.bordered th:only-child{
				-moz-border-radius: 6px 6px 0 0;
				-webkit-border-radius: 6px 6px 0 0;
				border-radius: 6px 6px 0 0;
			}
			.bordered tr:last-child td:first-child {
				-moz-border-radius: 0 0 0 6px;
				-webkit-border-radius: 0 0 0 6px;
				border-radius: 0 0 0 6px;
			}
			.bordered tr:last-child td:last-child {
				-moz-border-radius: 0 0 6px 0;
				-webkit-border-radius: 0 0 6px 0;
				border-radius: 0 0 6px 0;
			}
		</style>
	</head>
	<body>
		<xsl:apply-templates/>
	</body>
	</html>

</xsl:template>

<xsl:template match="testsuites">
	<h1>Unit Test Run <xsl:value-of select="@timestamp"/></h1>
	<p>
		Executed <b><xsl:value-of select="@tests"/></b> test cases in 
		<b><xsl:value-of select="count(testsuite)"/></b> test suites, 
		<b><xsl:value-of select="@failures"/></b> test cases failed.
		Execution time <b><xsl:value-of select="@time"/></b>
	</p>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="testsuite">
	<h2><xsl:value-of select="@name"/></h2>

	<table class="bordered">
		<tr><th style="width:30%">Test (<xsl:value-of select="@failures"/>/<xsl:value-of select="@tests"/> failed) </th>
			<th>Message</th>
			<th style="width:1%">Result</th>
		</tr>
		<xsl:for-each select="testcase">
		<tr>
			<td><xsl:value-of select="@name"/></td>
			<xsl:choose>
				<xsl:when test="*">
					<td id="failed">
						<xsl:for-each select="failure">
							<xsl:if test="@message">
								<xsl:value-of select="@message"/>
							</xsl:if>
						</xsl:for-each>
					</td>
					<td id="failed">FAIL</td>
				</xsl:when>
				<xsl:otherwise>
					<td>
						<xsl:for-each select="@* [name()!='classname' and name()!='name' and name()!='status' and name()!='time']">
							<xsl:value-of select="name()"/>=<xsl:value-of select="."/><br></br>
						</xsl:for-each>
						<xsl:for-each select="*">
							<xsl:value-of select="@message"/>
						</xsl:for-each>
					</td>
					<td id="passed">OK</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
		</xsl:for-each>
	</table>
</xsl:template>
</xsl:stylesheet>
