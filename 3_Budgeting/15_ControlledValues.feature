#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 15. Checking controlled values on save

	As Administrator I want to
	so that an indicator value greater than the control value cannot be saved

Background:

	And I close all client application windows

Scenario: 15.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 15.01 Creating report type "VA - Controlled indicators"

	* Creates report type
		And I create report type with name "VA - Controlled indicators" and parent "VA - Report group"
		And I open report type with name "VA - Controlled indicators"
	
	* Refining a report type
		And I change checkbox named 'IsChangeTrackingEnabled'
		And I set checkbox named 'ProjectSeparation'
		And I click the button named 'RecordButtonForm'

	* Configuring report type structure
		And I click the button named 'EditTree'
		When "Report wizard" window is opened
		And I add row with name "Synthetic" in report wizard
		And I add row with name "Analysts" in report wizard
		And I add column with name "Count" in report wizard
		And I add column with name "ControlYes" in report wizard
		And I add column with name "ControlNo" in report wizard
		And I add column with name "Date" in report wizard

	* Configuring indicators
		And I change indicator properties 'ControllableIndicator' to "True" in cell 'R2C2:R3C5' in report wizard
		And I change indicator properties 'ControllableIndicator' to "False" in cell 'R2C2' in report wizard
		And I change indicator property 'ControllableIndicator' to "False" in cell 'R3C2' in report wizard
		And I change indicator property 'ValueType' to "Date" in cell 'R2C5' in report wizard
		And I change indicator property 'ValueType' to "Date" in cell 'R3C5' in report wizard
		And I change indicator properties 'TotalKind' to "Minimum" in cell 'R2C5:R3C5' in report wizard

	* Configuring dimensions
		And I add dimension with code "VA0CFItems" in cell 'R3C2' in report wizard
		And I add dimension with code "VA0Product" in cell 'R3C3' in report wizard
		And I change dimension currency in cell 'R3C8' in report wizard
		And I change indicator properties 'ShouldRecalculateForeignCurrencyAmount' to "True" in cell 'R3C2:R3C5' in report wizard

	* Report type template
		And I create default template for report type "VA - Controlled indicators"

	* Creating pivot table template
		And I for report type "VA - Controlled indicators" create default pivot table template with filters "Project"
		When "VA - Controlled indicators (Report types)" window is opened
		And I click Open button of the field named 'DefaultPivotTableTemplate'
		Then I open pivot table template for report type "VA - Controlled indicators"
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Product range"               |
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Additional currencies"      |
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I change checkbox named 'TotalByColumns'
		And I click the button named 'ButtonApply'
		When '$WindowTitle$' window is opened
		And I click the button named 'FormWrite'

Scenario: 15.02 Creating a new scenario for controlled values

	And I create scenario with name "VA - Scenario with control"
	And I set value "VA - Main scenario" for attribute 'ControllingScenario' on tab 'Budgeting' for scenario "VA - Scenario with control"

	And I create period management document with scenario "VA - Scenario with control" regulation "VA - Main regulations" frequency "Month" start date '1/1/2024' end date '3/31/2024'

Scenario: 15.03 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Controlled indicators" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 15.04 Creating report instance "VA - Controlled indicators"

	And I create report instance for report type "VA - Controlled indicators" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Filling indicator values
		* Synthetic
			And I enter value '100' in cell 'R6C2'
			And I enter value '100' in cell 'R6C3'
			And I enter value '100' in cell 'R6C4'
			And I enter value '1/1/2024' in cell 'R6C5'
			And I enter value '200' in cell 'R6C6'
			And I enter value '200' in cell 'R6C7'
			And I enter value '200' in cell 'R6C8'
			And I enter value '1/1/2024' in cell 'R6C9'
		* Dimensions
			And I add values with indicator expansion in cell 'R7C14'
				| "Cash flow items"                       | "Product range"                 | "Currencies" | 'Period_1_Value1' | 'Period_2_Value1' |
				| "3Software sale" | "5C:Corporate performance management"    | 'RUB'    | '100'                | '200'                |
				| "3Software sale" | "2C:Corporation"                | 'RUB'    | '100'                | '200'                |
				| "3Software sale" | "1C:ERP. Corporate performance management" | 'RUB'    | '100'                | '200'                |
			And I add values with indicator expansion in cell 'R7C15'
				| "Cash flow items"                       | "Product range"                 | "Currencies" | 'Period_1_Value1' | 'Period_2_Value1' |
				| "3Software sale" | "5C:Corporate performance management"    | 'RUB'    | '100'                | '200'                |
				| "3Software sale" | "2C:Corporation"                | 'RUB'    | '100'                | '200'                |
			And I add values with indicator expansion in cell 'R7C16'
				| "Cash flow items"                       | "Product range"                 | "Currencies" | 'Period_1_Value1' | 'Period_2_Value1' |
				| "3Software sale" | "5C:Corporate performance management"    | 'RUB'    | '100'                | '200'                |
				| "3Software sale" | "2C:Corporation"                | 'RUB'    | '100'                | '200'                |
			And I add values with indicator expansion in cell 'R7C17'
				| "Cash flow items"                       | "Product range"                 | "Currencies" | 'Period_1_Value1' | 'Period_2_Value1' |
				| "3Software sale" | "5C:Corporate performance management"    | 'RUB'    | '1/1/2024'         | '2/1/2024'         |
				| "3Software sale" | "2C:Corporation"                | 'RUB'    | '1/1/2024'         | '2/1/2024'         |
				| "3Software sale" | "1C:ERP. Corporate performance management" | 'RUB'    | '1/1/2024'         | '2/1/2024'         |

	* Saving, checking form
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Controlled indicators"    | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | "January 2024" | ''           | ''            | ''           | "February 2024" | ''           | ''            | ''           | "March 2024" | ''           | ''            | ''     | "TOTAL"      | ''           | ''            | ''           |
			| ''                                  | "Count"     | "ControlYes" | "ControlNo" | "Date"       | "Count"      | "ControlYes" | "ControlNo" | "Date"       | "Count"   | "ControlYes" | "ControlNo" | "Date" | "Count" | "ControlYes" | "ControlNo" | "Date"       |
			| "Synthetic"                         | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '1/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| "Analysts"                         | '300'            | '200'        | '200'         | '1/1/2024' | '600'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '900'        | '600'        | '600'         | ''           |
			| "3Software sale " | '300'            | '200'        | '200'         | '1/1/2024' | '600'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '900'        | '600'        | '600'         | ''           |
			| "1C:ERP. Corporate performance management "     | '100'            | '0'          | '0'           | '1/1/2024' | '200'             | '0'          | '0'           | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '0'          | '0'           | ''           |
			| 'RUB '                              | '100'            | '0'          | '0'           | '1/1/2024' | '200'             | '0'          | '0'           | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '0'          | '0'           | ''           |
			| "2C:Corporation "                    | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | ''           |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | ''           |
			| "5C:Corporate performance management "        | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | ''           |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | ''           |

	* Deleting one row
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R7C14" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And I go to line in 'IndicatorsDrilldown' table:
			| "Currencies" | 'Value1' | 'ValueCurrency1' | "Product range"                 | "Report period"   | "Cash flow items"                       |
			| 'RUB'    | '200'       | '200'             | "1C:ERP. Corporate performance management" | "February 2024" | "3Software sale" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I go to line in 'IndicatorsDrilldown' table:
			| "Currencies" | 'Value1' | 'ValueCurrency1' | "Product range"                 | "Report period"  | "Cash flow items"                       |
			| 'RUB'    | '100'       | '100'             | "1C:ERP. Corporate performance management" | "January 2024" | "3Software sale" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R7C17" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And I go to line in 'IndicatorsDrilldown' table:
			| "Currencies" | 'Value1'  | "Product range"                 | "Report period"   | "Cash flow items"                       |
			| 'RUB'    | '2/1/2024' | "1C:ERP. Corporate performance management" | "February 2024" | "3Software sale" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I go to line in 'IndicatorsDrilldown' table:
			| "Currencies" | 'Value1'  | "Product range"                 | "Report period"  | "Cash flow items"                       |
			| 'RUB'    | '1/1/2024' | "1C:ERP. Corporate performance management" | "January 2024" | "3Software sale" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton'

	* Checking document movement
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		When I set 'R1C1:R200C20' template area reading parameters
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\15\VA_ControlledIndicators_Movements.mxl" by template
		And I close "Flat table of indicator values" window

	* Refreshing and checking the form
		When '$WindowTitle$' window is opened
		And I click the button named 'FormUpdateConsideringVersions'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Controlled indicators"    | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | "January 2024" | ''           | ''            | ''           | "February 2024" | ''           | ''            | ''           | "March 2024" | ''           | ''            | ''     | "TOTAL"      | ''           | ''            | ''           |
			| ''                                  | "Count"     | "ControlYes" | "ControlNo" | "Date"       | "Count"      | "ControlYes" | "ControlNo" | "Date"       | "Count"   | "ControlYes" | "ControlNo" | "Date" | "Count" | "ControlYes" | "ControlNo" | "Date"       |
			| "Synthetic"                         | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '1/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| "Analysts"                           | '200'            | '200'        | '200'         | '1/1/2024' | '400'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '600'        | '600'        | '600'         | '1/1/2024' |
			| "3Software sale " | '200'            | '200'        | '200'         | '1/1/2024' | '400'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '600'        | '600'        | '600'         | '1/1/2024' |
			| "2C:Corporation "                    | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| "5C:Corporate performance management "        | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |

Scenario: 15.05 Creating a report instance for controlled values

	* Copying an existing document
		And I find report type with name "VA - Controlled indicators" in list
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I click the button named 'FormCopy'
		When "Specify key document attributes" window is opened
		And I select from the drop-down list named 'Scenario'  by "VA - Scenario with control" string
		And I click Choice button of the field named 'Organization'
		And I select company "Mercury LLC"
		When "Specify key document attributes *" window is opened
		And I click the button named 'FormApplyAndClose'
		Then I open report instance for report type "VA - Controlled indicators" currency 'RUB' company "Mercury LLC" scenario "VA - Scenario with control" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		
	* Changing values
		And I enter value '250' in cell 'R6C6'
		And I enter value '250' in cell 'R6C7'
		And I enter value '150' in cell 'R6C8'
		And I enter value '250' in cell 'R10C6'
		And I enter value '250' in cell 'R10C7'
		And I enter value '150' in cell 'R10C8'
		And I enter value '250' in cell 'R6C10'
		And I enter value '250' in cell 'R6C11'
		And I enter value '150' in cell 'R6C12'
		And I enter value '250' in cell 'R10C10'
		And I enter value '250' in cell 'R10C11'
		And I enter value '150' in cell 'R10C12'

	* Trying to save the document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		When "1C:Enterprise" window is opened
		And I click the button named 'OK'
		When '$WindowTitle$' window is opened
		Then there are lines in TestClient message log
			|"You have exceeded the controlled value for the indicator:\n	Indicator: \"Synthetic controlyes\"\n	Calculated value: \"250\"\n	Control value: \"200\"\n	Controlling scenario: \"VA - Main scenario\"\n	Company: \"Mercury LLC\"\n	Period: \"February 2024\"\n	Project: \"VA - Main project\""|
			|"You have exceeded the controlled value for the indicator:\n	Indicator: \"Analysts controlyes\"\n	Calculated value: \"250\"\n	Control value: \"200\"\n	Controlling scenario: \"VA - Main scenario\"\n	Company: \"Mercury LLC\"\n	Period: \"February 2024\"\n	Project: \"VA - Main project\"\n	Dimension1: \"3Software sale\"\n	Dimension2: \"2C:Corporation\"\n	DimensionCurrency: \"RUB\""|

	* Reverting changes
		When '$WindowTitle$' window is opened
		And I repeat 12 times
			And I click the button named 'CancelAction'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Controlled indicators"    | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | ''               | ''           | ''            | ''           | ''                | ''           | ''            | ''           | ''             | ''           | ''            | ''     | ''           | ''           | ''            | ''           |
			| ''                                  | "January 2024" | ''           | ''            | ''           | "February 2024" | ''           | ''            | ''           | "March 2024" | ''           | ''            | ''     | "TOTAL"      | ''           | ''            | ''           |
			| ''                                  | "Count"     | "ControlYes" | "ControlNo" | "Date"       | "Count"      | "ControlYes" | "ControlNo" | "Date"       | "Count"   | "ControlYes" | "ControlNo" | "Date" | "Count" | "ControlYes" | "ControlNo" | "Date"       |
			| "Synthetic"                         | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '1/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| "Analysts"                           | '200'            | '200'        | '200'         | '1/1/2024' | '400'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '600'        | '600'        | '600'         | '1/1/2024' |
			| "3Software sale " | '200'            | '200'        | '200'         | '1/1/2024' | '400'             | '400'        | '400'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '600'        | '600'        | '600'         | '1/1/2024' |
			| "2C:Corporation "                    | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| "5C:Corporate performance management "        | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |
			| 'RUB '                              | '100'            | '100'        | '100'         | '1/1/2024' | '200'             | '200'        | '200'         | '2/1/2024' | '0'            | '0'          | '0'           | ''     | '300'        | '300'        | '300'         | '1/1/2024' |

	* Saving a document
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 15.06 Creating a pivot table for controlled values

	* Opening a pivot table
		And I open report pivot table with name "VA - Controlled indicators"
		And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Scenario with control", company "Mercury LLC"
		And I set pivot table filter 'Project' with value "VA - Main project"

	* Entering values
		And I enter value '250' in cell 'R4C6'
		And I enter value '250' in cell 'R4C7'
		And I enter value '150' in cell 'R4C8'
		And I enter value '250' in cell 'R8C6'
		And I enter value '250' in cell 'R8C7'
		And I enter value '150' in cell 'R8C8'
		And I enter value '250' in cell 'R4C10'
		And I enter value '250' in cell 'R4C11'
		And I enter value '150' in cell 'R4C12'
		And I enter value '250' in cell 'R8C10'
		And I enter value '250' in cell 'R8C11'
		And I enter value '150' in cell 'R8C12'

	* Saving indicators
		And I click the button named 'Apply'
		Then "Protocol" window is opened
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
			| "Errors"                                                                                                                                                                                                                                                                                                                                                                                                                      |
			| "You have exceeded the controlled value for the indicator:\n	Indicator: \"Synthetic controlyes\"\n	Calculated value: \"250\"\n	Control value: \"200\"\n	Controlling scenario: \"VA - Main scenario\"\n	Company: \"Mercury LLC\"\n	Period: \"February 2024\"\n	Project: \"VA - Main project\""                                                                                                               |
			| "You have exceeded the controlled value for the indicator:\n	Indicator: \"Analysts controlyes\"\n	Calculated value: \"250\"\n	Control value: \"200\"\n	Controlling scenario: \"VA - Main scenario\"\n	Company: \"Mercury LLC\"\n	Period: \"February 2024\"\n	Project: \"VA - Main project\"\n	Dimension1: \"3Software sale\"\n	Dimension2: \"2C:Corporation\"\n	DimensionCurrency: \"RUB\"" |
				
		
