#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 04. Checking arbitrary requests for indicator calculation

	As Administrator I want to
	Check that arbitrary requests work for indicator calculation
	so that indicators are calculated without errors

Background:

	And I close all client application windows

Scenario: 04.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 04.01 Creating a report type "VA - Arbitrary request"

	And I create report type with name "VA - Arbitrary request" and parent "VA - Report group"
	
	* Editing the report structure
		And I open report wizard with name "VA - Arbitrary request"
		And I add row with name "Product range" in report wizard
		And I add column with name "Price" in report wizard
		And I add dimension with code "VA0Product" in cell 'R2C2' in report wizard

	And I create default template for report type "VA - Arbitrary request"
	And I set sorting "Product range" "Product ID" in template for expansion group with address 'R8C1' for report type "VA - Arbitrary request"

Scenario: 04.02 Checking the behavior of the indicator configuration form

	And I open report wizard with name "VA - Arbitrary request"
				
	* Entering the calculation formula
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'AddOperand1'

	* Checking the form behavior with the extended indicator calculation engine
		Then "Data sources" window is opened
		And I click the button named 'FormCreate'
		When "Data source (create)" window is opened
		And I select "Current infobase report item indicator" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' does not exist on the form
		And the field named 'Help' does not exist on the form
		And I select "Current infobase accumulation register" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' does not exist on the form
		And the field named 'Help' does not exist on the form
		And I select "Current infobase accounting register" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' does not exist on the form
		And the field named 'Help' does not exist on the form
		And I select "Current infobase information register" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' does not exist on the form
		And the field named 'Help' does not exist on the form
		And I select "Current infobase catalog" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' does not exist on the form
		And the field named 'Help' does not exist on the form
		And I select "Arbitrary query to current infobase" exact value from the drop-down list named 'MethodOfObtaining'
		And the field named 'UseMultiperiodContext' exists on the form
		And the field named 'Help' exists on the form
		And I click the button named 'Help'
		Then "Help" window is opened
		And I close "Help" window

	* Setting the request text
		When "Data source (create) *" window is opened
		If '$$IsCPM$$' Then
			And I input text in the field named 'QueryTextForm'
				|'SELECT'|
				|'	ItemsPrices.Period AS Date,'|
				|'	ItemsPrices.Products AS Products,'|
				|'	MAX(ItemsPrices.Price) AS Price'|
				|'INTO vtCalculation'|
				|'FROM'|
				|'	InformationRegister.ItemsPrices AS ItemsPrices'|
				|'WHERE'|
				|'	ItemsPrices.Period >= &StartDateParameter'|
				|'	AND ItemsPrices.Period <= &EndDateParameter'|
				|'	AND ItemsPrices.PriceType_ = &ParameterPriceType_'|
				|''|
				|'GROUP BY'|
				|'	ItemsPrices.Period,'|
				|'	ItemsPrices.Products'|
				|';'|
				|''|
				|'////////////////////////////////////////////////////////////////////////////////'|
				|'SELECT'|
				|'	vtCalculation.Date AS Date,'|
				|'	vtCalculation.Products AS Products,'|
				|'	vtCalculation.Price AS Price'|
				|'FROM'|
				|'	vtCalculation AS vtCalculation'|
		If '$$IsERPCPM$$' Then
			And I input text in the field named 'QueryTextForm'
				|'SELECT'|
				|'	ItemsPrices.Period AS Date,'|
				|'	ItemsPrices.Products AS Products,'|
				|'	MAX(ItemsPrices.Price) AS Price'|
				|'INTO vtCalculation'|
				|'FROM'|
				|'	InformationRegister.ItemsPrices25 AS ItemsPrices'|
				|'WHERE'|
				|'	ItemsPrices.Period >= &StartDateParameter'|
				|'	AND ItemsPrices.Period <= &EndDateParameter'|
				|'	AND ItemsPrices.PriceType = &ParameterPriceType_'|
				|''|
				|'GROUP BY'|
				|'	ItemsPrices.Period,'|
				|'	ItemsPrices.Products'|
				|';'|
				|''|
				|'////////////////////////////////////////////////////////////////////////////////'|
				|'SELECT'|
				|'	vtCalculation.Date AS Date,'|
				|'	vtCalculation.Products AS Products,'|
				|'	vtCalculation.Price AS Price'|
				|'FROM'|
				|'	vtCalculation AS vtCalculation'|
		And I click the button named 'QueryWizard'
		Then "Query wizard" window is opened
		And I close "Query wizard" window
		If '1C:Enterprise' window is opened Then
			And I click the button named 'Button0'
		Then "Data source (create) *" window is opened
		And I click the button named 'EditQueryText'
		And I move to the tab named 'ComplianceAnalyst'
		
	* Checking table filling
		When "Data source (create) *" window is opened
		And I expand a line in 'FieldsTreeDB' table
			| "Field"                 |
			| "Query parameters(3)" |
		And I expand a line in 'FieldsTreeDB' table
			| "Field"                 |
			| "Data source fields(3)" |
		Then I check table 'FieldsTreeDB' contains '8' rows from list:
			| "Field"                     |
			| "Query parameters(3)"     |
			| 'StartDateParameter'       |
			| 'EndDateParameter'    |
			| 'ParameterPriceType_'           |
			| "Data source fields(3)" |
			| 'Date'                     |
			| 'Products'                  |
			| 'Price'                     |
		Then I check table 'ComplianceTable' contains '3' rows from list:
			| "Destination dimension"       | "Filling method" | "Column name"    | "Dimension type" |
			| "Dimension 1: Product range" | "Source field"    | '[Products]' | "Product range"  |
			| "Value"                  | "Source field"    | '[Price]'         | ''              |
			| "Period"                    | "Source field"    | '[Date]'         | ''              |
		And I move to the tab named 'FiltersPage'
		When "Data source (create) *" window is opened
		Then I check table 'TreeOfFilterParametersDB' contains '3' rows from list:
			| "Field"                    | "Filter" | "Filter clarification" | "Value to check" |
			| '[StartDateParameter]'    | ''      | ''                 | ''                      |
			| '[EndDateParameter]' | ''      | ''                 | ''                      |
			| '[ParameterPriceType_]'        | ''      | ''                 | ''                      |

	* Filling parameters
		When "Data source (create) *" window is opened
		And I go to line in 'TreeOfFilterParametersDB' table:
			| "Field"                 |
			| '[StartDateParameter]' |
		And I select "Report period start date" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I finish line editing in 'TreeOfFilterParametersDB' table
		And I go to line in 'TreeOfFilterParametersDB' table:
			| "Field"                    |
			| '[EndDateParameter]' |
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select "Report period end date" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I finish line editing in 'TreeOfFilterParametersDB' table
		And I go to line in 'TreeOfFilterParametersDB' table:
			| "Field"             |
			| '[ParameterPriceType_]' |
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
		And I select "VA - Products" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
		And I finish line editing in 'TreeOfFilterParametersDB' table
		Then I check table 'TreeOfFilterParametersDB' contains '3' rows from list:
			| "Field"                    | "Filter"                      | "Filter clarification"  | "Value to check" |
			| '[StartDateParameter]'    | "Report period start date" | ''                  | ''                      |
			| '[EndDateParameter]' | "Report period end date"  | ''                  | ''                      |
			| '[ParameterPriceType_]'        | "Fixed value"     | "VA - Products" | ''                      |

	* Saving the element
		When "Data source (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Data source (create) *" window closing in 20 seconds
		Then "Data sources" window is opened
		And I select current line in 'List' table
		Then "Report wizard *" window is opened
		And I click the button named 'WriteAndCollapse'

Scenario: 04.03 Creating a report instance - "VA - Arbitrary request" using multi-period context

	And I create report instance for report type "VA - Arbitrary request" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Arbitrary request" | ''               | ''                | ''             | ''      |
			| ''                         | ''               | ''                | ''             | ''      |
			| ''                         | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                         | "Price"           | "Price"            | "Price"         | "Price"  |
			| "Product range"             | '0'              | '0'               | '0'            | '0'     |

	* Calculating indicator values
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Arbitrary request"                                        | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Price"           | "Price"            | "Price"         | "Price"       |
			| "Product range"                                                    | '6,030,000'      | '6,633,000'       | '7,495,400'    | '20,158,400' |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1,375,000'       | '1,553,800'    | '4,178,800'  |
			| "2C:Corporation "                                                  | '2,050,000'      | '2,255,000'       | '2,548,200'    | '6,853,200'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '198,000'         | '223,700'      | '601,700'    |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '2,145,000'       | '2,423,900'    | '6,518,900'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '660,000'         | '745,800'      | '2,005,800'  |
	
	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 04.04 Checking the behavior of the indicator configuration form without using multi-period context

	And I open report wizard with name "VA - Arbitrary request"

	* Unchecking the multi-period context flag on the data source
		Then "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'AddOperand1'
		When "Data sources" window is opened
		And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
		If '$$IsPerform$$' Then
			Then 'Arbitrary query to current infobase (Data source)' window is opened
		Else
			Then "Arbitrary query to current infobase (Data source)" window is opened
		And I save the window as 'WindowTitle'
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

	* Checking the form behavior with the extended indicator calculation engine
		Then "Data sources" window is opened
		And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
		Then '$WindowTitle$' window is opened
		And the field named 'UseMultiperiodContext' exists on the form
		And the field named 'Help' exists on the form
		And I remove checkbox named 'UseMultiperiodContext'
		And I move to the tab named 'ComplianceAnalyst'
		And I move to the tab named 'FiltersPage'
		Then I check table 'TreeOfFilterParametersDB' contains '3' rows from list:
			| "Field"                    | "Filter"                      | "Filter clarification"  | "Value to check" |
			| '[StartDateParameter]'    | "Report period start date" | ''                  | ''                      |
			| '[EndDateParameter]' | "Report period end date"  | ''                  | ''                      |
			| '[ParameterPriceType_]'        | "Fixed value"     | "VA - Products" | ''                      |
		And I click the button named 'FormWrite'
		And checkbox named 'UseMultiperiodContext' is equal to 'False'
								
	* Checking table filling
		When '$WindowTitle$' window is opened
		And I click the button named 'EditQueryText'
		And I click the button named 'EditQueryText'
		And I expand a line in 'FieldsTreeDB' table
			| "Field"                 |
			| "Query parameters(3)" |
		And I expand a line in 'FieldsTreeDB' table
			| "Field"                     |
			| "Data source fields(3)" |
		Then I check table 'FieldsTreeDB' contains '8' rows from list:
			| "Field"                     |
			| "Query parameters(3)"     |
			| 'StartDateParameter'       |
			| 'EndDateParameter'    |
			| 'ParameterPriceType_'           |
			| "Data source fields(3)" |
			| 'Date'                     |
			| 'Products'                  |
			| 'Price'                     |
		Then I check table 'ComplianceTable' contains '2' rows from list:
			| "Destination dimension"       | "Filling method" | "Column name"    | "Dimension type" |
			| "Dimension 1: Product range" | "Source field"    | '[Products]' | "Product range"  |
			| "Value"                  | "Source field"    | '[Price]'         | ''              |
		And I move to the tab named 'FiltersPage'
		When '$WindowTitle$' window is opened
		Then I check table 'TreeOfFilterParametersDB' contains '3' rows from list:
			| "Field"                    | "Filter"                      | "Filter clarification"  | "Value to check" |
			| '[StartDateParameter]'    | "Report period start date" | ''                  | ''                      |
			| '[EndDateParameter]' | "Report period end date"  | ''                  | ''                      |
			| '[ParameterPriceType_]'        | "Fixed value"     | "VA - Products" | ''                      |
	 			
	* Closing the data source
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "Data sources" window is opened
		And I close "Data sources" window
		Then "Report wizard" window is opened
		And I click the button named 'UndoFormulaEdit'

Scenario: 04.05 Creating a report instance - "VA - Arbitrary request" without using multi-period context

	And I create report instance for report type "VA - Arbitrary request" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Venus LLC" project '' dimensions '' '' '' '' '' ''

	* The document should be empty
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Arbitrary request" | ''               | ''                | ''             | ''      |
			| ''                         | ''               | ''                | ''             | ''      |
			| ''                         | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| ''                         | "Price"           | "Price"            | "Price"         | "Price"  |
			| "Product range"             | '0'              | '0'               | '0'            | '0'     |

	* Calculating indicator values
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Arbitrary request"                                        | ''               | ''                | ''             | ''           |
			| ''                                                                | ''               | ''                | ''             | ''           |
			| ''                                                                | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
			| ''                                                                | "Price"           | "Price"            | "Price"         | "Price"       |
			| "Product range"                                                    | '6,030,000'      | '6,633,000'       | '7,495,400'    | '20,158,400' |
			| "5C:Corporate performance management "                                      | '1,250,000'      | '1,375,000'       | '1,553,800'    | '4,178,800'  |
			| "2C:Corporation "                                                  | '2,050,000'      | '2,255,000'       | '2,548,200'    | '6,853,200'  |
			| "4C:Enterprise 8.3 CORP. Server License (x86-64) "           | '180,000'        | '198,000'         | '223,700'      | '601,700'    |
			| "1C:ERP. Corporate performance management "                                   | '1,950,000'      | '2,145,000'       | '2,423,900'    | '6,518,900'  |
			| "3C:Enterprise 8 CORP. Client license for 100 users " | '600,000'        | '660,000'         | '745,800'      | '2,005,800'  |

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds
