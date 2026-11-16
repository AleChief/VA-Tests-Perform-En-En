#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Report instances"

Scenario: I create report instance for report type 'TheReportKind' scenario 'TheScenario' period 'TheStartDate' 'TheEndDate' frequency 'TheFrequency' company 'TheBusinessUnit' project 'TheProject' dimensions 'TheDimension1' 'TheDimension2' 'TheDimension3' 'TheDimension4' 'TheDimension5' 'TheDimension6'

	* Opening a key attributes form
		If current window header is "Specify key document attributes" Then
			// The form is already open
		Else
			And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
			Then "Report instances" window is opened
			And I click Clear button of the field named 'SavedSetting'
			And I click the button named 'FormCreate'

	* Filling key attributes
		Then "Specify key document attributes" window is opened
		And I select from the drop-down list named 'ReportKind'  by '[TheReportKind]' string
		And I select from the drop-down list named 'Scenario'  by '[TheScenario]' string
		And I select '[TheFrequency]' exact value from the drop-down list named 'ReportFrequency'
		And I click the button named 'ChangePeriod'
		Then "Select period" window is opened
		And I input '[TheStartDate]' text in the field named 'DateBegin'
		And I input '[TheEndDate]' text in the field named 'DateEnd'
		And I click the button named 'Select'
		Then "Specify key document attributes *" window is opened
		And I click Choice button of the field named 'Organization'
		And I select company '[TheBusinessUnit]'
		Then "Specify key document attributes *" window is opened
		If 'NOT IsBlankString("[TheProject]")' Then
			And I select from the drop-down list named 'Project'  by '[TheProject]' string
		If 'NOT IsBlankString("[TheDimension1]")' Then
			And I select from the drop-down list named 'Dimension1'  by '[TheDimension1]' string
		If 'NOT IsBlankString("[TheDimension2]")' Then
			And I select from the drop-down list named 'Dimension2'  by '[TheDimension2]' string
		If 'NOT IsBlankString("[TheDimension3]")' Then
			And I select from the drop-down list named 'Dimension3'  by '[TheDimension3]' string
		If 'NOT IsBlankString("[TheDimension4]")' Then
			And I select from the drop-down list named 'Dimension4'  by '[TheDimension4]' string
		If 'NOT IsBlankString("[TheDimension5]")' Then
			And I select from the drop-down list named 'Dimension5'  by '[TheDimension5]' string
		If 'NOT IsBlankString("[TheDimension6]")' Then
			And I select from the drop-down list named 'Dimension6'  by '[TheDimension6]' string
		When "Specify key document attributes *" window is opened
		And I click the button named 'FormApplyAndClose'
		
		And I open report instance for report type '[TheReportKind]' currency '*' company '[TheBusinessUnit]' scenario '[TheScenario]' frequency '[TheFrequency]' project '[TheProject]' dimensions '[TheDimension1]' '[TheDimension2]' '[TheDimension3]' '[TheDimension4]' '[TheDimension5]' '[TheDimension6]'

Scenario: I open first report instance for report type 'TheReportKind'

	And I find report type with name '[TheReportKind]' in list
	And in the table 'ReportKindList' I click the button named 'ReportKindListOpenInstancesList'
	Then "Report instances" window is opened
	And I select current line in 'List' table

Scenario: I open report instance by saved setting 'TheName'

	And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
	Then "Report instances" window is opened
	And I click Choice button of the field named 'SavedSetting'
	And I select '[TheName]' exact value from the drop-down list named 'SavedSetting'
	And I select current line in 'List' table

Scenario: I delete all existing versions in report instance

	And I click the button named 'FormVersionsManagement'
	Then "Indicator version management" window is opened
	And While the number of 'List' table lines ">" 0 Then
		And I click the button named 'ListDeleteVersions'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
	Then "Indicator version management*" window is opened
	And I close "Indicator version management*" window

Scenario: I check report instance movements are equal to "ThePath"

	And I click the button named 'FormDocumentRegisterRecords'
	Then "Flat table of indicator values with attributes" window is opened
	And I wait for filling of 'R2C1' cell in 'ReportSpreadsheetDocument' spreadsheet document for 60 seconds
	Given 'ReportSpreadsheetDocument' spreadsheet document is equal to "[ThePath]" by template
	And I close "Flat table of indicator values with attributes" window
