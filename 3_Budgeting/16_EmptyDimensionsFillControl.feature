#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 16. Checking the control of empty dimension filling

	As Administrator I want to
	so that it is not possible to save an indicator value with an empty dimension

Background:

	And I close all client application windows

Scenario: 16.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 16.01 Creating a report type "VA - Empty analytics"

	* Creating a report type
		And I create report type with name "VA - Empty analytics" and parent "VA - Report group"
		And I open report type with name "VA - Empty analytics"
	
	* Refining a report type
		And I move to the tab named 'DimensionsOfReport'
		And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
		And I click the button named 'RecordButtonForm'
		Then "Data restructuring" window is opened
		And I click the button named 'FormOK'

	* Configuring report type structure
		And I click the button named 'EditTree'
		When "Report wizard" window is opened
		And I add row with name "Source" in report wizard
		And I add row with name "Destination1" in report wizard
		And I add row with name "Destination2" in report wizard
		And I add column with name "Number" in report wizard
		And I add column with name "Date" in report wizard

	* Configuring indicators
		And I change indicator properties 'ValueType' to "Date" in cell 'R2C3:R4C3' in report wizard
		And I change indicator properties 'TotalKind' to "Maximum" in cell 'R2C3:R4C3' in report wizard

	* Configuring dimensions
		And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard
		And I click the button named 'CopyAndShiftDown1'
		And I add dimension with code "VA0ProCate" in cell 'R2C4' in report wizard
		And I click the button named 'CopyAndShiftDown1'

	* Setting dimension filling as mandatory
		* GR_Destination1
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R3C9" cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			When "DG_Destination1 (Report indicator dimension groups)" window is opened
			And I go to line in 'TabFieldsDisplaySetting' table:
				| "Group dimension"          | "Dimension kind" | "Required" |
				| "Dimension 2: Product range" | "Product range"  | "No"          |
			And I activate field named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I change checkbox named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I finish line editing in 'TabFieldsDisplaySetting' table
			And I click the button named 'FormWriteAndClose'
			And I wait "DG_Destination1 (Report indicator dimension groups) *" window closing in 20 seconds
		* GR_Destination2
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R4C9" cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			When "DG_Destination2 (Report indicator dimension groups)" window is opened
			And I go to line in 'TabFieldsDisplaySetting' table:
				| "Group dimension"          | "Dimension kind" | "Required" |
				| "Dimension 2: Product range" | "Product range"  | "No"          |
			And I activate field named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I change checkbox named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I finish line editing in 'TabFieldsDisplaySetting' table
			And I go to line in 'TabFieldsDisplaySetting' table:
				| "Group dimension"                | "Dimension kind"      | "Required" |
				| "Dimension 3: Product categories" | "Product categories" | "No"          |
			And I activate field named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I change checkbox named 'MandatoryAnalytics' in 'TabFieldsDisplaySetting' table
			And I finish line editing in 'TabFieldsDisplaySetting' table
			And I click the button named 'FormWriteAndClose'
			And I wait "DG_Destination2 (Report indicator dimension groups) *" window closing in 20 seconds

	* Closing report wizard
		When "Report wizard" window is opened
		And I close "Report wizard" window
		
	* Report type template
		And I create default template for report type "VA - Empty analytics"

	* Pivot table template
		And I for report type "" create default pivot table template with filters "VA - Empty analytics"

Scenario: 16.02 Configuring the report structure

	And I open report wizard with name "VA - Empty analytics"

	* Entering formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And I click the button named 'FormShowSourceData'
		And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Empty analytics" string
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to "Source_Number" cell
		Then "Report wizard" window is opened
		And I click the button named 'AddDataToCell1'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to "Source_Date" cell
		And I click the button named 'AddDataToCell1'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to "Source_Number" cell
		And I click the button named 'AddDataToCell1'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to "Source_Date" cell
		And I click the button named 'AddDataToCell1'
		And I click the button named 'FormShowSourceData'

	* Configuring dimensions
		* Receiver1 number
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Empty analytics_Source number (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension kind"      | "Column name"                       | "Filling method" |
				| "Dimension 3: Product categories" | "Product categories" | "[Dimension 3: Product categories]" | "Source field"    |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Empty analytics_Source number (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard" window is opened
			And I click the button named 'UndoFormulaEdit'
		* Receiver1 date
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R3C3" cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Empty analytics_Source date (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension kind"      | "Column name"                       | "Filling method" |
				| "Dimension 3: Product categories" | "Product categories" | "[Dimension 3: Product categories]" | "Source field"    |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Empty analytics_Source date (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard" window is opened
			And I click the button named 'UndoFormulaEdit'
		* Receiver2 number
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Empty analytics_Source number (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension kind"      | "Column name"                       | "Filling method" |
				| "Dimension 3: Product categories" | "Product categories" | "[Dimension 3: Product categories]" | "Source field"    |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Empty analytics_Source number (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard" window is opened
			And I click the button named 'UndoFormulaEdit'
		* Receiver2 date
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Empty analytics_Source date (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension kind"      | "Column name"                       | "Filling method" |
				| "Dimension 3: Product categories" | "Product categories" | "[Dimension 3: Product categories]" | "Source field"    |
			And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Empty analytics_Source date (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard" window is opened
			And I click the button named 'UndoFormulaEdit'

	* Closing report wizard
		When "Report wizard" window is opened
		And I close "Report wizard" window

Scenario: 16.03 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Empty analytics" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 16.04 Creating a report instance "VA - Empty analytics"

	And I create report instance for report type "VA - Empty analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions "3Software sale" '' '' '' '' ''
	And I click the button named 'Write'

	And I add values with indicator expansion in cell 'R6C8'
		| "Product range"                 | "Product categories"   | 'Period_1_Value1' | 'Period_2_Value1' |
		| "5C:Corporate performance management"    | "Software products" | '100'                | '200'                |
		| "1C:ERP. Corporate performance management" | "Software products" | '100'                | '200'                |

	And I add values with indicator expansion in cell 'R6C9'
		| "Product range"                 | "Product categories"   | 'Period_1_Value1' | 'Period_2_Value1' |
		| "5C:Corporate performance management"    | "Software products" | '1/1/2024'         | '2/2/2024'         |
		| "1C:ERP. Corporate performance management" | "Software products" | '1/1/2024'         | '2/2/2024'         |

	And I enter comment "Number" in cell 'R8C2'
	And I enter comment "Date" in cell 'R10C5'

	Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
		| "VA - Empty analytics"         | ''               | ''           | ''                | ''           | ''             | ''     | ''      | ''           |
		| ''                              | ''               | ''           | ''                | ''           | ''             | ''     | ''      | ''           |
		| ''                              | "January 2024" | ''           | "February 2024" | ''           | "March 2024" | ''     | "TOTAL" | ''           |
		| ''                              | "Number"          | "Date"       | "Number"           | "Date"       | "Number"        | "Date" | "Number" | "Date"       |
		| "Source"                      | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
		| "1C:ERP. Corporate performance management " | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "Software products "         | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "5C:Corporate performance management "    | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "Software products "         | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "Destination1"                     | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
		| "1C:ERP. Corporate performance management " | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| ' '                             | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "5C:Corporate performance management "    | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| ' '                             | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "Destination2"                     | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
		| "1C:ERP. Corporate performance management " | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| ' '                             | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| "5C:Corporate performance management "    | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
		| ' '                             | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |

	When '$WindowTitle$' window is opened
	And I click the button named 'Write'
	Then "1C:Enterprise" window is opened
	And I click the button named 'OK'

	Then there are lines in TestClient message log
		|"Required dimension is not filled for the indicator:\n	Indicator: Destination2 number\n	Dimension3: \"Product categories\""|
		|"Required dimension is not filled for the indicator:\n	Indicator: Destination2 date\n	Dimension3: \"Product categories\""|

	When '$WindowTitle$' window is opened
	And I close '$WindowTitle$' window
	Then "1C:Enterprise" window is opened
	And I click the button named 'Button1'
		
Scenario: 16.05 Creating a pivot table "VA - Empty analytics"
		
	And I open report pivot table with name "VA - Empty analytics"
	And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Mercury LLC"

	* Configuring the dimension order
		And I click the button named 'ShowTableSettingsByAxes'
		And I move dimension with name "Product categories" up in pivot table
		And I move dimension with name "Product range" up in pivot table
		And I move dimension with name "Cash flow items" up in pivot table
		And I click the button named 'ButtonApply'
		And I wait for "Pivot table: *" form opening for 20 seconds

	And I add values with indicator expansion in cell 'R4C8'
		 | "Product range"                 | "Product categories"   | "Cash flow items"                       | 'Period_1_Value1' | 'Period_2_Value1' |
		 | "5C:Corporate performance management"    | "Software products" | "3Software sale" | '100'                | '200'                |
		 | "1C:ERP. Corporate performance management" | "Software products" | "2Software implementation"  | '100'                | '200'                |

	And I add values with indicator expansion in cell 'R4C9'
		| "Product range"                 | "Product categories"   | "Cash flow items"                       | 'Period_1_Value1' | 'Period_2_Value1' |
		| "5C:Corporate performance management"    | "Software products" | "3Software sale" | '1/1/2024'         | '2/2/2024'         |
		| "1C:ERP. Corporate performance management" | "Software products" | "2Software implementation"  | '1/1/2024'         | '2/2/2024'         |

	And I enter comment "Number" in cell 'R7C2'
	And I enter comment "Date" in cell 'R10C5'

	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Empty analytics (pivot table)" | "January 2024" | ''           | "February 2024" | ''           | "March 2024" | ''     | "TOTAL" | ''           |
			| "VA - Empty analytics (pivot table)" | "Number"          | "Date"       | "Number"           | "Date"       | "Number"        | "Date" | "Number" | "Date"       |
			| "Source"                                | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
			| "2Software implementation"         | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "1C:ERP. Corporate performance management"            | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "Software products"                    | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "3Software sale"        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "5C:Corporate performance management"               | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "Software products"                    | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "Destination1"                               | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
			| "2Software implementation"         | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "1C:ERP. Corporate performance management"            | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| ''                                        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "3Software sale"        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "5C:Corporate performance management"               | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| ''                                        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "Destination2"                               | '200'            | '1/1/2024' | '400'             | '2/2/2024' | '0'            | ''     | '600'   | '2/2/2024' |
			| "2Software implementation"         | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "1C:ERP. Corporate performance management"            | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| ''                                        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "3Software sale"        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| "5C:Corporate performance management"               | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
			| ''                                        | '100'            | '1/1/2024' | '200'             | '2/2/2024' | '0'            | ''     | '300'   | '2/2/2024' |
	
	* Opening a report instance
		When "Pivot table: *" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R10C3" cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuOpenReportInstance' of the form attribute named 'SpreadsheetFieldTemlate'
		And I open report instance for report type "VA - Empty analytics" currency "RUB" company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions "3Software sale" '' '' '' '' ''
		And I close '$WindowTitle$' window

	* Opening a non-existent report instance
		When "Pivot table: *" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R7C3" cell
		And I select context menu item named 'SpreadsheetFieldTemlateContextMenuOpenReportInstance' of the form attribute named 'SpreadsheetFieldTemlate'
		Then there are lines in TestClient message log
			|"A report instance is not found by the key slices:\n	Scenario: VA - Main scenario\n	Company: Mercury LLC\n	Period: January 2024,\n	Dimension1: 2Software implementation"|
	
	When "Pivot table: *" window is opened
	And I click the button named 'Apply'

	Then "Protocol" window is opened
	Then 'SpreadsheetDocumentField' spreadsheet document is equal
		| "Errors"                                                                                                                     |
		| "Required dimension is not filled for the indicator:\n	Indicator: Destination2 number\n	Dimension3: \"Product categories\"" |
		| "Required dimension is not filled for the indicator:\n	Indicator: Destination2 date\n	Dimension3: \"Product categories\"" |
		
