#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Adjustment of indicator values"

Scenario: I create indicator values adjustment template with name "TheName" and report types

	* Opening a reference form
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustments templates"

	* Deleting an element
		And I search element '[TheName]' "Exact match" by field "Description" in list "Indicator value adjustments templates"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Indicator value adjustments templates)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I delete all lines of 'UsedReportTypes' table
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Indicator value adjustments templates) *" window closing in 20 seconds

	* Creating an element
		When "Indicator value adjustments templates" window is opened
		And I click the button named 'FormCreate'
		Then "Indicator value adjustments templates (create)" window is opened
		And I fill 'UsedReportTypes' table with data
			|'Table'|
		And I input '[TheName]' text in the field named 'Description'
		When "Indicator value adjustments templates (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Indicator value adjustments templates (create) *" window closing in 20 seconds
				
Scenario: I fill adjustment table with values for indicator values adjustment template with name "TheName"

	* Opening a reference form
		And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustments templates"

	* Searching for an element
		And I search and select element '[TheName]' "Exact match" by field "Description" in list "Indicator value adjustments templates"

	* Filling
		And I fill 'TableOfAdjustments' table with data
			|'Table'|

	* Saving an element
		When "[TheName] (Indicator value adjustments templates) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "[TheName] (Indicator value adjustments templates) *" window closing in 20 seconds

Scenario: I create indicator values adjustment scenario "TheScenario" period "TheStartDate" frequency "TheFrequency" company "TheBusinessUnit" values

	And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
	Then "Indicator value adjustment" window is opened

	And I click the button named 'FormCreate'
	Then "Indicator value adjustment (create)" window is opened

	And I click Choice button of the field named 'PeriodManagement'
	And I search element "[TheScenario]" "Exact match" by field "Scenario" in list "Reporting period management"
	And I search element "[TheFrequency]" "Exact match" by field "Frequency" in list "Reporting period management"
	And I search and select element "[TheStartDate]" "At the beginning of the line" by field "Start period" in list "Reporting period management"

	When "Indicator value adjustment (create) *" window is opened
	And I click Choice button of the field named 'Organization'
	And I select company "[TheBusinessUnit]"

	And I fill 'TableOfAdjustments' table with data
		|'Table'|
	
	When "Indicator value adjustment (create) *" window is opened
	And I click the button named 'FormPostAndClose'
	And I wait "Indicator value adjustment (create) *" window closing in 20 seconds

Scenario: I open new indicator values adjustment scenario "TheScenario" period "TheStartDate" frequency "TheFrequency" company "TheBusinessUnit"

	And In the command interface I select "Budgeting, reporting, and analysis" "Indicator value adjustment"
	Then "Indicator value adjustment" window is opened

	And I click the button named 'FormCreate'
	Then "Indicator value adjustment (create)" window is opened

	And I click Choice button of the field named 'PeriodManagement'
	And I search element "[TheScenario]" "Exact match" by field "Scenario" in list "Reporting period management"
	And I search element "[TheFrequency]" "Exact match" by field "Frequency" in list "Reporting period management"
	And I search and select element "[TheStartDate]" "At the beginning of the line" by field "Start period" in list "Reporting period management"

	When "Indicator value adjustment (create) *" window is opened
	And I click Choice button of the field named 'Organization'
	And I select company "[TheBusinessUnit]"