#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 12. Automatic filling of empty dimensions

	As Administrator I want to
	Checking automatic filling of dimensions
	so that empty dimensions are filled

Background:

	And I close all client application windows

Scenario: 12.00 Initial initialization of variables

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Given I initialize variables

Scenario: 12.01 Configuring default dimension values

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		When "Dimension types (corporate)" window is opened

	* Configuring Product categories
		* Finding dimension type
			And I click the button named 'FormFind'
			Then "Find" window is opened
			And I select "Code" exact value from the drop-down list named 'FieldSelector'
			And I input "VA0ProCate" text in the field named 'Pattern'
			And I change the radio button named 'CompareType' value to "Exact match"
			And I click the button named 'Find'
			Then "Dimension types (corporate)" window is opened
			And I select current line in 'List' table
			Then "Product categories (Dimension types (corporate))" window is opened
			And In this window I click command interface button "Default dimension values"
		* Deleting current items
			And While the number of 'List' table lines '>' 0 Then
				And I select context menu item named 'ListContextMenuDelete' of the form attribute named 'List'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
		* Creating a value for January
			Then "Product categories (Dimension types (corporate))" window is opened
			And I click the button named 'FormCreate'
			Then "Default dimension values (create)" window is opened
			And I input '12/2/2020' text in the field named 'Period'
			If '$$IsPerform$$' Then
				And I click Choice button of the field named 'DefaultValue'
				Then "Arbitrary classifier" window is opened
				And I click the button named 'FormFind'
				Then "Find" window is opened
				And I select "Description" exact value from the drop-down list named 'FieldSelector'
				And I input "Software products" text in the field named 'Pattern'
				And I change the radio button named 'CompareType' value to "Exact match"
				And I click the button named 'Find'
				Then "Arbitrary classifier" window is opened
				And I select current line in 'List' table
			Else
				And I select from the drop-down list named 'DefaultValue'  by "Software products" string
			And I click the button named 'FormWriteAndClose'
			And I wait "Default dimension values (create) *" window closing in 20 seconds
		* Closing windows
			Then "Product categories (Dimension types (corporate))" window is opened
			And I close "Product categories (Dimension types (corporate))" window

	* Configuring Product range
		* Finding dimension type
			And I click the button named 'FormFind'
			Then "Find" window is opened
			And I select "Code" exact value from the drop-down list named 'FieldSelector'
			And I input "VA0Product" text in the field named 'Pattern'
			And I change the radio button named 'CompareType' value to "Exact match"
			And I click the button named 'Find'
			Then "Dimension types (corporate)" window is opened
			And I select current line in 'List' table
			Then "Product range (Dimension types (corporate))" window is opened
			And In this window I click command interface button "Default dimension values"
		* Deleting current items
			And While the number of 'List' table lines '>' 0 Then
				And I select context menu item named 'ListContextMenuDelete' of the form attribute named 'List'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
		* Creating a value for February
			Then "Product range (Dimension types (corporate))" window is opened
			And I click the button named 'FormCreate'
			Then "Default dimension values (create)" window is opened
			And I input '1/2/2024' text in the field named 'Period'
			If '$$IsPerform$$' Then
				And I click Choice button of the field named 'DefaultValue'
				Then "Product range" window is opened
				And I click the button named 'FormFind'
				Then "Find" window is opened
				And I select "Description" exact value from the drop-down list named 'FieldSelector'
				And I input "5C:Corporate performance management" text in the field named 'Pattern'
				And I change the radio button named 'CompareType' value to "Exact match"
				And I click the button named 'Find'
				Then "Product range" window is opened
				And I select current line in 'List' table
			Else
				And I select from the drop-down list named 'DefaultValue'  by "5C:Corporate performance management" string
			And I click the button named 'FormWriteAndClose'
			And I wait "Default dimension values (create) *" window closing in 20 seconds
		* Creating a value for March
			Then "Product range (Dimension types (corporate))" window is opened
			And I click the button named 'FormCreate'
			Then "Default dimension values (create)" window is opened
			And I input '2/2/2024' text in the field named 'Period'
			If '$$IsPerform$$' Then
				And I click Choice button of the field named 'DefaultValue'
				Then "Product range" window is opened
				And I click the button named 'FormFind'
				Then "Find" window is opened
				And I select "Description" exact value from the drop-down list named 'FieldSelector'
				And I input "1C:ERP. Corporate performance management" text in the field named 'Pattern'
				And I change the radio button named 'CompareType' value to "Exact match"
				And I click the button named 'Find'
				Then "Product range" window is opened
				And I select current line in 'List' table
			Else
				And I select from the drop-down list named 'DefaultValue'  by "1C:ERP. Corporate performance management" string
			And I click the button named 'FormWriteAndClose'
			And I wait "Default dimension values (create) *" window closing in 20 seconds
		* Closing windows
			Then "Product range (Dimension types (corporate))" window is opened
			And I close "Product range (Dimension types (corporate))" window
		
Scenario: 12.02 Creating report type and report structure

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password

	And I create report type with name "VA - Filling empty analytics" and parent "VA - Report group"
	
	And I open report type with name "VA - Filling empty analytics"
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	Then "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	And I add row with name "Source" in report wizard
	And I add row with name "SuccessorSameAnalytics" in report wizard
	And I add row with name "SuccessorEmptyAnalytics" in report wizard
	And I add column with name "Amount" in report wizard
	And I add column with name "Date" in report wizard

	And I change indicator properties 'ValueType' to "Date" in cell 'R2C3:R4C3' in report wizard
	And I change indicator properties 'TotalKind' to "Maximum" in cell 'R2C3:R4C3' in report wizard
		
	And I add dimension with code "VA0ProCate" in cell 'R2C3' in report wizard
	And I click the button named 'CopyAndShiftDown1'
	And I add dimension with code "VA0Product" in cell 'R2C4' in report wizard
	And I click the button named 'CopyAndShiftDown1'

	* Setting formulas
		* Sum
			When "Report wizard" window is opened
			And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteAndCollapse'
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteAndCollapse'
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Filling empty analytics_Source amount (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension type"      | "Column name"                       | "Filling method" |
				| "Dimension 2: Product categories" | "Product categories" | "[Dimension 2: Product categories]" | "Source field"    |
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"       | "Dimension type" | "Column name"                 | "Filling method" |
				| "Dimension 3: Product range" | "Product range"  | "[Dimension 3: Product range]" | "Source field"    |
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Filling empty analytics_Source amount (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
		* Date
			Then "Report wizard" window is opened
			And I click the button named 'WriteAndCollapse'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteAndCollapse'
			Then "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteFormula'
			Then "Report wizard" window is opened
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Filling empty analytics_Source date (Data source)" window is opened
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"             | "Dimension type"      | "Column name"                       | "Filling method" |
				| "Dimension 2: Product categories" | "Product categories" | "[Dimension 2: Product categories]" | "Source field"    |
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I go to line in 'ComplianceTable' table:
				| "Destination dimension"       | "Dimension type" | "Column name"                 | "Filling method" |
				| "Dimension 3: Product range" | "Product range"  | "[Dimension 3: Product range]" | "Source field"    |
			And I select current line in 'ComplianceTable' table
			And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Filling empty analytics_Source date (Data source) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard" window is opened
			And I click the button named 'WriteAndCollapse'
		* Closing report wizard
			Then "Report wizard" window is opened
			And I close "Report wizard" window
					
	And I create default template for report type "VA - Filling empty analytics"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R9C1' for report type "VA - Filling empty analytics"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R12C1' for report type "VA - Filling empty analytics"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R15C1' for report type "VA - Filling empty analytics"

Scenario: 12.03 Creating report instance without saving and filling dimensions

	And I create report instance for report type "VA - Filling empty analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	And I add values with indicator expansion in cell 'R6C2'
		| 'Value1' |
		| '1,000'     |
	And I add values with indicator expansion in cell 'R6C5'
		| 'Value1'  |
		| '2/1/2024' |

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Filling empty analytics" | ''               | ''     | ''                | ''           | ''             | ''     | ''      | ''           |
			| ''                                | ''               | ''     | ''                | ''           | ''             | ''     | ''      | ''           |
			| ''                                | "January 2024" | ''     | "February 2024" | ''           | "March 2024" | ''     | "TOTAL" | ''           |
			| ''                                | "Amount"          | "Date" | "Amount"           | "Date"       | "Amount"        | "Date" | "Amount" | "Date"       |
			| "Source"                        | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| "SuccessorSameAnalytics"            | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| "SuccessorEmptyAnalytics"          | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
			| ' '                               | '1,000'          | ''     | '0'               | '2/1/2024' | '0'            | ''     | '1,000' | '2/1/2024' |
		
	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'
				
Scenario: 12.04 Creating report instance without saving with filling dimensions

	And I change flag 'ShouldInsertDimensionValuesByDefault' for regulation "VA - Main regulations"

	And I create report instance for report type "VA - Filling empty analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* Filling indicator values
		And I add values with indicator expansion in cell 'R6C2'
			| 'Value1' |
			| '100'       |
		And I add values with indicator expansion in cell 'R6C3'
			| 'Value1'  |
			| '1/1/2024' |
		And I add values with indicator expansion in cell 'R6C4'
			| 'Value1' |
			| '200'       |
		And I add values with indicator expansion in cell 'R6C5'
			| 'Value1'  |
			| '2/1/2024' |
		And I add values with indicator expansion in cell 'R6C6'
			| 'Value1' |
			| '300'       |
		And I add values with indicator expansion in cell 'R6C7'
			| 'Value1'  |
			| '3/1/2024' |

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Filling empty analytics" | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | "January 2024" | ''           | "February 2024" | ''           | "March 2024" | ''           | "TOTAL" | ''           |
			| ''                                | "Amount"          | "Date"       | "Amount"           | "Date"       | "Amount"        | "Date"       | "Amount" | "Date"       |
			| "Source"                        | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorSameAnalytics"            | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorEmptyAnalytics"          | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
				
	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 12.05 Adding calculation for source

	And I open report wizard with name "VA - Filling empty analytics"

	* Adding formula
		* Sum
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
			When "Data source (create) *" window is opened
			And I input text in the field named 'QueryTextForm'
				|'SELECT'|
				|' MONTH(TimeIntervals.StartDate) * 100 AS Value,'|
				|' TimeIntervals.StartDate AS StartDate'|
				|'FROM'|
				|' Catalog.TimeIntervals AS TimeIntervals'|
				|'WHERE'|
				|' TimeIntervals.Ref IN (&PeriodsReport)'|
			And I click the button named 'EditQueryText'
			And I move to the tab named 'ComplianceAnalyst'
			And I move to the tab named 'FiltersPage'
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "List of values (function in 1C:Enterprise script)" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "VA - Filling empty analytics: Calculate a parameter value" window is opened
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'Result = ObjectOfARAP.ArrayOfPeriods; '|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		* Date
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
			When "Data source (create) *" window is opened
			And I input text in the field named 'QueryTextForm'
				|'SELECT'|
				|' TimeIntervals.StartDate AS StartDate'|
				|'FROM'|
				|' Catalog.TimeIntervals AS TimeIntervals'|
				|'WHERE'|
				|' TimeIntervals.Ref IN (&PeriodsReport)'|
			And I click the button named 'EditQueryText'
			And I move to the tab named 'ComplianceAnalyst'
			And I move to the tab named 'FiltersPage'
			And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I select current line in 'TreeOfFilterParametersDB' table
			And I select "List of values (function in 1C:Enterprise script)" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
			And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
			Then "VA - Filling empty analytics: Calculate a parameter value" window is opened
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'Result = ObjectOfARAP.ArrayOfPeriods; '|
			And I click the button named 'FormWriteAndClose'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then "Data source (create) *" window is opened
			And I finish line editing in 'TreeOfFilterParametersDB' table
			And I click the button named 'FormWriteAndClose'
			And I wait "Data source (create) *" window closing in 20 seconds
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'
		
Scenario: 12.06 Creating report instance with calculation by rules

	And I create report instance for report type "VA - Filling empty analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''
	
	* Calculating and comparing the result
		And I click the button named 'FormFillByDefault'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Filling empty analytics" | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | "January 2024" | ''           | "February 2024" | ''           | "March 2024" | ''           | "TOTAL" | ''           |
			| ''                                | "Amount"          | "Date"       | "Amount"           | "Date"       | "Amount"        | "Date"       | "Amount" | "Date"       |
			| "Source"                        | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorSameAnalytics"            | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorEmptyAnalytics"          | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |

	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

	* Opening document
		And I open first report instance for report type "VA - Filling empty analytics"

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Filling empty analytics" | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | ''               | ''           | ''                | ''           | ''             | ''           | ''      | ''           |
			| ''                                | "January 2024" | ''           | "February 2024" | ''           | "March 2024" | ''           | "TOTAL" | ''           |
			| ''                                | "Amount"          | "Date"       | "Amount"           | "Date"       | "Amount"        | "Date"       | "Amount" | "Date"       |
			| "Source"                        | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorSameAnalytics"            | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
			| "SuccessorEmptyAnalytics"          | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| "Software products "           | '100'            | '1/1/2024' | '200'             | '2/1/2024' | '300'          | '3/1/2024' | '600'   | '3/1/2024' |
			| ' '                               | '100'            | '1/1/2024' | '0'               | ''           | '0'            | ''           | '100'   | '1/1/2024' |
			| "5C:Corporate performance management "      | '0'              | ''           | '200'             | '2/1/2024' | '0'            | ''           | '200'   | '2/1/2024' |
			| "1C:ERP. Corporate performance management "   | '0'              | ''           | '0'               | ''           | '300'          | '3/1/2024' | '300'   | '3/1/2024' |
				
Scenario: 12.06 Returning regulation to its previous state

	And I change flag 'ShouldInsertDimensionValuesByDefault' for regulation "VA - Main regulations"
