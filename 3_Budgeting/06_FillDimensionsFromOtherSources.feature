#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 06. Checking filling of dimensions from other sources

	As Administrator I want to
	Checking that filling of dimensions from other sources was working correctly
	so that report indicators are calculated without errors

Background:

	And I close all client application windows

Scenario: 06.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 06.01 Creating report group "VA - Analytics of other sources (group)"

	And I create report type group with name "VA - Analytics of other sources (group)" and parent "VA - Report group"

Scenario: 06.02 Creating report type "VA - Data to add analytics"

	And I create report type with name "VA - Data to add analytics" and parent "VA - Analytics of other sources (group)"
	And I open report type with name "VA - Data to add analytics"
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0ProCate" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened
	And I add row with name "Cash flow items" in report wizard
	And I add row with name "Goods" in report wizard
	And I add column with name "Count" in report wizard
	And I add dimension with code "VA0CFItems" in cell 'R2C3' in report wizard
	And I add dimension with code "VA0Product" in cell 'R3C3' in report wizard

	And I create default template for report type "VA - Data to add analytics"

Scenario: 06.03 Creating report instance "VA - Data to add analytics"

	And I create report instance for report type "VA - Data to add analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions "Software products" '' '' '' '' ''
	And I save the window as 'WindowTitle'

	* The document should be empty
		And 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Data to add analytics" | ''               | ''                | ''             | ''           |
			| ''                                    | ''               | ''                | ''             | ''           |
			| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                    | "Count"     | "Count"      | "Count"   | "Count" |
			| "Cash flow items"                          | '0'              | '0'               | '0'            | '0'          |
			| "Goods"                              | '0'              | '0'               | '0'            | '0'          |

	* Filling indicator values
		* Product categories
			And I add values with indicator expansion in cell 'R6C2'
				| "VA0CFItems"                       | 'Value1' |
				| "3Software sale" | '1.00000'   |
				| "2Software implementation"  | '2.00000'   |
			And I enter value '1.00000' in cell 'R7C3'
			And I enter value '2.00000' in cell 'R8C3'
		* Products
			And I add values with indicator expansion in cell 'R9C2'
				| "VA0Product"                                                     | 'Value1' |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '1.00000'   |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '3.00000'   |
				| "5C:Corporate performance management"                                      | '2.00000'   |
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C2:R12C2' cell
			And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
			And I change value to '100.00000' percent in cell 'R10C3:R12C3'
			And I change value to '200.00000' percent in cell 'R10C4:R12C4'

	* Saving and closing the document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 06.04 Creating report type "VA - Analysts from fields of other sources"

	And I create report type with name "VA - Analysts from fields of other sources" and parent "VA - Analytics of other sources (group)"
	And I open report type with name "VA - Analysts from fields of other sources"
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0ProCate" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	Then "Report wizard" window is opened
	And I add row with name "Current formula" in report wizard
	And I add row with name "Other source" in report wizard
	And I add row with name "Analytics transformation" in report wizard
	And I add row with name "Calculated source" in report wizard
	And I add row with name "Recalculation in code" in report wizard
	And I add column with name "Count" in report wizard
	And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard
	And I add dimension with code "VA0Product" in cell 'R3C3' in report wizard
	And I add dimension with code "VA0CFItems" in cell 'R4C3' in report wizard
	And I add dimension with code "VA0Product" in cell 'R4C4' in report wizard
	And I add dimension with code "VA0CFItems" in cell 'R5C3' in report wizard
	And I add dimension with code "VA0Product" in cell 'R5C4' in report wizard
	And I add dimension with code "VA0CFItems" in cell 'R6C3' in report wizard
	And I add dimension with code "VA0Product" in cell 'R6C4' in report wizard

	* Configuring calculation formulas
		When "Report wizard*" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		* Current formula
			* Main source
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_Count" of report type "VA - Data to add analytics"
				When "Report wizard*" window is opened
				And I click the button named 'WriteAndCollapse'
				* Source with additional dimensions
					When "Report wizard" window is opened
					And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
					And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
					And I click the button named 'AddOperand1'
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
					And I change checkbox named 'UseMultiperiodContext'
					And I input 'SELECT 2 AS Value' text in the field named 'QueryTextForm'
					And I click the button named 'EditQueryText'
					And I move to the tab named 'ComplianceAnalyst'
					And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
					And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
					And I select current line in 'ComplianceTable' table
					Then "Data sources" window is opened
					And I select current line in 'List' table
					Then "Data source (create)*" window is opened
					And I click the button named 'FormWriteAndClose'
					And I wait "Data source (create)*" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard*" window is opened
				And I click the button named 'ButtonMultiply'
				And I click the button named 'WriteAndCollapse'
		* Other source
			* Source with custom query No. 1
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
				And I change checkbox named 'UseMultiperiodContext'
				And I input 'SELECT 2 AS Value' text in the field named 'QueryTextForm'
				And I click the button named 'EditQueryText'
				And I move to the tab named 'ComplianceAnalyst'
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				* Source for supplementing dimensions
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Data to add analytics" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "Goods_Count"
					Then "Data source (create)*" window is opened
					And I click the button named 'FormWriteAndClose'
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Data source (create)*" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create)*" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard*" window is opened
				And I click the button named 'ButtonPlus'
			* Source with custom query No. 1
				When "Report wizard*" window is opened
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
				And I change checkbox named 'UseMultiperiodContext'
				And I input 'SELECT 3 AS Value' text in the field named 'QueryTextForm'
				And I click the button named 'EditQueryText'
				And I move to the tab named 'ComplianceAnalyst'
				And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				When "Data sources" window is opened
				And I go to line in 'List' table:
					| "Description"                                          | "Receipt method"                                 | "Indicator filter"  |
					| "VA - Data to add analytics_Goods count" | "Current infobase report indicator (easy setup)" | "Goods count" |
				And I select current line in 'List' table
				Then "Data source (create)*" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create)*" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard*" window is opened
				And I click the button named 'WriteAndCollapse'
		* Dimension transformation
			* Data source for transformation
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Data to add analytics" string
				And I click Choice button of the field named 'IndicatorFilter'
				And I select indicator with code "Goods_Count"
				Then "Data source (create) *" window is opened
				And I select current line in 'ComplianceTable' table
				And I select "Fixed value" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				Then "Cash flow items" window is opened
				And I click the button named 'FormFind'
				Then the form named 'UniversalListFindExtForm' is opened
				And I select "Description" exact value from the drop-down list named 'FieldSelector'
				And I input "1Software upgrade" text in the field named 'Pattern'
				And I change the radio button named 'CompareType' value to "Exact match"
				And I click the button named 'Find'
				Then "Cash flow items" window is opened
				And I select current line in 'List' table
				Then "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
		* Calculated source
			* Custom database query with multi-period context
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
				And I input text in the field named 'QueryTextForm'
					|'SELECT'|
					|' TimeIntervals.StartDate AS Date,'|
					|' MONTH(TimeIntervals.EndDate) AS Value'|
					|'FROM'|
					|' Catalog.TimeIntervals AS TimeIntervals'|
					|'WHERE'|
					|' TimeIntervals.Ref IN (&TimeIntervals)'|
				And I click the button named 'EditQueryText'
				And I move to the tab named 'ComplianceAnalyst'
				And I select current line in 'ComplianceTable' table
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				* Source for filling Analytics2
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Data to add analytics" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "CashFlowItems_Count"
					Then "Data source (create)*" window is opened
					And I click the button named 'FormWriteAndClose'
					Then "Data sources" window is opened
					And I select current line in 'List' table
				Then "Data source (create) *" window is opened
				And I go to line in 'ComplianceTable' table:
					| "Destination dimension"       | "Dimension type" |
					| "Dimension 3: Product range" | "Product range"  |
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				* Source for filling Analytics3
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Analysts from fields of other sources" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "AnalyticsTransformat_Count"
					Then "Data source (create)*" window is opened
					And I click the button named 'FormWriteAndClose'
					Then "Data sources" window is opened
					And I select current line in 'List' table
				Then "Data source (create)*" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create)*" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard*" window is opened
				And I click the button named 'WriteAndCollapse'
		* Recalculation in code
			* Main source
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Current infobase information register" exact value from the drop-down list named 'MethodOfObtaining'
				If '$$IsERPCPM$$' Then
					And I select from the drop-down list named 'DBInformationRegister'  by 'ItemsPrices25' string
				Else
					And I select from the drop-down list named 'DBInformationRegister'  by 'ItemsPrices' string
				And I select "Slice of the last ones" exact value from the drop-down list named 'SliceType'
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				* Source with additional dimensions - Cash flow statement items
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Analysts from fields of other sources" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "AnalyticsTransformat_Count"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					Then "Data sources" window is opened
					And I select current line in 'List' table
				Then "Data source (create)*" window is opened
				And I go to line in 'ComplianceTable' table:
					| "Destination dimension"       | "Dimension type" | "Column name"    | "Filling method" |
					| "Dimension 3: Product range" | "Product range"  | "[Product range]" | "Source field"    |
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				* Source with additional dimensions - Products
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Analysts from fields of other sources" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "CurrentFormula_Count"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					Then "Data sources" window is opened
					And I select current line in 'List' table
				* Configuring filters
					Then "Data source (create)*" window is opened
					And I move to the tab named 'FiltersPage'
					And I expand current line in 'FieldsTreeDB' table
					And I go to line in 'FieldsTreeDB' table:
						| "Field"         |
						| "Product range" |
					And I click the button named 'AddConditionItem'
					And I go to line in 'TreeOfFilterParametersDB' table:
						| "Field"           |
						| "[Product range]" |
					And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select "5C:Corporate performance management" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
					If '$$IsCPM$$' Then
						And I go to line in 'FieldsTreeDB' table:
							| "Field"    |
							| "Price type" |
						And I click the button named 'AddConditionItem'
						And I go to line in 'TreeOfFilterParametersDB' table:
							| "Field"      |
							| "[Price type]" |
					If '$$IsERPCPM$$' Then
						And I go to line in 'FieldsTreeDB' table:
							| "Field"    |
							| 'Price type' |
						And I click the button named 'AddConditionItem'
						And I go to line in 'TreeOfFilterParametersDB' table:
							| "Field"       |
							| "[Price type]" |
					And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create)*" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
			* Entering the calculation formula
				When "Report wizard*" window is opened
				And I click the button named 'ArbitraryCode'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
				If '$$LanguageInterface$$ = "Ru"' Then
					If '$$IsPerform$$' Then
						And I input 'Result = Max([IR_PricesNomenclature_Price_], 1500000)' text in the field named 'TextDocumentFieldProcedure'
					ElseIf '$$IsERPCPM$$' Then
						And I input 'Result = Max([RS_PriceNomenclature25_Price_], 1500000)' text in the field named 'TextDocumentFieldProcedure'
					Else
						And I input 'Result = Max([RS_PricesNomenclature_Price_], 1500000)' text in the field named 'TextDocumentFieldProcedure'
				Else
					And I input 'Result = Max([IR_ProRanPri_Price_], 1500000)' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'WriteAndCollapse'
	
	And I create default template for report type "VA - Analysts from fields of other sources"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Analysts from fields of other sources"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R10C1' for report type "VA - Analysts from fields of other sources"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R13C1' for report type "VA - Analysts from fields of other sources"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R16C1' for report type "VA - Analysts from fields of other sources"
	And I change sorting "Product range" "Description" to sorting "Product range" "Product ID" in template for expansion group with address 'R19C1' for report type "VA - Analysts from fields of other sources"

Scenario: 06.05 Creating report instance "VA - Analysts from fields of other sources"

	And I create report instance for report type "VA - Analysts from fields of other sources" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions "Software products" '' '' '' '' ''
	And I save the window as 'WindowTitle'

	* The document should be empty
		And 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Analysts from fields of other sources" | ''               | ''                | ''             | ''           |
			| ''                                          | ''               | ''                | ''             | ''           |
			| ''                                          | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                          | "Count"     | "Count"      | "Count"   | "Count" |
			| "Current formula"                           | '0'              | '0'               | '0'            | '0'          |
			| "Other source"                           | '0'              | '0'               | '0'            | '0'          |
			| "Analytics transformation"                    | '0'              | '0'               | '0'            | '0'          |
			| "Calculated source"                   | '0'              | '0'               | '0'            | '0'          |
			| "Recalculation in code"                           | '0'              | '0'               | '0'            | '0'          |

	* Running calculation
		And I click the button named 'FormFillByDefault'

	* Comparing the result
		Then '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Analysts from fields of other sources"                       | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Count"     | "Count"      | "Count"   | "Count" |
			| "Current formula"                                                 | '12'             | '24'              | '36'           | '72'         |
			| "5C:Corporate performance management "                                      | '4'              | '8'               | '12'           | '24'         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '2'              | '4'               | '6'            | '12'         |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '6'              | '12'              | '18'           | '36'         |
			| "Other source"                                                 | '15'             | '15'              | '15'           | '45'         |
			| "5C:Corporate performance management "                                      | '5'              | '5'               | '5'            | '15'         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '5'              | '5'               | '5'            | '15'         |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '5'              | '5'               | '5'            | '15'         |
			| "Analytics transformation"                                          | '6'              | '12'              | '18'           | '36'         |
			| "1Software upgrade "                                  | '6'              | '12'              | '18'           | '36'         |
			| "5C:Corporate performance management "                                      | '2'              | '4'               | '6'            | '12'         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '1'              | '2'               | '3'            | '6'          |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '3'              | '6'               | '9'            | '18'         |
			| "Calculated source"                                         | '6'              | '12'              | '9'            | '27'         |
			| ' '                                                               | '0'              | '0'               | '9'            | '9'          |
			| "5C:Corporate performance management "                                      | '0'              | '0'               | '3'            | '3'          |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '0'              | '0'               | '3'            | '3'          |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '0'              | '0'               | '3'            | '3'          |
			| "2Software implementation "                                | '3'              | '6'               | '0'            | '9'          |
			| "5C:Corporate performance management "                                      | '1'              | '2'               | '0'            | '3'          |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '1'              | '2'               | '0'            | '3'          |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '1'              | '2'               | '0'            | '3'          |
			| "3Software sale "                               | '3'              | '6'               | '0'            | '9'          |
			| "5C:Corporate performance management "                                      | '1'              | '2'               | '0'            | '3'          |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '1'              | '2'               | '0'            | '3'          |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '1'              | '2'               | '0'            | '3'          |
			| "Recalculation in code"                                                 | '4,500,000'      | '4,500,000'       | '4,661,400'    | '13,661,400' |
			| "1Software upgrade "                                  | '4,500,000'      | '4,500,000'       | '4,661,400'    | '13,661,400' |
			| "5C:Corporate performance management "                                      | '1,500,000'      | '1,500,000'       | '1,553,800'    | '4,553,800'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '1,500,000'      | '1,500,000'       | '1,553,800'    | '4,553,800'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '1,500,000'      | '1,500,000'       | '1,553,800'    | '4,553,800'  |
			
	* Saving and closing the document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 06.06 Checking for recursive nesting of dimension extension

	And I open report wizard with name "VA - Analysts from fields of other sources"
	And I add row with name 'Recursion in analytics' in report wizard
	And I add dimension with code "VA0Product" in cell 'R7C3' in report wizard

	* Entering data sources
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'AddOperand1'
		Then "Data sources" window is opened
		And I click the button named 'FormCreate'
		Then "Data source (create)" window is opened
		And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Analysts from fields of other sources" string
		And I click Choice button of the field named 'IndicatorFilter'
		And I select indicator with code "CurrentFormula_Count"
		Then "Data source (create)*" window is opened
		And I select current line in 'ComplianceTable' table
		And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
		And I finish line editing in 'ComplianceTable' table
		And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
		And I select current line in 'ComplianceTable' table
		* Data source for dimension extension No. 1
			Then "Data sources" window is opened
			And I click the button named 'FormCreate'
			Then "Data source (create)" window is opened
			And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Data to add analytics" string
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "Goods_Count"
			Then "Data source (create) *" window is opened
			And I select current line in 'ComplianceTable' table
			And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
			And I finish line editing in 'ComplianceTable' table
			And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
			And I select current line in 'ComplianceTable' table
			* Data source for dimension extension No. 2
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Data to add analytics" string
				And I click Choice button of the field named 'IndicatorFilter'
				And I select indicator with code "Goods_Count"
				Then "Data source (create)*" window is opened
				And I click the button named 'FormWriteAndClose'
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Data source (create)*" window is opened
			And I click the button named 'FormWriteAndClose'
		Then "Data sources" window is opened
		And I select current line in 'List' table
		Then "Data source (create)*" window is opened
		And I click the button named 'FormWriteAndClose'
		* Receiving an error message
			Then "1C:Enterprise" window is opened
			And I click the button named 'OK'
			Затем я жду, что в сообщениях пользователю будет подстрока "Data source used to add data to dimensions cannot contain dimension filling method \"Another source field\"." в течение 30 секунд

	* Closing all windows
		When "Data source (create)*" window is opened
		And I close "Data source (create)*" window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'
		Then "Data sources" window is opened
		And I close "Data sources" window
		Then "Report wizard" window is opened
		And I click the button named 'UndoFormulaEdit'
	
