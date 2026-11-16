#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 01. Checking creation of report types with full set of dimensions

	As Administrator I want to
	Check creation and operation of report types
	so that report types are entered without errors

Background:
	
	And I close all client application windows

Scenario: 01.00 Determining application type

	And I close "CPM - Budget" TestClient
	Try
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 01.01 Creating report type

	And I create report type with name "VA - Manual entry for all analytics" and parent "VA - Report group"
	And I change flag 'ProjectSeparation' for report type "VA - Manual entry for all analytics"

Scenario: 01.02 Testing buttons of list form and report type element form

	* Finding report type
		And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input "VA - Manual entry for all analytics" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then the number of 'ReportKindList' table lines is 'equal' 1

	* Wizard
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'DoOpenDesigner'
		Then "Report wizard" window is opened
		And I close "Report wizard" window

	* Report instances
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I close "Report instances" window

	* Copying
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListCopy'
		Then "Copy report type" window is opened
		And I click the button named 'FormOK'
		Then "Report types (create)" window is opened
		And I close "Report types (create)" window

	* Opening form
		When "Report types and templates" window is opened
		And I select current line in 'ReportKindList' table

	* Wizard
		Then "VA - Manual entry for all analytics (Report types)" window is opened
		And I click the button named 'EditTree'
		Then "Report wizard" window is opened
		And I close "Report wizard" window

	* Graphical indicator links
		Then "VA - Manual entry for all analytics (Report types)" window is opened
		If '$$IsCPM$$' Then
			And I click the button named 'FormReportGraphicReportOnReportLinksOpenReport'
		ElseIf '$$IsERPCPM$$' Then
			And I click the button named 'FormLinksReport'
		Then "Report links report" window is opened
		And I close "Report links report" window

	* Indicator links
		Then "VA - Manual entry for all analytics (Report types)" window is opened
		And I click the button named 'FormReportReportLinksReportOpenReport'
		Then "Report on report indicator links" window is opened
		And I close "Report on report indicator links" window

	* Tabs
		Then "VA - Manual entry for all analytics (Report types)" window is opened
		And I move to the tab named 'DimensionsOfReport'
		And I move to the tab named 'DefaultSettings'
		And I move to the tab named 'ReportParameters'
		And I move to the tab named 'GroupSetLimits'

	* Closing the form
		And I close "VA - Manual entry for all analytics (Report types)" window

	* Closing the list form
		Then "Report types and templates" window is opened
		And I close "Report types and templates" window

Scenario: 01.03 Working in the report wizard - Configuring the report structure

	And I open report wizard with name "VA - Manual entry for all analytics"

	* Adding rows
		When "Report wizard" window is opened
		And I click the button named 'RowsTreeAddRows'
		Then "Adding new lines" window is opened
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineSynthetic" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension1" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension2" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension3" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension4" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension5" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension6" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimension6Currency" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LineDimensionCurrency" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And I click the button named 'OK'
	
	* Adding a group of rows
		Then "Report wizard" window is opened
		And I click the button named 'RowsTreeAddRows'
		Then "Adding new lines" window is opened
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "LinesGroup" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And I click the button named 'OK'
	
	* Checking the row movement buttons
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C1' cell
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveDown'
		And I click the button named 'RowsTreeRowMoveUp'

	* Adding a row and immediately deleting it
		When "Report wizard" window is opened
		And I click the button named 'RowsTreeAddRows'
		Then "Adding new lines" window is opened
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "StringDelete" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And I click the button named 'OK'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R12C1' cell
		And I click the button named 'DeleteRows'

	* Adding columns
		And I click the button named 'RowsTreeAddColumn'
		Then "Adding new columns" window is opened
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "Amount" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "Count" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "Price" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And I click the button named 'OK'

	* Checking the arrows
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R1C2' cell
		And I click the button named 'ColumnMoveRight'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R1C4' cell
		And I click the button named 'ColumnMoveLeft'

	* Deleting indicators
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2:R11C4' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteIndicator' in report wizard
	
	* Creating indicators
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2:R11C4' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuCreateIndicators' in report wizard
	
	* Editing indicator properties
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3:R11C3' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuProperties' in report wizard
		Then "Bulk edit indicators" window is opened
		And I change checkbox named 'ValueTypeChange'
		And I select "Number" exact value from the drop-down list named 'ValueType'
		And I change checkbox named 'TotalKindChange'
		And I select "Average" exact value from the drop-down list named 'TotalKind'
		And I set checkbox named 'DoNotSumUpChange'
		And I set checkbox named 'DoNotSumUp'
		And I set checkbox named 'ControllableIndicatorChange'
		And I set checkbox named 'ControllableIndicator'
		And I click the button named 'FormWriteAndClose'

	* Adding a column, immediately deleting it
		When "Report wizard" window is opened
		And I click the button named 'RowsTreeAddColumn'
		Then "Adding new columns" window is opened
		And in the table 'NewLines' I click the button named 'NewLinesAdd'
		And I input "ColumnDelete" text in the field named 'NewLinesDescription' of 'NewLines' table
		And I finish line editing in 'NewLines' table
		And I click the button named 'OK'
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R1C5' cell
		And I click the button named 'DeleteColumns'

	* Adding row and column attribute settings and comparing
		When "Report wizard" window is opened
		And I click the button named 'OpenLinesAttributesSettings'
		Then "Line attributes" window is opened
		And in the table 'LinesAttributes' I click the button named 'LinesAttributesAdd'
		Then "Select attribute" window is opened
		And I go to line in 'SettingsComposerSettingsOrderAvailableOrderFields' table:
			| "Available fields" |
			| 'Code'            |
		And I select current line in 'SettingsComposerSettingsOrderAvailableOrderFields' table
		Then "Line attributes" window is opened
		And I finish line editing in 'LinesAttributes' table
		And I click the button named 'FormSelect'
		Then "Report wizard" window is opened
		And I click the button named 'OpenIndicatorsPropertiesSettings'
		Then "Indicator attributes" window is opened
		And in the table 'IndicatorsAttributes' I click the button named 'IndicatorsAttributesAdd'
		Then "Select attribute" window is opened
		And I go to line in 'SettingsComposerSettingsOrderAvailableOrderFields' table:
			| "Available fields" |
			| 'Code'            |
		And I select current line in 'SettingsComposerSettingsOrderAvailableOrderFields' table
		Then "Indicator attributes" window is opened
		And I finish line editing in 'IndicatorsAttributes' table
		And I click the button named 'FormSelect'
		Then "Report wizard" window is opened
		And I click the button named 'ShowMarkedForDeletion'

	* Comparing with the reference
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal by template
			| 'String'               | 'Code'              | "Indicator attributes" | "Count"                      | "Price"                   | "Amount"                   | "ColumnDelete" |
			| "LinesGroup"            | "LinesGroup*"     | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LinesGroup_Count1*"     | "LinesGroup_Price1*"     | "LinesGroup_Amount1*"     | ''               |
			| "LineSynthetic"        | "LineSynthetic*"   | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineSynthetic_Count1*"   | "LineSynthetic_Price1*"   | "LineSynthetic_Amount1*"   | ''               |
			| "LineDimension1"       | "LineANLT1*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT1_Count1*"       | "LineANLT1_Price1*"       | "LineANLT1_Amount1*"       | ''               |
			| "LineDimension2"       | "LineANLT2*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT2_Count1*"       | "LineANLT2_Price1*"       | "LineANLT2_Amount1*"       | ''               |
			| "LineDimension3"       | "LineANLT3*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT3_Count1*"       | "LineANLT3_Price1*"       | "LineANLT3_Amount1*"       | ''               |
			| "LineDimension4"       | "LineANLT4*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT4_Count1*"       | "LineANLT4_Price1*"       | "LineANLT4_Amount1*"       | ''               |
			| "LineDimension5"       | "LineANLT5*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT5_Count1*"       | "LineANLT5_Price1*"       | "LineANLT5_Amount1*"       | ''               |
			| "LineDimension6"       | "LineANLT6*"       | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT6_Count1*"       | "LineANLT6_Price1*"       | "LineANLT6_Amount1*"       | ''               |
			| "LineDimension6Currency" | "LineANLT6Currency*" | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLT6Currency_Count1*" | "LineANLT6Currency_Price1*" | "LineANLT6Currency_Amount1*" | ''               |
			| "LineDimensionCurrency"  | "LineANLTCurrency*"  | ''                      | '■'                            | '■'                      | '■'                       | ''               |
			| ''                       | ''                 | 'Code'                   | "LineANLTCurrency_Count1*"  | "LineANLTCurrency_Price1*"  | "LineANLTCurrency_Amount1*"  | ''               |
			| "StringDelete"          | "STRKDelete*"     | ''                      | ''                             | ''                       | ''                        | ''               |
			| ''                       | ''                 | 'Code'                   | ''                             | ''                       | ''                        | ''               |

	* Removing all settings and comparing
		When "Report wizard" window is opened
		And I click the button named 'OpenLinesAttributesSettings'
		Then "Line attributes" window is opened
		And I go to line in 'LinesAttributes' table:
			| 'Value' |
			| 'Code'      |
		And in the table 'LinesAttributes' I click the button named 'LinesAttributesDelete'
		And I click the button named 'FormSelect'
		Then "Report wizard" window is opened
		And I click the button named 'OpenIndicatorsPropertiesSettings'
		Then "Indicator attributes" window is opened
		And in the table 'IndicatorsAttributes' I click the button named 'IndicatorsAttributesDelete'
		And I click the button named 'FormSelect'
		Then "Report wizard" window is opened
		And I click the button named 'ShowMarkedForDeletion'

	* Comparing with the reference
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| 'String'               | "Count" | "Price" | "Amount" |
			| "LinesGroup"            | '■'          | '■'    | '■'     |
			| "LineSynthetic"        | '■'          | '■'    | '■'     |
			| "LineDimension1"       | '■'          | '■'    | '■'     |
			| "LineDimension2"       | '■'          | '■'    | '■'     |
			| "LineDimension3"       | '■'          | '■'    | '■'     |
			| "LineDimension4"       | '■'          | '■'    | '■'     |
			| "LineDimension5"       | '■'          | '■'    | '■'     |
			| "LineDimension6"       | '■'          | '■'    | '■'     |
			| "LineDimension6Currency" | '■'          | '■'    | '■'     |
			| "LineDimensionCurrency"  | '■'          | '■'    | '■'     |

Scenario: 01.04 Working in the report wizard - Configuring dimensions

	And I open report wizard with name "VA - Manual entry for all analytics"
	
	* Setting the dimension "Product categories"
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0ProCate" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And I click the button named 'CopyAndShiftDown1'

	* Setting the dimension 'VA0Nomenclature'
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0Product" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
		And I click the button named 'CopyAndShiftDown1'

	* Setting the dimension 'VA0Counterparties'
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0Counter" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C4' cell
		And I click the button named 'CopyAndShiftDown1'

	* Setting the dimension 'VA0Counterparties Contracts'
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C5' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0Contrac" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C5' cell
		And I click the button named 'CopyAndShiftDown1'

	* Setting the dimension "Cash flow items"
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C6' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0CFItems" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R8C6' cell
		And I click the button named 'CopyAndShiftDown1'

	* Setting the dimension "Income and expense items"
		When "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C7' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0IEItems" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I select current line in 'List' table
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C7' cell
		And I click the button named 'CopyAndShiftDown1'
	
	* Trying to delete and insert a dimension
		Then "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C7' cell
		And I click the button named 'DeleteDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C7' cell
		And I click the button named 'CopyDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C7' cell
		And I click the button named 'InsertDimension'

	* Deleting dimensions from the currency indicator
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C7' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C6' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C2' cell
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And I press context menu button with name 'SpreadsheetFieldTemlateContextMenuDeleteDimension' in report wizard
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	* Adding and deleting the currency dimension
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C9' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "DG_LineDimension6 (Report indicator dimension groups)" window is opened
		And I change checkbox named 'IsCurrency'
		And I click the button named 'FormWriteAndClose'
		And I wait "DG_LineDimension6 (Report indicator dimension groups) *" window closing in 3 seconds

	* Comparing the layout with the reference
		Then "Report wizard" window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| 'String'               | "Dimension 1"        | "Dimension 2"  | "Dimension 3" | "Dimension 4"           | "Dimension 5" | "Dimension 6"               | "Drilldown by currencies" | "Settings" |
			| "LinesGroup"            | ''                   | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineSynthetic"        | ''                   | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension1"       | "Product categories" | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension2"       | "Product categories" | "Product range" | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension3"       | "Product categories" | "Product range" | "Counterparties" | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension4"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | ''            | ''                          | ''                     | ''          |
			| "LineDimension5"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | ''                          | ''                     | ''          |
			| "LineDimension6"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | "Income and expense items" | ''                     | ''          |
			| "LineDimension6Currency" | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | "Income and expense items" | '■'                    | ''          |
			| "LineDimensionCurrency"  | ''                   | ''             | ''            | ''                      | ''            | ''                          | '■'                    | ''          |

	* Deleting the dimension
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C6' cell
		And I click the button named 'DeleteDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C5' cell
		And I click the button named 'DeleteDimension'

	* Comparing the layout with the reference
		Then "Report wizard" window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| 'String'               | "Dimension 1"        | "Dimension 2"  | "Dimension 3" | "Dimension 4"               | "Dimension 5" | "Dimension 6"               | "Drilldown by currencies" | "Settings" |
			| "LinesGroup"            | ''                   | ''             | ''            | ''                          | ''            | ''                          | ''                     | ''          |
			| "LineSynthetic"        | ''                   | ''             | ''            | ''                          | ''            | ''                          | ''                     | ''          |
			| "LineDimension1"       | "Product categories" | ''             | ''            | ''                          | ''            | ''                          | ''                     | ''          |
			| "LineDimension2"       | "Product categories" | "Product range" | ''            | ''                          | ''            | ''                          | ''                     | ''          |
			| "LineDimension3"       | "Product categories" | "Product range" | "Counterparties" | ''                          | ''            | ''                          | ''                     | ''          |
			| "LineDimension4"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts"     | ''            | ''                          | ''                     | ''          |
			| "LineDimension5"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts"     | "Cash flow items"  | ''                          | ''                     | ''          |
			| "LineDimension6"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts"     | "Cash flow items"  | "Income and expense items" | ''                     | ''          |
			| "LineDimension6Currency" | "Product categories" | "Product range" | "Counterparties" | "Income and expense items" | ''            | ''                          | '■'                    | ''          |
			| "LineDimensionCurrency"  | ''                   | ''             | ''            | ''                          | ''            | ''                          | '■'                    | ''          |

	* Filling the dimension
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R9C5' cell
		And I click the button named 'CopyDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C5' cell
		And I click the button named 'InsertDimension'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C9' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "DG_LineDimension6Currency (Report indicator dimension groups)" window is opened
		And I go to line in 'TabFieldsDisplaySetting' table:
			| "Group dimension" | "Required" |
			| "Dimension 5"      | "No"          |
		And I activate field named 'DimensionKind' in 'TabFieldsDisplaySetting' table
		And I select current line in 'TabFieldsDisplaySetting' table
		And I click choice button of the attribute named 'DimensionKind' in 'TabFieldsDisplaySetting' table
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0CFItems" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I activate field named 'Description' in 'List' table
		And I select current line in 'List' table
		Then "DG_LineDimension6Currency (Report indicator dimension groups) *" window is opened
		And I finish line editing in 'TabFieldsDisplaySetting' table
		And I go to line in 'TabFieldsDisplaySetting' table:
			| "Group dimension" | "Required" |
			| "Dimension 6"      | "No"          |
		And I select current line in 'TabFieldsDisplaySetting' table
		And I click choice button of the attribute named 'DimensionKind' in 'TabFieldsDisplaySetting' table
		Then "Dimension types (corporate)" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA0IEItems" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Dimension types (corporate)" window is opened
		And I activate field named 'Description' in 'List' table
		And I select current line in 'List' table
		Then "DG_LineDimension6Currency (Report indicator dimension groups) *" window is opened
		And I finish line editing in 'TabFieldsDisplaySetting' table
		And I click the button named 'FormWriteAndClose'
		And I wait "DG_LineDimension6Currency (Report indicator dimension groups) *" window closing in 5 seconds
		Then "Report wizard" window is opened
		And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'

	* Comparing the layout with the reference
		Then "Report wizard" window is opened
		Then 'SpreadsheetFieldTemlate' spreadsheet document is equal
			| 'String'               | "Dimension 1"        | "Dimension 2"  | "Dimension 3" | "Dimension 4"           | "Dimension 5" | "Dimension 6"               | "Drilldown by currencies" | "Settings" |
			| "LinesGroup"            | ''                   | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineSynthetic"        | ''                   | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension1"       | "Product categories" | ''             | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension2"       | "Product categories" | "Product range" | ''            | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension3"       | "Product categories" | "Product range" | "Counterparties" | ''                      | ''            | ''                          | ''                     | ''          |
			| "LineDimension4"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | ''            | ''                          | ''                     | ''          |
			| "LineDimension5"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | ''                          | ''                     | ''          |
			| "LineDimension6"       | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | "Income and expense items" | ''                     | ''          |
			| "LineDimension6Currency" | "Product categories" | "Product range" | "Counterparties" | "Counterparty contracts" | "Cash flow items"  | "Income and expense items" | '■'                    | ''          |
			| "LineDimensionCurrency"  | ''                   | ''             | ''            | ''                      | ''            | ''                          | '■'                    | ''          |

Scenario: 01.05 Configuring currency indicators

	And I open report wizard with name "VA - Manual entry for all analytics"

	* Removing currency dimension from indicator "LineDimensionCurrency"
		When "Report wizard" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C1' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "LineDimensionCurrency (Report lines)" window is opened
		And the form attribute named 'DrillDownGroup' became equal to "DG_LineDimensionCurrency"
		And I close "LineDimensionCurrency (Report lines)" window
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C8' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C1' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "LineDimensionCurrency (Report lines)" window is opened
		And the form attribute named 'DrillDownGroup' became equal to ''
		And I close "LineDimensionCurrency (Report lines)" window

	* Checking that dimension groups are cleared for indicators
		When "Report wizard" window is opened
		And I select "Report structure" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R11C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		When "LineDimensionCurrency count (Report indicators)" window is opened
		And the form attribute named 'DrillDownGroup' became equal to ''
		And the form attribute named 'ShouldRecalculateForeignCurrencyAmount' became equal to 'No'
		And I close "LineDimensionCurrency count (Report indicators)" window

	* Re-adding currency dimension
		And I change dimension currency in cell 'R11C8' in report wizard

	* Configuring currency indicators
		And I check indicator property 'ShouldRecalculateForeignCurrencyAmount' is "False" in cell 'R11C2' in report wizard
		And I change indicator property 'ShouldRecalculateForeignCurrencyAmount' to "True" in cell 'R11C3' in report wizard
		And I change indicator property 'ShouldRecalculateForeignCurrencyAmount' to "True" in cell 'R10C3' in report wizard
		And I change indicator properties 'ShouldRecalculateForeignCurrencyAmount' to "True" in cell 'R10C4:R11C4' in report wizard
		And I check indicator property 'ShouldRecalculateForeignCurrencyAmount' is "True" in cell 'R11C4' in report wizard

Scenario: 01.06 Entering formulas in the report wizard

	And I open report wizard with name "VA - Manual entry for all analytics"

	* Checking button 'Sum of indicators' - 'LinesGroup - Count'
		When "Report wizard*" window is opened
		And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C2:R11C2' cell
		And I click the button named 'ButtonSum'
		And I click the button named 'WriteAndCollapse'

	* Entering formula manually - 'LinesGroup - Price'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And I input "({VAManualEntryForAllAnalytics.LineSynthetic_Price1}+{VAManualEntryForAllAnalytics.LineANLT1_Price1}+{VAManualEntryForAllAnalytics.LineANLT2_Price1}+{VAManualEntryForAllAnalytics.LineANLT3_Price1}+{VAManualEntryForAllAnalytics.LineANLT4_Price1}+{VAManualEntryForAllAnalytics.LineANLT5_Price1}+{VAManualEntryForAllAnalytics.LineANLT6_Price1}+{VAManualEntryForAllAnalytics.LineANLT6Currency_Price1}+{VAManualEntryForAllAnalytics.LineANLTCurrency_Price1})/13" text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'WriteAndCollapse'

	* Entering formula using buttons - 'LinesGroup - Amount'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'

	* Copying formula - 'LineSynthetic - Amount'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R2C4' cell
		And I click the button named 'CopyFormula'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
		And I click the button named 'InsertFormula'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And I click the button named 'WriteAndCollapse'

	* Entering formula via wizard - 'LineSynthetic - Amount'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R3C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "LineSynthetic_Count1" of report type "VA - Manual entry for all analytics"
		Then "Report wizard*" window is opened
		And I click the button named 'ButtonMultiply'
		And I click the button named 'RefToIndicator1'
		And I select indicator with code "LineSynthetic_Price1"
		Then "Report wizard*" window is opened
		And I click the button named 'WriteAndCollapse'

	* Entering formula using buttons - 'LineDimension1 - Amount'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C4' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I input ' ' text in the field named 'TextDocumentFieldProcedure'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C2' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And I click the button named 'WriteAndCollapse'

	* Entering formula by copying - 'LineDimension6Currency - Amount'
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R4C4' cell
		And I click the button named 'CopyFormula'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C4' cell
		And I click the button named 'InsertFormula'

	* Editing formula via data sources form
		* Adding operand "Count"
			When "Report wizard*" window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C4' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			And I click the button named 'AddOperand1'
			When "Data sources" window is opened
			And I click the button named 'FormFind'
			Then the form named 'UniversalListFindExtForm' is opened
			And I input "VA - Manual entry for all analytics_LineDimension1 count" text in the field named 'Pattern'
			And I change the radio button named 'CompareType' value to "Exact match"
			And I click the button named 'Find'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Manual entry for all analytics_LineDimension1 count (Data source)" window is opened
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "LineANLT6Currency_Count1"
			Then "VA - Manual entry for all analytics_LineDimension1 count (Data source) *" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Manual entry for all analytics_LineDimension1 count *" window closing in 5 seconds
		* Adding operand "Price"
			When "Data sources" window is opened
			And I click the button named 'FormFind'
			Then the form named 'UniversalListFindExtForm' is opened
			And I input "VA - Manual entry for all analytics_LineDimension1 price" text in the field named 'Pattern'
			And I change the radio button named 'CompareType' value to "Exact match"
			And I click the button named 'Find'
			Then "Data sources" window is opened
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			When "VA - Manual entry for all analytics_LineDimension1 price (Data source)" window is opened
			And I click Choice button of the field named 'IndicatorFilter'
			And I select indicator with code "LineANLT6Currency_Price1"
			Then "VA - Manual entry for all analytics_LineDimension1 price (Data source) *" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Manual entry for all analytics_LineDimension1 price *" window closing in 5 seconds
			Then "Data sources" window is opened
			And I close "Data sources" window
			Then "Report wizard*" window is opened
			And I click the button named 'UndoFormulaEdit'
			
	* Copying formula to all indicators
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C1' cell
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And I click the button named 'RowsTreeRowMoveUp'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C4' cell
		And I click the button named 'CopyAndShiftDown'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C1' cell
		And I click the button named 'RowsTreeRowMoveDown'
		And I click the button named 'RowsTreeRowMoveDown'
		And I click the button named 'RowsTreeRowMoveDown'
		And I click the button named 'RowsTreeRowMoveDown'
		And I click the button named 'RowsTreeRowMoveDown'
	
	* Checking that the structure form works
		When "Report wizard*" window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R10C4' cell
		And I click the button named 'ShowIndicatorTree'
		Then "Indicator tree" window is opened
		And I click the button named 'FormClose'
			
	* Checking that the calculation rule form opens and saves
		When "Report wizard*" window is opened
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - Manual entry for all analytics (Calculation rules)" window is opened
		And I click the button named 'FormWrite'
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - Manual entry for all analytics *" window closing in 5 seconds
		Then "Report wizard*" window is opened
		And I click Open button of the field named 'ProcessingRule'
		Then "VA - Manual entry for all analytics (Calculation rules)" window is opened
		And I close "VA - Manual entry for all analytics *" window

Scenario: 01.07 Creating a report type template

	And I create default template for report type "VA - Manual entry for all analytics"

	* Configuring an additional template
		When "VA - Manual entry for all analytics (Report types)" window is opened
		And I click Open button of the field named 'DefaultTemplateToDisplay'
		Then "Template *" window is opened
		And I click the button named 'ShowIndicatorsPanel'
		And I move to the tab named 'GroupAdditionalTemplates'
		And in the table 'AdditionalTemplates' I click the button named 'AdditionalTemplatesAdd'
		And I click Create button of the field named 'AdditionalTemplatesForm'
		Then "Template *" window is opened
		And I click the button named 'ShowIndicatorsPanel'
		And I input "Additional template" text in the field named 'Description'
		And I select "Only to display" exact value from the drop-down list named 'TemplateToDisplay'
		And I click the button named 'CreateTemplateWithDesigner'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Report structure" window is opened
		And I change checkbox named 'DisplayBankingDetails'
		And I click the button named 'FormSelect'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R3C8" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text "VA - Manual entry for all analytics"
		And I click the button named 'FormButtonWriteAndClose'
		Then "Template *" window is opened
		And I move to the next attribute
		And I activate field named 'AdditionalTemplatesBookmarkPicture' in 'AdditionalTemplates' table
		And I finish line editing in 'AdditionalTemplates' table
		And I select current line in 'AdditionalTemplates' table
		Then "Picture selection dialog box" window is opened
		And I go to line in 'ListOfAvailablePics' table:
			| "Picture name"   |
			| "Budgeting" |
		And I select current line in 'ListOfAvailablePics' table
		Then "Template *" window is opened
		And I click the button named 'FormButtonWriteAndClose'
		And I wait "Template *" window closing in 20 seconds

Scenario: 01.08 Creating a pivot table template

	And I for report type "VA - Manual entry for all analytics" create default pivot table template with filters "Project"

	* Refining the template
		When "VA - Manual entry for all analytics (Report types)" window is opened
		And I click Open button of the field named 'DefaultPivotTableTemplate'
		Then I open pivot table template for report type "VA - Manual entry for all analytics"
		And I save the window as 'WindowTitle'
		And I click the button named 'ShowPeriodsSettings'
		And I change checkbox named 'ShouldShowTotalQuarter'
		And I click the button named 'FormApply'

	* Setting column order
		When '$WindowTitle$ *' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Product categories"         |
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Product range"               |
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveDown'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Counterparties"                |
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Counterparty contracts"      |
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Cash flow items"                 |
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Income and expense items"  |
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'ButtonApply'

	* Saving the template
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$ *' window closing in 20 seconds

Scenario: 01.09 Configuring rights for user "Budgeting1"

	And I add right "Read, write" for report type "VA - Manual entry for all analytics" user "Budgeting1" for all companies
	And I close "CPM - Budget" TestClient
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

Scenario: 01.10 Creating a report instance

	And I create report instance for report type "VA - Manual entry for all analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project "VA - Main project" dimensions '' '' '' '' '' ''
	Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'
		
	* Entering values in the table
		And I enter value '123.00000' in cell 'R7C2'

		And I add values with indicator expansion in cell 'R8C2'
			| "VA0ProCate"           | 'Value1'    |
			| "Software products" | '1,000.00000'  |

		And I add values with indicator expansion in cell 'R10C2'
			| "VA0ProCate"           | "VA0Product"                | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | '2,000.00000'  |

		And I add values with indicator expansion in cell 'R13C2'
			| "VA0ProCate"           | "VA0Product"                | "VA0Counter"      | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | '3,000.00000'  |

		And I add values with indicator expansion in cell 'R17C2'
			| "VA0ProCate"           | "VA0Product"                | "VA0Counter"      | "VA0Contrac"  | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | '4,000.00000'  |

		And I add values with indicator expansion in cell 'R22C2'
			| "VA0ProCate"           | "VA0Product"                | "VA0Counter"      | "VA0Contrac"  | "VA0CFItems"                       | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | "3Software sale" | '5,000.00000'  |

		And I add values with indicator expansion in cell 'R28C2'
			| "VA0ProCate"           | "VA0Product"                | "VA0Counter"      | "VA0Contrac"  | "VA0CFItems"                       | "VA0IEItems"                       | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | "3Software sale" | "3Software sale" | '6,000.00000'  |

		And I add values with indicator expansion in cell 'R35C2'
			| "VA0ProCate"           | "VA0Product"                | "VA0Counter"      | "VA0Contrac"  | "VA0CFItems"                       | "VA0IEItems"                       | 'DimensionCurrency' | 'Value1'    |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | "3Software sale" | "3Software sale" | 'RUB'             | '1,100.00000'  |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | "3Software sale" | "3Software sale" | 'USD'             | '1,200.00000'  |
			| "Software products" | "5C:Corporate performance management" | "LLC \"Ganymede\"" | "Ganymede-001" | "3Software sale" | "3Software sale" | 'EUR'             | '1,300.00000'  |

	* Remembering the window title
		And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		And I save the window as 'WindowTitle'

	* Testing the copy down button and the clear button
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '55.00000'
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R35C3:R45C3' cell
		And I click the button named 'SpreadsheetFieldTemplateClearRange'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '11.00000'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R43C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '22.00000'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R44C3' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '33.00000'

	* Copying right along the row
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2:R44C2' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C3:R44C3' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
	
	* Change to value
		And I change value to '100.00000' in cell 'R7C6'
		Then '$WindowTitle$' window is opened
		
	* Copy down column
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C6' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'

	* Change to percentage
		And I change value to '100.00000' percent in cell 'R7C9'
		Then '$WindowTitle$' window is opened
	
	* Copy down column
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R7C9' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'

	* Copy and paste from clipboard
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C3:R44C3' cell
		And I click the button named 'CopyToClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C6:R44C6' cell
		And I paste from clipboard in the layout
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C9:R44C9' cell
		And I paste from clipboard in the layout

	* Clear range
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C9:R44C9' cell
		And I click the button named 'SpreadsheetFieldTemplateClearRange'

	* Setting value manually
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R42C9' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '22.00000'

	* Setting quantity value for currency indicator
		When '$WindowTitle$' window is opened
		And I add values with indicator expansion in cell 'R45C2'
			| 'DimensionCurrency' | 'Value1'    |
			| 'EUR'             | '123.00000'    |
			| 'USD'             | '456.00000'    |
			| 'RUB'             | '78900.00000'  |

	* Copying values for currency indicator
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R46C2:R48C2' cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'

	* Setting price value for currency indicator
		And I enter value '77.00000' in cell 'R46C3'
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'
		And I enter value '88.00000' in cell 'R46C6'
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'
		And I enter value '99.00000' in cell 'R46C9'
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'

	* Testing the 'Show comments' button
		When '$WindowTitle$' window is opened
		And I click the button named 'FormDisplayComments'
		And I input "Comment" text in the field named 'AnalyticalTemplateNote'
		And I click the button named 'FormDisplayComments'
		And I click the button named 'FormDisplayComments'
		And the field named 'AnalyticalTemplateNote' is filled
		And I click the button named 'FormDisplayComments'

	* Adding cell comments
		When '$WindowTitle$' window is opened
		And I enter comment "Comment Group" in cell 'R6C2'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Synthetic" in cell 'R7C3'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 1" in cell 'R9C4'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 2" in cell 'R12C5'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 3" in cell 'R16C6'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 4" in cell 'R21C7'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 5" in cell 'R27C8'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 6" in cell 'R34C9'
		Then '$WindowTitle$' window is opened
		And I enter comment "Comment Dimension 6 Currency" in cell 'R42C10'
	
	* Checking the comments form
		* Group comment
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R45C2' cell
			And I click the button named 'LeaveCommentToIndicator'
		* Cancel comment
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R47C2' cell
			And I click the button named 'LeaveCommentToIndicator'
			Then "Comments" window is opened
			And I input "Comment" text in the field named 'NewComment'
			And I close "Comments" window
		* Entering a comment
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R47C2' cell
			And I click the button named 'LeaveCommentToIndicator'
			Then "Comments" window is opened
			Then the form attribute named 'CommentsHistory' became equal to ''
			Then the form attribute named 'NewComment' became equal to ''
			And I input "Comment Currency" text in the field named 'NewComment'
			And I click the button named 'WriteComment'
		* Comment history
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R47C2' cell
			And I click the button named 'LeaveCommentToIndicator'
			Then "Comments" window is opened
			Then form element named "CommentsHistory" became equal to by template
				|'* (*): '|
				|"Comment Currency"|
			Then the form attribute named 'NewComment' became equal to ''
			And I input "Comment Currency 2" text in the field named 'NewComment'
			And I click the button named 'WriteComment'
		* History of two comments
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R47C2' cell
			And I click the button named 'LeaveCommentToIndicator'
			Then "Comments" window is opened
			Then form element named "CommentsHistory" became equal to by template
				|'* (*): '|
				|"Comment Currency"|
				|'* (*): '|
				|"Comment Currency 2"|
			And I close "Comments" window

	* Saving and closing the document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 60 seconds

	And I close "CPM - Budget" TestClient

Scenario: 01.11 Checking document movements
	
	Try
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password
	Except
		And Delay 30
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

	* Opening the document
		And I find report type with name "VA - Manual entry for all analytics" in list
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I select current line in 'List' table

	* Remembering the window title
		And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Loading the reference template
		When '$WindowTitle$' window is opened
		And I select external file '$ProjectPath$\3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Mercury.mxl'
		And I click the button named 'FormImportRefTemplate'
		And Delay 1

	* Comparing with the reference template
		When '$WindowTitle$' window is opened
		And I click the button named 'FormCompareWithRefTemplateByTemplate'
		// TODO, Temporary stub for CPMWE until formats arrive
		If 'NOT $$IsPerform$$' Then
			Then "Documents are identical: Compare spreadsheet documents" window is opened
		And I change checkbox named 'AreOnlyValuesCompared'
		And I click the button named 'FormCompareDocuments'
		Then "Documents are identical: Compare spreadsheet documents" window is opened
		And I click the button named 'FormClose'

	* Checking document movements
		When '$WindowTitle$' window is opened
		And I check report instance movements are equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Mercury_Movements.mxl'

	* Saving and closing the document
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 60 seconds

Scenario: 01.12 Copying a report instance

	* Opening report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		Then "Report instances" window is opened

	* Filter by scenario
		And I set checkbox named 'UseScenario'
		And I click Choice button of the field named 'FilteringByScenario'
		Then "Value list" window is opened
		And While the number of 'ValueList' table lines 'more' 0 Then
			And I select context menu item named 'ValueListContextMenuDelete' of the form attribute named 'ValueList'
		When "Value list" window is opened
		And I click the button named 'Add'
		And I select "VA - Main scenario" by string from the drop-down list named 'Value' in 'ValueList' table
		And I finish line editing in 'ValueList' table
		And I click the button named 'OK'

	* Filter by company
		When "Report instances" window is opened
		And I set checkbox named 'UseCompanies'
		If 'Companies' table contains line Then
			| "Value"    | "Use" |
			| "System LLC" | "Yes"          |
			And I go to line in 'Companies' table:
				| "Value"    | "Use" |
				| "System LLC" | "Yes"          |
			And I remove checkbox named 'CompaniesUse' in 'Companies' table
			And I finish line editing in 'Companies' table
		And I go to line in 'Companies' table:
			| "Value"    | "Use" |
			| "System LLC" | "No"          |
		And I expand current line in 'Companies' table
		If 'Companies' table contains line Then
			| "Value"     | "Use" |
			| "Mercury LLC" | "No"          |
			And I go to line in 'Companies' table:
				| "Value"     | "Use" |
				| "Mercury LLC" | "No"          |
			And I set checkbox named 'CompaniesUse' in 'Companies' table
			And I finish line editing in 'Companies' table
		And I go to line in 'Companies' table:
			| "Value"     | "Use" |
			| "Mercury LLC" | "Yes"           |

	* Filter by report type
		When "Report instances" window is opened
		And I set checkbox named 'UseReportTypes'
		If 'ReportsKinds' table contains line Then
			| "Value"            |
			| "VA - Report group" |
			And I go to line in 'ReportsKinds' table:
				| "Value"            |
				| "VA - Report group" |
			And I remove checkbox named 'ReportsKindsUse' in 'ReportsKinds' table
			And I expand current line in 'ReportsKinds' table
		If 'ReportsKinds' table contains line Then
			| "Value"                            |
			| "VA - Manual entry for all analytics" |
			And I go to line in 'ReportsKinds' table:
				| "Value"                            |
				| "VA - Manual entry for all analytics" |
			And I set checkbox named 'ReportsKindsUse' in 'ReportsKinds' table
			And I finish line editing in 'ReportsKinds' table
		And I go to line in 'ReportsKinds' table:
			| "Value"                            | "Use" |
			| "VA - Manual entry for all analytics" | "Yes"           |

	* Copying an instance
		When "Report instances" window is opened
		And I select context menu item named 'ListContextMenuCopy' of the form attribute named 'List'
		When "Specify key document attributes" window is opened
		And I click the button named 'FormApplyAndClose'
		Then there are lines in TestClient message log
			|"A report instance with the specified key attributes already exists."|						
		When "Specify key document attributes" window is opened
		And I click Choice button of the field named 'Organization'
		And I select company "Earth LLC"
		When "Specify key document attributes *" window is opened
		And I click the button named 'FormApplyAndClose'

	* Verifying the result
		Then I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Earth LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Mercury.mxl'

	* Viewing fill options
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And drop-down list named 'ReportGenerationMethod' is equal to:
			| "By processing rule" |
			| "Collapse by period"  |
		And I click the button named 'FormClose'

	* Adding a comment
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R34C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment Dimension 6" text in the field named 'NewComment'
		And I click the button named 'WriteComment'

	* Changing the company again
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I select from the drop-down list named 'Organization'  by "Mars LLC" string
		And I click the button named 'FormApplyAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Report instances" window is opened
		And I go to line in 'Companies' table:
			| "Value"     | "Use" |
			| "Mercury LLC" | "Yes"           |
		And I change checkbox named 'CompaniesUse' in 'Companies' table
		And I finish line editing in 'Companies' table
		And I go to line in 'Companies' table:
			| "Value"  | "Use" |
			| "Mars LLC"  | "No"          |
		And I change checkbox named 'CompaniesUse' in 'Companies' table
		And I finish line editing in 'Companies' table
		And I select current line in 'List' table
		And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Mars LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Adding comments
		When '$WindowTitle$' window is opened
		And I click the button named 'EnableEdit'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R43C3' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment Dimension 6 Currency" text in the field named 'NewComment'
		And I click the button named 'WriteComment'
		Then '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R46C4' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment Dimension Currency" text in the field named 'NewComment'
		And I click the button named 'WriteComment'

	* Changing the company again
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I select from the drop-down list named 'Organization'  by "Venus LLC" string
		And I click the button named 'FormApplyAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Report instances" window is opened
		And I go to line in 'Companies' table:
			| "Value" | "Use" |
			| "Mars LLC" | "Yes"           |
		And I change checkbox named 'CompaniesUse' in 'Companies' table
		And I finish line editing in 'Companies' table
		And I go to line in 'Companies' table:
			| "Value"   | "Use" |
			| "Venus LLC" | "No"          |
		And I change checkbox named 'CompaniesUse' in 'Companies' table
		And I finish line editing in 'Companies' table
		And I select current line in 'List' table
		And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		
	* Loading the reference template
		When '$WindowTitle$' window is opened
		And I select external file '$ProjectPath$\3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus.mxl'
		And I click the button named 'FormImportRefTemplate'
		And Delay 5

	* Comparing with the reference template
		When '$WindowTitle$' window is opened
		// TODO, Temporary stub for CPMWE until formats arrive
		If '$$IsPerform$$' Then
			And I click the button named 'FormCompareWithRefTemplateByValue'
		Else
			And I click the button named 'FormCompareWithRefTemplateByTemplate'
		Then "Documents are identical: Compare spreadsheet documents" window is opened
		And I click the button named 'FormClose'

	* Checking document movements
		When '$WindowTitle$' window is opened
		And I check report instance movements are equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_Movements.mxl'

	* Collapsing all versions
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListCollapseTillVersion'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window

	* Closing the document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'

Scenario: 01.13 Checking the report instance document creation form

	And I find report type with name "VA - Manual entry for all analytics" in list

	* All settings should be pulled from the settings storage
		When "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
		Then "Report instances" window is opened
		And I click the button named 'FormCreate'
		Then "Specify key document attributes" window is opened
		And I select from the drop-down list named 'Scenario'  by "VA - Main scenario" string
		And I click Choice button of the field named 'Organization'
		And I select company "System LLC"
		Then the form attribute named 'Dimension1' became equal to ""
		And the form attribute named 'Dimension2' became equal to ""
		And the form attribute named 'Dimension3' became equal to ""
		And the form attribute named 'Dimension4' became equal to ""
		And the form attribute named 'Dimension5' became equal to ""
		And the form attribute named 'Dimension6' became equal to ""
		And the form attribute named 'DisplayCurrency' became equal to "RUB"
		And the form attribute named 'ReportKind' became equal to "VA - Manual entry for all analytics"
		And the form attribute named 'AdditionalCurrencies' became equal to ""
		And the editing text of form attribute named 'UnitOfMeasure' became equal to "units"
		And the form attribute named 'CopyingValue' became equal to ""
		And the form attribute named 'ExternalInfobase' became equal to "Current infobase"
		And the form attribute named 'Organization' became equal to "System LLC"
		And the form attribute named 'MainCurrency' became equal to "RUB"
		And the form attribute named 'ReportFrequency' became equal to "Month"
		And the form attribute named 'EndingPeriod' became equal to "March 2024"
		And the form attribute named 'ReportPeriod' became equal to "January 2024"
		And the form attribute named 'ProcessingRule' became equal to "VA - Manual entry for all analytics"
		And the form attribute named 'CheckRule' became equal to "VA - Manual entry for all analytics"
		And the form attribute named 'Project' became equal to ""
		And the form attribute named 'RegulationVersion' became equal to "VA - Main regulations"
		And the form attribute named 'ReportGenerationMethod' became equal to "By processing rule"
		And the form attribute named 'Scenario' became equal to "VA - Main scenario"
		And the form attribute named 'PeriodManagement' became equal to "January 2024 - March 2024 (Frequency: Month) <VA - Main scenario>"
		And the form attribute named 'AccuracyLevel' became equal to "0"
		And the form attribute named 'TemplateForReport' became equal to "VA - Manual entry for all analytics"
				
	* Changing attributes
		When "Specify key document attributes *" window is opened
		And I select from the drop-down list named 'Project'  by "VA - Main project" string
		And I move to the tab named 'GroupPageReportSettings'
		And I select "thousands" exact value from the drop-down list named 'UnitOfMeasure'
		And I input "2" text in the field named 'AccuracyLevel'
		Then "Specify key document attributes *" window is opened
		And drop-down list named 'ReportGenerationMethod' is equal to:
			| "By processing rule"                       |
			| "Consolidate perimeter (IFRS)"            |
			| "Consolidate perimeter (Proportionally)" |
			| "Collapse by period"                        |
		When "Specify key document attributes *" window is opened
		And I select "Collapse by period" exact value from the drop-down list named 'ReportGenerationMethod'
		And I select "Day" exact value from the drop-down list named 'RollupFrequency'
		And I click the button named 'FormApplyAndClose'

	* Viewing document settings
		And I open report instance for report type "VA - Manual entry for all analytics" currency "RUB" company "System LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And the editing text of form attribute named 'UnitOfMeasure' became equal to "thousands"
		And the form attribute named 'AccuracyLevel' became equal to "2"
		And the form attribute named 'ReportGenerationMethod' became equal to "Collapse by period"
		And the form attribute named 'RollupFrequency' became equal to "Day"
		And I click the button named 'DocumentsProcessingSettings'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And I close "Document settings" window

	* Viewing the calculation form
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		And the form attribute named 'ReportGenerationMethod' became equal to "Collapse by period"
		And the form attribute named 'ProcessingRule' became equal to "VA - Manual entry for all analytics"
		And the form attribute named 'CheckRule' became equal to "VA - Manual entry for all analytics"
		And the form attribute named 'RollupFrequency' became equal to "Day"
		And drop-down list named 'ReportGenerationMethod' is equal to:
			| "By processing rule"                       |
			| "Consolidate perimeter (IFRS)"            |
			| "Consolidate perimeter (Proportionally)" |
			| "Collapse by period"                        |
		And drop-down list named 'RollupFrequency' is equal to:
			| "Day"   |
			| "Week" |
			| "Ten-day period" |
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'

	* Checking the period in "Collapse by period"
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And the form attribute named 'ReportGenerationMethod' became equal to "Collapse by period"
		And I select "By processing rule" exact value from the drop-down list named 'ReportGenerationMethod'
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'

	* Calculating by "Consolidate perimeter (IFRS)"
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		And the form attribute named 'ReportGenerationMethod' became equal to "By processing rule"
		Then "Select method to calculate indicators" window is opened
		And I select "Consolidate perimeter (IFRS)" exact value from the drop-down list named 'ReportGenerationMethod'
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_System_IFRS.mxl' by template

	* Changing display settings
		When '$WindowTitle$' window is opened
		And the editing text of form attribute named 'UnitOfMeasure' became equal to "thousands"
		And I select "units" exact value from the drop-down list named 'UnitOfMeasure'
		Then the form attribute named 'AccuracyLevel' became equal to "2"
		And I decrease value of field named 'AccuracyLevel'
		And I input "1" text in the field named 'AccuracyLevel'
		And I decrease value of field named 'AccuracyLevel'
		And I input "0" text in the field named 'AccuracyLevel'
		And I click the button named 'FormUpdateConsideringVersions'
	
	* Entering the quantity
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R11C2" cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Drill down indicators: *" window is opened
		And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownAdd'
		And I select "1C:ERP. Corporate performance management" by string from the drop-down list named "VA0Product" in 'IndicatorsDrilldown' table
		And I input "2,000.00000" text in the field named 'Value1' of 'IndicatorsDrilldown' table
		And I click the button named 'FormOKButton'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document the cell with address "R12C2" is equal to "2,000"

	* Entering the price
		When '$WindowTitle$' window is opened
		And I enter value '10.00000' in cell 'R7C3'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to "R7C3" cell
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnColumn'
		And I click the button named 'SpreadsheetFieldTemplateCopyDataOnRow'
				
	* Calculating by "Consolidate perimeter (Proportionally)"
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And I select "Consolidate perimeter (Proportionally)" exact value from the drop-down list named 'ReportGenerationMethod'
		And I click the button named 'FormSelect'

	* Entering the quantity value
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document the cell with address "R12C2" is equal to "0"
		And I enter value '2,000.00000' in cell 'R12C2'

	* Verifying the result
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_System_Proportionally.mxl'

	* Checking the action history
		When '$WindowTitle$' window is opened
		And I click the button named 'CancelApplyDetailed'
		Then "Action history" window is opened
		Then 'Transactions_' table became equal
			| "Transaction presentation"                |
			| "Change indicator"                    |
			| "Automatic indicator consolidation" |
			| "Copy by line"                   |
			| "Copy by column"                  |
			| "Change indicator"                    |
			| "Change indicator"                    |
			| "Automatic indicator consolidation" |
			| "Fill in by rule"                   |
			| "Collapsed automatically by period"        |
		And I click the button named 'FormCancel'

	* Saving the report instance
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I select "Consolidate perimeter (Proportionally)" exact value from the drop-down list named 'ReportGenerationMethod'
		And I click the button named 'FormApplyAndClose'
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillByDefault'
		And I enter value '2,000.00000' in cell 'R12C2'
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_System_Proportionally.mxl' by template
		And I click the button named 'Write'

	* Verifying the movements
		And I check report instance movements are equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_System_Proportionally_Movements.mxl'
	
Scenario: 01.14 Elimination and the indicator calculation selection form

	* Creating a document
		And I create report instance for report type "VA - Manual entry for all analytics" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mars LLC" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Elimination of indicators
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And the form attribute named 'ReportGenerationMethod' became equal to "By processing rule"
		And drop-down list named 'ReportGenerationMethod' is equal to:
			| "By processing rule" |
			| "Eliminate"        |
			| "Collapse by period"  |
		And I select "Eliminate" exact value from the drop-down list named 'ReportGenerationMethod'
		And I click the button named 'FormSelect'
		When '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'

	* Elimination of indicators
		When '$WindowTitle$' window is opened
		And I click the button named 'FormFillInUsingAnotherApproach'
		Then "Select method to calculate indicators" window is opened
		And the form attribute named 'ReportGenerationMethod' became equal to "Eliminate"
		And drop-down list named 'ReportGenerationMethod' is equal to:
			| "By processing rule" |
			| "Eliminate"        |
			| "Collapse by period"  |
		And I close "Select method to calculate indicators" window

	* Closing the document without saving
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 01.15 Saving the report instances list form settings

	And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable

	* Opening report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		Then "Report instances" window is opened
		Then I set checkbox named 'ShouldShowStandardFilters'
		And in the table 'Filter' I click the button named 'FilterUncheckAll'

	* Setting the standard filters
		And I move to the tab named 'Standard1'
		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"        | "Display mode" |
			| "Equal to"         | "No"           | "Company" | "Quick access"    |
		And I select "Venus LLC" by string from the drop-down list named 'FilterRightValue' in 'Filter' table
		
		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"          | "Display mode" |
			| "Equal to"         | "No"           | "Report period" | "Quick access"    |
		And I click choice button of the attribute named 'FilterRightValue' in 'Filter' table
		Then "Periods" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I change the radio button named 'CompareType' value to "Exact match"
		And I select from the drop-down list named 'Pattern'  by "January 2024" string
		And I click the button named 'Find'
		Then "Periods" window is opened
		And I select current line in 'List' table
	
	Then "Report instances" window is opened
	And I go to line in 'Filter' table:
		| "Comparison type" | "Use" | "Left value"     | "Display mode" |
		| "Equal to"         | "No"           | "Scenario" | "Quick access"    |
	And I select "VA - Main scenario" by string from the drop-down list named 'FilterRightValue' in 'Filter' table
	
	And I go to line in 'Filter' table:
		| "Comparison type" | "Use" | "Left value"       | "Display mode" |
		| "Equal to"         | "No"           | "Report type" | "Quick access"    |
	And I select "VA - Manual entry for all analytics" by string from the drop-down list named 'FilterRightValue' in 'Filter' table
	
	And I go to line in 'Filter' table:
		| "Comparison type" | "Use" | "Left value"   | "Display mode" |
		| "Equal to"         | "No"           | "Project" | "Quick access"    |
	And I select "VA - Main project" by string from the drop-down list named 'FilterRightValue' in 'Filter' table

	* Saving the setting
		When "Report instances" window is opened
		And I click the button named 'SaveSettingAs'
		Then "Saved settings" window is opened
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input "VA - Manual entry for all analytics - Venus LLC" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Saved settings" window is opened
		And While the number of 'List' table lines 'more' 0 Then
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Manual entry for all analytics - Venus LLC (Setup option)" window is opened
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Manual entry for all analytics - Venus LLC *" window closing in 20 seconds
			
	Then "Saved settings" window is opened
	And I input "VA - Manual entry for all analytics - Venus LLC" text in the field named 'Description'
	And I click the button named 'FormSaveVariant'

Scenario: 01.16 Display in additional currency

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Changing display parameters in a report instance
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I select "thousands" exact value from the drop-down list named 'UnitOfMeasure'
		And I select "USD" exact value from the drop-down list named 'DisplayCurrency'
		And I input '5' text in the field named 'AccuracyLevel'
		And I click the button named 'FormApplyAndClose'

	* Remembering the window title
		And I open report instance for report type "VA - Manual entry for all analytics" currency 'USD' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''
		And I save the window as 'WindowTitle'

	* Adding a comment to a report with additional currency
		Then '$WindowTitle$' window is opened
		And I click the button named 'EnableEdit'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R6C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment Group" text in the field named 'NewComment'
		And I click the button named 'WriteComment'
		When '$WindowTitle$' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R47C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment Dimension 6 Currency" text in the field named 'NewComment'
		And I click the button named 'WriteComment'

	* Comparing with the reference
		Then '$WindowTitle$' window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_USD'
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 01.17 Clearing report indicators

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Clearing indicators
		When '$WindowTitle$' window is opened
		And I click the button named 'EnableEdit'
		And I click the button named 'Clear'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'

	* Closing the document
		When '$WindowTitle$ *' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$ *' window closing in 60 seconds

Scenario: 01.18 Opening a version

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Checking the number of versions
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		When "Indicator version management" window is opened
		When the number of 'List' table lines is 'equal' 2
		And I close "Indicator version management" window

	* Opening the version directory
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		When "Indicator version management" window is opened
		And I select current line in 'List' table
		When "* (Version description)" window is opened
		And I close "* (Version description)" window

	* Opening a version
		When "Indicator version management" window is opened
		And I click the button named 'ListOpenVersion'
		Then "VA - Manual entry for all analytics (Version view mode)" window is opened
		And I click the button named 'FormGenerate'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Empty.mxl'
		And I close "VA - Manual entry for all analytics *" window

	* Closing the versions window
		When "Indicator version management" window is opened
		And I close "Indicator version management" window

Scenario: 01.19 Deleting a version

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Deleting a version
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		When "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window
	
	* Closing the document
		Then '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		
	* Comparing with the baseline after deleting versions
		Then "Report instances" window is opened
		And I select current line in 'List' table
		Then '$WindowTitle$' window is opened
		// TODO, Temporary stub for CPMWE until formats arrive
		If '$$IsPerform$$' Then
			And I click the button named 'FormCompareWithRefTemplateByValue'
		Else
			And I click the button named 'FormCompareWithRefTemplateByTemplate'
		Then "Documents are identical: Compare spreadsheet documents" window is opened
		And I click the button named 'FormClose'

Scenario: 01.20 Comparing versions

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Changing indicators of the current report (percentage)
		When '$WindowTitle$' window is opened
		And I click the button named 'EnableEdit'
		And I change value to '100.00000' percent in cell 'R6C2:R34C2'

	* Changing indicators of the current report (value)
		Then '$WindowTitle$ *' window is opened
		And I change value to '25.00000' in cell 'R6C3:R34C3'

	* Saving document
		When '$WindowTitle$ *' window is opened
		And I click the button named 'Write'

	* Comparing versions
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		When "Indicator version management" window is opened
		And I select all lines of 'List' table
		And I click the button named 'ListCompareVersions'
		When "VA - Manual entry for all analytics (Two versions comparison mode)" window is opened
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_VersionComparison_Different.mxl'
		And I close "VA - Manual entry for all analytics *" window

	* Closing the versions window
		When "Indicator version management" window is opened
		And I close "Indicator version management" window

Scenario: 01.21 Rolling back to a version

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Rolling back to a version
		When '$WindowTitle$' window is opened
		And I click the button named 'FormVersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListCollapseTillVersion'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then the number of 'List' table lines is 'equal' 1
		When "Indicator version management *" window is opened
		And I close "Indicator version management *" window

	* Comparing with the reference template
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_2.mxl'

	* Closing the document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		
Scenario: 01.22 Modifying a report when output in thousands

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Changing display parameters in a report instance
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I move to the tab named 'GroupPageReportSettings'
		And I select "thousands" exact value from the drop-down list named 'UnitOfMeasure'
		And I input '2' text in the field named 'AccuracyLevel'
		And I click the button named 'FormApplyAndClose'

	* Opening a document, entering new values
		Then '$WindowTitle$' window is opened
		And I click the button named 'Edit'
		And I change value to '1,000.00000' in cell 'R6C2:R44C2'
		Then '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds
	
	* Opening a document, entering new values
		Then "Report instances" window is opened
		And I select current line in 'List' table
		Then '$WindowTitle$' window is opened
		And I click the button named 'Edit'
		And I change value to '1,000.00000' in cell 'R6C2:R44C2'

	* Comparing with the reference
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_3.mxl'

	* Saving a document
		When '$WindowTitle$' window is opened
		And I click the button named 'WriteAndClose'
		And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 01.23 Testing a report instance with different templates

	And I open report instance by saved setting "VA - Manual entry for all analytics - Venus LLC"
	And I open report instance for report type "VA - Manual entry for all analytics" currency 'RUB' company "Venus LLC" scenario "VA - Main scenario" frequency "Month" project "VA - Main project" dimensions '' '' '' '' '' ''

	* Checking an additional template
		And I move to the tab named 'Template_1'
		Given 'SpreadsheetFieldTemlate1' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_3.mxl'

	* Changing display parameters in a report instance
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I click Choice button of the field named 'TemplateForReport'
		Then "Report templates" window is opened
		And I go to line in 'List' table:
			| "Description"                                          |
			| "VA - Manual entry for all analytics (pivot table)" |
		And I click the button named 'ListChoose1'
		And I click the button named 'FormApplyAndClose'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_PivotTable1.mxl'
	
	* Configuring properties
		And I click the button named 'EnableEdit'
		* Row composition
			When '$WindowTitle$' window is opened
			And I click the button named 'ShowListOfRows'
			Then "Set up line list" window is opened
			And I go to line in 'TreeOfSelectedLines' table by template:
				| "Report type"                          | "Drilldown group"          | "Code"              | "Report line"          |
				| "VA - Manual entry for all analytics" | "DG_LineDimension6Currency" | "LineANLT6Currency*" | "LineDimension6Currency" |
			And I click the button named 'Delete'
			And I go to line in 'TreeOfSelectedLines' table by template:
				| "Report type"                          | "Drilldown group"         | "Code"             | "Report line"         |
				| "VA - Manual entry for all analytics" | "DG_LineDimensionCurrency" | "LineANLTCurrency*" | "LineDimensionCurrency" |
			And I click the button named 'Delete'
			And I click the button named 'ApplyTheChanges'
		* Column composition
			When '$WindowTitle$' window is opened
			And I click the button named 'ShowListOfColumns'
			Then "Set up column list" window is opened
			And I go to line in 'PivotTableColumnsListSettings' table:
				| "Title in table" | "Report column/Formula" |
				| "Price"                | "Price"                   |
			And I change checkbox named 'PivotTableColumnsListSettingsUsageFlag_' in 'PivotTableColumnsListSettings' table
			And I finish line editing in 'PivotTableColumnsListSettings' table
			And I click the button named 'FormApply'
		* Dimension composition
			When '$WindowTitle$' window is opened
			And I click the button named 'ShowTableSettingsByAxes'
			Then "Set up field location" window is opened
			And I go to line in 'TableRows1' table:
				| "Horizontally (in rows)" |
				| "Income and expense items"  |
			And I select context menu item named 'TableRows1ContextMenuMoveToAvailableFields' of the form attribute named 'TableRows1'
			And I go to line in 'TablePages' table:
				| "Top (quick filters)" |
				| "Company"             |
			And I select context menu item named 'TablePagesContextMenuMoveToRows' of the form attribute named 'TablePages'
			And I go to line in 'TableRows1' table:
				| "Horizontally (in rows)" |
				| "Company"                |
			And I click the button named 'RowsMoveUp'
			And I click the button named 'RowsMoveUp'
			And I click the button named 'RowsMoveUp'
			And I click the button named 'RowsMoveUp'
			And I click the button named 'RowsMoveUp'
			And I change checkbox named 'TotalByColumns'
			And I click the button named 'ButtonApply'
		* Periods
			When '$WindowTitle$' window is opened
			And I click the button named 'ShowPeriodsSettings'
			And I change checkbox named 'UsePeriodGroupingMidTerm'
			And I increase value of field named 'MidTermGroupingBorder'
			And I input '1' text in the field named 'MidTermGroupingBorder'
			And I increase value of field named 'MidTermGroupingBorder'
			And I input '2' text in the field named 'MidTermGroupingBorder'
			And I select "Quarter" exact value from the drop-down list named 'MidTermGroupingFrequency'
			And I click the button named 'FormApply'

		* Comparing the result
			When '$WindowTitle$' window is opened
			Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_PivotTable2.mxl'

	* Returning periods
		When '$WindowTitle$' window is opened
		And I click the button named 'ShowPeriodsSettings'
		When I change checkbox named 'ShouldShowTotalQuarter'
		And I click the button named 'FormApply'

	* Setting manual cell update mode
		When '$WindowTitle$' window is opened
		And I click the button named 'ManualRecalculation'

	* Changing indicator values
		And I enter value '8000' in cell 'R10C2'
		And I wait the attribute named 'LabelUpdateTable' appearance in 20 seconds

	// TODO: Simple test for all buttons
	// TODO: Copying cell value does not account for scale
	// TODO: Changing cell does not account for scale

	* Changing template again
		When '$WindowTitle$' window is opened
		And I click the button named 'FormOpenSettings'
		Then "Document settings" window is opened
		And I click Choice button of the field named 'TemplateForReport'
		Then "Report templates" window is opened
		And I go to line in 'List' table:
			| "Description"                        |
			| "VA - Manual entry for all analytics" |
		And I click the button named 'ListChoose1'
		And I click the button named 'FormApplyAndClose'
		And I wait '$WindowTitle$' window opening in 20 seconds
		And I click the button named 'CancelAction'
		And I move to the tab named 'Template_1'
		And I wait '$WindowTitle$' window opening in 20 seconds
		Given 'SpreadsheetFieldTemlate1' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_Venus_3.mxl'

	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 01.24 Switching to data display mode

	And I open report pivot table with name "VA - Manual entry for all analytics"
	And I set pivot table filters: start date '1/1/2024', end date '3/31/2024', currency 'RUB', scenario "VA - Main scenario", company "Venus LLC"
	And I set pivot table filter 'Item_Project' with value "VA - Main project"
	And I open pivot table for report type "VA - Manual entry for all analytics"

	* Checking content
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable1.mxl'

	* Testing settings buttons
		When '$WindowTitle$' window is opened
		And I click the button named 'ShowListOfColumns'
		Then "Set up column list" window is opened
		And I go to line in 'PivotTableColumnsListSettings' table:
			| "Title in table" | "Report column/Formula" | "Company"        | "Display in additional currency" | "Period"             | "Shows usage" | "Project"             | "Scenario"           | "Column type"      |
			| "Price"                | "Price"                   | "Context value" | "No"                     | "Context value" | "Yes"                    | "Context value" | "Context value" | "Basic value" |
		And I change checkbox named 'PivotTableColumnsListSettingsUsageFlag_' in 'PivotTableColumnsListSettings' table
		And I finish line editing in 'PivotTableColumnsListSettings' table
		And I click the button named 'FormApply'
		Then '$WindowTitle$' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Additional currencies"      |
		And I click the button named 'RowsMoveDown'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveUp'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Income and expense items"  |
		And I select context menu item named 'TableRows1ContextMenuMoveToAvailableFields' of the form attribute named 'TableRows1'
		And I select context menu item named 'TableRows1ContextMenuMoveToAvailableFields' of the form attribute named 'TableRows1'
		And I go to line in 'TableRows1' table:
			| "Horizontally (in rows)" |
			| "Product range"               |
		And I click the button named 'RowsMoveUp'
		And I click the button named 'ButtonApply'
		Then '$WindowTitle$' window is opened
		And I click the button named 'ShowPeriodsSettings'
		And I click the button named 'FormApply'
		And I click the button named 'ShowAdditionalFilters'
		And I go to line in 'FiltersSettings' table:
			| "Comparison type" | "Value"| "Use" 	| "Field"        |
			| "Equal to"         | ''        | "No"           | "Counterparties" |		
		And I set checkbox named 'FiltersSettingsUse' in 'FiltersSettings' table
		And I activate field named 'FiltersSettingsFilterValue' in 'FiltersSettings' table
		And I select "LLC \"Ganymede\"" by string from the drop-down list named 'FiltersSettingsFilterValue' in 'FiltersSettings' table
		And I finish line editing in 'FiltersSettings' table
		And I click the button named 'UpdateTabData'
		And I wait for '$WindowTitle$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable2.mxl'
				
	* Changing indicators
		* First indicator
			When '$WindowTitle$' window is opened
			And I enter value '10,000.00000' with indicator expansion in cell 'R26C2'
			When '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R26C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			When "Drill down indicators*" window is opened
			Then 'IndicatorsDrilldown' table became equal
				| "Cash flow items"                       | "Income and expense items"        | 'Value1' |
				| "3Software sale" | "3Software sale" | '800,000'   |
			And I click the button named 'FormCancel'
		* Second indicator
			Then '$WindowTitle$' window is opened
			And I enter value '20,000.00000' with indicator expansion in cell 'R21C2'
			Then '$WindowTitle$' window is opened
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R21C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			When "Drill down indicators*" window is opened
			Then 'IndicatorsDrilldown' table became equal
				| "Cash flow items"                       | 'Value1'  |
				| "3Software sale" | '1,600,000'  |
			And I click the button named 'FormCancel'
		* Reverting changed value
			When '$WindowTitle$' window is opened
			And I click the button named 'CancelAction'
			And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R21C3' cell
			And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
			Then "Drill down indicators*" window is opened
			Then 'IndicatorsDrilldown' table became equal
				| "Cash flow items"                       | 'Value1' |
				| "3Software sale" | '960,000'   |
			And I click the button named 'FormCancel'
		* Indicator with currency dimension
			When '$WindowTitle$' window is opened
			And I enter value '10,000.00000' with indicator expansion in cell 'R32C2'
			And I enter value '10,000.00000' with indicator expansion in cell 'R37C2'
			Then 'R27C2:R27C3' area of 'SpreadsheetFieldTemlate' spreadsheet document is equal
				| '23,200' | '435,600' |

	* Closing without saving
		When '$WindowTitle$' window is opened
		And I close '$WindowTitle$' window
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button1'

Scenario: 01.25 Testing indicator recalculation buttons

	And I open report pivot table with name "VA - Manual entry for all analytics"
	And I open pivot table for report type "VA - Manual entry for all analytics"

	* Checking table content
		And I set pivot table filter 'DisplayCurrency' with value 'RUB'
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable1.mxl'

	* Changing indicators in the table
		When '$WindowTitle$ *' window is opened
		And I enter value '10,000.00000' in cell 'R5C2'
		And I enter value '10,000.00000' in cell 'R7C2'
		And I enter value '10,000.00000' in cell 'R10C2'
		And I enter value '10,000.00000' in cell 'R14C2'
		And I enter value '10,000.00000' in cell 'R19C2'
		And I enter value '10,000.00000' in cell 'R25C2'
		And I enter value '10,000.00000' in cell 'R32C2'
		And I enter value '12,000.00000' in cell 'R40C2'
		And I enter value '10,000.00000' in cell 'R41C2'
		And I enter value '11,000.00000' in cell 'R42C2'
		And I enter value '12,000.00000' in cell 'R44C2'
		And I enter value '10,000.00000' in cell 'R45C2'
		And I enter value '11,000.00000' in cell 'R46C2'
	
	* Changing indicators in the window
		When '$WindowTitle$ *' window is opened
		And I enter value '100.00000' with indicator expansion in cell 'R26C3'

	* Indicator copy buttons
		Then '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R26C3' cell
		And I click the button named 'CopyIntoClipboard'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R25C3' cell
		And I click the button named 'PasteFromClipboard1'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C3' cell
		And I click the button named 'PasteFromClipboard1'
		And I click the button named 'CopyDataByRow'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
		And I click the button named 'PasteFromClipboard1'

	* Testing arrows
		Then '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C3' cell
		And I click the button named 'CopyDataByColumn'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C2:R46C2' cell
		And I click the button named 'CopyDataByRow'

	* Range clear button
		When '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R5C6:R46C6' cell
		And I click the button named 'ClearRange'

	* Comment
		When '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C2:R25C4' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment 1" text in the field named 'NewComment'
		And I click the button named 'WriteComment'
		When '$WindowTitle$ *' window is opened
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to 'R19C2' cell
		And I click the button named 'LeaveCommentToIndicator'
		Then "Comments" window is opened
		And I input "Comment 2" text in the field named 'NewComment'
		And I click the button named 'WriteComment'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'LeaveCommentToIndicator'
		Then form element named "CommentsHistory" became equal to by template
			|'* (*): '|
			|"Comment 1"|
			|'* (*): '|
			|"Comment 2"|
		And I close "Comments" window

	* Testing indicator change buttons
		When '$WindowTitle$ *' window is opened
		And I change value to '50.00000' in cell 'R5C6'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'CopyDataByColumn'
		When '$WindowTitle$ *' window is opened
		And I change value to '50.00000' percent in cell 'R5C6:R46C6'

	* Saving indicator values
		When '$WindowTitle$ *' window is opened
		And I click the button named 'Apply'

	* Indicator display precision settings
		Then '$WindowTitle$' window is opened
		And I input '6' text in the field named 'Accuracy'
		And I move to the next attribute
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then '$WindowTitle$' window is opened
		And I input '5' text in the field named 'Accuracy'
		And I select "thousands" exact value from the drop-down list named 'Divisor'
		
	* Changing display currency
		And I set pivot table filter 'DisplayCurrency' with value 'USD'
	
	* Configuring dimensions
		When '$WindowTitle$ *' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I click the button named 'DimensionsLayoutOption'
		And on the form menu I select "Adjacent dimensions"
		And I click the button named 'ButtonApply'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'ShowPeriodsSettings'
		And I change checkbox named 'ShouldShowTotalYear'
		And I click the button named 'FormApply'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'UpdateTabData'
		And I wait for '$WindowTitle$ *' form opening for 20 seconds
				
	* Comparing the result
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable3.mxl' by template
					
	* Saving variant
		And I click the button named 'SaveCurrentTabVariantAs'
		Then "Save the pivot table option" window is opened
		And I input "VA - Main variant" text in the field named 'SettingDescription'
		And I click the button named 'Apply'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
		Then I open pivot table for variant "VA - Main variant"
		And I close "Pivot table: *" window
							
	* Loading a variant
		And I open report pivot table with name "VA - Manual entry for all analytics"
		And I click the hyperlink named 'FilterHeading'
		And Delay 1
		And I click Choice button of the field named 'PivotTableVariant'
		Then "Pivol table options" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I input "VA - Main variant" text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Pivol table options" window is opened
		And I select current line in 'List' table
		Then I open pivot table for variant "VA - Main variant"
		And I save the window as 'WindowTitleVariant'
		And I click the button named 'UpdateTabData'
		And I wait for '$WindowTitleVariant$' form opening for 20 seconds
		And I select "thousands" exact value from the drop-down list named 'Divisor'
		And I move to the next attribute
		And I input '5' text in the field named 'Accuracy'
		And I move to the next attribute
		And I click the button named 'UpdateTabData'
		And I wait for '$WindowTitleVariant$' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable3.mxl' by template
		And I close '$WindowTitleVariant$' window

	* Rolling back a version
		And I open report pivot table with name "VA - Manual entry for all analytics"
		And I click the button named 'VersionsManagement'
		Then "Indicator version management" window is opened
		And I click the button named 'ListDeleteVersions'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Indicator version management *" window is opened
		And I close "Indicator version management *" window
		Then '$WindowTitle$' window is opened
		And I click the hyperlink named 'FilterHeading'
		And I click Choice button of the field named 'DisplayCurrency'
		And I select "RUB" exact value from the drop-down list named 'DisplayCurrency'
		And I click the button named 'UpdateTabData1'
		And I wait for '$WindowTitle$ *' form opening for 20 seconds
		Given 'SpreadsheetFieldTemlate' spreadsheet document is equal to '3_Budgeting\Layouts\01\VA_ReportTypeWithDimensions_PivotTable1.mxl'
