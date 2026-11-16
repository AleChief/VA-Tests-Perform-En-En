#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Pivot table"

Scenario: I move dimension with name 'TheDimensionName' up in pivot table

	Then "Set up field location" window is opened
	And I save '[TheDimensionName]' in "DimensionName" variable
	
	And I go to line in 'TableRows1' table:
		| "Horizontally (in rows)" |
		| '$DimensionName$'      |
	
	And I click the button named 'RowsMoveUp'
	And I click the button named 'RowsMoveUp'
	And I click the button named 'RowsMoveUp'
	And I click the button named 'RowsMoveUp'
	And I click the button named 'RowsMoveUp'
	And I click the button named 'RowsMoveUp'

Scenario: I open report pivot table with name 'TheReportKindName'

	And I find report type with name '[TheReportKindName]' in list

	When "Report types and templates" window is opened
	And I save '[TheReportKindName]' line to the variable 'ReportKindName'
	And I go to line in 'List' table by template:
		| "Description"                       |
		| '$ReportKindName$ (pivot table)' |
	And I click the button named 'SwitchToDataDisplayMode'
	And I wait for "Pivot table: *" form opening for 30 seconds

	And I open pivot table for report type 'TheReportKindName'
		
Scenario: I set pivot table filter 'TheFilterName' with value 'TheFilterValue'

	When "Pivot table: *" window is opened
	And I click the hyperlink named 'FilterHeading'
	And I wait for "Pivot table: *" form opening for 20 seconds
	If the field named '[TheFilterName]' exists on the form Then
		And I select from the drop-down list named '[TheFilterName]'  by '[TheFilterValue]' string
		And I click the button named 'UpdateTabData1'
	ElseIf 'Item_[TheFilterName]' attribute is present on the form Then
		And I select from the drop-down list named 'Item_[TheFilterName]'  by '[TheFilterValue]' string
		And I click the button named 'UpdateTabData1'
	And I wait for "Pivot table: *" form opening for 20 seconds

Scenario: I set pivot table filters: start date 'TheStartDate', end date 'TheEndDate', currency 'TheCurrency', scenario 'TheScenario', company 'TheBusinessUnit'

	When "Pivot table: *" window is opened
	And I click the hyperlink named 'FilterHeading'
	And I click the button named 'ChangePeriod'
	Then "Select period" window is opened
	And I input '[TheStartDate]' text in the field named 'DateBegin'
	And I move to the next attribute
	And I input '[TheEndDate]' text in the field named 'DateEnd'
	And I click the button named 'Select'
	Then "Pivot table: *" window is opened
	And I select from the drop-down list named 'DisplayCurrency'  by '[TheCurrency]' string
	And I select from the drop-down list named 'Item_Scenario'  by '[TheScenario]' string
	And I select from the drop-down list named 'Item_Organization'  by '[TheBusinessUnit]' string
	And I click the button named 'UpdateTabData1'
	And I wait for "Pivot table: *" form opening for 20 seconds
