#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 05. Checking report types without saving history, checking data filling from RB

	As Administrator I want to
	Check that report types without history correctly save versions
	so that versions are saved without errors

Background:
	
	And I close all client application windows

Scenario: 05.00 Determining the application type

	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 05.01 Creating report type "VA - Filling from PH (no history)"

	And I create report type with name "VA - Filling from PH (no history)" and parent "VA - Report group"
	And I change flag 'IsChangeTrackingEnabled' for report type "VA - Filling from PH (no history)"
	And I change flag 'ProjectSeparation' for report type "VA - Filling from PH (no history)"
	
	* Editing the report structure
		And I open report wizard with name "VA - Filling from PH (no history)"
		And I add row with name "Cash flow items" in report wizard
		And I add column with name "Amount" in report wizard
		And I add dimension with code "VA0CFItems" in cell 'R2C2' in report wizard

	And I create default template for report type "VA - Filling from PH (no history)"

Scenario: 05.02 Creating pivot table template

	And I find report type with name "VA - Filling from PH (no history)" in list
					
	* Creating pivot table template
		When "Report types and templates" window is opened
		And I go to line in 'List' table:
			| "Description"                                          |
			| "VA - Filling from PH (no history) (pivot table)" |
		And I select current line in 'List' table
		* Row composition
			When I open pivot table template for report type "VA - Filling from PH (no history)"
			And I click the button named 'ShowListOfRows'
			Then "Set up line list" window is opened
			And I go to line in 'SettingTree' table:
				| "Dimension kind 1" | "Dimension group" | "Code"       | "Purpose"      | "Report line" |
				| "Cash flow items"      | "DG_Cash flow items"   | "CashFlowItems" | "Arbitrary data" | "Cash flow items"    |
			And I click the button named 'MoveLeft'
			And I click the button named 'ApplyTheChanges'
		* Column composition
			Then I open pivot table template for report type "VA - Filling from PH (no history)"
			And I save form header as 'WindowTitle' variable
			And I click the button named 'ShowListOfColumns'
			Then "Set up column list" window is opened
			And in the table 'PivotTableColumnsListSettings' I click the button named 'PivotTableColumnsListSettingsAdd'
			And I click choice button of the attribute named 'PivotTableColumnsListSettingsReportColumn' in 'PivotTableColumnsListSettings' table
			Then "Report columns" window is opened
			And I select current line in 'List' table
			Then "Set up column list" window is opened
			And I finish line editing in 'PivotTableColumnsListSettings' table
			And I click the button named 'FormApply'
		* Grouping layout
			When '$WindowTitle$' window is opened
			And I click the button named 'ShowTableSettingsByAxes'
			Then "Set up field location" window is opened
			And I go to line in 'TableAvailableFields' table:
				| "Available dimensions" |
				| "Project"              |
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToFilters' of the form attribute named 'TableAvailableFields'
			And I go to line in 'TableAvailableFields' table:
				| "Available dimensions" |
				| "Cash flow items"          |
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToRows' of the form attribute named 'TableAvailableFields'
			And I click the button named 'ButtonApply'
		* Scale with periods
			Then '$WindowTitle$' window is opened
			And I click the button named 'ShowPeriodsSettings'
			And I select "Quarter" exact value from the drop-down list named 'Periodicity'
			And I select "Month" exact value from the drop-down list named 'Periodicity'
			And I change checkbox named 'ShouldShowTotalYear'
			And I change checkbox named 'ShouldShowTotalYear'
			And I change checkbox named 'ShouldShowTotal6Months'
			And I change checkbox named 'ShouldShowTotal6Months'
			And I change checkbox named 'ShouldShowTotalQuarter'
			And I change checkbox named 'ShouldShowTotalQuarter'
			And I click the button named 'FormApply'
		* Field layout
			Then '$WindowTitle$' window is opened
			And I click the button named 'ShowDimensionCompositionSettings'
			Then "Row and column dimension list settings" window is opened
			And I click the button named 'FormApply'
		* Saving template
			Then '$WindowTitle$' window is opened
			And I expand the group named 'GroupOfMainAttributes'
			And I click the button named 'FormWriteAndClose'
			And I wait '$WindowTitle$ *' window closing in 20 seconds

Scenario: 05.03 Creating calculation formula with filling from PH

	If 'NOT $$IsPerform$$' Then

		And I open report wizard with name "VA - Filling from PH (no history)"
					
		* Entering the calculation formula
			* Creating a new element
				Then "Report wizard" window is opened
				And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'AddOperand1'
				When "Data sources" window is opened
				And I click the button named 'FormCreate'
			* Filling source of obtaining, checking field filling
				When "Data source (create)" window is opened
				And I select "Current infobase accumulation register" exact value from the drop-down list named 'MethodOfObtaining'
				If '$$IsERPCPM$$' Then
					And I select from the drop-down list named 'DBAccumulationRegister'  by 'BudgetsOperations' string
					And I wait "Amount" value of the attribute named 'DBRegisterResource' for 3 seconds
					And I wait "Turnover" value of the attribute named 'TotalKindDB' for 3 seconds
					And I select "Amount executed" exact value from the drop-down list named 'DBRegisterResource'
					When "Data source (create) *" window is opened
					And I expand current line in "FieldsTreeDB" table
					And I expand a line in "FieldsTreeDB" table
						| 'Field'                      |
						| 'Dimension of budget items' |
					And I expand a line in "FieldsTreeDB" table
						| 'Field'           |
						| 'Budget item' |
					And I go to line in "FieldsTreeDB" table:
						| 'Field'                                     |
						| 'Catalog.CashFlowReportItems' |
					And I select context menu item named 'ButtonMapDimensions' of the form attribute named "ComplianceTable"
					Then "ComplianceTable" table became equal
						| 'Destination dimension'     | 'Filling method' | 'Column name'                                  | 'Dimension type' |
						| 'Dimension 1: ARTICLES__ Cash_Flow' | 'Source field'    | '[Budget items dimension].[Budget item]' | 'ARTICLES__ Cash_Flow'    |
				Else
					And I select from the drop-down list named 'DBAccumulationRegister'  by 'CashFlowCPM' string
					And I wait "Amount" value of the attribute named 'DBRegisterResource' for 3 seconds
					And I wait "Turnover" value of the attribute named 'TotalKindDB' for 3 seconds
					Then 'ComplianceTable' table became equal
						| 'Destination dimension'     | 'Filling method' | 'Column name'                        | 'Dimension type' |
						| "Dimension 1: Cash flow items" | 'Source field'    | '[Cash flow item]' | "Cash flow items"    |
			* Filling filters
				And I move to the tab named 'FiltersPage'
				If '$$IsERPCPM$$' Then
					And I expand a line in "FieldsTreeDB" table
						| 'Field'                |
						| 'Dimension of structure' |
					And I go to line in "FieldsTreeDB" table:
						| 'Field'        |
						| 'Organization' |
					And I click the button named 'AddConditionItem'
					And I go to line in "TreeOfFilterParametersDB" table:
						| 'Field'                                |
						| '[Structure dimension].[Organization]' |
					And I select 'Organization Report_' exact value from the drop-down list named "ParameterCalculationMethod" in "TreeOfFilterParametersDB" table
					And I finish line editing in "TreeOfFilterParametersDB" table
				Else
					And I go to line in 'TreeOfFilterParametersDB' table:
						| 'Filter'         | 'Field'         |
						| 'Project Report_' | '[Dimension1]' |
					And I click the button named 'TreeOfFilterParametersDBDelete'
					And I go to line in 'TreeOfFilterParametersDB' table:
						| 'Filter'           | 'Field'         |
						| 'Scenario Report_' | '[Dimension2]' |
					And I click the button named 'TreeOfFilterParametersDBDelete'
					And I go to line in 'TreeOfFilterParametersDB' table:
						| 'Filter'         | 'Field'         |
						| "Report period" | '[Dimension3]' |
					And I click the button named 'TreeOfFilterParametersDBDelete'
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds

		* Saving an element
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'

Scenario: 05.04 Creating report instance - "VA - Filling from PH (no history)" without saving

	If 'NOT $$IsPerform$$' Then

		And I create report instance for report type "VA - Filling from PH (no history)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency 'Month' company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''
		
		* The document should be empty
			And 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Filling from PH (no history)" | ''               | ''                | ''             | ''      |
				| ''                                    | ''               | ''                | ''             | ''      |
				| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
				| ''                                    | "Amount"          | "Amount"           | "Amount"        | "Amount" |
				| "Cash flow items"                          | '0'              | '0'               | '0'            | '0'     |

		* Calculating indicator values
			When '$WindowTitle$' window is opened
			And I click the button named 'FormFillByDefault'
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Filling from PH (no history)" | ''               | ''                | ''             | ''           |
				| ''                                    | ''               | ''                | ''             | ''           |
				| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
				| ''                                    | "Amount"          | "Amount"           | "Amount"        | "Amount"      |
				| "Cash flow items"                          | '3,120,000'      | '16,000,000'      | '0'            | '19,120,000' |
				| "1Software upgrade "      | '0'              | '3,450,000'       | '0'            | '3,450,000'  |
				| "2Software implementation "    | '2,340,000'      | '7,350,000'       | '0'            | '9,690,000'  |
				| "3Software sale "   | '780,000'        | '5,200,000'       | '0'            | '5,980,000'  |

		* Closing without saving
			When '$WindowTitle$' window is opened
			And I close '$WindowTitle$' window
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button1'

Scenario: 05.05 Creating report instance - "VA - Filling from PH (no history)" with saving

	If 'NOT $$IsPerform$$' Then

		And I create report instance for report type "VA - Filling from PH (no history)" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency 'Month' company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

		* The document should be empty
			And 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Filling from PH (no history)" | ''               | ''                | ''             | ''      |
				| ''                                    | ''               | ''                | ''             | ''      |
				| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL" |
				| ''                                    | "Amount"          | "Amount"           | "Amount"        | "Amount" |
				| "Cash flow items"                          | '0'              | '0'               | '0'            | '0'     |

		* Calculating indicator values
			When '$WindowTitle$' window is opened
			And I click the button named 'FormFillByDefault'
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| "VA - Filling from PH (no history)" | ''               | ''                | ''             | ''           |
				| ''                                    | ''               | ''                | ''             | ''           |
				| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL"      |
				| ''                                    | "Amount"          | "Amount"           | "Amount"        | "Amount"      |
				| "Cash flow items"                          | '3,120,000'      | '16,000,000'      | '0'            | '19,120,000' |
				| "1Software upgrade "      | '0'              | '3,450,000'       | '0'            | '3,450,000'  |
				| "2Software implementation "    | '2,340,000'      | '7,350,000'       | '0'            | '9,690,000'  |
				| "3Software sale "   | '780,000'        | '5,200,000'       | '0'            | '5,980,000'  |

		* Saving document, checking movements
			When '$WindowTitle$' window is opened
			And I click the button named 'Write'
			And I wait for '$WindowTitle$' form opening for 30 seconds

		* Checking the movements
			And I check report instance movements are equal to '3_Budgeting\Layouts\05\VA_FillFromAccumulationRegister_Movements_1.mxl'
		
Scenario: 05.06 Creating calculation formula with filling from PH for the main table

	If 'NOT $$IsPerform$$' Then

		And I open report wizard with name "VA - Filling from PH (no history)"
					
		* Entering the calculation formula
			* Creating a new element
				Then "Report wizard" window is opened
				And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
				And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
				And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
				And I input ' ' text in the field named 'TextDocumentFieldProcedure'
				And I click the button named 'AddOperand1'
				When "Data sources" window is opened
				And I click the button named 'FormCreate'
			* Filling source of obtaining, checking field filling
				When "Data source (create)" window is opened
				And I select "Current infobase accumulation register" exact value from the drop-down list named 'MethodOfObtaining'
				If '$$IsERPCPM$$' Then
					And I select from the drop-down list named 'DBAccumulationRegister'  by 'BudgetsOperations' string
				Else
					And I select from the drop-down list named 'DBAccumulationRegister'  by 'CashFlowCPM' string
				And I set checkbox named 'IsRegisterMainTable'
				And I wait "Amount" value of the attribute named 'DBRegisterResource' for 10 seconds
				Then 'FieldsTreeDB' table became equal by template
					| 'Field'                  |
					| 'Recorder'           |
					| 'Register dimensions(*)' |
					| 'Register attributes(*)' |
				If '$$IsERPCPM$$' Then
					And I select "Amount executed" exact value from the drop-down list named 'DBRegisterResource'
					When "Data source (create) *" window is opened
					And I expand a line in "FieldsTreeDB" table
						| 'Field'                   |
						| 'Register dimensions(12)' |
					And I expand a line in "FieldsTreeDB" table
						| 'Field'                      |
						| 'Dimension of budget items' |
					And I expand a line in "FieldsTreeDB" table
						| 'Field'           |
						| 'Budget item' |
					And I go to line in "FieldsTreeDB" table:
						| 'Field'                                     |
						| 'Catalog.CashFlowReportItems' |
					And I select context menu item named 'ButtonMapDimensions' of the form attribute named "ComplianceTable"
					Then "ComplianceTable" table became equal
						| 'Destination dimension'     | 'Filling method' | 'Column name'                                  | 'Dimension type' |
						| 'Dimension 1: ARTICLES__ Cash_Flow' | 'Source field'    | '[Budget items dimension].[Budget item]' | 'ARTICLES__ Cash_Flow'    |
				Else
					Then 'ComplianceTable' table became equal
						| 'Destination dimension'     | 'Filling method' | 'Column name'                        | 'Dimension type' |
						| "Dimension 1: Cash flow items" | 'Source field'    | '[Cash flow item]' | "Cash flow items"    |

			* Adding filters
				And I move to the tab named 'FiltersPage'
				When "Data source (create) *" window is opened
				And I go to line in 'TreeOfFilterParametersDB' table:
					| 'Filter'                      | 'Field'                      |
					| 'Report period start date' | 'Data selection start date' |
				And I select "Start date of report period with a shift" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I input '-1' text in the field named 'DefiningMethodClarification' of 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				And I go to line in 'TreeOfFilterParametersDB' table:
					| 'Filter'                     | 'Field'                         |
					| 'Report period end date' | 'Data selection end date' |
				And I select "Reporting period end date with a shift" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
				And I input '-1' text in the field named 'DefiningMethodClarification' of 'TreeOfFilterParametersDB' table
				And I finish line editing in 'TreeOfFilterParametersDB' table
				If '$$IsERPCPM$$' Then
					* Adding filter fields
						And I expand a line in "FieldsTreeDB" table
							| 'Field'                |
							| 'Dimension of structure' |
						And I go to line in "FieldsTreeDB" table:
							| 'Field'        |
							| 'Organization' |
						And I click the button named 'AddConditionItem'
						And I go to line in "TreeOfFilterParametersDB" table:
							| 'Field'                                |
							| '[Structure dimension].[Organization]' |
						And I select 'Organization Report_' exact value from the drop-down list named "ParameterCalculationMethod" in "TreeOfFilterParametersDB" table
						And I finish line editing in "TreeOfFilterParametersDB" table

				Else
					* Deleting current filters
						And I go to line in 'TreeOfFilterParametersDB' table:
							| 'Filter'         | 'Field'         |
							| 'Project Report_' | '[Dimension1]' |
						And I click the button named 'TreeOfFilterParametersDBDelete'
						And I go to line in 'TreeOfFilterParametersDB' table:
							| 'Filter'           | 'Field'         |
							| 'Scenario Report_' | '[Dimension2]' |
						And I click the button named 'TreeOfFilterParametersDBDelete'
						And I go to line in 'TreeOfFilterParametersDB' table:
							| 'Filter'         | 'Field'         |
							| "Report period" | '[Dimension3]' |
						And I click the button named 'TreeOfFilterParametersDBDelete''
				* Adding filter fields
					When "Data source (create) *" window is opened
					And I expand a line in 'FieldsTreeDB' table
						| 'Field'        |
						| 'Recorder' |
					If '$$IsERPCPM$$' Then
						And I go to line in 'FieldsTreeDB' table:
							| 'Field'                                              |
							| 'Document.BudgetingActualDataRecording' |
						And I expand current line in 'FieldsTreeDB' table
					And I expand a line in 'FieldsTreeDB' table
						| 'Field'       |
						| 'Counterparty' |
					And I expand a line in 'FieldsTreeDB' table
						| 'Field'       |
						| 'Catalog.Counterparties' |
					And I click the button named 'AddConditionItem'
					And I go to line in 'FieldsTreeDB' table:
						| 'Field'     |
						| 'Scenario' |
					And I click the button named 'AddConditionItem'
				* Adding filter values
					When "Data source (create) *" window is opened
					And I go to line in 'TreeOfFilterParametersDB' table:
						| 'Field'                     |
						| '[Recorder].[Scenario]' |
					And I activate field named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I select "Report scenario" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
					And I go to line in 'TreeOfFilterParametersDB' table:
						| 'Field'                       |
						| '[Recorder].[Counterparty]' |
					And I select "Fixed value" exact value from the drop-down list named 'ParameterCalculationMethod' in 'TreeOfFilterParametersDB' table
					And I click choice button of the attribute named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					When "Counterparties*" window is opened
					And I close "Counterparties*" window
					And I select "LLC \"Ganymede\"" by string from the drop-down list named 'DefiningMethodClarification' in 'TreeOfFilterParametersDB' table
					And I finish line editing in 'TreeOfFilterParametersDB' table
						
			* Saving the element
				When "Data source (create) *" window is opened
				And I click the button named 'FormWriteAndClose'
				And I wait "Data source (create) *" window closing in 20 seconds
		
		* Selecting element in the wizard form
			Then "Data sources" window is opened
			And I select current line in 'List' table
			Then "Report wizard *" window is opened
			And I click the button named 'WriteAndCollapse'

Scenario: 05.07 Configuring rights for users

	If 'NOT $$IsPerform$$' Then

		And I add right "Read, write" for report type "VA - Filling from PH (no history)" user "Budgeting1" for all companies
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 05.08 Creating pivot table

	If 'NOT $$IsPerform$$' Then

		And I find report type with name "VA - Filling from PH (no history)" in list

		* Creating pivot table
			When "Report types and templates" window is opened
			And I go to line in "List" table:
				| 'Description'                                          |
				| 'VA - Filling from PH (no history) (pivot table)' |
			And I click the button named 'SwitchToDataDisplayMode'
			And I open pivot table for report type "VA - Filling from PH (no history)"
			And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Mercury LLC"
			And I set pivot table filter 'Project' with value "VA - Main project"
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| 'VA - Filling from PH (no history) (pivot table)' | "January 2024" | "February 2024" | "March 2024" |
				| 'VA - Filling from PH (no history) (pivot table)' | "Amount"          | "Amount"           | "Amount"        |
				| "Cash flow items"                                            | '3,120,000'      | '16,000,000'      | '0'            |
				| "1Software upgrade"                         | '0'              | '3,450,000'       | '0'            |
				| "2Software implementation"                       | '2,340,000'      | '7,350,000'       | '0'            |
				| "3Software sale"                      | '780,000'        | '5,200,000'       | '0'            |
		
		* Calculating by regulation
			And I open pivot table for report type "VA - Filling from PH (no history)"
			And I click the button named 'RecalculateAccordingToRegulations'
			And I wait for '$WindowTitle$' form opening for 30 seconds
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| 'VA - Filling from PH (no history) (pivot table)' | "January 2024" | "February 2024" | "March 2024" |
				| 'VA - Filling from PH (no history) (pivot table)' | "Amount"          | "Amount"           | "Amount"        |
				| "Cash flow items"                                            | '0'              | '3,120,000'       | '0'            |
				| "2Software implementation"                       | '0'              | '2,340,000'       | '0'            |
				| "3Software sale"                      | '0'              | '780,000'         | '0'            |

		* Canceling transaction
			And I click the button named 'CancelAction'
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| 'VA - Filling from PH (no history) (pivot table)' | "January 2024" | "February 2024" | "March 2024" |
				| 'VA - Filling from PH (no history) (pivot table)' | "Amount"          | "Amount"           | "Amount"        |
				| "Cash flow items"                                            | '3,120,000'      | '16,000,000'      | '0'            |
				| "1Software upgrade"                         | '0'              | '3,450,000'       | '0'            |
				| "2Software implementation"                       | '2,340,000'      | '7,350,000'       | '0'            |
				| "3Software sale"                      | '780,000'        | '5,200,000'       | '0'            |								

		* Calculating by rule
			When '$WindowTitle$' window is opened
			And I click the button named 'RecalculateOther'
			Then "Select method to calculate indicators" window is opened
			And I click the button named 'FormSelect'
			And I wait for '$WindowTitle$' form opening for 30 seconds
			Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| 'VA - Filling from PH (no history) (pivot table)' | "January 2024" | "February 2024" | "March 2024" |
				| 'VA - Filling from PH (no history) (pivot table)' | "Amount"          | "Amount"           | "Amount"        |
				| "Cash flow items"                                            | '0'              | '3,120,000'       | '0'            |
				| "2Software implementation"                       | '0'              | '2,340,000'       | '0'            |
				| "3Software sale"                      | '0'              | '780,000'         | '0'            |

		* Saving table
			When '$WindowTitle$' window is opened
			And I close '$WindowTitle$' window
			Then '1C:Enterprise' window is opened
			And I click the button named 'Button0'

Scenario: 05.09 Checking movements of report instance

	If 'NOT $$IsPerform$$' Then

		And I open first report instance for report type "VA - Filling from PH (no history)"
		And I open report instance for report type "VA - Filling from PH (no history)" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| "VA - Filling from PH (no history)" | ''               | ''                | ''             | ''          |
			| ''                                    | ''               | ''                | ''             | ''          |
			| ''                                    | "January 2024" | "February 2024" | "March 2024" | "TOTAL"     |
			| ''                                    | "Amount"          | "Amount"           | "Amount"        | "Amount"     |
			| "Cash flow items"                          | '0'              | '3,120,000'       | '0'            | '3,120,000' |
			| "2Software implementation "    | '0'              | '2,340,000'       | '0'            | '2,340,000' |
			| "3Software sale "   | '0'              | '780,000'         | '0'            | '780,000'   |

		* Checking movements after the pivot table
			When '$WindowTitle$' window is opened
			And I check report instance movements are equal to '3_Budgeting\Layouts\05\VA_FillFromAccumulationRegister_Movements_2.mxl'

		* Calculating document
			When '$WindowTitle$' window is opened
			And I click the button named 'FormFillByDefault'

		* Checking the movements
			When '$WindowTitle$' window is opened
			And I click the button named 'FormDocumentRegisterRecords'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button1'
			When '$WindowTitle$' window is opened
			And I click the button named 'Write'
			And I wait for '$WindowTitle$' form opening for 30 seconds
			And I check report instance movements are equal to '3_Budgeting\Layouts\05\VA_FillFromAccumulationRegister_Movements_2.mxl'
