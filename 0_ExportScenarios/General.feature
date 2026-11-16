#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: General export scenarios

Scenario: I initialize variables

	And I save '?(CommonClientServerCPM.ConfigurationName() = "Perform", "True", "False")' in '$$IsPerform$$' variable

	And I save '?(CommonClientServerCPM.ConfigurationName() = "HoldingManagement" OR $$IsPerform$$, "True", "False")' in '$$IsCPM$$' variable
			
	And I save '?(CommonClientServerCPM.ConfigurationName() = "HoldingManagementERP", "True", "False")' in '$$IsERPCPM$$' variable

	Если в панели разделов есть команда 'Бюджетирование, отчетность и анализ' Тогда
		И Я запоминаю значение выражения 'Ru' в переменную '$$ЯзыкИнтерфейса$$'
	ИначеЕсли в панели разделов есть команда 'Budgeting, reporting, and analysis' Тогда
		И Я запоминаю значение выражения 'En' в переменную '$$ЯзыкИнтерфейса$$'
		
Scenario: I check table 'TheTable' contains 'TheNumberOfLines' rows from list:

	Then the number of '[TheTable]' table lines is 'equal' '[TheNumberOfLines]'

	Then '[TheTable]' table contains lines
		| 'Table' |	

Scenario: I set value 'TheValue' for attribute 'TheProperty'

	If 'Upper("[TheValue]") = "TRUE" OR Upper("[TheValue]") = "TRUE"' Then
		And I set checkbox named '[TheProperty]'
	ElseIf 'Upper("[TheValue]") = "FALSE" OR Upper("[TheValue]") = "FALSE"' Then
		And I remove checkbox named '[TheProperty]'
	Else
		And I select "[TheValue]" exact value from the drop-down list named '[TheProperty]'

Scenario: I delete current element in window 'TheWindowName' clearing 'TheFieldName1' 'TheFieldName2' 'TheFieldName3'

	When "[TheWindowName]" window is opened

	And I click the button named 'FormSetDeletionMark'
	When "1C:Enterprise" window is opened
	If form element named 'Message' became equal to "Mark * for deletion?" by template Then
		And I click the button named 'Button0'
	Else
		And I click the button named 'Button1'

	And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
	Then I input 'UID' variable value in the field named 'Description'
	
	If 'NOT StrStartsWith("[TheFieldName1]", "[") AND NOT IsBlankString("[TheFieldName1]")' Then
		Then I input ' ' text in the field named '[TheFieldName1]'
	If 'NOT StrStartsWith("[TheFieldName2]", "[") AND NOT IsBlankString("[TheFieldName2]")' Then
		Then I input ' ' text in the field named '[TheFieldName2]'
	If 'NOT StrStartsWith("[TheFieldName3]", "[") AND NOT IsBlankString("[TheFieldName3]")' Then
		Then I input ' ' text in the field named '[TheFieldName3]'

	Then "[TheWindowName]*" window is opened
	And I click the button named 'FormWriteAndClose'
	And I wait "[TheWindowName]*" window closing in 20 seconds
			