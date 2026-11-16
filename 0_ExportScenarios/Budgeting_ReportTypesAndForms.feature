#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Report types and templates"

Scenario: I open report type with name 'TheReportKindName'

	And I find report type with name '[TheReportKindName]' in list
	And I select current line in 'ReportKindList' table
	Then "* (Report types)" window is opened

Scenario: I create report type group with name 'TheReportKindName' and parent 'TheReportKindParentName'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"

	* Deleting the current element
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheReportKindName]' text in the field named 'Pattern'
		And I click the button named 'Find'
		And While the number of 'ReportKindList' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'ReportKindList'
				And I wait "Report types and templates" window opening in 120 seconds
			* Renaming
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'ReportKindList' table
				When "* (Report types)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I input 'UID' variable value in the field named 'Code'
				And I input '' text in the field named 'Parent'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Report types)" window closing in 20 seconds

	* Creating a new report group
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListCreateFolder'
		Then "Report types (create group)" window is opened
		And I input '[TheReportKindName]' text in the field named 'Description'
		If 'StrLen("[TheReportKindParentName]") = 0' Then
			And I input '' text in the field named 'Parent'
		Else
			And I select from the drop-down list named 'Parent'  by '[TheReportKindParentName]' string
		And I click the button named 'FormWriteAndClose'
		And I wait "Report types (create group) *" window closing in 20 seconds

	* Closing a list
		When "Report types and templates" window is opened
		And I close "Report types and templates" window

Scenario: I create report type with name 'TheReportKindName' and parent 'TheReportKindParentName'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"

	* Deleting the current element
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Report type" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheReportKindName]' text in the field named 'Pattern'
		And I click the button named 'Find'
		And While the number of 'ReportKindList' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'ReportKindList'
			* Renaming
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'ReportKindList' table
				Then "* (Report types)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I input 'UID' variable value in the field named 'FullDescr'
				And I input 'UID' variable value in the field named 'Code'
				And I input '' text in the field named 'Parent'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Report types)" window closing in 20 seconds

	* Creating a new element
		Then "Report types and templates" window is opened
		And in the table 'ReportKindList' I click the button named 'ReportKindListCreate'
		Then "Report types (create)" window is opened
		And I input '[TheReportKindName]' text in the field named 'Description'
		If 'StrLen("[TheReportKindParentName]") = 0' Then
			And I input '' text in the field named 'Parent'
		Else
			And I select from the drop-down list named 'Parent'  by '[TheReportKindParentName]' string
		And I click the button named 'FormWriteAndClose'
		And I wait "Report types (create group) *" window closing in 20 seconds

	* Closing a list
		When "Report types and templates" window is opened
		And I close "Report types and templates" window

Scenario: I change flag 'TheFlagName' for report type 'TheReportKindName'

	And I find report type with name '[TheReportKindName]' in list
	And I select current line in 'ReportKindList' table
	Then "* (Report types)" window is opened

	And I change checkbox named '[TheFlagName]'
	And I click the button named 'FormWriteAndClose'
	And I wait "[TheReportKindName] (Report types)" window closing in 20 seconds

	Then "Report types and templates" window is opened
	And I close "Report types and templates" window

Scenario: I create default template for report type 'TheReportKindName'

	* Opening a report type
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
			Then "* (Report types)" window is opened
	
	* Forming a report instance template
		When "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		And I click Open button of the field named 'DefaultTemplateToDisplay'
		Then "Template [TheReportKindName] report type: [TheReportKindName]" window is opened
		And I click the button named 'CreateTemplateWithDesigner'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
		Then "Report structure" window is opened
		And I select from the drop-down list named 'TemplateOfReportsTemplatesAppearance'  by 'Classic' string
		And I change checkbox named 'DisplayBankingDetails'
		And I click the button named 'FormSelect'

	* Saving a template
		Then "Template [TheReportKindName] report type: [TheReportKindName] *" window is opened
		And I click the button named 'FormButtonWriteAndClose'
		And I wait "Template [TheReportKindName] report type: [TheReportKindName] *" window closing in 20 seconds

Scenario: I set sorting 'TheSortingObject' 'TheSortingProperty' in template for expansion group with address 'TheCell' for report type 'TheReportKindName'

	* Opening a report type
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
			Then "* (Report types)" window is opened
	
	* Opening the default template
		When "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		And I click Open button of the field named 'DefaultTemplateToDisplay'
		Then "Template [TheReportKindName] report type: [TheReportKindName]" window is opened

	* Adding sorting
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Set up dimension drilldown area" window is opened
		And I move to the tab named 'SectionSort'
		And I select current line in 'SettingsComposerSettingsOrder' table
		And I select '[TheSortingObject].[TheSortingProperty]' by string from the drop-down list named 'SettingsComposerSettingsOrderField' in 'SettingsComposerSettingsOrder' table
		And I finish line editing in 'SettingsComposerSettingsOrder' table
		And I click the button named 'Apply'
				
	* Saving a template
		Then "Template [TheReportKindName] report type: [TheReportKindName] *" window is opened
		And I click the button named 'FormButtonWriteAndClose'
		And I wait "Template [TheReportKindName] report type: [TheReportKindName] *" window closing in 20 seconds

Scenario: I change sorting 'TheSortingIinitialObject' 'TheSortingIinitialProperty' to sorting 'TheSortingObject' 'TheSortingProperty' in template for expansion group with address 'TheCell' for report type 'TheReportKindName'

	* Opening a report type
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
			Then "* (Report types)" window is opened
	
	* Opening the default template
		When "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		And I click Open button of the field named 'DefaultTemplateToDisplay'
		Then "Template [TheReportKindName] report type: [TheReportKindName]" window is opened

	* Changing sorting
		And in 'SpreadsheetFieldTemlate' spreadsheet document I move to '[TheCell]' cell
		And in 'SpreadsheetFieldTemlate' spreadsheet document I double-click the current cell
		Then "Set up dimension drilldown area" window is opened
		And I move to the tab named 'SectionSort'
		And I save '[TheSortingIinitialObject].[TheSortingIinitialProperty]' value to 'SortingIinitial' variable
		And I go to line in 'SettingsComposerSettingsOrder' table:
			| "Field"              |
			| '$SortingIinitial$' |
		And I select '[TheSortingObject].[TheSortingProperty]' exact value from the drop-down list named 'SettingsComposerSettingsOrderField' in 'SettingsComposerSettingsOrder' table
		And I finish line editing in 'SettingsComposerSettingsOrder' table
		And I click the button named 'Apply'
				
	* Saving a template
		Then "Template [TheReportKindName] report type: [TheReportKindName] *" window is opened
		And I click the button named 'FormButtonWriteAndClose'
		And I wait "Template [TheReportKindName] report type: [TheReportKindName] *" window closing in 20 seconds

Scenario: I create default import template for report type 'TheReportKindName'

	* Opening a report type
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
			Then "* (Report types)" window is opened

	* Opening a template
		Then "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		When "[TheReportKindName] (Report types)" window is opened
		And I click Open button of the field named 'DefaultTemplateToImport'

	* Generating a template
		Then I open template for report type '[TheReportKindName]'
		And I click the button named 'ShowIndicatorsPanel'
		And I select "To import and display" exact value from the drop-down list named 'TemplateToDisplay'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		Then "Report structure" window is opened
		And I select from the drop-down list named 'TemplateOfReportsTemplatesAppearance'  by "Classic" string
		And I remove checkbox named 'DisplayBankingDetails'
		And I click the button named 'FormSelect'

	* Saving a template
		Then '$WindowTitle$' window is opened
		And I click the button named 'RecordButtonForm'

Scenario: I open default pivot table template for report type 'TheReportKindName'

	* Opening a report type
		// Opening option from a form
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
		When "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		And I click Open button of the field named 'DefaultPivotTableTemplate'

	* Forming a pivot table template
		Then I open pivot table template for report type '[TheReportKindName]'
		
Scenario: I for report type 'TheFilter1' create default pivot table template with filters 'TheFilter2' 'TheFilter3' 'TheReportKindName'
	
	* Opening a report type
		// Opening option from a form
		If current window header is "[TheReportKindName] (Report types)" Then
			// The form is already open
		Else
			And I find report type with name '[TheReportKindName]' in list
			And I select current line in 'ReportKindList' table
		When "[TheReportKindName] (Report types)" window is opened
		And I move to the tab named 'DefaultSettings'
		And I click Open button of the field named 'DefaultPivotTableTemplate'

	* Forming a pivot table template
		Then I open pivot table template for report type '[TheReportKindName]'
		And I click the button named 'ShowListOfRows'
		Then "Set up line list" window is opened
		And I click the button named 'MoveLeftAll'
		And I click the button named 'ApplyTheChanges'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'ShowListOfColumns'
		Then "Set up column list" window is opened
		And in the table 'PivotTableColumnsListSettings' I click the button named 'PivotTableColumnsListSettingsPopulateColumns'
		And I click the button named 'FormApply'
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'ShowTableSettingsByAxes'
		Then "Set up field location" window is opened
		And I save '[TheFilter1]' line to the variable 'FieldName'
		If 'TableAvailableFields' table contains line Then
			| "Available dimensions" |
			| '$FieldName$'           |
			And I go to line in 'TableAvailableFields' table:
				| "Available dimensions" |
				| '$FieldName$'           |
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToFilters' of the form attribute named 'TableAvailableFields'
		And I save '[TheFilter2]' line to the variable 'FieldName'
		If 'TableAvailableFields' table contains line Then
			| "Available dimensions" |
			| '$FieldName$'           |
			And I go to line in 'TableAvailableFields' table:
				| "Available dimensions" |
				| '$FieldName$'           |
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToFilters' of the form attribute named 'TableAvailableFields'
		And I save '[TheFilter3]' line to the variable 'FieldName'
		If 'TableAvailableFields' table contains line Then
			| "Available dimensions" |
			| '$FieldName$'           |
			And I go to line in 'TableAvailableFields' table:
				| "Available dimensions" |
				| '$FieldName$'           |
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToFilters' of the form attribute named 'TableAvailableFields'
		And While the number of 'TableAvailableFields' table lines 'more' 0 Then
			And I select context menu item named 'TableAvailableFieldsContextMenuMoveToRows' of the form attribute named 'TableAvailableFields'
		And I save "Project" line to the variable 'FieldName'
		If '"[TheFilter1]" <> "$FieldName$" AND "[TheFilter2]" <> "$FieldName$" AND "[TheFilter3]" <> "$FieldName$"' Then
			When "Set up field location" window is opened
			And I go to line in 'TableRows1' table:
				| "Horizontally (in rows)" |
				| "Project"                     |
			And I select context menu item named 'TableRows1ContextMenuMoveToAvailableFields' of the form attribute named 'TableRows1'
			
		And I click the button named 'RowsMoveUp'
		And I click the button named 'RowsMoveDown'
		And I click the button named 'DimensionsLayoutOption'
		And on the form menu I select "Hierarchical dimensions"
		And I set checkbox named 'TotalByColumns'
		And I go to line in 'ColumnsTable' table:
			| "Vertically (in columns)" |
			| "Report columns"           |
		And I click the button named 'ColumnsMoveUp'
		And I click the button named 'ColumnsMoveDown'
		And I click the button named 'ButtonApply'
		
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'ShowPeriodsSettings'
		And I click the button named 'FormApply'

	* Saving
		Then '$WindowTitle$ *' window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait '$WindowTitle$ *' window closing in 20 seconds
