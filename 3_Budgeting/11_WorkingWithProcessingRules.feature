#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 11. Checking the calculation rules functionality

	As Administrator I want to
	Check creation and operation of report types
	so that report types are entered without errors

Background:

	And I close all client application windows

Scenario: 11.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 11.01 Creating a group of report types "VA - Calculation rules (group)"

	And I create report type group with name "VA - Calculation rules (group)" and parent "VA - Report group"

Scenario: 11.02 Creating a report type with manual input - "VA - Count"

	And I create report type with name "VA - Count" and parent "VA - Calculation rules (group)"
	
	* Editing the report structure
		And I open report wizard with name "VA - Count"
		And I add row with name "Product range" in report wizard
		And I add column with name "Count" in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard
		And I close "Report wizard" window

	And I create default template for report type "VA - Count"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Count"

Scenario: 11.03 Creating a report instance - "VA - Count"

	And I create report instance for report type "VA - Count" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	And I add values with indicator expansion in cell 'R6C2'
		| "VA0Product"                                                     | 'Value1' |
		| "4C:Enterprise 8.3 CORP. Server License (x86-64)"           | '20.00000'  |
		| "3C:Enterprise 8 CORP. Client license for 100 users" | '40.00000'  |
		| "5C:Corporate performance management"                                      | '5.00000'   |
		| "2C:Corporation"                                                  | '7.00000'   |
		| "1C:ERP. Corporate performance management"                                   | '8.00000'   |

	* Copying and changing indicator values
		Then '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2:R11C2' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
		And I change value to '10.00000' in cell 'R7C3:R11C3'
		When '$WindowTitle$' window is opened
		And I change value to '100.00000' percent in cell 'R6C4:R11C4'

	* Checking the result
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Count"                                                 | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Count"     | "Count"      | "Count"   | "Count" |
			| "Product range"                                                    | '80'             | '130'             | '160'          | '370'        |
			| "5C:Corporate performance management "                                      | '5'              | '15'              | '10'           | '30'         |
			| "2C:Corporation "                                                  | '7'              | '17'              | '14'           | '38'         |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '20'             | '30'              | '40'           | '90'         |
			| "1C:ERP. Corporate performance management "                                   | '8'              | '18'              | '16'           | '42'         |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '40'             | '50'              | '80'           | '170'        |

	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'Write'

	* Checking whether it is possible to change the value of an empty cell
		When I open report instance for report type "VA - Count" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		And I save the window as 'WindowTitle'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C2:R12C4' cell
		And I click the button named 'ChangeIndicators'

	* Closing and saving the document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 11.04 Creating a report type with loading from RS "VA - Price"

	And I create report type with name "VA - Price" and parent "VA - Calculation rules (group)"

	* Editing the report structure
		And I open report wizard with name "VA - Price"
		And I add row with name "Product range" in report wizard
		And I add column with name "Price" in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard

	* Entering calculation formulas
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'AddOperand1'
		Then "Data sources" window is opened
		And I click the button named 'FormCreate'
		Then "Data source (create)" window is opened
		And I select "Current infobase information register" exact value from the drop-down list named 'MethodOfObtaining'
		And I click Choice button of the field named 'DBInformationRegister'
		Then "Infobase information registers" window is opened
		And I click the button named 'FormFind'
		Then "Find" window is opened
		And I select "Register" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "At the beginning of the line"
		If '$$IsERPCPM$$' Then
			And I input "Product range prices 2.5" text in the field named 'Pattern'
		Else
			And I input "Product range prices" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Infobase information registers" window is opened
		And I select current line in 'List' table
		And I select "Price" exact value from the drop-down list named 'InfoRegisterResource'
		And I select "Slice of the last ones" exact value from the drop-down list named 'SliceType'
		And I move to the tab named 'FiltersPage'
		And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select "Report period start date" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I finish line editing in 'TreeOfFilterParametersDB' table
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
				| "Field"     |
				| 'Price type' |
			And I click the button named 'AddConditionItem'
			And I go to line in 'TreeOfFilterParametersDB' table:
			| "Field"       |
			| '[Price type]' |
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
		And I click the button named 'FormWriteAndClose'
		And I wait "Data source (create) *" window closing in 20 seconds
		Then "Data sources" window is opened
		And I select current line in 'List' table
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'

	And I create default template for report type "VA - Price"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Price"

Scenario: 11.05 Creating a report instance - "VA - Price"

	And I create report instance for report type "VA - Price" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* Saving document
		And I click the button named 'FormFillByDefault'
		And I click the button named 'Write'

	* Checking the result
		When I open report instance for report type "VA - Price" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Price"                                                       | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Price"           | "Price"            | "Price"         | "Price"       |
			| "Product range"                                                    | '6,030,000'      | '6,633,000'       | '7,495,400'    | '20,158,400' |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1,375,000'       | '1,553,800'    | '4,178,800'  |
			| "2C:Corporation "                                                  | '2,050,000'      | '2,255,000'       | '2,548,200'    | '6,853,200'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '198,000'         | '223,700'      | '601,700'    |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '2,145,000'       | '2,423,900'    | '6,518,900'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '660,000'         | '745,800'      | '2,005,800'  |

Scenario: 11.06 Creating a report type with calculated indicators - "VA - Sales"

	And I create report type with name "VA - Sales" and parent "VA - Calculation rules (group)"

	* Editing the report structure
		And I open report wizard with name "VA - Sales"
		And I add row with name "Product range" in report wizard
		And I add column with name "Count" in report wizard
		And I add column with name "Price" in report wizard
		And I add column with name "Amount" in report wizard
		And I change indicator property 'NonFinancial' to 'True' in cell 'R2C2' in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard

	* Entering calculation formulas
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "ProductRange_count" of report type "VA - Count"
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "ProductRange_Price" of report type "VA - Price"
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "ProductRange_count"
		Then "Report wizard *" window is opened
		And I click the button named 'ButtonMultiply'
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "ProductRange_Price"
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'
		When "Report wizard" window is opened
		And I close "Report wizard" window

	And I create default template for report type "VA - Sales"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Sales"
		
Scenario: 11.07 Creating a report instance - "VA - Sales" without saving

	And I create report instance for report type "VA - Sales" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* The document should be empty
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales" | ''               | ''     | ''      | ''                | ''     | ''      | ''             | ''     | ''      | ''           | ''     | ''      |
			| ''             | ''               | ''     | ''      | ''                | ''     | ''      | ''             | ''     | ''      | ''           | ''     | ''      |
			| ''             | "January 2024" | ''     | ''      | "February 2024" | ''     | ''      | "March 2024" | ''     | ''      | "TOTAL"      | ''     | ''      |
			| ''             | "Count"     | "Price" | "Amount" | "Count"      | "Price" | "Amount" | "Count"   | "Price" | "Amount" | "Count" | "Price" | "Amount" |
			| "Product range" | '0'              | '0'    | '0'     | '0'               | '0'    | '0'     | '0'            | '0'    | '0'     | '0'          | '0'    | '0'     |

	* Calculating the document
		And I click the button named 'FormFillByDefault'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales"                                                    | ''               | ''          | ''           | ''                | ''          | ''            | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | ''               | ''          | ''           | ''                | ''          | ''            | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | "January 2024" | ''          | ''           | "February 2024" | ''          | ''            | "March 2024" | ''          | ''            | "TOTAL"      | ''           | ''            |
			| ''                                                                | "Count"     | "Price"      | "Amount"      | "Count"      | "Price"      | "Amount"       | "Count"   | "Price"      | "Amount"       | "Count" | "Price"       | "Amount"       |
			| "Product range"                                                    | '80'             | '6,030,000' | '63,800,000' | '130'             | '6,633,000' | '136,510,000' | '160'          | '7,495,400' | '158,607,200' | '370'        | '20,158,400' | '358,917,200' |
			| "5C:Corporate performance management "                                      | '5'              | '1,250,000' | '6,250,000'  | '15'              | '1,375,000' | '20,625,000'  | '10'           | '1,553,800' | '15,538,000'  | '30'         | '4,178,800'  | '42,413,000'  |
			| "2C:Corporation "                                                  | '7'              | '2,050,000' | '14,350,000' | '17'              | '2,255,000' | '38,335,000'  | '14'           | '2,548,200' | '35,674,800'  | '38'         | '6,853,200'  | '88,359,800'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '20'             | '180,000'   | '3,600,000'  | '30'              | '198,000'   | '5,940,000'   | '40'           | '223,700'   | '8,948,000'   | '90'         | '601,700'    | '18,488,000'  |
			| "1C:ERP. Corporate performance management "                                   | '8'              | '1,950,000' | '15,600,000' | '18'              | '2,145,000' | '38,610,000'  | '16'           | '2,423,900' | '38,782,400'  | '42'         | '6,518,900'  | '92,992,400'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '40'             | '600,000'   | '24,000,000' | '50'              | '660,000'   | '33,000,000'  | '80'           | '745,800'   | '59,664,000'  | '170'        | '2,005,800'  | '116,664,000' |
	
	* Closing the document without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 11.08 Creating a report instance - "VA - Sales"

	And I create report instance for report type "VA - Sales" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales" | ''               | ''     | ''      | ''                | ''     | ''      | ''             | ''     | ''      | ''           | ''     | ''      |
			| ''             | ''               | ''     | ''      | ''                | ''     | ''      | ''             | ''     | ''      | ''           | ''     | ''      |
			| ''             | "January 2024" | ''     | ''      | "February 2024" | ''     | ''      | "March 2024" | ''     | ''      | "TOTAL"      | ''     | ''      |
			| ''             | "Count"     | "Price" | "Amount" | "Count"      | "Price" | "Amount" | "Count"   | "Price" | "Amount" | "Count" | "Price" | "Amount" |
			| "Product range" | '0'              | '0'    | '0'     | '0'               | '0'    | '0'     | '0'            | '0'    | '0'     | '0'          | '0'    | '0'     |

	* Calculating the document
		And I click the button named 'FormFillByDefault'
		And I click the button named 'Write'
		And I save the window as 'WindowTitle'
		When '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales"                                                    | ''               | ''          | ''           | ''                | ''          | ''            | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | ''               | ''          | ''           | ''                | ''          | ''            | ''             | ''          | ''            | ''           | ''           | ''            |
			| ''                                                                | "January 2024" | ''          | ''           | "February 2024" | ''          | ''            | "March 2024" | ''          | ''            | "TOTAL"      | ''           | ''            |
			| ''                                                                | "Count"     | "Price"      | "Amount"      | "Count"      | "Price"      | "Amount"       | "Count"   | "Price"      | "Amount"       | "Count" | "Price"       | "Amount"       |
			| "Product range"                                                    | '80'             | '6,030,000' | '63,800,000' | '130'             | '6,633,000' | '136,510,000' | '160'          | '7,495,400' | '158,607,200' | '370'        | '20,158,400' | '358,917,200' |
			| "5C:Corporate performance management "                                      | '5'              | '1,250,000' | '6,250,000'  | '15'              | '1,375,000' | '20,625,000'  | '10'           | '1,553,800' | '15,538,000'  | '30'         | '4,178,800'  | '42,413,000'  |
			| "2C:Corporation "                                                  | '7'              | '2,050,000' | '14,350,000' | '17'              | '2,255,000' | '38,335,000'  | '14'           | '2,548,200' | '35,674,800'  | '38'         | '6,853,200'  | '88,359,800'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '20'             | '180,000'   | '3,600,000'  | '30'              | '198,000'   | '5,940,000'   | '40'           | '223,700'   | '8,948,000'   | '90'         | '601,700'    | '18,488,000'  |
			| "1C:ERP. Corporate performance management "                                   | '8'              | '1,950,000' | '15,600,000' | '18'              | '2,145,000' | '38,610,000'  | '16'           | '2,423,900' | '38,782,400'  | '42'         | '6,518,900'  | '92,992,400'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '40'             | '600,000'   | '24,000,000' | '50'              | '660,000'   | '33,000,000'  | '80'           | '745,800'   | '59,664,000'  | '170'        | '2,005,800'  | '116,664,000' |
	
	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 11.09 Checking behavior of the procedure editing form

	* Opening the processing rule
		And I open report wizard with name "VA - Sales"
		And I click Open button of the field named 'ProcessingRule'
		Then I open calculation rule for report type "VA - Sales"
		And I save the window as 'WindowTitle'

	* Opening the BEFORE calculation procedure
		And I click the button named 'FormProcedureOfCalculation'
		Then the form attribute named 'TextDocumentFieldProcedure' became equal to
			|''|
			|''|
		And 'UsedReportTypes' table became equal
			| "Report type"   |
			| "VA - Sales" |
		If '$$LanguageInterface$$ = "Ru"' Then
			And 'Definitions' table became equal
				| "Method"                                        |
				| 'ObjectOfARAP'                                |
				| 'GetIndicatorsValue()'                |
				| 'SetIndicatorValue()'               |
				| 'DateBelongsToPeriod()'                     |
				| 'RelativePeriod()'                        |
				| 'RelativePeriodYear()'                     |
				| 'PerimeterContent()'                            |
				| 'PerimeterContentForElimination()'               |
				| 'CompaniesControllingPerimeter()' |
				| 'ClearAll()'                                |
		Else
			And 'Definitions' table became equal
				| 'Method'                            |
				| 'CalcStructure'                     |
				| 'UGetIndicatorsValue()'             |
				| 'USetIndicatorsValue()'             |
				| 'UDateBelongsToPeriod()'            |
				| 'URelativePeriod()'                 |
				| 'URelativePeriodYear()'             |
				| 'UPerimeterContent()'               |
				| 'UPerimeterContentForElimination()' |
				| 'UPerimeterControllingCompanies()'  |
				| 'UClearAll()'                       |

	* Visibility of ReportsKinds
		And form attribute named 'FormReportsTypesVisibility' is marked
		And the field named 'UsedReportTypes' exists on the form
		And I click the button named 'FormReportsTypesVisibility'
		And form attribute named 'FormReportsTypesVisibility' is not marked
		And the field named 'UsedReportTypes' does not exist on the form
		And I click the button named 'FormReportsTypesVisibility'
		And form attribute named 'FormReportsTypesVisibility' is marked

	* Visibility of Procedure and function
		And form attribute named 'FormProceduresAndFunctionsVisibility' is marked
		And the field named 'GroupMethods' exists on the form
		And I click the button named 'FormProceduresAndFunctionsVisibility'
		And form attribute named 'FormProceduresAndFunctionsVisibility' is not marked
		And the field named 'GroupMethods' does not exist on the form
		And I click the button named 'FormProceduresAndFunctionsVisibility'
		And form attribute named 'FormProceduresAndFunctionsVisibility' is marked

	* Input of indicators
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And in the table 'UsedReportTypes' I click the button named 'UsedReportTypesInsertIndicators'
		And I select indicator with code "ProductRange_count"
		When "VA - Sales, VA - Sales: Procedure before calculation *" window is opened
		If '$$LanguageInterface$$ = "Ru"' Then
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' ArrayOfIndicators = New Array;'|
				|'ArrayOfIndicators.Add(\"DimenKindSales:Products_Count\");'|
				|'tIndicatorsValues = GetIndicatorsValue(New Structure(\"ReportsIndicators\", ArrayOfIndicators));'|
				|''|							
		Else
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' ArrayIndicators = New Array;'|
				|'ArrayIndicators.Add(\"VASales:ProductRange_Count\");'|
				|'tValuesIndicators = UGetIndicatorsValue(New Structure(\"IndicatorsReports\", ArrayIndicators));'|
				|''|
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And in the table 'UsedReportTypes' I click the button named 'UsedReportTypesAdd'
		And I select "VA - Price" by string from the drop-down list named 'UsedReportTypesReportKind' in 'UsedReportTypes' table
		And I finish line editing in 'UsedReportTypes' table
		And in the table 'UsedReportTypes' I click the button named 'UsedReportTypesInsertIndicators'
		And I select indicator with code "ProductRange_Price"
		If '$$LanguageInterface$$ = "Ru"' Then
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' ArrayOfIndicators = New Array;'|
				|'ArrayOfIndicators.Add(\"DimenKindPrice:Products_Price\");'|
				|'tIndicatorsValues = GetIndicatorsValue(New Structure(\"ReportsIndicators\", ArrayOfIndicators));'|
				|''|						
		Else
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' ArrayIndicators = New Array;'|
				|'ArrayIndicators.Add(\"VAPrice:ProductRange_Price\");'|
				|'tValuesIndicators = UGetIndicatorsValue(New Structure(\"IndicatorsReports\", ArrayIndicators));'|
				|''|
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'

	* Input of functions
		If '$$LanguageInterface$$ = "Ru"' Then
			* ObjectOfARAP
				And I go to line in 'Definitions' table:
						| "Method"         |
						| 'ObjectOfARAP' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' ObjectOfARAP.'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* GetValueIndicators
				And I go to line in 'Definitions' table:
					| "Method"                         |
					| 'GetIndicatorsValue()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' GetIndicatorsValue('|
					|'	<FilterParameterStructure>,'|
					|'	[DimensionsToDrillDown], '|
					|'	[AdditionalParameters]);'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* InstallValueIndicator
				And I go to line in 'Definitions' table:
					| "Method"                          |
					| 'SetIndicatorValue()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' SetIndicatorValue('|
					|'	<indicator code or reference to indicator>,'|
					|'	<indicator value>,'|
					|'	[<period>],'|
					|'	[<dimension 1>],'|
					|'	[<dimension 2>],'|
					|'	[<dimension 3>],'|
					|'	[<dimension 4>],'|
					|'	[<dimension 5>],'|
					|'	[<dimension 6>]);'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* DateBelongsToPeriod
				And I go to line in 'Definitions' table:
					| "Method"                    |
					| 'DateBelongsToPeriod()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to ' DateBelongsToPeriod(<date>, <period>);'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* RelativePeriod
				And I go to line in 'Definitions' table:
					| "Method"                 |
					| 'RelativePeriod()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' RelativePeriod(<source period>, [<offset>]);'|
					|''|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* RelativePeriodYear
				And I go to line in 'Definitions' table:
					| "Method"                 |
					| 'RelativePeriodYear()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' RelativePeriodYear(<source period>, [<offset>]);'|
					|''|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ContentPerimeter
				And I go to line in 'Definitions' table:
					| "Method"             |
					| 'PerimeterContent()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' PerimeterContent([<scenario>],'|
					|'	[<period>],'|
					|'	[<organizational unit>],'|
					|'	[<consolidation method>],'|
					|'	[<maximum full ownership share>],'|
					|'	[<minimum full ownership share>],'|
					|'	[<organization types>]);'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ContentPerimeterForElimination
				And I go to line in 'Definitions' table:
					| "Method"                          |
					| 'PerimeterContentForElimination()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' PerimeterContentForElimination();'|
					|''|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ReturnValue_ArrayOfCompaniesPerformingPerimeterControl
				And I go to line in 'Definitions' table:
					| "Method"                                        |
					| 'CompaniesControllingPerimeter()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to ' CompaniesControllingPerimeter();'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ClearAll
				And I go to line in 'Definitions' table:
					| "Method"         |
					| 'ClearAll()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' ClearAll();'|
					|''|
		Else
			* ObjectOfARAP
				And I go to line in 'Definitions' table:
					| "Method"         |
					| "CalcStructure" |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' CalcStructure.'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* GetValueIndicators
				And I go to line in 'Definitions' table:
					| "Method"                 |
					| 'UGetIndicatorsValue()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' UGetIndicatorsValue('|
					|'	<SelectionParametersStructure>,'|
					|'	[<Dimension>],'|
					|'	[<Options>]);'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* InstallValueIndicator
				And I go to line in 'Definitions' table:
					| "Method"                 |
					| 'USetIndicatorsValue()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' USetIndicatorsValue(<CodeReferenceIndicators>, <Value>, '|
					|'	[<ReportPeriod>],'|
					|'	[<Dimension1>], [<Dimension2>], [<Dimension3>], [<Dimension4>], [<Dimension5>], [<Dimension6>],'|
					|'	[<DimensionCurrency>]);'|	
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* DateBelongsToPeriod
				And I go to line in 'Definitions' table:
					| "Method"                  |
					| 'UDateBelongsToPeriod()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to ' UDateBelongsToPeriod(<StringDate>, <Period>);'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* RelativePeriod
				And I go to line in 'Definitions' table:
					| "Method"             |
					| 'URelativePeriod()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' URelativePeriod(<ReportPeriod>, [<Offset>]);'|
					|''|				
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* RelativePeriodYear
				And I go to line in 'Definitions' table:
					| "Method"                 |
					| 'URelativePeriodYear()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' URelativePeriodYear(<ReportPeriod>, [<Offset>]);'|
					|''|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ContentPerimeter
				And I go to line in 'Definitions' table:
					| "Method"               |
					| 'UPerimeterContent()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' UPerimeterContent('|
					|'	[<Scenario>], [<ReportPeriod>], [<Organization>],'|
					|'	[<ConsolidationMethod>], [<MinTotalOwnershipShare>], [<MaxTotalOwnershipShare>],'|
					|'	[<OrganizationTypes>], [<PerimeterOwner>]);'|
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ContentPerimeterForElimination
				And I go to line in 'Definitions' table:
					| "Method"                             |
					| 'UPerimeterContentForElimination()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to ' UPerimeterContentForElimination();'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ReturnValue_ArrayOfCompaniesPerformingPerimeterControl
				And I go to line in 'Definitions' table:
					| "Method"                            |
					| 'UPerimeterControllingCompanies()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to ' UPerimeterControllingCompanies();'
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
			* ClearAll
				And I go to line in 'Definitions' table:
					| "Method"       |
					| 'UClearAll()' |
				And I select current line in 'Definitions' table
				Then the form attribute named 'TextDocumentFieldProcedure' became equal to
					|' UClearAll();'|
					|''|

	* Saving changes
		And I click the button named 'FormValidate'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "VA - Sales, VA - Sales: Procedure before calculation *" window is opened
		And I click the button named 'FormWriteAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'FormWrite'

	* AFTER calculation procedure
		When '$WindowTitle$' window is opened
		And I click the button named 'FormProcedureOfCalculation'
		When "VA - Sales, VA - Sales: Procedure before calculation" window is opened
		If '$$LanguageInterface$$ = "Ru"' Then
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' ClearAll();'|
				|''|
				|''|
		Else
			Then the form attribute named 'TextDocumentFieldProcedure' became equal to
				|' UClearAll();'|
				|''|
				|''|
		And I click the button named 'FormClose'

	* Closing forms
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "Report wizard" window is opened
		And I close "Report wizard" window

Scenario: 11.10 Checking operation of custom calculation functions

	* Opening the processing rule
		And I open report wizard with name "VA - Sales"
		And I click Open button of the field named 'ProcessingRule'
		Then I open calculation rule for report type "VA - Sales"
		And I save the window as 'WindowTitle'

	* Filling the procedure text
		And I click the button named 'FormProcedureAfterCalculation'
		When "VA - Sales, VA - Sales: Procedure after calculation" window is opened
		If '$$LanguageInterface$$ = "Ru"' Then
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'ReportData = New Structure("Organization,Scenario,Currency,ReportPeriod",'|
				|' ObjectOfARAP.Organization,ObjectOfARAP.Scenario,ObjectOfARAP.MainCurrency,ObjectOfARAP.ArrayOfPeriods);'|
				|'DimensionsToDrillDown = New Structure("Dimension1");'|
				|'AdditionalParameters = New Structure("Overall",Enums.IndicatorTotalsTypes.Sum);'|
				|''|
				|'ArrayOfIndicators = New Array;'|
				|'ArrayOfIndicators.Add("DimenKindSales:Products_Count");'|
				|'ReportData.Insert("ReportsIndicators",ArrayOfIndicators);'|
				|'tIndicatorsValues_Count = GetIndicatorsValue('|
				|' ReportData,DimensionsToDrillDown);'|
				|'ReportData.Delete("ReportsIndicators"); '|
				|''|
				|'ReportData.Insert("ReportIndicator", '|
				|' Catalogs.ReportsIndicators.FindByCode("Products_Price",True,,ObjectOfARAP.ReportKind));'|
				|'tIndicatorsValues_Price = GetIndicatorsValue('|
				|' ReportData,DimensionsToDrillDown,AdditionalParameters);'|
				|'ReportData.Delete("ReportIndicator"); '|
				|''|
				|'ClearAll();'|
				|''|
				|'For Each LineValue In tIndicatorValues_Count Do'|
				|''|
				|' PeriodOffset = RelativePeriod(StringValue2.ReportPeriod, 1);'|
				|' If DateBelongsToPeriod(PeriodOffset.StartDate,ObjectOfARAP.ArrayOfPeriods.Get(1)) OR'|
				|'  DateBelongsToPeriod(PeriodOffset.StartDate,ObjectOfARAP.ArrayOfPeriods.Get(2)) Then'|
				|''|
				|'  SetIndicatorValue('|
				|'   StringValue2.ReportIndicator,'|
				|'   StringValue2.Value + 10,'|
				|'   RelativePeriod(StringValue2.ReportPeriod, 1),'|
				|'   StringValue2.Dimension1);'|
				|'   '|
				|' EndIf;'|
				|'  '|
				|'EndOfTheCycle;'|
				|''|
				|'For Each LineValue In tIndicatorValues_Price Do'|
				|''|
				|' If NOT ValueIsFilled(StringValue2.ReportPeriod) Then'|
				|'  Continue;'|
				|' EndIf;'|
				|''|
				|' PeriodOffset = RelativePeriod(StringValue2.ReportPeriod, 1);'|
				|' If DateBelongsToPeriod(PeriodOffset.StartDate,ObjectOfARAP.ArrayOfPeriods.Get(1)) OR'|
				|'  DateBelongsToPeriod(PeriodOffset.StartDate,ObjectOfARAP.ArrayOfPeriods.Get(2)) Then'|
				|''|
				|'  SetIndicatorValue('|
				|'   StringValue2.ReportIndicator,'|
				|'   StringValue2.Value * 2,'|
				|'   RelativePeriod(StringValue2.ReportPeriod, 1),'|
				|'   StringValue2.Dimension1);'|
				|'   '|
				|' EndIf;  '|
				|'  '|
				|'EndOfTheCycle;'|
		Else
			And I input text in the field named 'TextDocumentFieldProcedure'
				|'ReportData = New Structure(\"Organization,Scenario,Currency,ReportPeriod\",'|
				|'  CalcStructure.Organization, CalcStructure.Scenario, CalcStructure.MainCurrency, CalcStructure.PeriodsArray);'|
				|'DisclosedAnalysts = New Structure(\"Dimension1\");'|
				|'ExtraOptions = New Structure(\"Overall\",Enums.IndicatorTotalsTypes.Sum);'|
				|''|
				|'ArrayIndicators = New Array;'|
				|'ArrayIndicators.Add(\"VASales:ProductRange_Count\");'|
				|'ReportData.Insert(\"ReportsIndicators\", ArrayIndicators);'|
				|'tValuesIndicators_Number = UGetIndicatorsValue('|
				|' 	ReportData, DisclosedAnalysts);'|
				|'ReportData.Delete(\"ReportsIndicators\"); '|
				|''|
				|'ReportData.Insert(\"ReportIndicator\", '|
				|'  Catalogs.ReportsIndicators.FindByCode(\"ProductRange_Price\",True,,CalcStructure.ReportKind));'|
				|'tValuesIndicators_Price = UGetIndicatorsValue('|
				|'  ReportData, DisclosedAnalysts, ExtraOptions);'|
				|'ReportData.Delete(\"ReportIndicator\"); '|
				|''|
				|'UClearAll();'|
				|''|
				|'For Each StringValue In tValuesIndicators_Number Do'|
				|''|
				|' PeriodOffset = URelativePeriod(StringValue.ReportPeriod, 1);'|
				|' If UDateBelongsToPeriod(PeriodOffset.StartDate,CalcStructure.PeriodsArray.Get(1)) OR'|
				|'  UDateBelongsToPeriod(PeriodOffset.StartDate,CalcStructure.PeriodsArray.Get(2)) Then'|
				|''|
				|'  USetIndicatorsValue('|
				|'   StringValue.ReportIndicator,'|
				|'   StringValue.Value + 10,'|
				|'   URelativePeriod(StringValue.ReportPeriod, 1),'|
				|'   StringValue.Dimension1);'|
				|'   '|
				|' EndIf;'|
				|'  '|
				|'EndDo;'|
				|''|
				|'For Each StringValue In tValuesIndicators_Price Do'|
				|''|
				|' If Not ValueIsFilled(StringValue.ReportPeriod) Then'|
				|'  Continue;'|
				|' EndIf;'|
				|''|
				|' PeriodOffset = URelativePeriod(StringValue.ReportPeriod, 1);'|
				|' If UDateBelongsToPeriod(PeriodOffset.StartDate,CalcStructure.PeriodsArray.Get(1)) OR'|
				|'  UDateBelongsToPeriod(PeriodOffset.StartDate,CalcStructure.PeriodsArray.Get(2)) Then'|
				|''|
				|'  USetIndicatorsValue('|
				|'   StringValue.ReportIndicator,'|
				|'   StringValue.Value * 2,'|
				|'   URelativePeriod(StringValue.ReportPeriod, 1),'|
				|'   StringValue.Dimension1);'|
				|'   '|
				|' EndIf;  '|
				|'  '|
				|'EndDo;'|
		And I click the button named 'FormWriteAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$ *' window closing in 20 seconds
		Then "Report wizard" window is opened
		And I close "Report wizard" window

	* Calculating the document
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I select current line in 'List' table
		Then I open report instance for report type "VA - Sales" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		And I save the window as 'WindowTitle'
		And I click the button named 'FormFillByDefault'

	* Comparing the result
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales"                                                    | ''               | ''     | ''      | ''                | ''           | ''      | ''             | ''           | ''      | ''           | ''           | ''      |
			| ''                                                                | ''               | ''     | ''      | ''                | ''           | ''      | ''             | ''           | ''      | ''           | ''           | ''      |
			| ''                                                                | "January 2024" | ''     | ''      | "February 2024" | ''           | ''      | "March 2024" | ''           | ''      | "TOTAL"      | ''           | ''      |
			| ''                                                                | "Count"     | "Price" | "Amount" | "Count"      | "Price"       | "Amount" | "Count"   | "Price"       | "Amount" | "Count" | "Price"       | "Amount" |
			| "Product range"                                                    | '0'              | '0'    | '0'     | '130'             | '12,060,000' | '0'     | '180'          | '13,266,000' | '0'     | '310'        | '25,326,000' | '0'     |
			| "5C:Corporate performance management "                                      | '0'              | '0'    | '0'     | '15'              | '2,500,000'  | '0'     | '25'           | '2,750,000'  | '0'     | '40'         | '5,250,000'  | '0'     |
			| "2C:Corporation "                                                  | '0'              | '0'    | '0'     | '17'              | '4,100,000'  | '0'     | '27'           | '4,510,000'  | '0'     | '44'         | '8,610,000'  | '0'     |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '0'              | '0'    | '0'     | '30'              | '360,000'    | '0'     | '40'           | '396,000'    | '0'     | '70'         | '756,000'    | '0'     |
			| "1C:ERP. Corporate performance management "                                   | '0'              | '0'    | '0'     | '18'              | '3,900,000'  | '0'     | '28'           | '4,290,000'  | '0'     | '46'         | '8,190,000'  | '0'     |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '0'              | '0'    | '0'     | '50'              | '1,200,000'  | '0'     | '60'           | '1,320,000'  | '0'     | '110'        | '2,520,000'  | '0'     |
	
	* Saving and opening the document
		When '$WindowTitle$ *' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$ *' window closing in 20 seconds

Scenario: 11.11 Display of the instance in currency after calculations

	And I open first report instance for report type "VA - Sales"
	Then I open report instance for report type "VA - Sales" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
	
	* Checking amounts in currency
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I select "EUR" exact value from the drop-down list named 'DisplayCurrency'
		And I click the button named 'FormApplyAndClose'
		When I open report instance for report type "VA - Sales" currency 'EUR' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		And I save the window as 'WindowTitle'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales"                                                    | ''               | ''     | ''      | ''                | ''        | ''      | ''             | ''        | ''      | ''           | ''        | ''      |
			| ''                                                                | ''               | ''     | ''      | ''                | ''        | ''      | ''             | ''        | ''      | ''           | ''        | ''      |
			| ''                                                                | "January 2024" | ''     | ''      | "February 2024" | ''        | ''      | "March 2024" | ''        | ''      | "TOTAL"      | ''        | ''      |
			| ''                                                                | "Count"     | "Price" | "Amount" | "Count"      | "Price"    | "Amount" | "Count"   | "Price"    | "Amount" | "Count" | "Price"    | "Amount" |
			| "Product range"                                                    | '0'              | '0'    | '0'     | '130'             | '134,101' | '0'     | '180'          | '149,591' | '0'     | '310'        | '283,692' | '0'     |
			| "5C:Corporate performance management "                                      | '0'              | '0'    | '0'     | '15'              | '27,799'  | '0'     | '25'           | '31,010'  | '0'     | '40'         | '58,808'  | '0'     |
			| "2C:Corporation "                                                  | '0'              | '0'    | '0'     | '17'              | '45,590'  | '0'     | '27'           | '50,856'  | '0'     | '44'         | '96,446'  | '0'     |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '0'              | '0'    | '0'     | '30'              | '4,003'   | '0'     | '40'           | '4,465'   | '0'     | '70'         | '8,468'   | '0'     |
			| "1C:ERP. Corporate performance management "                                   | '0'              | '0'    | '0'     | '18'              | '43,366'  | '0'     | '28'           | '48,375'  | '0'     | '46'         | '91,741'  | '0'     |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '0'              | '0'    | '0'     | '50'              | '13,343'  | '0'     | '60'           | '14,885'  | '0'     | '110'        | '28,228'  | '0'     |
					
	* Saving document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 11.12 Deleting versions during automatic calculation

	And I open first report instance for report type "VA - Sales"
	Then I open report instance for report type "VA - Sales" currency 'EUR' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
	And I save the window as 'WindowTitle'
	
	* Deleting a version
		And I click the button named 'FormVersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'

	* Closing windows
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		
	* Checking the result
		Then "Report instances" window is opened
		And I select current line in 'List' table
		Then '$WindowTitle$' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Sales"                                                    | ''               | ''       | ''        | ''                | ''       | ''          | ''             | ''       | ''          | ''           | ''        | ''          |
			| ''                                                                | ''               | ''       | ''        | ''                | ''       | ''          | ''             | ''       | ''          | ''           | ''        | ''          |
			| ''                                                                | "January 2024" | ''       | ''        | "February 2024" | ''       | ''          | "March 2024" | ''       | ''          | "TOTAL"      | ''        | ''          |
			| ''                                                                | "Count"     | "Price"   | "Amount"   | "Count"      | "Price"   | "Amount"     | "Count"   | "Price"   | "Amount"     | "Count" | "Price"    | "Amount"     |
			| "Product range"                                                    | '80'             | '66,632' | '704,995' | '130'             | '73,756' | '1,517,923' | '160'          | '84,520' | '1,788,494' | '370'        | '224,908' | '4,011,412' |
			| "5C:Corporate performance management "                                      | '5'              | '13,813' | '69,063'  | '15'              | '15,289' | '229,340'   | '10'           | '17,521' | '175,210'   | '30'         | '46,623'  | '473,613'   |
			| "2C:Corporation "                                                  | '7'              | '22,653' | '158,569' | '17'              | '25,074' | '426,266'   | '14'           | '28,734' | '402,278'   | '38'         | '76,461'  | '987,112'   |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '20'             | '1,989'  | '39,780'  | '30'              | '2,202'  | '66,050'    | '40'           | '2,522'  | '100,900'   | '90'         | '6,713'   | '206,730'   |
			| "1C:ERP. Corporate performance management "                                   | '8'              | '21,548' | '172,381' | '18'              | '23,851' | '429,324'   | '16'           | '27,332' | '437,320'   | '42'         | '72,731'  | '1,039,025' |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '40'             | '6,630'  | '265,202' | '50'              | '7,339'  | '366,944'   | '80'           | '8,410'  | '672,786'   | '170'        | '22,379'  | '1,304,931' |
