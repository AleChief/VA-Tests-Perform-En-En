#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Report wizard"

Scenario: I open report wizard with name 'TheReportKindName'

	And I find report type with name '[TheReportKindName]' in list
	And in the table 'ReportKindList' I click the button named 'DoOpenDesigner'

Scenario: I press context menu button with name 'TheName' in report wizard

	If '$$IsPerform$$' Then
		And I click the button named '[TheName]'
	Else
		And I select context menu item named '[TheName]' of the form attribute named 'SpreadsheetFieldTemlate'
		
Scenario: I add row with name 'TheLineName' in report wizard

	When "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And I click the button named 'RowsTreeAddRows'
	Then "Adding new lines" window is opened
	And in the table 'NewLines' I click the button named 'NewLinesAdd'
	And I input '[TheLineName]' text in the field named 'NewLinesDescription' of 'NewLines' table
	And I finish line editing in 'NewLines' table
	And I click the button named 'OK'

Scenario: I add rows in report wizard

	When "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And I click the button named 'RowsTreeAddRows'
	Then "Adding new lines" window is opened

	And I fill 'NewLines' table with data
		| 'Table' |

	And I click the button named 'OK'

Scenario: I add column with name 'TheColumnName' in report wizard

	Then "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And I click the button named 'RowsTreeAddColumn'
	Then "Adding new columns" window is opened
	And in the table 'NewLines' I click the button named 'NewLinesAdd'
	And I input '[TheColumnName]' text in the field named 'NewLinesDescription' of 'NewLines' table
	And I finish line editing in 'NewLines' table
	And I click the button named 'OK'

Scenario: I add columns in report wizard

	Then "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And I click the button named 'RowsTreeAddColumn'
	Then "Adding new columns" window is opened

	And I fill 'NewLines' table with data
		| 'Table' |

	And I click the button named 'OK'

Scenario: I add dimension with code 'TheDimensionCode' in cell 'TheCell' in report wizard

	Then "Report wizard*" window is opened
	And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	Then "Dimension types (corporate)" window is opened
	And I click the button named 'FormFind'
	Then the form named 'UniversalListFindExtForm' is opened
	And I select "Code" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Exact match"
	And I input '[TheDimensionCode]' text in the field named 'Pattern'
	And I click the button named 'Find'
	Then "Dimension types (corporate)" window is opened
	And I select current line in 'List' table

Scenario: I add dimension with name 'TheDimensionName' in cell 'TheCell' in report wizard

	Then "Report wizard*" window is opened
	And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	Then "Dimension types (corporate)" window is opened
	And I click the button named 'FormFind'
	Then the form named 'UniversalListFindExtForm' is opened
	And I select "Description" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Exact match"
	And I input '[TheDimensionCode]' text in the field named 'Pattern'
	And I click the button named 'Find'
	Then "Dimension types (corporate)" window is opened
	And I select current line in 'List' table

Scenario: I change dimension currency in cell 'TheCell' in report wizard

	Then "Report wizard*" window is opened
	And I select "Indicator dimensions" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	Then "Report wizard*" window is opened

Scenario: I change row parent to 'TheParentName' in cell 'TheCell' in report wizard

	Then "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	Then "* (Report lines)" window is opened
	And I select from the drop-down list named 'Parent'  by '[TheParentName]' string
	And I click the button named 'FormWriteAndClose'
	And I wait "* (Report lines) *" window closing in 20 seconds

Scenario: I change indicator property 'TheProperty' to 'TheValue' in cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	Then "* (Report indicators)" window is opened
	And I set value '[TheValue]' for attribute '[TheProperty]'
	And I click the button named 'FormWriteAndClose'
	And I wait "* (Report indicators)" window closing in 20 seconds

Scenario: I change indicator properties 'TheProperty' to 'TheValue' in cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I select context menu item named 'SpreadsheetFieldTemlateContextMenuProperties' of the form attribute named 'SpreadsheetFieldTemlate'
	Then "Bulk edit indicators" window is opened
	And I change checkbox named '[TheProperty]Change'
	And I set value '[TheValue]' for attribute '[TheProperty]'
	And I click the button named 'FormWriteAndClose'

Scenario: I check indicator property 'TheProperty' is 'TheValue' in cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Report structure" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	When "* (Report indicators)" window is opened
	And the form attribute named '[TheProperty]' became equal to '[TheValue]'
	And I close "* (Report indicators)" window

Scenario: I set link to indicator with code 'TheIndicatorCode' of report type 'TheReportKindName' for cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	And I click the button named 'RefToIndicator1'

	When "Report indicators" window is opened
	And I click Choice button of the field named 'ReportKind'
	Then "Report types" window is opened
	And I click the button named 'Find'
	Then "Find" window is opened
	And I select "Description" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Exact match"
	And I input '[TheReportKindName]' text in the field named 'Pattern'
	And I click the button named 'Find'
	Then "Report types" window is opened
	And I select current line in 'List' table

	And I select indicator with code '[TheIndicatorCode]'
	
	Then "Report wizard *" window is opened
	And I click the button named 'WriteAndCollapse'

Scenario: I set formula 'TheFormula' for cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	And I input '[TheFormula]' text in the field named 'TextDocumentFieldProcedure'
	
	And I click the button named 'WriteAndCollapse'

Scenario: I set cell copy formula 'TheCell1' for cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell1]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	
	And I click the button named 'WriteAndCollapse'

Scenario: I set cell sum formula 'TheCell1' for cell 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell1]' cell
	And I click the button named 'ButtonSum'
	
	And I click the button named 'WriteAndCollapse'

Scenario: I set sum formula for cell 'TheCell1' of cells 'TheCell2' 'TheCell3' 'TheCell4' 'TheCell5' 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell1]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	And I click the button named 'ButtonPlus'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell2]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell3]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonPlus'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell3]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell4]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonPlus'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell4]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell5]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonPlus'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell5]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	
	And I click the button named 'WriteAndCollapse'

Scenario: I set product formula for cell 'TheCell1' of cells 'TheCell2' 'TheCell3' 'TheCell4' 'TheCell5' 'TheCell' in report wizard

	When "Report wizard*" window is opened
	And I select "Indicators calculation formulas" exact value from the drop-down list named 'WorkMode'
	
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell1]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	And I click the button named 'ButtonMultiply'
	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell2]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell3]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell3]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell4]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell4]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell

	If 'NOT StrStartsWith("[TheCell5]", "[") AND NOT IsBlankString("[TheCell3]")' Then
		And I click the button named 'ButtonMultiply'
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell5]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	
	And I click the button named 'WriteAndCollapse'
