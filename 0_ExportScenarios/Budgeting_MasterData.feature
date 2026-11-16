#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for working with the "Budgeting" subsystem - "Master data"

Scenario: I create scenario with name 'TheName'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Scenarios"

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Scenarios"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			* Deleting scenario period management documents
				When "BudgetingScenarios: [TheName] (BudgetingScenarios)" window is opened
				And I click the button named 'FormDocumentScenarioPeriodManagementDocumentsManagementReportingPeriod'
				Then "Reporting period management" window is opened
				If number of 'List' table lines is 'more' 0 Then
					Then I select all lines of 'List' table
					And I select context menu item named 'ListContextMenuSetDeletionMark' of the form attribute named 'List'
					Then "1C:Enterprise" window is opened
					And I click the button named 'Button0'
				And I close "Reporting period management" window
			And I delete current element in window "BudgetingScenarios: [TheName] (BudgetingScenarios)" clearing
			
	* Creating a new element
		Then "Scenarios" window is opened
		And I click the button named 'FormCreate'
		Then "Scenarios: Scenarios (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Scenarios: Scenarios (create) *" window closing in 5 seconds

	* Closing a list
		When "Scenarios" window is opened
		And I close "Scenarios" window

Scenario: I set value 'TheValue' for attribute 'TheProperty' on tab 'ThePage' for scenario 'TheName'

	* Searching for an element
		And In the command interface I select "Budgeting, reporting, and analysis" "Scenarios"
		And I search and select element '[TheName]' "Exact match" by field "Description" in list "Scenarios"
		
	* Changing an attribute
		And I save form header as 'FormCaption' variable
		Then '$FormCaption$' window is opened
		And I move to the tab named '[ThePage]'
		And I set value '[TheValue]' for attribute '[TheProperty]'

	* Saving an element
		And I click the button named 'FormWriteAndClose'
		And I wait '$FormCaption$ *' window closing in 20 seconds

Scenario: I create project with name 'TheProjectName'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Projects*"
	
	* Deleting the current element
		Then "Projects*" window is opened
		And I click the button named 'FormFind'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input '[TheProjectName]' text in the field named 'Pattern'
		And I click the button named 'Find'
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "*(Project*" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "*(Project*" window closing in 20 seconds
			
	* Creating a new element
		Then "Projects*" window is opened
		And I click the button named 'FormCreate'
		Then "Projects and phases (create)" window is opened
		And I input '[TheProjectName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Projects and phases (create) *" window closing in 20 seconds

	* Closing a list
		When "Projects*" window is opened
		And I close "Projects*" window

Scenario: I create dimension type with code 'TheAnalyticsCode' name 'TheAnalyticsName' type 'TheAnalyticsType'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		
	* Deleting an element
		And I search element '[TheAnalyticsCode]' "Exact match" by field "Code" in list "Dimension types (corporate)"
		And While the number of 'List' table lines 'more' 0 Then
			* Arbitrary classifier
				And I select current line in 'List' table
				Then "* (Dimension types (corporate))" window is opened
				And In this window I click command interface button "Arbitrary classifier"
				If number of 'List' table lines is 'more' 0 Then
					And I click the button named 'FormListSettings'
					And I set filter in list form "Description" "Does not begin with" 'Delete_'
					And While the number of 'List' table lines 'more' 0 Then
						* Marking for deletion
							And I delete current row in list 'List'
						* Renaming
							And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
							And I select current line in 'List' table
							When "* (Arbitrary classifier)" window is opened
							Then I input 'UID' variable value in the field named 'Description'
							And I click the button named 'FormWriteAndClose'
							And I wait "* (Arbitrary classifier)" window closing in 20 seconds
					And I click the button named 'FormListSettings'
					And I remove all filters in list form
				When "* (Dimension types (corporate))" window is opened
				And I close "* (Dimension types (corporate))" window
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Dimension types (corporate))" window is opened
				And I input 'Delete' text in the field named 'Code'
				Then "1C:Enterprise" window is opened
				And I click the button named 'Button0'
				Then "* (Dimension types (corporate))" window is opened
				And I input '' text in the field named 'Code'
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Dimension types (corporate)) *" window closing in 20 seconds
		And I close "Dimension types (corporate)" window

	* Creating an element by code
		And I execute 1C:Enterprise script at server no context
			| 'TypeOfAnalytics = ChartsOfCharacteristicTypes.CorporateExtDimensionTypes.CreateItem();' |
			| 'Array = New Array;' |
			| 'Array.Add(Type("[TheAnalyticsType]"));' |
			| 'TypeOfAnalytics.ValueType = New TypeDescription(Array);' |
			| 'TypeOfAnalytics.Code = "[TheAnalyticsCode]";' |
			| 'TypeOfAnalytics.Description = "[TheAnalyticsName]";' |
			| 'TypeOfAnalytics.Write();' |

Scenario: I set attribute "ThePropertyName" as key for dimension type with code "TheAnalyticsCode"

	* Opening a list and an element
		And In the command interface I select "Budgeting, reporting, and analysis" "Dimension types (corporate)"
		And I search and select element '[TheAnalyticsCode]' "Exact match" by field "Code" in list "Dimension types (corporate)"
		When "* (Dimension types (corporate))" window is opened
		And I go to line in 'TableBoxAttributes' table:
			| "Attribute"          |
			| '[ThePropertyName]' |
		And I set checkbox named 'AttributesTableKey' in 'TableBoxAttributes' table
		And I set checkbox named 'AttributesTableTemplate' in 'TableBoxAttributes' table
		And I click the button named 'FormWriteAndClose'
		And I wait "* (Dimension types (corporate)) *" window closing in 20 seconds
		When "Dimension types (corporate)" window is opened
		And I select context menu item named 'ListContextMenuCancelSearch' of the form attribute named 'List'

Scenario: I create CPM subaccount with name 'TheExtDimensionCPMName' and dimension type with code 'TheExtDimensionCPMKind'

	* Opening a list
		And In the command interface I select "Budgeting, reporting, and analysis" "Arbitrary classifier"
		When "Arbitrary classifier" window is opened

	* Setting a type
		And I select from the drop-down list named 'Owner'  by '[TheExtDimensionCPMKind]' string

	* Deleting the current element
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheExtDimensionCPMName]' text in the field named 'Pattern'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I click the button named 'Find'
		Then "Arbitrary classifier" window is opened
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				When "* (Arbitrary classifier)" window is opened
				Then I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Arbitrary classifier)" window closing in 20 seconds

	* Creating a new element
		When "Arbitrary classifier" window is opened
		And I click the button named 'FormCreate'
		Then "Arbitrary classifier (create)" window is opened
		And I input '[TheExtDimensionCPMName]' text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Arbitrary classifier (create) *" window closing in 20 seconds

	* Closing a list
		When "Arbitrary classifier" window is opened
		And I close "Arbitrary classifier" window

Scenario: I fill dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

		And I activate field named "DimensionKindsDimensionKind" in "DimensionKinds" table
		And I select current line in "KindsOfDimensions" table
		If 'NOT IsBlankString("[TheAnalytics1]")' Then
			And I select '[TheAnalytics1]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics2]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '2' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics2]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics3]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '3' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics3]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics4]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '4' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics4]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics5]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '5' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics5]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table
		If 'NOT IsBlankString("[TheAnalytics6]")' Then
			And I go to line in "DimensionKinds" table:
				| '№' |
				| '6' |
			And I select current line in "KindsOfDimensions" table
			And I select '[TheAnalytics6]' by string from the drop-down list named "DimensionKindsDimensionKind" in "DimensionKinds" table
			And I finish line editing in "DimensionKinds" table

Scenario: I create article dimension group 'TheAnalyticsGroup' with dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'

	* Opening a list form
		And I open "ItemDimensionGroups" catalog default form
	
	* Deleting an element
		And I search element '[TheAnalyticsGroup]' "Exact match" by field "Description" in list "Item dimension groups"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheAnalyticsGroup] (Item dimension group)" clearing
	
	* Creating an element
		And I click the button named 'FormCreate'
		And I input '[TheAnalyticsGroup]' text in the field named 'Description'
		And I fill dimension types 'TheAnalytics1', 'TheAnalytics2', 'TheAnalytics3', 'TheAnalytics4', 'TheAnalytics5', 'TheAnalytics6'
		And I click the button named 'FormWriteAndClose'
		And I wait 'Item dimension group (create) *' window closing in 20 seconds
		
	* Closing a list form
		When 'Item dimension groups' window is opened
		And I close 'Item dimension groups' window

Scenario: I check filled dimensions count 'N' in table for dimension group 'TheAnalyticsGroup'
	* Checking the number of dimensions
		And I open "ItemDimensionGroups" catalog default form
		And I search element '[TheAnalyticsGroup]' "Exact match" by field "Description" in list "Item dimension groups"
		And I select current line in "List" table
		And the form attribute named "МаксимальныйНомерЗаполненнойАналитики" became equal to '[N]'
		And I close '[TheAnalyticsGroup] (Item dimension group)' window
		And I close 'Item dimension groups' window

Scenario: I create regulation group with name 'TheName'

	* Opening a regulation
		And In the command interface I select "Budgeting, reporting, and analysis" "Regulations for preparing reports"

	* Deleting a group
		And I search element '[TheName]' "Exact match" by field "Description" in list "Regulations for preparing reports"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "[TheName] (Regulations for preparing reports)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "[TheName] (Regulations for preparing reports) *" window closing in 20 seconds

	* Creating a group
		When "Regulations for preparing reports" window is opened
		And I click the button named 'FormCreateFolder'
		Then "Regulations for preparing reports (create group)" window is opened
		And I input "VA - Group regulations" text in the field named 'Description'
		And I click the button named 'FormWriteAndClose'
		And I wait "Regulations for preparing reports (create group) *" window closing in 20 seconds
				
Scenario: I change flag 'TheFlagName' for regulation 'TheRegulationName'

	And In the command interface I select "Budgeting, reporting, and analysis" "Regulations for preparing reports"
	Then "Regulations for preparing reports" window is opened
	And I click the button named 'FormFind'
	Then "Find" window is opened
	And I select "Description" exact value from the drop-down list named 'FieldSelector'
	And I input '[TheRegulationName]' text in the field named 'Pattern'
	And I change the radio button named 'CompareType' value to "Exact match"
	And I click the button named 'Find'
	Then "Regulations for preparing reports" window is opened
	And I select current line in 'List' table
	Then I open reporting preparation regulation 'TheRegulationName'
	And I move to the tab named 'GroupMainPage'
	And I change checkbox named '[TheFlagName]'
	And I click the button named 'FormWriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: I create information base type with name 'TheName' version 'ThePlatformVersion'

	* Opening a list
		And In the command interface I select "Integration and master data management" "Infobase types"

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "Description" in list "Infobase types"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (Infobase type)" clearing
	
	* Creating a new element
		And I click the button named 'FormCreate'
		Then "Infobase type (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I select '[ThePlatformVersion]' exact value from the drop-down list named 'PlatformVersion'
		And I click the button named 'FormWriteAndClose'
		And I wait "Infobase type (create) *" window closing in 20 seconds
		
	* Closing a list
		When "Infobase types" window is opened
		And I close "Infobase types" window

Scenario: I create external information base 'TheName' type 'TheType' catalog 'TheCatalog' storage type 'TheTypeOfStorage'

	* Opening a list
		And In the command interface I select "Integration and master data management" "External infobases"

	* Deleting an element
		And I search element '[TheName]' "At the beginning of the line" by field "External infobase" in list "External infobases"
		And While the number of 'List' table lines 'more' 0 Then
			And I select current line in 'List' table
			And I delete current element in window "[TheName] (External infobases)" clearing

	* Creating a new element
		And I click the button named 'FormCreate'
		Then "External infobases (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click Choice button of the field named 'ExternalSourceType'
		And I search and select element '[TheType]' "At the beginning of the line" by field "Description" in list "Infobase types"
		And I input '[TheCatalog]' text in the field named 'NameBeginning'
		If '"[TheTypeOfStorage]" = "Excel"' Then
			And I change the radio button named 'ADOStorageType' value to "MS Excel (.xls) files"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
			And I click the button named 'TestConnection'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
		If '"[TheTypeOfStorage]" = "FoxPro"' Then
			And I change the radio button named 'ADOStorageType' value to "FoxPro (.dbf) files"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
		If '"[TheTypeOfStorage]" = "Access"' Then
			And I change the radio button named 'ADOStorageType' value to "MS Access databases (.mdb)"
			And I input '[TheCatalog]' text in the field named 'ReferenceDirectory'
		And I save "[TheName] (External infobases)*" line to the variable 'WindowTitle'
		And I click the button named 'FormWrite'
		And I wait '$WindowTitle$' window opening in 20 seconds
	
Scenario: I add company files path element for type 'TheType' object 'TheObject' value 'TheValue'

	Then "Company file path items: List form" window is opened
	And I move to the tab named 'Page_[TheType]'

	* Deleting an old element
		And in the table 'List_[TheType]' I click the button named 'List_[TheType]Find'
		Then "Find" window is opened
		And I select "Object" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheObject]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Company file path items: List form" window is opened
		And While the number of 'List_[TheType]' table lines 'more' 0 Then
			And I select context menu item named 'List_[TheType]ContextMenuDelete' of the form attribute named 'List_[TheType]'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
				
	* Adding a new element
		And in the table 'List_[TheType]' I click the button named 'List_[TheType]Create'
		Then "Company file path items (create)" window is opened
		And I select from the drop-down list named 'Object'  by '[TheObject]' string
		And I input '[TheValue]' text in the field named 'Name'
		And I click the button named 'FormWriteAndClose'
		And I wait "Company file path items (create) *" window closing in 20 seconds

Scenario: I create universal process template with name "TheName" mode "TheMode"

	* Opening a reference form
		And In the command interface I select "Budgeting, reporting, and analysis" "Templates of report preparation process"

	* Deleting an element
		And I search element '[TheName]' "Exact match" by field "Description" in list "Universal process templates"
		And While the number of 'List' table lines 'more' 0 Then
			* Renaming
				And I select current line in 'List' table
				Then "Editing process stages: [TheName]" window is opened
				And I click the button named 'FormOpenProcessProperties'
				When "[TheName] (Universal process template)" window is opened
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "[TheName] (Universal process template) *" window closing in 20 seconds
				Then "Editing process stages: *" window is opened
				And I close "Editing process stages: *" window

	* Creating an element
		When "Universal process templates" window is opened
		And I click the button named 'FormCreate'
		Then "Universal process template (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		When "Universal process template (create)" window is opened
		And I select '[TheMode]' exact value from the drop-down list named 'ProcessPurpose'
		When "Universal process template (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Universal process template (create) *" window closing in 20 seconds
		Then "Editing process stages: *" window is opened
		And I close "Editing process stages: *" window
