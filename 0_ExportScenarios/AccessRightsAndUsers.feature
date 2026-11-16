#language: en

@ExportScenarios
@IgnoreOnCIMainBuild

Feature: Export scenarios for configuring users and access rights

Scenario: I create profile with name 'TheName' based on profile 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroupsProfiles'

	* Deleting the existing profile
		And I search element '[TheName]' "Exact match" by field "Description" in list "Access group profiles"
		And While the number of 'List' table lines 'more' 0 Then
			* Marking for deletion
				And I delete current row in list 'List'
			* Renaming
				And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
				And I select current line in 'List' table
				Then "* (Access group profile)" window is opened
				And I input 'UID' variable value in the field named 'Description'
				And I click the button named 'FormWriteAndClose'
				And I wait "* (Access group profile) *" window closing in 20 seconds

	* Searching for the predefined profile
		Then "Access group profiles" window is opened
		And I select context menu item named 'ListContextMenuFind' of the form attribute named 'List'
		Then the form named 'UniversalListFindExtForm' is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I input '[TheProfile]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Access group profiles" window is opened
		And the number of 'List' table lines is 'equal' 1

	* Copying the profile
		And I select context menu item named 'ListContextMenuCopy' of the form attribute named "List"
		Then "Access group profile (create)" window is opened
		And I input '[TheName]' text in the field named 'Description'
		And I click the button named 'FormWrite'
	
	* Closing windows
		Then "[TheName] (Access group profile)" window is opened
		And I close "[TheName] (Access group profile)" window
		Then "Access group profiles" window is opened
		And I close "Access group profiles" window

Scenario: I add access restriction with kind 'TheType' value 'TheValue' to profile 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroupsProfiles'

	* Searching for the existing profile
		And I search element '[TheProfile]' "Exact match" by field "Description" in list "Access group profiles"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

	* Deleting the access type if it is already set
		Then "[TheProfile] (Access group profile)" window is opened
		And I move to the tab named 'AccessKindsAndValues'
		And I save '[TheType]' in 'CurrentType' variable
		If 'AccessKinds' table contains line Then
			| "Access kind"  |
			| '$CurrentType$' |
			And I go to line in 'AccessKinds' table
				| "Access kind" |
				| '$CurrentType$' |
			And I select context menu item named 'AccessKindsContextMenuDelete' of the form attribute named 'AccessKinds'
						
	* Adding an access restriction
		And in the table 'AccessKinds' I click the button named 'AccessKindsAdd'
		And I select '[TheType]' exact value from the drop-down list named 'AccessKindsAccessKindPresentation' in 'AccessKinds' table
		And I move to the next attribute
		And I select '[TheValue]' exact value from the drop-down list named 'AccessKindsAllAllowedPresentation' in 'AccessKinds' table
		And I finish line editing in 'AccessKinds' table
		And I repeat 5 times
			And in the table 'AccessKinds' I click the button named 'AccessKindsMoveUp'

	* Saving the element
		When "[TheProfile] (Access group profile) *" window is opened
		And I click the button named 'FormWriteAndClose'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		And I wait "[TheProfile] (Access group profile) *" window closing in 20 seconds
		Then "Access group profiles" window is opened
		And I close "Access group profiles" window

Scenario: I add role 'TheRole' to profile 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroupsProfiles'

	* Searching for the existing profile
		And I search element '[TheProfile]' "Exact match" by field "Description" in list "Access group profiles"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

	* Adding a role
		Then "[TheProfile] (Access group profile)" window is opened
		And in the table 'Roles' I click the button named 'RolesShowSelectedRolesOnly'
		
	* Searching for the existing role
		And in the table 'Roles' I click the button named 'RolesFind'
		Then "Find" window is opened
		And I select 'Check, Allowed action (role)' exact value from the drop-down list named "FieldSelector"
		And I change the radio button named 'CompareType' value to 'Exact match'
		And I input '[TheRole]' text in the field named 'Pattern'
		And I click the button named 'Find'
		And the number of 'Roles' table lines is 'equal' 1
		And I select current line in 'Roles' table

	* Setting the role flag
		And I set checkbox named 'RolesCheck' in 'Roles' table
		And I finish line editing in 'Roles' table

	* Saving the element
		And I click the button named 'FormWriteAndClose'
		And I wait "[TheProfile] (Access group profile) *" window closing in 20 seconds
		And I close "Access group profiles" window
		Then "Users and rights settings" window is opened
		And I close "Users and rights settings" window

Scenario: I remove role 'TheRole' from profile 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroupsProfiles'

	* Searching for the existing profile
		And I search element '[TheProfile]' "Exact match" by field "Description" in list "Access group profiles"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

	* Deleting the role
		Then "[TheProfile] (Access group profile)" window is opened
		And in the table 'Roles' I click the button named 'RolesShowSelectedRolesOnly'
		
	* Searching for the existing role
		And in the table 'Roles' I click the button named 'RolesFind'
		Then "Find" window is opened
		And I select 'Check, Allowed action (role)' exact value from the drop-down list named "FieldSelector"
		And I change the radio button named 'CompareType' value to 'Exact match'
		And I input '[TheRole]' text in the field named 'Pattern'
		And I click the button named 'Find'
		And the number of 'Roles' table lines is 'equal' 1
		And I select current line in 'Roles' table

	* Setting the role flag
		And I remove checkbox named 'RolesCheck' in 'Roles' table
		And I finish line editing in 'Roles' table

	* Saving the element
		And I click the button named 'FormWriteAndClose'
		And I wait "[TheProfile] (Access group profile) *" window closing in 20 seconds
		And I close "Access group profiles" window
		Then "Users and rights settings" window is opened
		And I close "Users and rights settings" window

Scenario: I create access group with name 'TheName' by profile 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroups'

	And I search element '[TheProfile]' "Exact match" by field "Description" in list "Access groups"

	If '"[TheName]" = "Opening external reports and data processors" OR "[TheName]" = "Open external reports and data processors"' Then

		* Checking that the access group has the correct profile
			And the number of 'List' table lines is 'equal' 1
			And I select current line in 'List' table
			Then "Open external reports and data processors (Access group)" window is opened
			Then the form attribute named 'Profile' became equal to '[TheProfile]'

	Else

		* Deleting the existing access group
			And While the number of 'List' table lines 'more' 0 Then
				* Marking for deletion
					And I delete current row in list 'List'
				* Renaming
					And I save 'StrReplace(New UUID, "-", "")' in 'UID' variable
					And I select current line in 'List' table
					Then "* (Access group)" window is opened
					And I input 'UID' variable value in the field named 'Description'
					And I click the button named 'FormWriteAndClose'
					And I wait "* (Access group) *" window closing in 20 seconds

		* Creating an access group
			Then "Access groups" window is opened
			And I click the button named 'FormCreate'
			Then "Access group (create)" window is opened
			And I input '[TheName]' text in the field named 'Description'

		* Updating the settings
			And I select from the drop-down list named "Profile"  by '[TheProfile]' string
			And I click the button named 'FormWrite'
			Then "[TheName] (Access group)" window is opened

	And I close "[TheName] (Access group)" window
	Then "Access groups" window is opened
	And I close "Access groups" window

Scenario: I add access values with kind 'TheType' from table to access group 'TheProfile'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenAccessGroups'
	
	* Searching for the access group
		And I search element '[TheProfile]' "Exact match" by field "Description" in list "Access groups"
		And the number of 'List' table lines is 'equal' 1
		And I select current line in 'List' table

	* Configuring the restrictions
		Then "[TheProfile] (Access group)" window is opened
		And I move to the tab named 'Access'
		And I fill 'AccessValues' table with data
			| '$CurrentTable$' |

	* Saving the profile
		When "[TheProfile] (Access group) *" window is opened
		And I click the button named 'FormWriteAndClose'
		And I wait "[TheProfile] (Access group) *" window closing in 20 seconds
		Then "Access groups" window is opened
		And I close "Access groups" window

Scenario: I find or create user group with name 'TheName'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenUsers'
		Then "Users" window is opened

	* Searching for or creating the required group
		And I select context menu item named 'UserGroupsContextMenuFind' of the form attribute named 'UserGroups'
		Then "Find" window is opened
		And I select "Description" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Anywhere in the line"
		And I input '[TheName]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Users" window is opened
		If number of 'UserGroups' table lines is "equal" 0 Then
			And I click the button named 'CreateUsersGroup'
			When "User group (create)" window is opened
			And I input '[TheName]' text in the field named 'Description'
			And I click the button named 'FormWriteAndClose'
			And I wait "User group (create) *" window closing in 20 seconds

	Then "Users" window is opened
	And I close "Users" window

Scenario: I find or create user 'TheUser' access group 'TheProfile' group 'TheGroup'

	* Opening a list
		If '$$IsERPCPM$$' Then
			And In the command interface I select "Reference data and administration" "Users and rights settings"
		Else
			And In the command interface I select "Administration" "Users and rights settings"
		Then "Users and rights settings" window is opened
		And I click the button named 'OpenUsers'
		Then "Users" window is opened

	* Searching for or creating the required user
		And I select context menu item named 'UsersListContextMenuFind' of the form attribute named 'UsersList'
		Then "Find" window is opened
		And I select "Full name" exact value from the drop-down list named 'FieldSelector'
		And I change the radio button named 'CompareType' value to "Exact match"
		And I input '[TheUser]' text in the field named 'Pattern'
		And I click the button named 'Find'
		Then "Users" window is opened
		And Delay 1
		If number of 'UsersList' table lines is "equal" 0 Then
			And I click the button named 'CreateUser'
			Then "User (create)" window is opened
			And I input '[TheUser]' text in the field named 'Description'
		Else
			And I select current line in 'UsersList' table
							
	* Updating the settings
		And I set checkbox named 'CanSignIn'
		And I set checkbox named 'IBUserStandardAuthentication'
		And I set checkbox named 'IBUserShowInList'
		And I click the button named 'FormWrite'
		If "Conversations (interaction system)" window is opened Then
			And I set checkbox named 'NeverAskAgain'
			And I click the button named 'Command2'
		Then "[TheUser] (User)" window is opened

	If 'NOT IsBlankString("[TheProfile]")' Then
		And In this window I click command interface button "Access rights"
		If '"[TheProfile]" = "Administrators"' Then
			* Group "Administrators"
				If 'AccessGroups' table contains line Then
					| "Description"   | "Profile"        |
					| "Administrators" | "Administrator"  |
					And I go to line in 'AccessGroups' table:
						| "Description"   |
						| "Administrators" |	
				Else
					And in the table 'AccessGroups' I click the button named 'AccessGroupsAddToGroup'
					Then "Access groups" window is opened
					And I go to line in 'AccessGroups' table:
						| "Description"   |
						| "Administrators" |
					And I select current line in 'AccessGroups' table
			* Group "Open external reports and data processors"
				If 'AccessGroups' table contains line Then
					| "Description"                         | "Profile"                              |
					| "Open external reports and data processors" | "Open external reports and data processors" |
					And I go to line in 'AccessGroups' table:
						| "Description"                         |
						| "Open external reports and data processors" |
				Else
					And in the table 'AccessGroups' I click the button named 'AccessGroupsAddToGroup'
					Then "Access groups" window is opened
					And I go to line in 'AccessGroups' table:
						| "Description"                         |
						| "Open external reports and data processors" |
					And I select current line in 'AccessGroups' table
		Else
			* Clearing the groups and setting the passed one
				And While the number of 'AccessGroups' table lines ">" 0 Then
					And in the table 'AccessGroups' I click the button named 'AccessGroupsRemoveFromGroup'
				And in the table 'AccessGroups' I click the button named 'AccessGroupsAddToGroup'
				Then "Access groups" window is opened
				And I select context menu item named 'AccessGroupsFind' of the form attribute named 'AccessGroups'
				Then "Find" window is opened
				And I input '[TheProfile]' text in the field named 'Pattern'
				And I click the button named 'Find'
				Then "Access groups" window is opened
				And I select current line in 'AccessGroups' table

	If 'NOT IsBlankString("[TheGroup]")' Then
		When "[TheUser] (User)" window is opened
		And In this window I click command interface button "Groups"
		And I save '[TheGroup]' in 'CurrentGroup' variable
		And I go to line in 'GroupsTree' table:
			| 'Group'         |
			| '$CurrentGroup$' |
		And I set checkbox named 'GroupsTreeCheck' in 'GroupsTree' table
		And I finish line editing in 'GroupsTree' table
		And I click the button named 'FormWriteAndClose'

	When "[TheUser] (User)" window is opened
	And I close "[TheUser] (User)" window
	Then "Users" window is opened
	And I close "Users" window

Scenario: I enable performance mode of restrictions at record level

	If '$$IsERPCPM$$' Then
		And In the command interface I select "Reference data and administration" "Users and rights settings"
	Else
		And In the command interface I select "Administration" "Users and rights settings"
	Then "Users and rights settings" window is opened
	And I expand the group named 'AccessGroupsGroup'
	If the field named 'LimitAccessAtRecordLevelUniversally' exists on the form Then
		And I select "High performance" exact value from the drop-down list named 'LimitAccessAtRecordLevelUniversally'
		Then "1C:Enterprise" window is opened
		And I click the button named 'Button0'
		
	Then "Users and rights settings" window is opened
	And I click the button named 'AccessUpdateOnRecordsLevel'
	Then "Update record-level access" window is opened
	And Delay 1

	And I expand the group named 'BriefDetailed'
	If form attribute named 'StartAccessUpdateImmediately' is available Then
		And I click the button named 'StartAccessUpdateImmediately'
		If "1C:Enterprise" window is opened Then
			And I click the button named 'Button0'
	And I wait "(completed *)" value by template of the attribute named 'LastAccessUpdateCompletion' for 600 seconds
	And I wait that in 'Lists' table number of lines will be "equal" 0 for 60 seconds
	When the number of 'Lists' table lines is "equal" 0

	When "Update record-level access" window is opened
	And I close "Update record-level access" window
