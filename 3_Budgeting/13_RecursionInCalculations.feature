#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 13. Recursion in calculations

	As Administrator I want to
	Checking that recursion in calculations is caught

Background:

	And I close all client application windows

Scenario: 13.00 Determining application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 13.01 Creating report type with indicator calculation recursion

	* Creating a report type
		And I create report type group with name "VA - Transformations period (group)" and parent "VA - Report group"
		And I create report type with name "VA - Transformation period" and parent "VA - Transformations period (group)"
		
	* Configuring report type structure
		And I open report wizard with name "VA - Transformation period"
		And I add row with name "Source" in report wizard
		And I add row with name "Destination" in report wizard
		And I add row with name "Accumulation" in report wizard
		And I add row with name "Total" in report wizard
		And I add column with name "Amount" in report wizard

	* Configuring calculation formulas
		When "Report wizard" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ButtonPlus'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'

	* Creating pivot table template
		And I for report type "Cash flow items" create default pivot table template with filters "VA - Transformation period"

Scenario: 13.02 Entering data into pivot table, getting recursive calculation error

	* Opening a pivot table
		And I open report pivot table with name "VA - Transformation period"
		And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Mercury LLC"
		And I save form header as 'WindowTitle' variable

	* Entering a value
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
		Then "Protocol" window is opened
		And I click the button named 'FormTechnicalInformation'
		Then 'SpreadsheetDocumentField' spreadsheet document is equal
				| "Errors"                                                                                                                                | '' | ''                                                                                                                     |
				| "Recursion is found in links when calculating the indicator: \"Destination amount\".\nCheck calculation formulas and rewrite the calculation rule."   | '' | "{\"S\",\"Calculation tree:\n	Total amount\n		Accumulation amount\n			Destination amount\n				Source amount\n				Total amount\"}"      |
				| "Recursion is found in links when calculating the indicator: \"Accumulation amount\".\nCheck calculation formulas and rewrite the calculation rule." | '' | "{\"S\",\"Calculation tree:\n	Destination amount\n		Source amount\n		Total amount\n			Accumulation amount\n				Destination amount\"}"    |
				| "Recursion is found in links when calculating the indicator: \"Total amount\".\nCheck calculation formulas and rewrite the calculation rule."       | '' | "{\"S\",\"Calculation tree:\n	Accumulation amount\n		Destination amount\n			Source amount\n			Total amount\n				Accumulation amount\"}" |
		And I close "Protocol" window
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 13.03 Reconfiguring report type structure

	* Configuring report type structure
		And I open report wizard with name "VA - Transformation period"

	* Receiver
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input "[VATransformationPeriod_Source_Amount]" text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'WriteAndCollapse'

	* Accumulation
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'AddOperand1'
		Then "Data sources" window is opened
		And I click the button named 'FormCreate'
		Then "Data source (create)" window is opened
		And I select from the drop-down list named 'ReportTypeFilter'  by "VA - Transformation period" string
		And I click Choice button of the field named 'IndicatorFilter'
		And I select indicator with code "Accumulation_Amount"
		Then "Data source (create) *" window is opened
		And I move to the tab named 'FiltersPage'
		And I go to line in 'TreeOfFilterParametersDB' table:
			| "Filter"         | "Field"            |
			| "Report period" | "[Report period]" |
		And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I select "Report period with a shift" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I activate field named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
 		And I input '-1' text in the field named 'DefiningMethodClarification' of 'TreeOfFilterParametersDB' table
		And I click the button named 'FormWriteAndClose'
		And I wait "Data source (create) *" window closing in 20 seconds
		Then "Data sources" window is opened
		And I select current line in 'List' table
		Then "Report wizard *" window is opened
		And I input "[VATransformationPeriod_Accumulation_Amount01] + [VATransformationPeriod_Destination_Amount]" text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'WriteAndCollapse'

	* Total
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'AddOperand1'
		Then "Data sources" window is opened
		And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
		Then "VA - Transformation period_Accumulation Amount (Data source)" window is opened
		And I move to the tab named 'FiltersPage'
		And I go to line in 'TreeOfFilterParametersDB' table:
			| "Filter"         | "Field"            |
			| "Report period" | "[Report period]" |
		And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select current line in 'TreeOfFilterParametersDB' table
		And I select "Not filtered" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
		And I finish line editing in 'TreeOfFilterParametersDB' table
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - Transformation period_Accumulation Amount (Data source) *" window closing in 20 seconds
		Then "Data sources" window is opened
		And I close "Data sources" window
		Then "Report wizard" window is opened
		And I click the button named 'UndoFormulaEdit'
				
Scenario: 13.04 Checking calculation in pivot table

	* Opening pivot table
		And I open report pivot table with name "VA - Transformation period"

	* Entering values
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '100.00000'
		When '$WindowTitle$ *' window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Transformation period (pivot table)" | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| "VA - Transformation period (pivot table)" | "Amount"          | "Amount"           | "Amount"        | "Amount" |
			| "Source"                                      | '100'            | '0'               | '0'            | '100'   |
			| "Destination"                                      | '100'            | '0'               | '0'            | '100'   |
			| "Accumulation"                                    | '100'            | '100'             | '100'          | '300'   |
			| "Total"                                          | '300'            | '300'             | '300'          | '900'   |

	* Entering values
		When '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '200.00000'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '300.00000'
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Transformation period (pivot table)" | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
			| "VA - Transformation period (pivot table)" | "Amount"          | "Amount"           | "Amount"        | "Amount" |
			| "Source"                                      | '100'            | '200'             | '300'          | '600'   |
			| "Destination"                                      | '100'            | '200'             | '300'          | '600'   |
			| "Accumulation"                                    | '100'            | '300'             | '600'          | '1,000' |
			| "Total"                                          | '1,000'          | '1,000'           | '1,000'        | '3,000' |
			
	* Saving result
		When '$WindowTitle$ *' window is opened
		And I close '$WindowTitle$ *' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
									
