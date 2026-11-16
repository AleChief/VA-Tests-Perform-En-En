#language: en
@tree

@UH32_Budget
@ERPUH32_Budget
@Perform_Budget

Feature: 20. Testing the approval subsystem

	As Administrator I want to
	Test the approval subsystem
	To eliminate errors during development

Background:

	And I close all client application windows

Scenario: 20.00 Determining the application type
	
	And I close "CPM - Budget" TestClient
	And I connect "CPM - Budget" TestClient using "Administrator" login and '' password
	Given I initialize variables

Scenario: 20.01 Creating roles

	* Create roles and add them to the addressing matrix
		And I create contact persons role "VA - Addressing by Role"
		And I create contact persons role "VA - The role of extended addressing"

		And I create extended addressing element "VA - Extended Addressing" role "VA - The role of extended addressing"

		And I add row to addressing matrix role "VA - Addressing by Role" user "Budgeting2"
		And I add row to addressing matrix role "VA - The role of extended addressing" user "Budgeting3"

	* Create the Superuser role
		And I create contact persons role "Superuser"

		And In the command interface I select "General catalogs and settings" "General settings"
		Then "General settings*" window is opened
		And I click Choice button of the field named 'RoleSuperUser'
		And I search and select element "Superuser" "Exact match" by field "Description" in list "Contact person roles"
		Then "General settings *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "General settings *" window closing in 20 seconds
		
		And I add row to addressing matrix role "Superuser" user "Administrator"
		And I add row to addressing matrix role "Superuser" user "Budgeting4"

Scenario: 20.02 Configuring the security document

	And In the command interface I select "General catalogs and settings" "Documents"
	
	Then "Current infobase documents" window is opened
	And in the table 'List' I click the button named 'ListFind'
	Then "Find" window is opened
	And I select "Document" exact value from the drop-down list named 'FieldSelector'
	And I change the radio button named 'CompareType' value to "Anywhere in the line"
	And I input "Report instance" text in the field named 'Pattern'

	And I click the button named 'Find'
	Then "Current infobase documents" window is opened
	And I wait that in 'List' table number of lines will be "equal" 1 for 20 seconds
	And I select current line in 'List' table

	Then "Report instance (Infobase document)" window is opened
	And I move to the tab named 'ApprovalGroup'
	And I set checkbox named 'ShouldDivideByCompanies'
	And I click the button named 'FormWriteAndClose'
	And I wait "Report instance (Infobase document) *" window closing in 20 seconds
	Then "Current infobase documents" window is opened
	And I close "Current infobase documents" window

Scenario: 20.03 Creating a report type

	* Creating a report type
		And I create report type with name "VA - Coordination" and parent "VA - Report group"

	* Configuring structure
		And I open report wizard with name "VA - Coordination"
		And I add rows in report wizard
			| "Description" |
			| "Line 1"     |
			| "Line 2"     |
			| "Line 3"     |
		And I add columns in report wizard
			| "Description" |
			| "Count"   |
			| "Price"         |
			| "Amount"        |

	* Configuring formulas
		And I set product formula for cell 'R2C2' of cells 'R2C3' 'R2C4' in report wizard
		And I set product formula for cell 'R3C2' of cells 'R3C3' 'R3C4' in report wizard
		And I set product formula for cell 'R4C2' of cells 'R4C3' 'R4C4' in report wizard

	* Closing report wizard
		When "Report wizard" window is opened
		And I close "Report wizard" window
		
	* Creating a template
		And I create default template for report type "VA - Coordination"

Scenario: 20.04 Creating a report instance

	And I create report instance for report type "VA - Coordination" scenario "VA - Main scenario" period '1/1/2024' '3/31/2024' frequency "Month" company "Mercury LLC" project '' dimensions '' '' '' '' '' ''

	And I enter value '3.00000' in cell 'R6C2'
	And I enter value '4.00000' in cell 'R7C2'
	And I enter value '5.00000' in cell 'R8C2'
	And I enter value '100.00000' in cell 'R6C3'
	And I enter value '200.00000' in cell 'R7C3'
	And I enter value '300.00000' in cell 'R8C3'

	When '$WindowTitle$' window is opened
	And I click the button named 'WriteAndClose'
	And I wait '$WindowTitle$' window closing in 20 seconds

Scenario: 20.05 Creating an approval process template

	* Check for the presence of a template group
		And In the command interface I select "Processes and approval" "Process templates"
		Then "Universal process templates" window is opened
		And I search element "VA - Approval Process Group" "Exact match" by field "Description" in list "Universal process templates"
		If number of 'List' table lines is "=" 0 Then
			And I click the button named 'FormCancelSearch'
			And I click the button named 'FormCreateFolder'
			Then "Universal process templates (create folder)" window is opened
			And I input "VA - Approval Process Group" text in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait "Universal process templates (create folder) *" window closing in 20 seconds

	* Deleting existing templates
		Then "Universal process templates" window is opened
		And I search element "VA - Approval Process Template" "Exact match" by field "Description" in list "Universal process templates"
		And While the number of 'List' table lines ">" 0 Then
			And I select current line in 'List' table
			Then "Editing process stages: VA - Approval Process Template" window is opened
			And I click the button named 'FormOpenProcessProperties'
			Then "VA - Approval Process Template (Universal process template)" window is opened
			And I save '"VA - (delete) " + StrReplace(New UUID, "-", "")' in 'UID_Description' variable
			And I input 'UID_Description' variable value in the field named 'Description'
			And I click the button named 'FormWrite'
			Then "$UID_Description$ (Universal process template)" window is opened
			And I click the button named 'FormSetDeletionMark'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'
			Then "$UID_Description$ (Universal process template)" window is opened
			And I click the button named 'FormWriteAndClose'
			And I wait "$UID_Description$ (Universal process template)" window closing in 20 seconds
			Then "Editing process stages: VA - Approval Process Template" window is opened
			And I close "Editing process stages: VA - Approval Process Template" window

	* Creating a template
		Then "Universal process templates" window is opened
		And I click the button named 'FormCreate'
		Then "Universal process template (create)" window is opened
		And I input "VA - Approval Process Template" text in the field named 'Description'
		And I select from the drop-down list named 'Parent'  by "VA - Approval Process Group" string
		And I select "Approval route" exact value from the drop-down list named 'ProcessPurpose'
		And I select "Current infobase document" exact value from the drop-down list named 'CatalogName'
		And I click Choice button of the field named 'ApprovalObjectType'
		And I search and select element "Report instance" "Anywhere in the line" by field "Document" in list "Infobase documents"
		Then "Universal process template (create) *" window is opened
		And I click the button named 'FormWrite'
		Then "Editing process stages: VA - Approval Process Template" window is opened

	* Configuring the process scheme
		And I add approval step with name "Approval step 1" addressing method "User" user "Budgeting1" role '' extended addressing ''
		And I add approval step with name "Approval step 2" addressing method "Role" user "Budgeting2" role "VA - Addressing by Role" extended addressing ''
		And I add approval step with name "Approval step 3" addressing method "Extended addressing" user "Budgeting3" role '' extended addressing "VA - Extended Addressing"
		And I add approval step with name "Approval step 4" addressing method "User" user "Budgeting4" role '' extended addressing ''
		And I add approval step with name "Approval step 5" addressing method "Role" user "Budgeting2" role "VA - Addressing by Role" extended addressing ''
		And I add approval step with name "Approval step 6" addressing method "Extended addressing" user "Budgeting3" role '' extended addressing "VA - Extended Addressing"
		And I add approval step with name "Approval step 7" addressing method "User" user "Budgeting4" role '' extended addressing ''
		And I add approval step with name "Approval step 8" addressing method "User" user "Budgeting1" role '' extended addressing ''
		And I add approval step with name "Approval step 9" addressing method "User" user "Budgeting1" role '' extended addressing ''

		And in 'PossibleStepsTableBox' spreadsheet document I move to 'AutoConfirmation' cell
		And I click the button named 'AddSelectedStep'
		Then "Automatic document confirmation (Universal process step)" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Automatic document confirmation (Universal process step)" window closing in 20 seconds
		
		And in 'PossibleStepsTableBox' spreadsheet document I move to 'ConditionalTransition' cell
		And I click the button named 'AddSelectedStep'
		Then "Conditional transition (Universal process step)" window is opened
		And I input "Conditional transition 1" text in the field named 'Description'
		And I click the button named 'OpenConditionalTransitionSetting'
		Then "Conditional transition settings" window is opened
		And in the table 'FilterTree' I click the button named 'FilterTreeAddDataSource'
		Then "Data source (create)" window is opened
		And I input "Source 1" text in the field named 'Description'
		And I click Choice button of the field named 'ReportTypeFilter'

		And I search element "VA - Coordination" "Exact match" by field "Description" in list "Report types"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

		Then "Data source (create) *" window is opened
		And I click Choice button of the field named 'IndicatorFilter'
		Then "Report indicators" window is opened
		And I change the radio button named 'IndicatorChoiceMode' value to "Structure layout"
		And in 'SpreadsheetDocSelectIndicator' spreadsheet document I move to "Line3_Amount" cell
		And I click the button named 'FormSelectItems'
		Then "Data source (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Data source (create) *" window closing in 20 seconds
		Then "Conditional transition settings *" window is opened
		And in the table 'TransitionTableBox' I click the button named 'TransitionTableBoxAddCondition'
		And I expand a line in 'FilterTree' table
			| "Item"    |
			| "Source 1" |
		And I go to line in 'FilterTree' table:
			| "Item"                    |
			| "Indicator: Line 3 amount" |
		When "Conditional transition settings *" window is opened
		And in the table 'FilterTree' I click the button named 'TransferConditionItem'
		When "Conditional transition settings *" window is opened
		And I activate field named 'TransitionTableBoxValue' in 'TransitionTableBox' table
		And I select current line in 'TransitionTableBox' table
		And I select "Equal to" exact value from the drop-down list named 'TransitionTableBoxValue' in 'TransitionTableBox' table
		And I activate field named 'TransitionTableBoxFilterValue' in 'TransitionTableBox' table
		And I input '1,536.7852' text in the field named 'TransitionTableBoxFilterValue' of 'TransitionTableBox' table
		And I finish line editing in 'TransitionTableBox' table
		When "Conditional transition settings *" window is opened
		And I go to line in 'TransitionTableBox' table:
			| "Action" |
			| "Then"    |
		And I activate field named 'TransitionTableBoxActionDisplayText' in 'TransitionTableBox' table
		And in the table 'TransitionTableBox' I click the button named 'TransitionTableBoxAddAction'
		And I activate field named 'TransitionTableBoxValue' in 'TransitionTableBox' table
		And I select current line in 'TransitionTableBox' table
		
		And I search element "Approval step 2" "Exact match" by field "Description" in list "Universal process steps"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

		Then "Conditional transition settings *" window is opened
		And I finish line editing in 'TransitionTableBox' table
		When "Conditional transition settings *" window is opened
		And I go to line in 'TransitionTableBox' table:
			| "Action" |
			| "Else"    |
		And I activate field named 'TransitionTableBoxActionDisplayText' in 'TransitionTableBox' table
		And in the table 'TransitionTableBox' I click the button named 'TransitionTableBoxAddAction'
		And I activate field named 'TransitionTableBoxValue' in 'TransitionTableBox' table
		And I select current line in 'TransitionTableBox' table
		
		And I search element "Approval step 5" "Exact match" by field "Description" in list "Universal process steps"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

		Then "Conditional transition settings *" window is opened
		And I finish line editing in 'TransitionTableBox' table
		And I click the button named 'FormApply'
		Then "Conditional transition (Universal process step) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Conditional transition (Universal process step) *" window closing in 20 seconds
		
		And I add link from step "Approval step 1" to step "Approval step 9"
		And I add link from step "Approval step 9" to step "Approval step 8"
		And I add link from step "Approval step 8" to step "Conditional transition 1"
		And I add link from step "Approval step 2" to step "Approval step 3"
		And I add link from step "Approval step 3" to step "Approval step 4"
		And I add link from step "Approval step 4" to step "Automatic document confirmation"
		And I add link from step "Approval step 5" to step "Approval step 6"
		And I add link from step "Approval step 6" to step "Approval step 7"
		And I add link from step "Approval step 7" to step "Automatic document confirmation"

		And I close "Editing process stages: VA - Approval Process Template" window
		Then "VA - Approval Process Template (Universal process template)" window is opened
		And I activate field named 'ProcessParametersDefaultValue' in 'ProcessParameters' table
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - Approval Process Template (Universal process template)" window closing in 20 seconds

Scenario: 20.06 Configuring the authority matrix
	
	And In the command interface I select "Processes and approval" "Responsibility assignment matrix"
	Then "Responsibility assignment matrix" window is opened
	And I click Choice button of the field named 'DocumentTypeSelection'
	And I search and select element "Report instance" "Anywhere in the line" by field "Document" in list "Infobase documents"
	Then "Responsibility assignment matrix" window is opened
	And I click Choice button of the field named 'RegulationVersion'
	And I search and select element "VA - Main regulations" "Exact match" by field "Description" in list "Regulations for preparing reports"
	
	When "Responsibility assignment matrix" window is opened
	And I move to the tab named 'GroupList'

	* Deleting existing records
		And in the table 'ResponsibilitiesRegister' I click the button named 'ResponsibilitiesRegisterListSettings'
		Then "List Options" window is opened
		And I delete all lines of 'SettingsComposerUserSettingsItem0Filter' table
		And in the table 'SettingsComposerUserSettingsItem0Filter' I click the button named 'SettingsComposerUserSettingsItem0FilterAddFilterItem'
		And I go to the last line in 'SettingsComposerUserSettingsItem0Filter' table
		And I select "Database document template" exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterLeftValue' in 'SettingsComposerUserSettingsItem0Filter' table
		And I activate field named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
		And I select "Equal to" exact value from the drop-down list named 'SettingsComposerUserSettingsItem0FilterComparisonType' in 'SettingsComposerUserSettingsItem0Filter' table
		And I click choice button of the attribute named 'SettingsComposerUserSettingsItem0FilterRightValue' in 'SettingsComposerUserSettingsItem0Filter' table
		Then "Select data type" window is opened
		And I go to line in "" table:
			| ''             |
			| "Report types" |
		And I select current line in "" table
		And I search and select element "VA - Coordination" "Exact match" by field "Description" in list "Report types"
		And I click the button named 'FormEndEdit'

		And While the number of 'ResponsibilitiesRegister' table lines ">" 0 Then
			When "Responsibility assignment matrix" window is opened
			And in the table 'ResponsibilitiesRegister' I click the button named 'ResponsibilitiesRegisterDelete'
			Then "1C:Enterprise" window is opened
			And I click the button named 'Button0'

		When "Responsibility assignment matrix" window is opened
		And in the table 'ResponsibilitiesRegister' I click the button named 'ResponsibilitiesRegisterListSettings'
		And I remove all filters in list form
			
	* Creating a new element
		And in the table 'ResponsibilitiesRegister' I click the button named 'ResponsibilitiesRegisterCreate'
		Then "Register of responsibility assignment matrix (create)" window is opened
		And I click Choice button of the field named 'DBDocumentTemplate'
		Then "Select data type" window is opened
		And I go to line in "" table:
			| ''             |
			| "Report types" |
		And I select current line in "" table
		And I search and select element "VA - Coordination" "Exact match" by field "Description" in list "Report types"
		
		Then "Register of responsibility assignment matrix (create) *" window is opened
		And I click Choice button of the field named 'Organization'
		And I select company "Mercury LLC"

		Then "Register of responsibility assignment matrix (create) *" window is opened
		And I click Choice button of the field named 'Approval'
		Then "Select data type" window is opened
		And I go to line in "" table:
			| ''                               |
			| "Universal process template" |
		And I select current line in "" table
		And I search and select element "VA - Approval Process Template" "Exact match" by field "Description" in list "Universal process templates"

		Then "Register of responsibility assignment matrix (create) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "Register of responsibility assignment matrix (create) *" window closing in 20 seconds

Scenario: 20.07 Saving the report instances list form settings

	* Opening report instances
		And In the command interface I select "Budgeting, reporting, and analysis" "Report instances"
		Then "Report instances" window is opened
		Then I set checkbox named 'ShouldShowStandardFilters'
		And in the table 'Filter' I click the button named 'FilterUncheckAll'

	* Setting filters
		And I move to the tab named 'Standard1'

		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"        | "Display mode" |
			| "Equal to"         | "No"           | "Company" | "Quick access"    |
		And I select "Mercury LLC" by string from the drop-down list named 'FilterRightValue' in 'Filter' table
		
		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"          | "Display mode" |
			| "Equal to"         | "No"           | "Report period" | "Quick access"    |
		And I click choice button of the attribute named 'FilterRightValue' in 'Filter' table
		And I search and select element "January 2024" "At beginning of line" by field "Description" in list "Periods"
	
		Then "Report instances" window is opened
		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"     | "Display mode" |
			| "Equal to"         | "No"           | "Scenario" | "Quick access"    |
		And I select "VA - Main scenario" by string from the drop-down list named 'FilterRightValue' in 'Filter' table
		
		And I go to line in 'Filter' table:
			| "Comparison type" | "Use" | "Left value"       | "Display mode" |
			| "Equal to"         | "No"           | "Report type" | "Quick access"    |
		And I select "VA - Coordination" by string from the drop-down list named 'FilterRightValue' in 'Filter' table

	* Saving the setting
		When "Report instances" window is opened
		And I click the button named 'SaveSettingAs'
		And I search element "VA - Coordination - Mercury LLC" "Exact match" by field "Description" in list "Saved settings"
		And While the number of 'List' table lines 'more' 0 Then
			And I save '"Delete_" + StrReplace(New UUID, "-", "")' in 'UID' variable
			And I select context menu item named 'ListContextMenuChange' of the form attribute named 'List'
			Then "VA - Coordination - Mercury LLC (Setup option)" window is opened
			And I input 'UID' variable value in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait "VA - Manual entry for all analytics - Venus LLC *" window closing in 20 seconds
			
	Then "Saved settings" window is opened
	And I input "VA - Coordination - Mercury LLC" text in the field named 'Description'
	And I click the button named 'FormSaveVariant'

	When "Report instances" window is opened
	And I click Open button of the field named 'SavedSetting'

	* Configuring users
		When "VA - Coordination - Mercury LLC (Setup option)" window is opened
		And in the table 'Users' I click the button named 'UsersAdd'
		And I click choice button of the attribute named 'UsersUser' in 'Users' table
		Then "Select data type" window is opened
		And I go to line in "" table:
			| ''                     |
			| "User group" |
		And I select current line in "" table
		And I search and select element "VA - Budgeting" "Exact match" by field "Description" in list "Select user group"
		Then "VA - Coordination - Mercury LLC (Setup option) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "VA - Coordination - Mercury LLC (Setup option) *" window closing in 20 seconds

Scenario: 20.08 Configuring rights for users

	And I add right "Read, write" for report type "VA - Coordination" user "Budgeting1" for all companies
	And I add right "Read, write" for report type "VA - Coordination" user "Budgeting2" for all companies
	And I add right "Read, write" for report type "VA - Coordination" user "Budgeting3" for all companies
	And I add right "Read, write" for report type "VA - Coordination" user "Budgeting4" for all companies

Scenario: 20.09 Approval by users

	* Approval 1 (part 1)
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''

		And I click the button named 'AcceptForApproval'
		
		Then '$WindowTitle$' window is opened
		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

	* Adding a deputy
		And I add deputy 'Budgeting3' for user 'Budgeting1'
		
	* Approval 3 (deputy)
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		
		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

	* Approval 1 (part 2)
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting1" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		
		And I click the button named 'ApproveDocument'
		Then 'Approval' window is opened
		And I click the button named 'AddApprovers'
		Then "Additional approval" window is opened
		And I click the button named 'FormAddApprovers'
		
		And I search element 'Budgeting2' "Exact match" by field "Full name" in list "Select user"
		And the number of 'UsersList' table lines is 'equal' 1
		And I select current line in 'UsersList' table

		Then "Additional approval" window is opened
		And I click the button named 'FormClose'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'
		Then '$WindowTitle$' window is opened
		And I click the button named 'ApprovalRoute'
		And I close "Approval: Report instance *" window

		And I close '$WindowTitle$' window
		Then "Report instances" window is opened
		And I close "Report instances" window
		
	* Approval 2
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting2" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
	
		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

	* Approval 3
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting3" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		
		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

	* Approval 4
		And I close "CPM - Budget" TestClient
		And I connect "CPM - Budget" TestClient using "Budgeting4" login and '' password

		And I open report instance by saved setting "VA - Coordination - Mercury LLC"
		And I open report instance for report type "VA - Coordination" currency 'RUB' company "Mercury LLC" scenario "VA - Main scenario" frequency "Month" project '' dimensions '' '' '' '' '' ''
		
		And I click the button named 'ApproveDocument'
		Then "Approval" window is opened
		And I click the button named 'MarkReportAsApproved'

		Then '$WindowTitle$' window is opened
		And I click the button named 'CancelApproval'
		If "Reason for canceling approval" window is opened Then
			And I click the button named 'OK'

	* Approval history
		Then '$WindowTitle$' window is opened
		And I click the button named 'ApprovalHistory'
		And 'Result' spreadsheet document is equal to "3_Budgeting\Layouts\20\VA_ApprovalTestingHistory_Mercury.mxl" by template
