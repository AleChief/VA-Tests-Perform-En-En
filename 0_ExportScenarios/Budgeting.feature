#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem

Scenario: I paste from clipboard in the layout

	And I clear user message window
	And I repeat 3 times
		And I click the button named 'InsertTemplateFromClipboard'
		If current window contains user messages Then
			And Delay 3
		Else
			And I interrupt the loop

Scenario: I enter value 'TheValue' in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
	And in 'SpreadsheetFieldTemlate' spreadsheet document I input text '[TheValue]'

Scenario: I enter value 'TheValue' with indicator expansion in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I click the button named 'DisplayADrilldown'

	Then "Drill down indicators: *" window is opened
	And I select current line in 'IndicatorsDrilldown' table
	And I input '[TheValue]' text in the field named 'Value1' of 'IndicatorsDrilldown' table
	And I click the button named 'FormOKButton'

	And I wait "Drill down indicators: *" window closing in 20 seconds

Scenario: I add values with indicator expansion in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I click the button named 'DisplayADrilldown'
	
	Then "Drill down indicators: *" window is opened
	If 'IndicatorsDrilldownPeriodsInColumns' attribute is editable Then
		If form attribute named 'IndicatorsDrilldownPeriodsInColumns' is not marked Then
			And in the table 'IndicatorsDrilldown' I click the button named 'IndicatorsDrilldownPeriodsInColumns'

	And I fill 'IndicatorsDrilldown' table with data
		| 'Table' |

	And I click the button named 'FormOKButton'
	And I wait "Drill down indicators: *" window closing in 20 seconds

Scenario: I enter comment 'TheComment' in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I click the button named 'LeaveCommentToIndicator'

	Then "Comments" window is opened
	And I input '[TheComment]' text in the field named 'NewComment'

	And I click the button named 'WriteComment'

Scenario: I change value to 'TheValue' percent in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I click the button named 'ChangeIndicators'

	Then "Change values" window is opened
	And I change the radio button named 'AdjustmentKind' value to "Percentage"
	And I input '[TheValue]' text in the field named 'ValueAdjustments'
	And I click the button named 'Apply'

Scenario: I change value to 'TheValue' in cell 'TheCell'

	And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
	And I click the button named 'ChangeIndicators'
	
	Then "Change values" window is opened
	And I change the radio button named 'AdjustmentKind' value to "Value"
	And I input '[TheValue]' text in the field named 'ValueAdjustments'
	And I click the button named 'Apply'

Scenario: I select indicator with code 'TheIndicatorCode' of report type 'TheReportKindName'

	When "Report indicators" window is opened
	And I click Choice button of the field named 'ReportKind'
	Then "Report types" window is opened
	And I click the button named 'FormFind'
	Then "Find" window is opened
	And I select "Description" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Exact match"
	And I input '[TheReportKindName]' text in the field named 'Pattern'
	And I click the button named 'Find'
	Then "Report types" window is opened
	And I select current line in 'List' table

	And I select indicator with code '[TheIndicatorCode]'
	
Scenario: I open reporting preparation process management for scenario 'TheScenario'

	And In the command interface I select "Processes and approval" "Reporting preparation management"
	Then "Reporting preparation management" window is opened
	And I click Choice button of the field named 'PeriodManagement'
	And I search and select element '[TheScenario]' "Exact match" by field "Scenario" in list "Reporting period management"
	Then "Reporting preparation management" window is opened
	And in the table 'StepsTree' I click the button named 'StepsTreeExpandAll'

Scenario: I add right 'TheRule' for report type 'TheReportKind' user 'TheUser' company 'TheBusinessUnit'

	And In the command interface I select "Budgeting, reporting, and analysis" "Report type access matrix"
	Then "Customizable reporting user access rights" window is opened
	And I select from the drop-down list named 'FilterReportsTypes'  by '[TheReportKind]' string
	And I select from the drop-down list named 'FilterUsers'  by '[TheUser]' string
	And I select from the drop-down list named 'FilterCompanies'  by '[TheBusinessUnit]' string
	And I change the radio button named 'ShowInColumnsNumber' value to 'companies'
	And I set checkbox named 'ShouldShowReportTemplates'
	
	And I click the button named 'FormUpdateTable'
	And in 'CustomField' spreadsheet document I move to 'DetailsReportKind' cell
	And in 'CustomField' spreadsheet document I double-click the current cell
	Then "Select access kind" window is opened
	And I save '[TheRule]' in 'CurrentRule' variable
	And I go to line in 'List' table:
		| "Reference"          |
		| '$CurrentRule$' |
	And I select current line in 'List' table

	Then "Customizable reporting user access rights *" window is opened
	And I click the button named 'FormApplySettings'
	Then "Customizable reporting user access rights" window is opened
	And I click the button named 'RereadData'

	When "Customizable reporting user access rights" window is opened
	And I close "Customizable reporting user access rights" window

Scenario: I add right 'TheRule' for report type 'TheReportKind' user 'TheUser' for all companies

	And In the command interface I select "Budgeting, reporting, and analysis" "Report type access matrix"
	Then "Customizable reporting user access rights" window is opened
	And I select from the drop-down list named 'FilterReportsTypes'  by '[TheReportKind]' string
	And I select from the drop-down list named 'FilterUsers'  by '[TheUser]' string
	And I click Clear button of the field named 'FilterCompanies'
	And I change the radio button named 'ShowInColumnsNumber' value to 'companies'
	And I set checkbox named 'ShouldShowReportTemplates'

	And I click the button named 'FormUpdateTable'
	And in 'CustomField' spreadsheet document I move to 'ReportKind' cell
	And in 'CustomField' spreadsheet document I double-click the current cell
	Then "Set up access rights to report type" window is opened
	And in the table 'RightsSettingsTable' I click the button named 'RightsSettingsTableFillAccessRights'
	Then "Select access kind" window is opened
	And I save '[TheRule]' in 'CurrentRule' variable
	And I go to line in 'List' table:
		| "Reference"          |
		| '$CurrentRule$' |
	And I select current line in 'List' table
	Then "Set up access rights to report type" window is opened
	And I click the button named 'FormOK'

	Then "Customizable reporting user access rights *" window is opened
	And I click the button named 'FormApplySettings'
	Then "Customizable reporting user access rights" window is opened
	And I click the button named 'RereadData'

	When "Customizable reporting user access rights" window is opened
	And I close "Customizable reporting user access rights" window

Scenario: I create analytical report group with code 'TheCode' name 'TheName' parent 'TheParent'

	* Opening a reference form
		And In the command interface I select "Budgeting, reporting, and analysis" "Analytical reports"

	* Deleting an element
		And I search element '[TheName]' "Exact match" by field "Description" in list "Analytical reports"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Analytical reports)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click Clear button of the field named 'Code'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
				And I input 'UID' variable value in the field named 'Code'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Analytical reports) *" window closing in 20 seconds
		And I select context menu item named 'ListContextMenuCancelSearch' of the form attribute named "List"

	* Creating an element
		When "Analytical reports" window is opened
		And I click the button named 'FormCreateFolder'
		Then 'Analytical reports (create group)' window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click Clear button of the field named 'Code'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And I input '[TheCode]' text in the field named 'Code'
		If 'IsBlankString("[TheParent]")' Then
			And I click Clear button of the field named 'Parent'
		Else
			And I select from the drop-down list named 'Parent'  by '[TheParent]' string
		And I click the button named 'FormWriteAndClose'
		And I wait 'Analytical reports (create group) *' window closing in 20 seconds

Scenario: I create analytical report with code 'TheCode' report type 'TheReportKind' period 'ThePeriod' company 'TheBusinessUnit' parent 'TheParent'

	* Opening a reference form
		And In the command interface I select "Budgeting, reporting, and analysis" "Analytical reports"

	* Deleting an element
		And I search element '[TheReportKind] ([TheBusinessUnit])' "Exact match" by field "Description" in list "Analytical reports"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Analytical report)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click Clear button of the field named 'Code'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
				And I input 'UID' variable value in the field named 'Code'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Analytical report) *" window closing in 20 seconds

	* Creating an element
		When "Analytical reports" window is opened
		And I click the button named 'FormCreate'
		Then "Analytical report (create)" window is opened
		And I input '[TheReportKind] ([TheBusinessUnit])' text in the field named 'Description'
		And I click Clear button of the field named 'Code'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And I input '[TheCode]' text in the field named 'Code'
		If 'IsBlankString("[TheParent]")' Then
			And I click Clear button of the field named 'Parent'
		Else
			And I select from the drop-down list named 'Parent'  by '[TheParent]' string
		And I click the button named 'FormWrite'

	* Configuring an element
		When "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" window is opened
		* Data source
			And I click Choice button of the field named 'ReportDataSource'
			Then "Select data type" window is opened
			And I select current line in "" table
			Then "Queries to infobase" window is opened
			And I click the button named 'FormCreate'
			Then "Query to infobase (create)" window is opened
			And I input '[TheReportKind] ([TheBusinessUnit])' text in the field named 'Description'
			And I click the button named 'Write'
			Then "[TheReportKind] ([TheBusinessUnit]) (Query to infobase)" window is opened
			And I move to the tab named 'CaclSetup'
			And I click the button named 'FormGetIndicatorsValues'
			And I click the button named 'WriteAndClose'
			And I wait "[TheReportKind] ([TheBusinessUnit]) (Query to infobase)" window closing in 20 seconds
			Then "Queries to infobase" window is opened
			And I select current line in 'List' table
		Then "[TheReportKind] ([TheBusinessUnit]) (Analytical report) *" window is opened
		And I click the button named 'FormWrite'

	* Editing a scheme
		And I click the button named 'EditSchemaOption'
		Then "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
		
		And in the table 'RowsGroupingTableBoxPageTable' I click the button named 'RowsGroupingTableBoxPageTableAddGroupingField'
		And I select "Company" exact value from the drop-down list named 'RowsGroupingTableBoxPageTableField' in 'RowsGroupingTableBoxPageTable' table
		And I select "Without hierarchy" exact value from the drop-down list named 'RowsGroupingTableBoxPageTableGroupingType' in 'RowsGroupingTableBoxPageTable' table
		And in the table 'RowsGroupingTableBoxPageTable' I click the button named 'RowsGroupingTableBoxPageTableAddGroupingField'
		And I select "Report period" exact value from the drop-down list named 'RowsGroupingTableBoxPageTableField' in 'RowsGroupingTableBoxPageTable' table
		And I select "Without hierarchy" exact value from the drop-down list named 'RowsGroupingTableBoxPageTableGroupingType' in 'RowsGroupingTableBoxPageTable' table
		
		And in the table 'SelectedFieldsPageTable' I click the button named 'SelectedFieldsPageTableAddSelectedField'
		And I select "Indicator" exact value from the drop-down list named 'SelectedFieldsPageTableField' in 'SelectedFieldsPageTable' table
		And I finish line editing in 'SelectedFieldsPageTable' table
		And in the table 'SelectedFieldsPageTable' I click the button named 'SelectedFieldsPageTableAddSelectedField'
		And I select "Value" exact value from the drop-down list named 'SelectedFieldsPageTableField' in 'SelectedFieldsPageTable' table

		And I move to the tab named 'FilterAndOrder'
		And in the table 'TableBoxFilterPageWithoutParameters' I click the button named 'TableBoxFilterPageWithoutParametersAddFilterItem'
		And I select "Company" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersLeftValue' in 'TableBoxFilterPageWithoutParameters' table
		And I select "Equal to" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersComparisonType' in 'TableBoxFilterPageWithoutParameters' table
		And I click choice button of the attribute named 'TableBoxFilterPageWithoutParametersRightValue' in 'TableBoxFilterPageWithoutParameters' table
		And I select company '[TheBusinessUnit]'
		Then "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
		And in the table 'TableBoxFilterPageWithoutParameters' I click the button named 'TableBoxFilterPageWithoutParametersAddFilterItem'
		And I select "Report period" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersLeftValue' in 'TableBoxFilterPageWithoutParameters' table
		And I select "Equal to" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersComparisonType' in 'TableBoxFilterPageWithoutParameters' table
		And I click choice button of the attribute named 'TableBoxFilterPageWithoutParametersRightValue' in 'TableBoxFilterPageWithoutParameters' table
		And I search and select element '[ThePeriod]' "At the beginning of the line" by field "Description" in list "Periods"
		When "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
		And in the table 'TableBoxFilterPageWithoutParameters' I click the button named 'TableBoxFilterPageWithoutParametersAddFilterItem'
		And I select "Currency" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersLeftValue' in 'TableBoxFilterPageWithoutParameters' table
		And I select "Equal to" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersComparisonType' in 'TableBoxFilterPageWithoutParameters' table
		And I select "RUB" exact value from the drop-down list named 'TableBoxFilterPageWithoutParametersRightValue' in 'TableBoxFilterPageWithoutParameters' table
		And I finish line editing in 'TableBoxFilterPageWithoutParameters' table
		When "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
		And in the table "Filter" I click the button named 'FilterAddFilterItem'
		And I select "Factor.Report type" by string from the drop-down list named "FilterLeftValue" in "Filter" table
		And I activate field named "FilterRightValue" in "Filter" table
		And I click choice button of the attribute named "FilterRightValue" in "Filter" table
		Then "Select data type" window is opened
		And I select current line in "" table
		And I search and select element '[TheReportKind]' "At the beginning of the line" by field "Description" in list "Report types"
		
		When "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
		And I move to the tab named 'OrderPage'
		And in the table 'Table_SortFields' I click the button named 'Table_SortFieldsAddOrderItem'
		And I select "Factor.Line.Sequence number" by string from the drop-down list named 'Table_SortFieldsField' in 'Table_SortFields' table
		And I finish line editing in 'Table_SortFields' table
		And in the table 'Table_SortFields' I click the button named 'Table_SortFieldsAddOrderItem'
		And I select "Factor.Column.Sequence number" by string from the drop-down list named 'Table_SortFieldsField' in 'Table_SortFields' table
		And I finish line editing in 'Table_SortFields' table
		
		And I click the button named 'FormOK'

	Then "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" window is opened
	And I click the button named 'FormWrite'
	And I set checkbox named 'CustomSettings'
	And I click the button named 'FormWrite'

	Then "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" window is opened
	And I click the button named 'EditSchemaOption'
	Then "Analytical report structure settings ([TheReportKind] ([TheBusinessUnit]))" window is opened
	And I move to the tab named 'OutputParametersPage'
	And I go to line in "Table_OutputParameters" table:
		| "Value" | "Use" | "Parameter"                               |
		| "Auto"     | "No"           | "Placement of grand totals vertically" |
	And I activate field named 'Table_OutputParametersValue' in 'Table_OutputParameters' table
	And I select current line in 'Table_OutputParameters' table
	And I select "No" exact value from the drop-down list named 'Table_OutputParametersValue' in 'Table_OutputParameters' table
	And I finish line editing in 'Table_OutputParameters' table
	And I click the button named 'FormOK'

	Then "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" window is opened
	And I click the button named 'FormWriteAndClose'
	And I wait "[TheReportKind] ([TheBusinessUnit]) (Analytical report)" window closing in 20 seconds
