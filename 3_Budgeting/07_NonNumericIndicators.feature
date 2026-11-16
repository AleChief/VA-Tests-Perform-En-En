#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 07. Working with non-numeric indicators

	As Administrator I want to
	Check that report types with non-numeric indicators are calculated and saved

Background:

	And I close all client application windows

Scenario: 07.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 07.01 Creating report group "VA - Non-Numbers and Groupings (group)"

	And I create report type group with name "VA - Non-Numbers and Groupings (group)" and parent "VA - Report group"

Scenario: 07.02 Creating report type "VA - Non-Numbers (source)"

	And I create report type with name "VA - Non-Numbers (source)" and parent "VA - Non-Numbers and Groupings (group)"
	
	And I open report type with name "VA - Non-Numbers (source)"
	And I set checkbox named 'ProjectSeparation'
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened

	And I add row with name "Goods" in report wizard

	And I add column with name "Price" in report wizard
	And I add column with name "DateReceipts" in report wizard
	And I add column with name "IncludeInPrice" in report wizard
	And I add column with name "Product ID" in report wizard

	And I change indicator property 'TotalKind' to "Average" in cell 'R2C2' in report wizard
	And I change indicator property 'ValueType' to "Date" in cell 'R2C3' in report wizard
	And I change indicator property 'TotalKind' to "Minimum" in cell 'R2C3' in report wizard
	And I change indicator property 'ValueType' to "Boolean" in cell 'R2C4' in report wizard
	And I change indicator property 'TotalKind' to "Total by dimensions is not calculated" in cell 'R2C4' in report wizard
	And I change indicator property 'ValueType' to "Line" in cell 'R2C5' in report wizard

	And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard

	And I create default template for report type "VA - Non-Numbers (source)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Non-Numbers (source)"

Scenario: 07.03 Creating report type "VA - Non-Numbers (recipient)"

	And I create report type with name "VA - Non-Numbers (recipient)" and parent "VA - Non-Numbers and Groupings (group)"
	
	And I open report type with name "VA - Non-Numbers (recipient)"
	And I set checkbox named 'ProjectSeparation'
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened

	And I add row with name "Goods" in report wizard
	And I add row with name "Formulas" in report wizard
	And I add row with name "Source" in report wizard

	And I add column with name "Price" in report wizard
	And I add column with name "DateReceipts" in report wizard
	And I add column with name "IncludeInPrice" in report wizard
	And I add column with name "Product ID" in report wizard

	And I change indicator properties 'ValueType' to "Date" in cell 'R2C3:R4C3' in report wizard
	* Checking and changing totals
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R2C3" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "* (Report indicators)" window is opened
		Then the form attribute named 'TotalKind' became equal to "Total by dimensions is not calculated"
		And drop-down list named 'TotalKind' contains values
			| "Total by dimensions is not calculated" |
			| "Minimum" |
			| "Maximum" |	
		And I select "Maximum" exact value from the drop-down list named 'TotalKind'
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Report indicators) *" window closing in 20 seconds
	And I change indicator properties 'ValueType' to "Boolean" in cell 'R2C4:R4C4' in report wizard
	And I change indicator properties 'ValueType' to "Line" in cell 'R2C5:R4C5' in report wizard
	And I change indicator properties 'TotalKind' to "Maximum" in cell 'R2C3:R4C5' in report wizard
	And I add dimension with code "VA0Product" in cell 'R2C3' in report wizard
	When "Report wizard" window is opened
	And I click the button named 'CopyAndShiftDown1'
					
	* Configuring calculation formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		* Products
			* Price
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_Price" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* DateOfReceipt
				Then "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Non-Numbers (source)" string
				And I click Choice button of the field named 'IndicatorFilter'
				And I select indicator with code "Goods_DateReceipts"
				Then "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* IncludeInPrice
				Then "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_IncludeInPrice" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* Article number
				Then "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_ProductID" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
		* Formulas
			* Price
				* Adding sources
					When "Report wizard" window is opened
					And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
					And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
					And I click the button named 'AddOperand1'
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Non-Numbers (source)" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "Goods_Price"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					And I wait "Data source (create) *" window closing in 20 seconds
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select "VA - Non-Numbers (source)" exact value from the drop-down list named 'ReportTypeFilter'
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "Goods_IncludeInPrice"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					And I wait "Data source (create) *" window closing in 20 seconds
					Then "Data sources" window is opened
					And I close "Data sources" window
				* Entering a formula
					When "Report wizard" window is opened
					And I input " ?([VANonNumbersSource_Goods_IncludeInPrice01],[VANonNumbersSource_Goods_Price01],-1) " text in the field named 'TextDocumentFieldProcedure'
					And I click the button named 'WriteAndCollapse'
			* DateOfReceipt
				* Adding sources
					When "Report wizard" window is opened
					And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
					And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
					And I click the button named 'AddOperand1'
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Non-Numbers (source)" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "Goods_DateReceipts"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					And I wait "Data source (create) *" window closing in 20 seconds
					Then "Data sources" window is opened
					And I select current line in 'List' table
				* Entering a formula
					Then "Report wizard *" window is opened
					And I input "[VANonNumbersSource_Goods_DateReceipts01] + 86400" text in the field named 'TextDocumentFieldProcedure'
					And I click the button named 'WriteAndCollapse'
			* IncludeInPrice
				* Adding sources
					When "Report wizard" window is opened
					And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
					And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
					And I click the button named 'AddOperand1'
					Then "Data sources" window is opened
					And I click the button named 'FormCreate'
					Then "Data source (create)" window is opened
					And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Non-Numbers (source)" string
					And I click Choice button of the field named 'IndicatorFilter'
					And I select indicator with code "Goods_IncludeInPrice"
					Then "Data source (create) *" window is opened
					And I click the button named 'FormWriteAndClose'
					And I wait "Data source (create) *" window closing in 20 seconds
					Then "Data sources" window is opened
					And I select current line in 'List' table
				* Entering a formula
					Then "Report wizard *" window is opened
					And I click the button named 'ArbitraryCode'
					And I input "Result = NOT [VANonNumbersSource_Goods_IncludeInPrice02]" text in the field named 'TextDocumentFieldProcedure'
					And I click the button named 'WriteAndCollapse'
			* Article number
				* Adding sources
					When "Report wizard" window is opened
					And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C5' cell
					And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
					And I click the button named 'RefToIndicator1'
					And I select indicator with code "Goods_ProductID" of report type "VA - Non-Numbers (source)"
					Then "Report wizard *" window is opened
					And I click the button named 'WriteFormula'
				* Entering a formula
					Then "Report wizard" window is opened
					And I click the button named 'ArbitraryCode'
					And I input text in the field named 'TextDocumentFieldProcedure'
						|"tString = [VANonNumbersSource_Goods_ProductID01];"|
						|'Result = "";'|
						|'For Cnt = 1 To StrLen(tString) Do'|
						|' Result = Mid(tString, Cnt, 1) + Result;'|
						|'EndDo; '|
					And I click the button named 'WriteAndCollapse'
		* Source
			* Price
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
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
				And I move to the tab named 'FiltersPage'
				And I expand current line in 'FieldsTreeDB' table
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
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I go to line in 'FieldsTreeDB' table:
					| "Field"         |
					| "Product range" |
				And I click the button named 'AddConditionItem'
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"           |
					| "[Product range]" |
			* Saved configuration
					And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select current line in 'TreeOfFilterParametersDB' table
					And I select "Saved filter setting" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					Then "Saved filter settings" window is opened
					And I click the button named 'FormCreate'
					Then "Set up filter (create)" window is opened
					And I go to line in 'FieldsTreeDB' table:
						| "Field"   |
						| "Reference" |										
					And I click the button named 'AddConditionItem'
					And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select current line in 'TreeOfFilterParametersDB' table
					And I select "Not equal to a fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I select "3C:Enterprise 8 CORP. Client license for 100 users" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
					And I click the button named 'FormWriteAndClose'
					And I wait "Set up filter (create) *" window closing in 20 seconds
					Then "Saved filter settings" window is opened
					And I select current line in 'List' table
				Then "Data source (create) *" window is opened
				And I finish line editing in 'TreeOfFilterParametersDB' table
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* DateOfReceipt
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
				If '$$IsCPM$$' Then
					And I input text in the field named 'QueryTextForm'
						|'SELECT'|
						|' BEGINOFPERIOD(ItemsPrices.Period, MONTH) AS Period,'|
						|' MAX(DATEADD(BEGINOFPERIOD(ItemsPrices.Period, MONTH), DAY, 3)) AS Date,'|
						|' ItemsPrices.Products AS Products'|
						|'FROM'|
						|' InformationRegister.ItemsPrices AS ItemsPrices'|
						|'WHERE'|
						|' ItemsPrices.PriceType_ = &PriceType_'|
						|' AND ItemsPrices.Products <> &ProductException'|
						|''|
						|'GROUP BY'|
						|' ItemsPrices.Products,'|
						|' BEGINOFPERIOD(ItemsPrices.Period, MONTH) '|
				If '$$IsERPCPM$$' Then
					And I input text in the field named 'QueryTextForm'
						|'SELECT'|
						|' BEGINOFPERIOD(ItemsPrices.Period, MONTH) AS Period,'|
						|' MAX(DATEADD(BEGINOFPERIOD(ItemsPrices.Period, MONTH), DAY, 3)) AS Date,'|
						|' ItemsPrices.Products AS Products'|
						|'FROM'|
						|' InformationRegister.ItemsPrices25 AS ItemsPrices'|
						|'WHERE'|
						|' ItemsPrices.PriceKind = &PriceType_'|
						|' AND ItemsPrices.Products <> &ProductException'|
						|''|
						|'GROUP BY'|
						|' ItemsPrices.Products,'|
						|' BEGINOFPERIOD(ItemsPrices.Period, MONTH) '|
				And I click the button named 'EditQueryText'
				And I move to the tab named 'ComplianceAnalyst'
				And I expand a line in 'FieldsTreeDB' table
					| "Field"                     |
					| "Data source fields(3)" |
				And I go to line in 'FieldsTreeDB' table:
					| "Field" |
					| 'Date' |
				And I go to line in 'ComplianceTable' table:
					| "Destination dimension" | "Column name" | "Filling method" |
					| "Value"            | '[Period]'    | "Source field"    |
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select context menu item named 'ButtonUnmap' of the form attribute named 'ComplianceTable'
				And I select context menu item named 'ButtonMapDimensions' of the form attribute named 'ComplianceTable'
				And I move to the tab named 'FiltersPage'
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"     |
					| '[PriceType_]' |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"                     |
					| '[ProductException]' |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I select "3C:Enterprise 8 CORP. Client license for 100 users" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				When "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* IncludeInPrice
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
				And I change checkbox named 'UseMultiperiodContext'
				If '$$IsPerform$$' Then
					And I input text in the field named 'QueryTextForm'
						|'SELECT'|
						|' Products.Ref IN(&CorporatePerformanceManagement) AS ЭтоУх,'|
						|' Products.Ref AS Ref'|
						|'FROM'|
						|' Catalog.Products AS Products'|
						|'WHERE'|
						|' Products.Parent = &ProductKind'|
						|' AND NOT Products.IsFolder'|
						|' AND Products.Ref <> &ProductException'|
				Else
					And I input text in the field named 'QueryTextForm'
						|'SELECT'|
						|' Products.Ref IN(&CorporatePerformanceManagement) AS ЭтоУх,'|
						|' Products.Ref AS Ref'|
						|'FROM'|
						|' Catalog.Products AS Products'|
						|'WHERE'|
						|' Products.ProductKind = &ProductKind'|
						|' AND NOT Products.IsFolder'|
						|' AND Products.Ref <> &ProductException'|
				And I click the button named 'EditQueryText'
				And I move to the tab named 'ComplianceAnalyst'
				And I move to the tab named 'FiltersPage'
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"              |
					| '[ProductKind]' |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				If '$$IsPerform$$' Then
					When "Product range" window is opened
					And I close "Product range" window
				If '$$IsERPCPM$$' Then
					When "Nomenclature types" window is opened
					And I close "Nomenclature types" window
				And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"                  |
					| '[CorporatePerformanceManagement]' |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value list" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				Then "Edit value list*" window is opened
				And in the table 'ValueList' I click the button named 'ValueListAdd'
				Then "Product range" window is opened
				And I click the button named 'FormFind'
				Then the form named 'UniversalListFindExtForm' is opened
				And I change the radio button named 'CompareType' value to "Exact match"
				And I input "5C:Corporate performance management" text in the field named 'Pattern'
				And I click the button named 'Find'
				Then "Product range" window is opened
				And I select current line in 'List' table
				Then "Edit value list*" window is opened
				And I finish line editing in 'ValueList' table
				And in the table 'ValueList' I click the button named 'ValueListAdd'
				Then "Product range" window is opened
				And I click the button named 'FormFind'
				Then the form named 'UniversalListFindExtForm' is opened
				And I change the radio button named 'CompareType' value to "Exact match"
				And I input "1C:ERP. Corporate performance management" text in the field named 'Pattern'
				And I click the button named 'Find'
				Then "Product range" window is opened
				And I select current line in 'List' table
				Then "Edit value list*" window is opened
				And I finish line editing in 'ValueList' table
				And I click the button named 'OK'
				Then "Data source (create) *" window is opened
				And I finish line editing in 'TreeOfFilterParametersDB' table
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"                     |
					| '[ProductException]' |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I select "3C:Enterprise 8 CORP. Client license for 100 users" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				Then "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* Article number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I click the button named 'FormCreate'
				Then "Data source (create)" window is opened
				And I select "Current infobase catalog" exact value from the drop-down list named 'MethodOfObtaining'
				And I click Choice button of the field named 'DBObjects'
				And I search and select element "Product range" "At beginning of line" by field "Catalog" in list "Infobase catalogs"
				If number of 'FieldsTreeDB' table lines is 'equal' 1 Then
					And I expand current line in 'FieldsTreeDB' table
				And I go to line in 'FieldsTreeDB' table:
					| "Field"    |
					| "Product ID" |
				And I go to line in 'ComplianceTable' table:
					| "Destination dimension" | "Column name" | "Filling method" |
					| "Value"            | "[Code]"       | "Source field"    |
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select context menu item named 'ButtonUnmap' of the form attribute named 'ComplianceTable'
				And I select context menu item named 'ButtonMapDimensions' of the form attribute named 'ComplianceTable'
				And I move to the tab named 'FiltersPage'
				And While the number of 'TreeOfFilterParametersDB' table lines 'more' 0 Then
					And I click the button named 'TreeOfFilterParametersDBDelete'
				If '$$IsCPM$$' Then
					And I go to line in 'FieldsTreeDB' table:
						| "Field"                  |
						| "Product range group" |
					And I click the button named 'AddConditionItem'
					And I go to line in 'TreeOfFilterParametersDB' table:
						| "Field"                    |
						| "[Product range group]" |
					And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select current line in 'TreeOfFilterParametersDB' table
					And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I select "VA - Product range group" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
				If '$$IsERPCPM$$' Then
					And I go to line in 'FieldsTreeDB' table:
						| "Field"             |
						| 'Product kind' |
					And I click the button named 'AddConditionItem'
					And I go to line in 'TreeOfFilterParametersDB' table:
						| "Field"               |
						| '[Nomenclature type]' |
					And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select current line in 'TreeOfFilterParametersDB' table
					And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
				When "Data source (create) *" window is opened
				And I go to line in 'FieldsTreeDB' table:
					| "Field"   |
					| "Reference" |
				And I click the button named 'AddConditionItem'
				And I go to line in 'TreeOfFilterParametersDB' table:
					| "Field"     |
					| "[Reference]" |
				And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I select current line in 'TreeOfFilterParametersDB' table
				And I select "Saved filter setting" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I select "Catalog_Product range  Reference<>1С:Pредприятие 8 КОРP. Клиентская лицензия for 100 рабочих мест" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				When "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I select current line in 'List' table
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
				When "Report wizard" window is opened
				And I close "Report wizard" window

	And I create default template for report type "VA - Non-Numbers (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Non-Numbers (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R10C1' for report type "VA - Non-Numbers (recipient)"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R12C1' for report type "VA - Non-Numbers (recipient)"

Scenario: 07.04 Creating report type "VA - Calculation in code"

	And I create report type with name "VA - Calculation in code" and parent "VA - Non-Numbers and Groupings (group)"
	And I open report type with name "VA - Calculation in code"
	And I set checkbox named 'ProjectSeparation'
	And I click the button named 'RecordButtonForm'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened
	And I add row with name "Source" in report wizard
	And I add row with name "SourceCode" in report wizard
	And I add row with name "DestinationCode" in report wizard
	And I add row with name "FormulasCode" in report wizard
	And I add row with name "Calculation" in report wizard
	And I add column with name "Number" in report wizard
	And I add column with name "Date" in report wizard
	And I add column with name "Boolean" in report wizard
	And I add column with name "Line" in report wizard

	And I change indicator properties 'ValueType' to "Date" in cell 'R2C3:R6C3' in report wizard
	And I change indicator properties 'ValueType' to "Boolean" in cell 'R2C4:R6C4' in report wizard
	And I change indicator properties 'ValueType' to "Line" in cell 'R2C5:R6C5' in report wizard

	* Setting report dimensions
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
		When "Report wizard" window is opened
		And I click the button named 'CopyDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I click the button named 'InsertDimension'

	* Configuring calculation formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		* Source
			* Number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_Price" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* Date
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_DateReceipts" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* Boolean
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_IncludeInPrice" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
			* Row
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'RefToIndicator1'
				And I select indicator with code "Goods_ProductID" of report type "VA - Non-Numbers (source)"
				Then "Report wizard *" window is opened
				And I click the button named 'WriteAndCollapse'
		* SourceCode
			* Number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'ArbitraryCode'
				And I click the button named 'EditProcedure'
				Then "VA - Calculation in code: Calculation formula" window is opened
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VANonNumbersSource:Goods_Price\");"|
					|'AdditionalParameters = New Structure("Overall",Enums.IndicatorTotalsTypes.Sum);'|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization),,AdditionalParameters);'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = 0;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).Value;'|
					|'EndIf;'|
				And I click the button named 'FormWriteAndClose'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
				Then "Report wizard" window is opened
				And I click the button named 'WriteAndCollapse'
			* Date
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'ArbitraryCode'
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VANonNumbersSource:Goods_DateOfReceipt\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
					|''|
				And I click the button named 'WriteAndCollapse'
			* Boolean
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VANonNumbersSource:Goods_IncludeInPrice\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Row
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VANonNumbersSource:Goods_SKU\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
		* DestinationCode
			* Number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VACalculationInCode:Source_Number\");"|
					|'AdditionalParameters = New Structure("Overall",Enums.IndicatorTotalsTypes.Sum);'|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization),,AdditionalParameters);'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = 0;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).Value;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Date
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VACalculationInCode:Source_Date\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Boolean
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VACalculationInCode:Source_Boolean\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Row
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'ArrayIndicators = New Array;'|
					|"ArrayIndicators.Add(\"VACalculationInCode:Source_STRK\");"|
					|'tIndicatorsValues = GetIndicatorsValue(New Structure("ReportsIndicators,Currency,ReportPeriod,Organization",ArrayIndicators,ObjectOfARAP.MainCurrency,ObjectOfARAP.ReportPeriod,ObjectOfARAP.Organization));'|
					|''|
					|'If tIndicatorsValues.Count() = 0 Then'|
					|' Result = Undefined;'|
					|'Else'|
					|' Result = tIndicatorsValues.Get(0).ValueNonNumeric;'|
					|'EndIf;'|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
		* FormulasCode
			* Number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input 'Result = Month(ObjectOfARAP.ReportPeriod.StartDate);' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Date
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input 'Result = RelativePeriod(ObjectOfARAP.ReportPeriod, -1).StartDate;' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Boolean
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input 'Result = DateBelongsToPeriod(ObjectOfARAP.ReportPeriod.StartDate, ObjectOfARAP.ArrayOfPeriods.Get(0));' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Row
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input text in the field named 'TextDocumentFieldProcedure'
					|'Result = String(ObjectOfARAP.Organization) + Chars.LF +'|
					|'String(ObjectOfARAP.Scenario) + Chars.LF + '|
					|'String(ObjectOfARAP.MainCurrency) + Chars.LF + '|
					|'String(ObjectOfARAP.ReportPeriod) + Chars.LF + '|
					|'String(ObjectOfARAP.Periodicity);'|
					|''|
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
		* Calculation
			* Number
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'ButtonMultiply'
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteFormula'
				Then "Report wizard" window is opened
				And I click the button named 'AddOperand1'
				Then "Data sources" window is opened
				And I go to line in 'List' table:
					| "Description"                        | "Indicator filter" | "Receipt method"                                 |
					| "VA - Calculation in code_FormulasCode number" | "FormulasCode number" | "Current infobase report indicator (easy setup)" |
				And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
				Then "VA - Calculation in code_FormulasCode number (Data source)" window is opened
				And I activate field named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				And I select "Another source field" exact value from the drop-down list named 'ComplianceTableFillingMethod' in 'ComplianceTable' table
				And I finish line editing in 'ComplianceTable' table
				And I activate field named 'MapTableDBAlias' in 'ComplianceTable' table
				And I select current line in 'ComplianceTable' table
				Then "Data sources" window is opened
				And I go to line in 'List' table:
					| "Description"                      | "Indicator filter" | "Receipt method"                                 |
					| "VA - Calculation in code_Source number" | "Source number"   | "Current infobase report indicator (easy setup)" |
				And I select current line in 'List' table
				Then "VA - Calculation in code_FormulasCode number (Data source) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "VA - Calculation in code_FormulasCode number (Data source) *" window closing in 20 seconds
				Then "Data sources" window is opened
				And I close "Data sources" window
				Then "Report wizard" window is opened
				And I click the button named 'WriteAndCollapse'
			* Date
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'WriteFormula'
				Then "Report wizard" window is opened
				And I input "Result = AddMonth([VACalculationInCode_Source_Date],1)" text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'ArbitraryCode'
				And I click the button named 'WriteAndCollapse'
			* Boolean
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'WriteFormula'
				Then "Report wizard" window is opened
				And I input "NOT {VACalculationInCode.Source_Boolean}" text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'WriteAndCollapse'
			* Row
				When "Report wizard" window is opened
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'WriteFormula'
				Then "Report wizard" window is opened
				And I input "\"!!! \"" text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'ButtonPlus'
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I click the button named 'WriteAndCollapse'

	And I create default template for report type "VA - Calculation in code"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Calculation in code"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R13C1' for report type "VA - Calculation in code"

Scenario: 07.05 Creating report type "VA - Grouping by analytics"

	And I create report type with name "VA - Grouping by analytics" and parent "VA - Non-Numbers and Groupings (group)"
	
	And I open report type with name "VA - Grouping by analytics"
	And I set checkbox named 'ProjectSeparation'
	And I move to the tab named 'DimensionsOfReport'
	And I select from the drop-down list named 'DimensionKind1'  by "VA0CFItems" string
	And I click the button named 'RecordButtonForm'
	When "Data restructuring" window is opened
	And I click the button named 'FormOK'

	And I click the button named 'EditTree'
	When "Report wizard" window is opened
	
	And I add row with name "Group" in report wizard
	And I add row with name "GoodsSum" in report wizard
	And I add row with name "GoodsNoTotal" in report wizard
	And I add column with name "Amount" in report wizard
	
	And I add column with name "Maximum" in report wizard
	And I add column with name "Minimum" in report wizard
	And I add column with name "Average" in report wizard
	And I add column with name "NoTotal" in report wizard

	And I change row parent to "Group" in cell 'R3C1' in report wizard
	And I change row parent to "Group" in cell 'R4C1' in report wizard

	* Changing indicator settings
		* Sum
			And I change indicator property 'TotalKind' to "Amount" in cell 'R3C2' in report wizard
			And I change indicator property 'TotalKind' to "Amount" in cell 'R4C2' in report wizard
		* Maximum
			And I change indicator property 'TotalKind' to "Maximum" in cell 'R3C3' in report wizard
			And I change indicator property 'TotalKind' to "Maximum" in cell 'R4C3' in report wizard
		* Minimum
			And I change indicator property 'TotalKind' to "Minimum" in cell 'R3C4' in report wizard
			And I change indicator property 'TotalKind' to "Minimum" in cell 'R3C4' in report wizard
		* Average
			And I change indicator property 'TotalKind' to "Average" in cell 'R3C5' in report wizard
			And I change indicator property 'TotalKind' to "Average" in cell 'R4C5' in report wizard
		* WithoutTotal
			And I change indicator property 'TotalKind' to "Total by dimensions is not calculated" in cell 'R3C6' in report wizard
			And I change indicator property 'TotalKind' to "Total by dimensions is not calculated" in cell 'R4C6' in report wizard

	* Setting report dimensions
		And I add dimension with code "VA0Product" in cell 'R3C3' in report wizard

	* Configuring calculation formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "Goods_Price" of report type "VA - Non-Numbers (source)"
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And I click the button named 'CopyAndMoveRight'
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "Goods_Price" of report type "VA - Non-Numbers (source)"
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And I click the button named 'CopyAndMoveRight'

	* Setting up calculation formulas for the group
		* Sum
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
			And I click the button named 'AmountByRowsHierarchy'
		* Maximum
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
			And I click the button named 'AmountByRowsHierarchy'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'ArbitraryCode'
			And I input "Result = Max([VAGroupingByAnalytics_GoodsSum_Maximum], [VAGroupingByAnalytics_GoodsNoTotal_Maximum]) " text in the field named 'TextDocumentFieldProcedure'
			And I click the button named 'WriteAndCollapse'
		* Minimum
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I input "?({VAGroupingByAnalytics.GoodsSum_Minimum}<{VAGroupingByAnalytics.GoodsNoTotal_Minimum},{VAGroupingByAnalytics.GoodsSum_Minimum},{VAGroupingByAnalytics.GoodsNoTotal_Minimum}) " text in the field named 'TextDocumentFieldProcedure'
			And I click the button named 'WriteAndCollapse'
		* Average
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C5' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I input "({VAGroupingByAnalytics.GoodsSum_Average} + {VAGroupingByAnalytics.GoodsNoTotal_Average})  /  2" text in the field named 'TextDocumentFieldProcedure'
			And I click the button named 'WriteAndCollapse'
		* WithoutTotal
			When "Report wizard" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C6' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C6' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'ButtonDivide'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C6' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'WriteAndCollapse'
			* The division by zero check should trigger
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
			Then "Report wizard *" window is opened
			And I input "?({VAGroupingByAnalytics.GoodsNoTotal_NoTotal}=0,-1,{VAGroupingByAnalytics.GoodsSum_NoTotal} / {VAGroupingByAnalytics.GoodsNoTotal_NoTotal}) " text in the field named 'TextDocumentFieldProcedure'
			And I click the button named 'WriteAndCollapse'
			When "Report wizard" window is opened
			And I close "Report wizard" window
									
	And I create default template for report type "VA - Grouping by analytics"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R9C1' for report type "VA - Grouping by analytics"

Scenario: 07.06 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Non-Numbers (source)" user "Budgeting1" for all companies
	And I add right "Read, write" for report type "VA - Non-Numbers (recipient)" user "Budgeting1" for all companies
	And I add right "Read, write" for report type "VA - Calculation in code" user "Budgeting1" for all companies
	And I add right "Read, write" for report type "VA - Grouping by analytics" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 07.07 Creating report instance - "VA - Non-Numbers (source)"

	And I create report instance for report type "VA - Non-Numbers (source)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)" | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL" | ''                | ''               | ''        |
			| ''                                      | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"  | "DateReceipts" | "IncludeInPrice" | "Product ID" |
			| "Goods"                                | '0'              | ''                | "No"            | ''        | '0'               | ''                | "No"            | ''        | '0'            | ''                | "No"            | ''        | '0'     | ''                | "No"            | ''        |

	* Filling indicator values
		* Entering price
			And I add values with indicator expansion in cell 'R6C2'
				| "VA0Product"                                                     | 'Value1'        |
				| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '180,000.00000'    |
				| "3C:Enterprise 8 CORP. Client license for 100 users" | '600,000.00000'    |
				| "5C:Corporate performance management"                                      | '1,250,000.00000'  |
				| "2C:Corporation"                                                  | '2,050,000.00000'  |
				| "1C:ERP. Corporate performance management"                                   | '1,950,000.00000'  |
		* Entering arrival date in cell
			And I enter value '1/1/2024' in cell 'R7C3'
			And I enter value '2/1/2024' in cell 'R8C3'
			And I enter value '3/1/2024' in cell 'R9C3'
			And I enter value '4/1/2024' in cell 'R10C3'
			And I enter value '5/1/2024' in cell 'R11C3'
		* Entering price list inclusion flag in cell
			And I enter value "Yes" in cell 'R7C4'
			And I enter value "Yes" in cell 'R8C4'
			And I enter value "Yes" in cell 'R9C4'
			And I enter value "Yes" in cell 'R10C4'
			And I enter value "Yes" in cell 'R11C4'
		* Entering article in cell
			And I enter value '000001' in cell 'R7C5'
			And I enter value '000002' in cell 'R8C5'
			And I enter value '000003' in cell 'R9C5'
			And I enter value '000004' in cell 'R10C5'
			And I enter value '000005' in cell 'R11C5'
		* Entering price in cell
			And I enter value '2,145,000.00000' in cell 'R7C6'
			And I enter value '2,255,000.00000' in cell 'R8C6'
			And I enter value '198,000.00000' in cell 'R9C6'
			And I enter value '660,000.00000' in cell 'R10C6'
			And I enter value '1,375,000.00000' in cell 'R11C6'
		* Entering arrival date in form
			And I add values with indicator expansion in cell 'R6C7'
				| "VA0Product"                   | 'Value1'   |
				| "5C:Corporate performance management"    | '5/2/2024'  |
				| "1C:ERP. Corporate performance management" | '1/2/2024'  |
		* Entering price list inclusion flag in form
			And I add values with indicator expansion in cell 'R6C8'
				| "VA0Product"                   | 'Value1' |
				| "5C:Corporate performance management"    | "Yes"        |
				| "1C:ERP. Corporate performance management" | "Yes"        |
				| "2C:Corporation"                | "No"       |
		* Entering article in form
			And I add values with indicator expansion in cell 'R6C9'
				| "VA0Product"                   | 'Value1' |
				| "1C:ERP. Corporate performance management" | '2000001'   |
				| "5C:Corporate performance management"    | '2000005'   |			
		* Copying indicators
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C6:R11C6' cell
			And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C7:R11C7' cell
			And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C8:R11C8' cell
			And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C9:R11C9' cell
			And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'

	* Comparing the final document
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)"                           | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                                                | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                                                | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL"     | ''                | ''               | ''        |
			| ''                                                                | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"      | "DateReceipts" | "IncludeInPrice" | "Product ID" |
			| "Goods"                                                          | '1,206,000'      | '1/1/2024'      | "No"            | ''        | '1,326,600'       | '1/2/2024'      | "No"            | ''        | '1,326,600'    | '1/2/2024'      | "No"            | ''        | '1,286,400' | '1/1/2024'      | "No"            | ''        |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1/1/2024'      | "Yes"             | '000001'  | '2,145,000'       | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000'    | '5/2/2024'      | "Yes"             | '2000005' | '1,846,667' | '1/1/2024'      | "Yes"             | ''        |
			| "2C:Corporation "                                                  | '2,050,000'      | '2/1/2024'      | "Yes"             | '000002'  | '2,255,000'       | ''                | "No"            | ''        | '2,255,000'    | ''                | "No"            | ''        | '2,186,667' | '2/1/2024'      | "Yes"             | ''        |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '3/1/2024'      | "Yes"             | '000003'  | '198,000'         | ''                | "No"            | ''        | '198,000'      | ''                | "No"            | ''        | '192,000'   | '3/1/2024'      | "Yes"             | ''        |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '4/1/2024'      | "Yes"             | '000004'  | '660,000'         | '1/2/2024'      | "Yes"             | '2000001' | '660,000'      | '1/2/2024'      | "Yes"             | '2000001' | '1,090,000' | '1/2/2024'      | "Yes"             | ''        |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '5/1/2024'      | "Yes"             | '000005'  | '1,375,000'       | ''                | "No"            | ''        | '1,375,000'    | ''                | "No"            | ''        | '1,116,667' | '5/1/2024'      | "Yes"             | ''        |

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 07.08 Interactive deletion of indicators

	And I create report instance for report type "VA - Non-Numbers (source)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Venus LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)" | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL" | ''                | ''               | ''        |
			| ''                                      | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"  | "DateReceipts" | "IncludeInPrice" | "Product ID" |
			| "Goods"                                | '0'              | ''                | "No"            | ''        | '0'               | ''                | "No"            | ''        | '0'            | ''                | "No"            | ''        | '0'     | ''                | "No"            | ''        |

	* Filling indicator values
		And I add values with indicator expansion in cell 'R6C1'
			| "Product range"                                                   | 'Period_3_Value3' | 'Period_1_Value1' | 'Period_1_Value2' | 'Period_2_Value1' | 'Period_1_Value3' | 'Period_1_Value4' | 'Period_2_Value2' | 'Period_2_Value3' | 'Period_2_Value4' | 'Period_3_Value1' | 'Period_3_Value2' | 'Period_3_Value4' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | "No"                | '180,000.00000'      | '3/1/2024'         | '198,000.00000'      | "Yes"                 | '000003'             | ''                   | "No"                | ''                   | '198,000.00000'      | ''                   | ''                   |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | "No"                | '600,000.00000'      | '5/1/2024'         | '1,375,000.00000'    | "Yes"                 | '000005'             | ''                   | "No"                | ''                   | '1,375,000.00000'    | ''                   | ''                   |
			| "5C:Corporate performance management"                                      | "Yes"                 | '1,250,000.00000'    | '1/1/2024'         | '2,145,000.00000'    | "Yes"                 | '000001'             | '5/2/2024'         | "Yes"                 | '2000005'            | '2,145,000.00000'    | '5/2/2024'         | '2000005'            |
			| "2C:Corporation"                                                  | "No"                | '2,050,000.00000'    | '2/1/2024'         | '2,255,000.00000'    | "Yes"                 | '000002'             | ''                   | "No"                | ''                   | '2,255,000.00000'    | ''                   | ''                   |
			| "1C:ERP. Corporate performance management"                                   | "Yes"                 | '1,950,000.00000'    | '4/1/2024'         | '660,000.00000'      | "Yes"                 | '000004'             | '1/2/2024'         | "Yes"                 | '2000001'            | '660,000.00000'      | '1/2/2024'         | '2000001'            |

	* Verifying the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)"                           | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                                                | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                                                | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL"     | ''                | ''               | ''        |
			| ''                                                                | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID" | "Price"      | "DateReceipts" | "IncludeInPrice" | "Product ID" |
			| "Goods"                                                          | '1,206,000'      | '1/1/2024'      | "No"            | ''        | '1,326,600'       | ''                | "No"            | ''        | '1,326,600'    | ''                | "No"            | ''        | '1,286,400' | ''                | "No"            | ''        |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1/1/2024'      | "Yes"             | '000001'  | '2,145,000'       | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000'    | '5/2/2024'      | "Yes"             | '2000005' | '1,846,667' | '1/1/2024'      | "Yes"             | ''        |
			| "2C:Corporation "                                                  | '2,050,000'      | '2/1/2024'      | "Yes"             | '000002'  | '2,255,000'       | ''                | "No"            | ''        | '2,255,000'    | ''                | "No"            | ''        | '2,186,667' | ''                | "Yes"             | ''        |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '3/1/2024'      | "Yes"             | '000003'  | '198,000'         | ''                | "No"            | ''        | '198,000'      | ''                | "No"            | ''        | '192,000'   | ''                | "Yes"             | ''        |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '4/1/2024'      | "Yes"             | '000004'  | '660,000'         | '1/2/2024'      | "Yes"             | '2000001' | '660,000'      | '1/2/2024'      | "Yes"             | '2000001' | '1,090,000' | '1/2/2024'      | "Yes"             | ''        |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '5/1/2024'      | "Yes"             | '000005'  | '1,375,000'       | ''                | "No"            | ''        | '1,375,000'    | ''                | "No"            | ''        | '1,116,667' | ''                | "Yes"             | ''        |

	* Entering an empty value manually
		And I enter value '0' in cell 'R7C2'
		And I enter value ' ' in cell 'R7C3'
		And I enter value "No" in cell 'R7C4'
		And I enter value ' ' in cell 'R7C5'

	* Clearing selected indicators
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R8C2:R8C5" cell
		And I click the button named 'SpreadsheetFieldTemplateClearRange'

	* Viewing price drill-down
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R6C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators*" window is opened
		Then 'IndicatorsDrilldown' table became equal
			| "Product range"                                                   | 'Value1' |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '180,000'   |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '600,000'   |
			| "1C:ERP. Corporate performance management"                                   | '1,950,000' |
		And I click the button named 'FormCancel'

	* Viewing date drill-down
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R6C3" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators*" window is opened
		Then 'IndicatorsDrilldown' table became equal
			| "Product range"                                                   | 'Value1'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '3/1/2024' |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '5/1/2024' |
			| "1C:ERP. Corporate performance management"                                   | '4/1/2024' |				
		And I go to line in 'IndicatorsDrilldown' table:
			| 'Value1'  | "Product range"                 |
			| '4/1/2024' | "1C:ERP. Corporate performance management" |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton1'
				
	* Deleting a row from the document form
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R9C2:R9C13" cell
		And I click the button named 'SpreadsheetFieldTemplateClearRange'
									
	* Deleting a row from the drill-down form
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R6C1" cell
		And I click the button named 'DisplayADrilldown'
		Then "Drill down indicators*" window is opened
		And I go to line in 'IndicatorsDrilldown' table:
			| "Product range"                                                   | 'Period_1_Value1' | 'Period_1_Value2' | 'Period_1_Value3' | 'Period_1_Value4' | 'Period_2_Value1' | 'Period_2_Value3' | 'Period_3_Value1' | 'Period_3_Value3' |
			| "3C:Enterprise 8 CORP. Client license for 100 users" | '600,000.00000'      | '5/1/2024'         | "Yes"                 | '000005'             | '1,375,000.00000'    | "No"                | '1,375,000.00000'    | "No"                |
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownDelete'
		And I click the button named 'FormOKButton1'
					
	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)" | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                      | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                      | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL"     | ''                | ''               | ''        |
			| ''                                      | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"      | "DateReceipts" | "IncludeInPrice" | "Product ID"        |
			| "Goods"                                | '1,950,000'      | ''                | "No"            | ''        | '1,686,667'       | ''                | "No"            | ''        | '1,686,667'    | ''                | "No"            | ''        | '1,724,286' | ''                | "No"            | ''        |
			| "5C:Corporate performance management "            | '0'              | ''                | "No"            | ' '       | '2,145,000'       | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000'    | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000' | ''                | "Yes"             | ''        |
			| "2C:Corporation "                        | '0'              | ''                | "No"            | ''        | '2,255,000'       | ''                | "No"            | ''        | '2,255,000'    | ''                | "No"            | ''        | '2,255,000' | ''                | "No"            | ''        |
			| "1C:ERP. Corporate performance management "         | '1,950,000'      | ''                | "Yes"             | '000004'  | '660,000'         | '1/2/2024'      | "Yes"             | '2000001' | '660,000'      | '1/2/2024'      | "Yes"             | '2000001' | '1,090,000' | ''                | "Yes"             | ''        |
		
	* Saving, refreshing the table
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		When '$WindowTitle$' window is opened
		And I click the button named 'FormUpdateConsideringVersions'
												
	* Clearing all indicators
		When '$WindowTitle$' window is opened
		And I click the button named 'Clear'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		When '$WindowTitle$' window is opened
		And I click the button named 'FormUpdateConsideringVersions'

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)" | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''      | ''                | ''               | ''        |
			| ''                                      | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL" | ''                | ''               | ''        |
			| ''                                      | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"  | "DateReceipts" | "IncludeInPrice" | "Product ID"        |
			| "Goods"                                | '0'              | ''                | "No"            | ''        | '0'               | ''                | "No"            | ''        | '0'            | ''                | "No"            | ''        | '0'     | ''                | "No"            | ''        |

	* Rolling back a version
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window

	* Verifying the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Non-Numbers (source)" | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                      | ''               | ''                | ''               | ''        | ''                | ''                | ''               | ''        | ''             | ''                | ''               | ''        | ''          | ''                | ''               | ''        |
			| ''                                      | "January 2024" | ''                | ''               | ''        | "February 2024" | ''                | ''               | ''        | "March 2024" | ''                | ''               | ''        | "TOTAL"     | ''                | ''               | ''        |
			| ''                                      | "Price"           | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"            | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"         | "DateReceipts" | "IncludeInPrice" | "Product ID"        | "Price"      | "DateReceipts" | "IncludeInPrice" | "Product ID"        |
			| "Goods"                                | '1,950,000'      | ''                | "No"            | ''        | '1,686,667'       | ''                | "No"            | ''        | '1,686,667'    | ''                | "No"            | ''        | '1,724,286' | ''                | "No"            | ''        |
			| "5C:Corporate performance management "            | '0'              | ''                | "No"            | ' '       | '2,145,000'       | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000'    | '5/2/2024'      | "Yes"             | '2000005' | '2,145,000' | ''                | "Yes"             | ''        |
			| "2C:Corporation "                        | '0'              | ''                | "No"            | ''        | '2,255,000'       | ''                | "No"            | ''        | '2,255,000'    | ''                | "No"            | ''        | '2,255,000' | ''                | "No"            | ''        |
			| "1C:ERP. Corporate performance management "         | '1,950,000'      | ''                | "Yes"             | '000004'  | '660,000'         | '1/2/2024'      | "Yes"             | '2000001' | '660,000'      | '1/2/2024'      | "Yes"             | '2000001' | '1,090,000' | ''                | "Yes"             | ''        |
		
	* Saving and closing the document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 07.09 Creating report instance - "VA - Non-Numbers (recipient)"

	And I create report instance for report type "VA - Non-Numbers (recipient)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* Calculating the document and comparing the final document
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_NonNumericIndicatorsReceiver_Mercury.mxl"
	
	* Calculating again and comparing the document, the result should not change
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_NonNumericIndicatorsReceiver_Mercury.mxl"

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 07.10 Calculation with deletion of indicators

	* Copying report instance
		And I find report type with name "VA - Non-Numbers (recipient)" in list
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And in the table 'List' I click the button named 'ListFind'
		Then "Find" window is opened
		And I select "Company" exact value from the drop-down list named 'FieldSelector'
		And I select from the drop-down list named 'Pattern'  by "Mercury LLC" string
		And I click the button named 'Find'
		Then "Report instances" window is opened
		And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'

	* Checking form
		When "Specify key document attributes" window is opened
		Then the form attribute named 'Dimension1' became equal to "3Software sale"
		And the form attribute named 'Dimension2' became equal to ""
		And the form attribute named 'Dimension3' became equal to ""
		And the form attribute named 'Dimension4' became equal to ""
		And the form attribute named 'Dimension5' became equal to ""
		And the form attribute named 'Dimension6' became equal to ""
		And the form attribute named 'TemplateForImport' became equal to "VA - Non-Numbers (recipient)"
		And the form attribute named 'DisplayCurrency' became equal to "RUB"
		And the form attribute named 'ReportKind' became equal to "VA - Non-Numbers (recipient)"
		And the form attribute named 'AdditionalCurrencies' became equal to "USD; EUR"
		And the editing text of form attribute named 'UnitOfMeasure' became equal to "units"
		And form element named 'CopyingValue' became equal to "Report instance *" by template
		And the form attribute named 'ExternalInfobase' became equal to "Current infobase"
		And the form attribute named 'Organization' became equal to "Mercury LLC"
		And the form attribute named 'MainCurrency' became equal to "RUB"
		And the form attribute named 'ReportFrequency' became equal to "Month"
		And the form attribute named 'RollupFrequency' became equal to "Ten-day period"
		And the form attribute named 'EndingPeriod' became equal to "March 2024"
		And the form attribute named 'ReportPeriod' became equal to "January 2024"
		And the form attribute named 'LastEditedBy' became equal to ""
		And the form attribute named 'ProcessingRule' became equal to "VA - Non-Numbers (recipient)"
		And the form attribute named 'CheckRule' became equal to "VA - Non-Numbers (recipient)"
		And the form attribute named 'Project' became equal to "VA - Main project"
		And the form attribute named 'RegulationVersion' became equal to "VA - Main regulations"
		And the form attribute named 'ReportGenerationMethod' became equal to "By processing rule"
		And the form attribute named 'Scenario' became equal to "VA - Main scenario"
		And the form attribute named 'PeriodManagement' became equal to "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>"
		And the form attribute named 'AccuracyLevel' became equal to "0"
		And the form attribute named 'TemplateForReport' became equal to "VA - Non-Numbers (recipient)"

	* Changing company
		When "Specify key document attributes" window is opened
		And I click Choice button of the field named 'Organization'
		And I select company "Venus LLC"
		And I click the button named 'FormApplyAndClose'
		Then I open report instance for report type "VA - Non-Numbers (recipient)" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''

	* Deleting the area of calculated indicators
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R6C2:R23C5" cell
		And I click the button named 'SpreadsheetFieldTemplateClearRange'

	* Checking table contents
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_NonNumericIndicatorsReceiver_Mercury.mxl"

	* Calculating the document and comparing the final document
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_NonNumericIndicatorsReceiver_Venus.mxl"
	
	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		And I wait '$WindowTitle$' window opening in 20 seconds

	* Checking the movements
		And I check report instance movements are equal to "3_Budgeting\Layouts\07\VA_NonNumericIndicatorsReceiver_Venus_Movements.mxl"

Scenario: 07.11 Creating report instance - "VA - Calculation in code"

	And I create report instance for report type "VA - Calculation in code" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Calculating the document and verifying the result
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation in code"                                              | ''               | ''           | ''       | ''                                                                 | ''                | ''           | ''       | ''                                                                  | ''             | ''           | ''       | ''                                                               | ''           | ''           | ''       | ''       |
			| ''                                                                | ''               | ''           | ''       | ''                                                                 | ''                | ''           | ''       | ''                                                                  | ''             | ''           | ''       | ''                                                               | ''           | ''           | ''       | ''       |
			| ''                                                                | "January 2024" | ''           | ''       | ''                                                                 | "February 2024" | ''           | ''       | ''                                                                  | "March 2024" | ''           | ''       | ''                                                               | "TOTAL"      | ''           | ''       | ''       |
			| ''                                                                | "Number"          | "Date"       | "Boolean" | "Line"                                                           | "Number"           | "Date"       | "Boolean" | "Line"                                                            | "Number"        | "Date"       | "Boolean" | "Line"                                                         | "Number"      | "Date"       | "Boolean" | "Line" |
			| "Source"                                                        | '6,030,000'      | ''           | "No"    | ''                                                                 | '6,633,000'       | ''           | "No"    | ''                                                                  | '6,633,000'    | ''           | "No"    | ''                                                               | '19,296,000' | ''           | "No"    | ''       |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1/1/2024' | "Yes"     | '000001'                                                           | '2,145,000'       | '5/2/2024' | "Yes"     | '2000005'                                                           | '2,145,000'    | '5/2/2024' | "Yes"     | '2000005'                                                        | '5,540,000'  | '5/2/2024' | "Yes"     | ''       |
			| "2C:Corporation "                                                  | '2,050,000'      | '2/1/2024' | "Yes"     | '000002'                                                           | '2,255,000'       | ''           | "No"    | ''                                                                  | '2,255,000'    | ''           | "No"    | ''                                                               | '6,560,000'  | '2/1/2024' | "Yes"     | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '3/1/2024' | "Yes"     | '000003'                                                           | '198,000'         | ''           | "No"    | ''                                                                  | '198,000'      | ''           | "No"    | ''                                                               | '576,000'    | '3/1/2024' | "Yes"     | ''       |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '4/1/2024' | "Yes"     | '000004'                                                           | '660,000'         | '1/2/2024' | "Yes"     | '2000001'                                                           | '660,000'      | '1/2/2024' | "Yes"     | '2000001'                                                        | '3,270,000'  | '4/1/2024' | "Yes"     | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '5/1/2024' | "Yes"     | '000005'                                                           | '1,375,000'       | ''           | "No"    | ''                                                                  | '1,375,000'    | ''           | "No"    | ''                                                               | '3,350,000'  | '5/1/2024' | "Yes"     | ''       |
			| "SourceCode"                                                     | '6,030,000'      | '5/1/2024' | "Yes"     | '000005'                                                           | '6,633,000'       | '5/2/2024' | "Yes"     | '2000005'                                                           | '6,633,000'    | '5/2/2024' | "Yes"     | '2000005'                                                        | '19,296,000' | ''           | "No"    | ''       |
			| "DestinationCode"                                                     | '0'              | ''           | "No"    | ''                                                                 | '0'               | ''           | "No"    | ''                                                                  | '0'            | ''           | "No"    | ''                                                               | '0'          | ''           | "No"    | ''       |
			| "FormulasCode"                                                      | '1'              | '12/1/2023' | "Yes"     | "Mercury LLC\nVA - Main scenario\nRUB\nJanuary 2024\nMonth" | '2'               | '1/1/2024' | "No"    | "Mercury LLC\nVA - Main scenario\nRUB\nFebruary 2024\nMonth" | '3'            | '2/1/2024' | "No"    | "Mercury LLC\nVA - Main scenario\nRUB\nMarch 2024\nMonth" | '6'          | ''           | "No"    | ''       |
			| "Calculation"                                                          | '6,030,000'      | ''           | "No"    | ''                                                                 | '13,266,000'      | ''           | "No"    | ''                                                                  | '19,899,000'   | ''           | "No"    | ''                                                               | '39,195,000' | ''           | "No"    | ''       |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '2/1/2024' | "No"    | '!!! 000001'                                                       | '4,290,000'       | '6/2/2024' | "No"    | '!!! 2000005'                                                       | '6,435,000'    | '6/2/2024' | "No"    | '!!! 2000005'                                                    | '11,975,000' | '6/2/2024' | "No"    | ''       |
			| "2C:Corporation "                                                  | '2,050,000'      | '3/1/2024' | "No"    | '!!! 000002'                                                       | '4,510,000'       | ''           | "Yes"     | ''                                                                  | '6,765,000'    | ''           | "No"    | ''                                                               | '13,325,000' | '3/1/2024' | "Yes"     | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '4/1/2024' | "No"    | '!!! 000003'                                                       | '396,000'         | ''           | "No"    | ''                                                                  | '594,000'      | ''           | "No"    | ''                                                               | '1,170,000'  | '4/1/2024' | "No"    | ''       |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '5/1/2024' | "No"    | '!!! 000004'                                                       | '1,320,000'       | '2/2/2024' | "No"    | '!!! 2000001'                                                       | '1,980,000'    | '2/2/2024' | "No"    | '!!! 2000001'                                                    | '5,250,000'  | '5/1/2024' | "No"    | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '6/1/2024' | "No"    | '!!! 000005'                                                       | '2,750,000'       | ''           | "No"    | ''                                                                  | '4,125,000'    | ''           | "No"    | ''                                                               | '7,475,000'  | '6/1/2024' | "No"    | ''       |
	
	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'
		Then I open report instance for report type "VA - Calculation in code" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Calculating the document again and verifying the changed result
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Calculation in code"                                              | ''               | ''           | ''       | ''                                                                 | ''                | ''           | ''       | ''                                                                  | ''             | ''           | ''       | ''                                                               | ''           | ''           | ''       | ''       |
			| ''                                                                | ''               | ''           | ''       | ''                                                                 | ''                | ''           | ''       | ''                                                                  | ''             | ''           | ''       | ''                                                               | ''           | ''           | ''       | ''       |
			| ''                                                                | "January 2024" | ''           | ''       | ''                                                                 | "February 2024" | ''           | ''       | ''                                                                  | "March 2024" | ''           | ''       | ''                                                               | "TOTAL"      | ''           | ''       | ''       |
			| ''                                                                | "Number"          | "Date"       | "Boolean" | "Line"                                                           | "Number"           | "Date"       | "Boolean" | "Line"                                                            | "Number"        | "Date"       | "Boolean" | "Line"                                                         | "Number"      | "Date"       | "Boolean" | "Line" |
			| "Source"                                                        | '6,030,000'      | ''           | "No"    | ''                                                                 | '6,633,000'       | ''           | "No"    | ''                                                                  | '6,633,000'    | ''           | "No"    | ''                                                               | '19,296,000' | ''           | "No"    | ''       |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1/1/2024' | "Yes"     | '000001'                                                           | '2,145,000'       | '5/2/2024' | "Yes"     | '2000005'                                                           | '2,145,000'    | '5/2/2024' | "Yes"     | '2000005'                                                        | '5,540,000'  | '5/2/2024' | "Yes"     | ''       |
			| "2C:Corporation "                                                  | '2,050,000'      | '2/1/2024' | "Yes"     | '000002'                                                           | '2,255,000'       | ''           | "No"    | ''                                                                  | '2,255,000'    | ''           | "No"    | ''                                                               | '6,560,000'  | '2/1/2024' | "Yes"     | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '3/1/2024' | "Yes"     | '000003'                                                           | '198,000'         | ''           | "No"    | ''                                                                  | '198,000'      | ''           | "No"    | ''                                                               | '576,000'    | '3/1/2024' | "Yes"     | ''       |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '4/1/2024' | "Yes"     | '000004'                                                           | '660,000'         | '1/2/2024' | "Yes"     | '2000001'                                                           | '660,000'      | '1/2/2024' | "Yes"     | '2000001'                                                        | '3,270,000'  | '4/1/2024' | "Yes"     | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '5/1/2024' | "Yes"     | '000005'                                                           | '1,375,000'       | ''           | "No"    | ''                                                                  | '1,375,000'    | ''           | "No"    | ''                                                               | '3,350,000'  | '5/1/2024' | "Yes"     | ''       |
			| "SourceCode"                                                     | '6,030,000'      | '5/1/2024' | "Yes"     | '000005'                                                           | '6,633,000'       | '5/2/2024' | "Yes"     | '2000005'                                                           | '6,633,000'    | '5/2/2024' | "Yes"     | '2000005'                                                        | '19,296,000' | ''           | "No"    | ''       |
			| "DestinationCode"                                                     | '6,030,000'      | '5/1/2024' | "Yes"     | '000005'                                                           | '6,633,000'       | '5/2/2024' | "Yes"     | '2000005'                                                           | '6,633,000'    | '5/2/2024' | "Yes"     | '2000005'                                                        | '19,296,000' | ''           | "No"    | ''       |
			| "FormulasCode"                                                      | '1'              | '12/1/2023' | "Yes"     | "Mercury LLC\nVA - Main scenario\nRUB\nJanuary 2024\nMonth" | '2'               | '1/1/2024' | "No"    | "Mercury LLC\nVA - Main scenario\nRUB\nFebruary 2024\nMonth" | '3'            | '2/1/2024' | "No"    | "Mercury LLC\nVA - Main scenario\nRUB\nMarch 2024\nMonth" | '6'          | ''           | "No"    | ''       |
			| "Calculation"                                                          | '6,030,000'      | ''           | "No"    | ''                                                                 | '13,266,000'      | ''           | "No"    | ''                                                                  | '19,899,000'   | ''           | "No"    | ''                                                               | '39,195,000' | ''           | "No"    | ''       |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '2/1/2024' | "No"    | '!!! 000001'                                                       | '4,290,000'       | '6/2/2024' | "No"    | '!!! 2000005'                                                       | '6,435,000'    | '6/2/2024' | "No"    | '!!! 2000005'                                                    | '11,975,000' | '6/2/2024' | "No"    | ''       |
			| "2C:Corporation "                                                  | '2,050,000'      | '3/1/2024' | "No"    | '!!! 000002'                                                       | '4,510,000'       | ''           | "Yes"     | ''                                                                  | '6,765,000'    | ''           | "No"    | ''                                                               | '13,325,000' | '3/1/2024' | "Yes"     | ''       |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '4/1/2024' | "No"    | '!!! 000003'                                                       | '396,000'         | ''           | "No"    | ''                                                                  | '594,000'      | ''           | "No"    | ''                                                               | '1,170,000'  | '4/1/2024' | "No"    | ''       |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '5/1/2024' | "No"    | '!!! 000004'                                                       | '1,320,000'       | '2/2/2024' | "No"    | '!!! 2000001'                                                       | '1,980,000'    | '2/2/2024' | "No"    | '!!! 2000001'                                                    | '5,250,000'  | '5/1/2024' | "No"    | ''       |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '6/1/2024' | "No"    | '!!! 000005'                                                       | '2,750,000'       | ''           | "No"    | ''                                                                  | '4,125,000'    | ''           | "No"    | ''                                                               | '7,475,000'  | '6/1/2024' | "No"    | ''       |
	
	* Saving the document and verifying the movements
		When '$WindowTitle$ *' window is opened
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		When I set 'R1C1:R800C20' template area reading parameters
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_CalculationInCode_Movements.mxl" by template

Scenario: 07.12 Creating report instance - "VA - Grouping by analytics"

	And I create report instance for report type "VA - Grouping by analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''
	
	* Calculating document
		And I click the button named 'FormFillByDefault'
		
	* Comparing the result
		When I set 'R1C1:R13C21' template area reading parameters
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Grouping by analytics"                                  | ''               | ''          | ''          | ''          | ''          | ''                | ''          | ''          | ''          | ''          | ''             | ''          | ''          | ''          | ''          | ''           | ''           | ''           | ''           | ''         |
			| ''                                                                | ''               | ''          | ''          | ''          | ''          | ''                | ''          | ''          | ''          | ''          | ''             | ''          | ''          | ''          | ''          | ''           | ''           | ''           | ''           | ''         |
			| ''                                                                | "January 2024" | ''          | ''          | ''          | ''          | "February 2024" | ''          | ''          | ''          | ''          | "March 2024" | ''          | ''          | ''          | ''          | "TOTAL"      | ''           | ''           | ''           | ''         |
			| ''                                                                | "Amount"          | "Maximum"  | "Minimum"   | "Average"   | "NoTotal"  | "Amount"           | "Maximum"  | "Minimum"   | "Average"   | "NoTotal"  | "Amount"        | "Maximum"  | "Minimum"   | "Average"   | "NoTotal"  | "Amount"      | "Maximum"   | "Minimum"    | "Average"    | "NoTotal" |
			| "Group"                                                          | '12,060,000'     | '6,030,000' | '6,030,000' | '6,030,000' | '1'         | '13,266,000'      | '6,633,000' | '6,633,000' | '6,633,000' | '1'         | '13,266,000'   | '6,633,000' | '6,633,000' | '6,633,000' | '1'         | '38,592,000' | '19,296,000' | '19,296,000' | '19,296,000' | '3'        |
			| "GoodsSum"                                                     | '6,030,000'      | '2,050,000' | '180,000'   | '1,206,000' | '0'         | '6,633,000'       | '2,255,000' | '198,000'   | '1,326,600' | '0'         | '6,633,000'    | '2,255,000' | '198,000'   | '1,326,600' | '0'         | '19,296,000' | '2,255,000'  | '180,000'    | '1,286,400'  | '0'        |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1,250,000' | '1,250,000' | '1,250,000' | '1,250,000' | '2,145,000'       | '2,145,000' | '2,145,000' | '2,145,000' | '2,145,000' | '2,145,000'    | '2,145,000' | '2,145,000' | '2,145,000' | '2,145,000' | '5,540,000'  | '2,145,000'  | '1,250,000'  | '1,846,667'  | '0'        |
			| "2C:Corporation "                                                  | '2,050,000'      | '2,050,000' | '2,050,000' | '2,050,000' | '2,050,000' | '2,255,000'       | '2,255,000' | '2,255,000' | '2,255,000' | '2,255,000' | '2,255,000'    | '2,255,000' | '2,255,000' | '2,255,000' | '2,255,000' | '6,560,000'  | '2,255,000'  | '2,050,000'  | '2,186,667'  | '0'        |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '180,000'   | '180,000'   | '180,000'   | '180,000'   | '198,000'         | '198,000'   | '198,000'   | '198,000'   | '198,000'   | '198,000'      | '198,000'   | '198,000'   | '198,000'   | '198,000'   | '576,000'    | '198,000'    | '180,000'    | '192,000'    | '0'        |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '1,950,000' | '1,950,000' | '1,950,000' | '1,950,000' | '660,000'         | '660,000'   | '660,000'   | '660,000'   | '660,000'   | '660,000'      | '660,000'   | '660,000'   | '660,000'   | '660,000'   | '3,270,000'  | '1,950,000'  | '660,000'    | '1,090,000'  | '0'        |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '600,000'   | '600,000'   | '600,000'   | '600,000'   | '1,375,000'       | '1,375,000' | '1,375,000' | '1,375,000' | '1,375,000' | '1,375,000'    | '1,375,000' | '1,375,000' | '1,375,000' | '1,375,000' | '3,350,000'  | '1,375,000'  | '600,000'    | '1,116,667'  | '0'        |
			| "GoodsNoTotal"                                                  | '6,030,000'      | '6,030,000' | '6,030,000' | '6,030,000' | '0'         | '6,633,000'       | '6,633,000' | '6,633,000' | '6,633,000' | '0'         | '6,633,000'    | '6,633,000' | '6,633,000' | '6,633,000' | '0'         | '19,296,000' | '6,633,000'  | '19,296,000' | '6,432,000'  | '0'        |

	* Saving a document
		And I click the button named 'Write'

	* Checking the movements
		Then I open report instance for report type "VA - Grouping by analytics" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions "3Software sale" '' '' '' '' ''
		And I click the button named 'FormOpenDocumentRegisterRecordsFlatTab'
		Then "Flat table of indicator values" window is opened
		And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 30 seconds
		When I set 'R1C1:R450C20' template area reading parameters
		Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "3_Budgeting\Layouts\07\VA_GroupingByDimensions_Movements.mxl" by template
													
