#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: General export scenarios

Scenario: I set filter in list form 'TheField' 'TheComparisonType' 'TheValue'

	Then "List settings" window is opened
	And I delete all lines of 'SettingsComposerUserSettingsItem0Filter' table
	And in the table 'SettingsComposerUserSettingsItem0Filter' I click the button named 'SettingsComposerUserSettingsItem0FilterAddFilterItem'
	And I go to the last line in 'SettingsComposerUserSettingsItem0Filter' table
	If 'StrFind("[TheField]", ".") > 0' Then
		And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem0FilterLeftValue' of 'SettingsComposerUserSettingsItem0Filter' table
	And I select '[TheField]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterLeftValue' in 'SettingsComposerUserSettingsItem0Filter' table
	And I activate field named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
	And I select '[TheComparisonType]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
	And I activate field named 'SettingsComposerUserSettingsItem0FilterRightValue' in 'SettingsComposerUserSettingsItem0Filter' table
	If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
		And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem0FilterRightValue' of 'SettingsComposerUserSettingsItem0Filter' table
	Else
		And I select '[TheValue]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterRightValue' in 'SettingsComposerUserSettingsItem0Filter' table
	And I finish line editing in 'SettingsComposerUserSettingsItem0Filter' table
	And I click the button named 'FormEndEdit'

Scenario: I add filter in list form 'TheField' 'TheComparisonType' 'TheValue'

	Then "List settings" window is opened
	And in the table 'SettingsComposerUserSettingsItem0Filter' I click the button named 'SettingsComposerUserSettingsItem0FilterAddFilterItem'
	If 'StrFind("[TheField]", ".") > 0' Then
		And I input '[TheField]' text in the field named 'SettingsComposerUserSettingsItem0FilterLeftValue' of 'SettingsComposerUserSettingsItem0Filter' table
	And I select '[TheField]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterLeftValue' in 'SettingsComposerUserSettingsItem0Filter' table
	And I activate field named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
	And I select '[TheComparisonType]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
	And I activate field named 'SettingsComposerUserSettingsItem0FilterRightValue' in 'SettingsComposerUserSettingsItem0Filter' table
	If 'StrFind(Lower("[TheComparisonType]"),"contains")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0 OR StrFind(Lower("[TheComparisonType]"),"contain")>0 OR StrFind(Lower("[TheComparisonType]"),"begin with")>0' Then
		And I input '[TheValue]' text in the field named 'SettingsComposerUserSettingsItem0FilterRightValue' of 'SettingsComposerUserSettingsItem0Filter' table
	Else
		And I select '[TheValue]' exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterRightValue' in 'SettingsComposerUserSettingsItem0Filter' table
	And I finish line editing in 'SettingsComposerUserSettingsItem0Filter' table
	And I click the button named 'FormEndEdit'

Scenario: I remove all filters in list form

	Then "List settings" window is opened
	And I move to the tab named 'SettingsComposerUserSettingsItem0'
	And I delete all lines of 'SettingsComposerUserSettingsItem0Filter' table
	And I click the button named 'FormEndEdit'

Scenario: I search element "ThePattern" "TheCompareType" by field "TheField" in list "TheListName"

//	Then the window '[TheListName]' opened
	If a button named 'FormFind' exists Then
		And I click the button named 'FormFind'
	Else
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
	Then "Find" window is opened
	And I select '[TheField]' exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to '[TheCompareType]'
	And I wait "Find" window opening in 10 seconds
	And I input '[ThePattern]' text in the field named 'Pattern'
	And I click the button named 'Find'
	And I wait '[TheListName]' window opening in 10 seconds

Scenario: I search and select element "ThePattern" "TheCompareType" by field "TheField" in list "TheListName"

//	Then the window '[TheListName]' opened
	If a button named 'FormFind' exists Then
		And I click the button named 'FormFind'
	Else
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
	Then "Find" window is opened
	And I select '[TheField]' exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to '[TheCompareType]'
	And I wait "Find" window opening in 10 seconds
	And I input '[ThePattern]' text in the field named 'Pattern'
	And I click the button named 'Find'
//	And I wait for the window '[TheListName]' to open for 10 seconds
	And I save '[TheField]' value to 'VarField' variable
	And I save '[ThePattern]' value to 'VarPattern' variable
	And I go to line in 'List' table:
		| '$VarField$'   |
		| '$VarPattern$' |
	And I select current line in 'List' table

Scenario: I delete current row in list 'TheList'

	And I select context menu item named '[TheList]ContextMenuMarkForDeletion' of the form attribute named '[TheList]'
	Then "1C:Enterprise" window is opened
	If form element named 'Message' became equal to "Mark * for deletion?" by template Then
		And I click the button named 'Button0'
	Else
		And I click the button named 'Button1'
	And I wait the attribute named '[TheList]' availability in 20 seconds
			