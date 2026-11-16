#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the 'Budgeting' subsystem
		
Scenario: I find report type with name 'TheReportKindDescription' in list

	And In the command interface I select "Budgeting, reporting, and analysis" "Report types and templates"
	Then "Report types and templates" window is opened
	And in the table 'ReportKindList' I click the button named 'ReportKindListFind'
	Then the form named 'UniversalListFindExtForm' is opened
	And I select "Report type" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Anywhere in the line"
	And I input '[TheReportKindDescription]' text in the field named 'Pattern'
	And I click the button named 'Find'
	Then the number of 'ReportKindList' table lines is 'equal' 1

Scenario: I open report instance for report type "TheReportKind" currency "TheCurrency" company "TheBusinessUnit" scenario 'TheScenario' frequency 'TheFrequency' project 'TheProject' dimensions 'TheDimension1' 'TheDimension2' 'TheDimension3' 'TheDimension4' 'TheDimension5' 'TheDimension6'

	If '$$LanguageInterface$$ = "Ru"' Then
		And I save 'Report instance "[TheReportKind]": <[TheCurrency]> <[TheBusinessUnit]> <* - * (Frequency: [TheFrequency]) <[TheScenario]>>' line to the variable 'WindowTitle'
	ElseIf '$$LanguageInterface$$ = "En"' Then
		And I save 'The \"[TheReportKind]\" report instance: <[TheCurrency]> <[TheBusinessUnit]> <* - * (Frequency: [TheFrequency]) <[TheScenario]>>' line to the variable 'WindowTitle'

	If 'NOT IsBlankString("[TheProject]")' Then
		And I save '$WindowTitle$ <[TheProject]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension1]")' Then
		And I save '$WindowTitle$ <[TheDimension1]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension2]")' Then
		And I save '$WindowTitle$ <[TheDimension2]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension3]")' Then
		And I save '$WindowTitle$ <[TheDimension3]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension4]")' Then
		And I save '$WindowTitle$ <[TheDimension4]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension5]")' Then
		And I save '$WindowTitle$ <[TheDimension5]>' line to the variable 'WindowTitle'
	If 'NOT IsBlankString("[TheDimension6]")' Then
		And I save '$WindowTitle$ <[TheDimension6]>' line to the variable 'WindowTitle'

	And I save '$WindowTitle$*' line to the variable 'WindowTitle'
	And I wait '$WindowTitle$' window opening in 30 seconds

Scenario: I open period management document for scenario 'TheScenario' frequency 'TheFrequency'

	If '$$LanguageInterface$$ = "Ru"' Then
		And I save '* - * (Periodicity: [TheFrequency]) <[TheScenario]>' line to the variable 'WindowTitle'
	ElseIf '$$LanguageInterface$$ = "En"' Then
		And I save '* - * (Frequency: [TheFrequency]) <[TheScenario]>' line to the variable 'WindowTitle'

	And '$WindowTitle$' window is opened

Scenario: I open reporting preparation regulation 'TheDescription'

	If '$$LanguageInterface$$ = "Ru"' Then
		If 'IsBlankString("[TheDescription]")' Then
			And I save 'Regulation from * (Create)*' line to the variable 'WindowTitle'
		Else
			And I save '[TheDescription] from * (Reporting preparation regulation)*' line to the variable 'WindowTitle'
	ElseIf '$$LanguageInterface$$ = "En"' Then
		If 'IsBlankString("[TheDescription]")' Then
			And I save 'Regulation from * (Create)*' line to the variable 'WindowTitle'
		Else
			And I save '[TheDescription] from * (Regulation for preparing reports)*' line to the variable 'WindowTitle'

	And '$WindowTitle$' window is opened

Scenario: I open template for report type 'TheReportKind'

	And I save "Template [TheReportKind] report type: [TheReportKind]*" line to the variable 'WindowTitle'
	And '$WindowTitle$' window is opened

Scenario: I open pivot table template for report type 'TheReportKind'

	And I save "Pivot table template: [TheReportKind] (pivot table)*" line to the variable 'WindowTitle'
	And '$WindowTitle$' window is opened

Scenario: I open pivot table for report type 'TheReportKind'

	And I save "Pivot table: [TheReportKind] (pivot table)*" line to the variable 'WindowTitle'
	And I wait '$WindowTitle$' window opening in 20 seconds

Scenario: I open pivot table for variant 'TheVariant'

	And I wait "Pivot table: [TheVariant]*" window opening in 20 seconds

Scenario: I open calculation rule for report type 'TheReportKind'

	And "[TheReportKind] (Calculation rules)*" window is opened
	
Scenario: I substitute parameters 'TheParameter1' 'TheParameter2' 'TheParameter3' in row 'TheLine'

	And I save 'StrTemplate("[TheLine]", "[TheParameter1]", "[TheParameter2]", "[TheParameter3]")' in 'FinalRow' variable

Scenario: I select indicator with code 'TheIndicatorCode'

	If '$$LanguageInterface$$ = "Ru"' Then
		Then "Report indicators" window is opened
		And I change the radio button named 'IndicatorChoiceMode' value to "Structure layout"
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to '[TheIndicatorCode]' cell
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I double-click the current cell
	Else
		Then "Report indicators" window is opened
		And I change the radio button named 'IndicatorChoiceMode' value to "Indicator list"
		And in the table 'List' I click the button named 'ListFind'
		Then "Find" window is opened
		And I select "Code" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input '[TheIndicatorCode]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Report indicators" window is opened
		And I select current line in 'List' table

Scenario: I select company 'TheName'

	If '$$IsPerform$$' Then
		And I search and select element '[TheName]' "At the beginning of the line" by field "Description" in list "Business units"
	ElseIf '$$IsCPM$$' Then
		And I search and select element '[TheName]' "Exact match" by field "Name in the application" in list "Business units"
	ElseIf '$$IsERPCPM$$' Then
		And I search and select element '[TheName]' "Exact match" by field "Working name" in list "Companies"